package com.tmdaq.ces.generator.plugin;

import com.tmdaq.ces.generator.api.Mode;
import com.tmdaq.ces.generator.api.SystemUtil;
import org.mybatis.generator.api.IntrospectedColumn;
import org.mybatis.generator.api.IntrospectedTable;
import org.mybatis.generator.api.dom.java.*;
import org.mybatis.generator.api.dom.xml.Attribute;
import org.mybatis.generator.api.dom.xml.Document;
import org.mybatis.generator.api.dom.xml.TextElement;
import org.mybatis.generator.api.dom.xml.XmlElement;

import java.util.Arrays;
import java.util.List;
import java.util.Objects;
import java.util.function.Predicate;
import java.util.stream.Collectors;

public class ListPagePlugin extends BasePlugin {
    private static final String METHOD_NAME = "selectList";

    @Override
    public boolean clientGenerated(Interface interfaze, TopLevelClass topLevelClass, IntrospectedTable introspectedTable) {
        String domainObjectName = introspectedTable.getTableConfiguration().getDomainObjectName();
        FullyQualifiedJavaType returnType = new FullyQualifiedJavaType(String.format("List<%s>", domainObjectName));
        Parameter record = new Parameter(new FullyQualifiedJavaType(String.format("%s", domainObjectName)), "record");
        Method method = new Method(METHOD_NAME);
        method.setReturnType(returnType);
        method.addParameter(record);
        interfaze.addMethod(method);
        interfaze.addImportedType(new FullyQualifiedJavaType("java.util.List"));
        Mode mode = SystemUtil.getInstance.getMode();
        switch (mode) {
            case SINGLE:
                break;
            case DUAL:
                break;
            case WORKFLOW:
                Method selectListMap = new Method(METHOD_NAME + "Map");
                selectListMap.setReturnType(new FullyQualifiedJavaType("List<Map<String,Object>>"));
                interfaze.addImportedType(new FullyQualifiedJavaType("java.util.Map"));
                selectListMap.addParameter(record);
                interfaze.addMethod(selectListMap);
                break;
            default:
                throw new UnsupportedOperationException();
        }
        return true;
    }

    @Override
    public boolean sqlMapDocumentGenerated(Document document, IntrospectedTable introspectedTable) {

        XmlElement listPage = new XmlElement("select");
        listPage.addAttribute(new Attribute("id", METHOD_NAME));
        listPage.addAttribute(new Attribute("resultMap", "BaseResultMap"));

        listPage.addElement(new TextElement(
                String.format("select \n      <include refid=\"Base_Column_List\" />\n" +
                                "    from %s.%s where C_SCBZ='N' ",
                        introspectedTable.getTableConfiguration().getSchema(), introspectedTable.getTableConfiguration().getTableName())));
        Mode mode = SystemUtil.getInstance.getMode();
        List<XmlElement> where = getWhere(introspectedTable);
        switch (mode) {
            case SINGLE:
                where.forEach(listPage::addElement);
                break;
            case DUAL:
                break;
            case WORKFLOW:
                XmlElement sql = new XmlElement("sql");
                sql.addAttribute(new Attribute("id", "base_where"));
                document.getRootElement().addElement(sql);
                where.forEach(sql::addElement);

                listPage.addElement(new TextElement("<include refid=\"base_where\" />\n"));

                XmlElement selectListMap = new XmlElement("select");
                selectListMap.addAttribute(new Attribute("id", METHOD_NAME + "Map"));
                selectListMap.addAttribute(new Attribute("resultType", "java.util.Map"));
                selectListMap.addElement(new TextElement(
                        String.format("select \n      <include refid=\"Base_Column_List\" />\n" +
                                        "    from %s.%s where C_SCBZ='N' ",
                                introspectedTable.getTableConfiguration().getSchema(), introspectedTable.getTableConfiguration().getTableName())));
                selectListMap.addElement(new TextElement("<include refid=\"base_where\" />\n"));
                selectListMap.addElement(new TextElement("and ( PROCESS_INSTANCE_ID is null or PROCESS_INSTANCE_ID='' )"));
                document.getRootElement().addElement(selectListMap);
                break;
            default:
                throw new UnsupportedOperationException();
        }
        document.getRootElement().addElement(listPage);
        return true;
    }

    private List<XmlElement> getWhere(IntrospectedTable introspectedTable) {
        Predicate<IntrospectedColumn> predicate = getPredicate(
                introspectedColumn -> !Objects.equals("cScbz", introspectedColumn.getJavaProperty()),
                introspectedColumn -> !Objects.equals("jqId", introspectedColumn.getJavaProperty()),
                introspectedColumn -> !Objects.equals("xm", introspectedColumn.getJavaProperty())

        );
        List<XmlElement> result = introspectedTable.getBaseColumns().stream().filter(predicate).flatMap(introspectedColumn -> Arrays.stream(getXmlElement(introspectedColumn))).collect(Collectors.toList());
        XmlElement jqId = new XmlElement("if");
        jqId.addAttribute(new Attribute("test", "jqId !=null and jqId !='' "));
        jqId.addElement(new TextElement(" AND JQ_ID like concat(#{jqId,jdbcType=VARCHAR},'%')"));
        result.add(jqId);
        introspectedTable.getBaseColumns().stream().filter(introspectedColumn -> introspectedColumn.getJavaProperty().equalsIgnoreCase("xm")).findFirst().ifPresent(introspectedColumn -> {
            XmlElement xm = new XmlElement("if");
            xm.addAttribute(new Attribute("test", "xm !=null and xm !='' "));
            xm.addElement(new TextElement(" AND (XM like concat( '%',#{xm,jdbcType=VARCHAR}, '%')\n" +
                    "      or BH like concat( '%',#{xm,jdbcType=VARCHAR}, '%')\n" +
                    "      or XM_SZM like concat( '%',#{xm,jdbcType=VARCHAR}, '%')\n" +
                    "      )"));
            result.add(xm);
        });
        return result;
    }

    @SafeVarargs
    private final Predicate<IntrospectedColumn> getPredicate(Predicate<IntrospectedColumn>... predicates) {
        Predicate<IntrospectedColumn> basePredicate = introspectedColumn -> true;
        for (Predicate<IntrospectedColumn> predicate : predicates) {
            basePredicate = basePredicate.and(predicate);
        }
        return basePredicate;
    }

    private XmlElement[] getXmlElement(IntrospectedColumn introspectedColumn) {
        XmlElement[] result;
        XmlElement ifElement = new XmlElement("if");
        if (introspectedColumn.getFullyQualifiedJavaType().getShortName().equalsIgnoreCase("Date")) {
            ifElement.addAttribute(new Attribute("test", String.format("%sStart !=null and %sStart !='' ", introspectedColumn.getJavaProperty(), introspectedColumn.getJavaProperty())));
            ifElement.addElement(new TextElement(String.format("<![CDATA[ AND %s >= #{%sStart,jdbcType=%s} ]]>", introspectedColumn.getActualColumnName(), introspectedColumn.getJavaProperty(), introspectedColumn.getJdbcTypeName())));
            XmlElement ifGt = new XmlElement("if");
            ifGt.addAttribute(new Attribute("test", String.format("%sEnd !=null and %sEnd !='' ", introspectedColumn.getJavaProperty(), introspectedColumn.getJavaProperty())));
            ifGt.addElement(new TextElement(String.format("<![CDATA[ AND %s <= #{%sEnd,jdbcType=%s} ]]>", introspectedColumn.getActualColumnName(), introspectedColumn.getJavaProperty(), introspectedColumn.getJdbcTypeName())));
            result = new XmlElement[2];
            result[0] = ifElement;
            result[1] = ifGt;
        } else if (introspectedColumn.getFullyQualifiedJavaType().getShortName().equalsIgnoreCase("String")) {
            ifElement.addAttribute(new Attribute("test", String.format("%s !=null and %s !='' ", introspectedColumn.getJavaProperty(), introspectedColumn.getJavaProperty())));
            ifElement.addElement(new TextElement(String.format(" AND %s = #{%s,jdbcType=%s}", introspectedColumn.getActualColumnName(), introspectedColumn.getJavaProperty(), introspectedColumn.getJdbcTypeName())));
            result = new XmlElement[1];
            result[0] = ifElement;
        } else {
            ifElement.addAttribute(new Attribute("test", String.format("%s !=null ", introspectedColumn.getJavaProperty())));
            ifElement.addElement(new TextElement(String.format(" AND %s = #{%s,jdbcType=%s}", introspectedColumn.getActualColumnName(), introspectedColumn.getJavaProperty(), introspectedColumn.getJdbcTypeName())));
            result = new XmlElement[1];
            result[0] = ifElement;
        }
        return result;
    }
}
