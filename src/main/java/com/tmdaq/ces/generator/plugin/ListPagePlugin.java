package com.tmdaq.ces.generator.plugin;

import org.mybatis.generator.api.IntrospectedColumn;
import org.mybatis.generator.api.IntrospectedTable;
import org.mybatis.generator.api.dom.java.*;
import org.mybatis.generator.api.dom.xml.Attribute;
import org.mybatis.generator.api.dom.xml.Document;
import org.mybatis.generator.api.dom.xml.TextElement;
import org.mybatis.generator.api.dom.xml.XmlElement;

import java.util.Objects;
import java.util.function.Predicate;

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
        Predicate<IntrospectedColumn> predicate = getPredicate(
                introspectedColumn -> !Objects.equals("cScbz", introspectedColumn.getJavaProperty()),
                introspectedColumn -> !Objects.equals("jqId", introspectedColumn.getJavaProperty())

        );
        introspectedTable.getBaseColumns().stream().filter(predicate)
                .forEach(introspectedColumn -> {
                    XmlElement ifElement = getXmlElement(listPage, introspectedColumn);
                    listPage.addElement(ifElement);
                });
        XmlElement ifElement = new XmlElement("if");
        ifElement.addAttribute(new Attribute("test", "jqId !=null and jqId !='' "));
        ifElement.addElement(new TextElement(" AND JQ_ID like concat(#{jqId,jdbcType=VARCHAR},'%')"));
        document.getRootElement().addElement(listPage);
        return true;
    }

    @SafeVarargs
    private final Predicate<IntrospectedColumn> getPredicate(Predicate<IntrospectedColumn>... predicates) {
        Predicate<IntrospectedColumn> basePredicate = introspectedColumn -> true;
        for (Predicate<IntrospectedColumn> predicate : predicates) {
            basePredicate = basePredicate.and(predicate);
        }
        return basePredicate;
    }

    private XmlElement getXmlElement(XmlElement listPage, IntrospectedColumn introspectedColumn) {
        XmlElement ifElement = new XmlElement("if");
        if (introspectedColumn.getFullyQualifiedJavaType().getShortName().equalsIgnoreCase("Date")) {
            ifElement.addAttribute(new Attribute("test", String.format("%sStart !=null and %sStart !='' ", introspectedColumn.getJavaProperty(), introspectedColumn.getJavaProperty())));
            ifElement.addElement(new TextElement(String.format("<![CDATA[ AND %s >= #{%sStart,jdbcType=%s} ]]>", introspectedColumn.getActualColumnName(), introspectedColumn.getJavaProperty(), introspectedColumn.getJdbcTypeName())));
            XmlElement ifGt = new XmlElement("if");
            ifGt.addAttribute(new Attribute("test", String.format("%sEnd !=null and %sEnd !='' ", introspectedColumn.getJavaProperty(), introspectedColumn.getJavaProperty())));
            ifGt.addElement(new TextElement(String.format("<![CDATA[ AND %s <= #{%sEnd,jdbcType=%s} ]]>", introspectedColumn.getActualColumnName(), introspectedColumn.getJavaProperty(), introspectedColumn.getJdbcTypeName())));
            listPage.addElement(ifGt);
        } else if (introspectedColumn.getFullyQualifiedJavaType().getShortName().equalsIgnoreCase("String")) {
            ifElement.addAttribute(new Attribute("test", String.format("%s !=null and %s !='' ", introspectedColumn.getJavaProperty(), introspectedColumn.getJavaProperty())));
            ifElement.addElement(new TextElement(String.format(" AND %s = #{%s,jdbcType=%s}", introspectedColumn.getActualColumnName(), introspectedColumn.getJavaProperty(), introspectedColumn.getJdbcTypeName())));
        } else {
            ifElement.addAttribute(new Attribute("test", String.format("%s !=null ", introspectedColumn.getJavaProperty())));
            ifElement.addElement(new TextElement(String.format(" AND %s = #{%s,jdbcType=%s}", introspectedColumn.getActualColumnName(), introspectedColumn.getJavaProperty(), introspectedColumn.getJdbcTypeName())));
        }
        return ifElement;
    }
}
