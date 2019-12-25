package com.tmdaq.ces.generator.plugin;

import org.mybatis.generator.api.IntrospectedColumn;
import org.mybatis.generator.api.IntrospectedTable;
import org.mybatis.generator.api.dom.java.TopLevelClass;
import org.mybatis.generator.config.TableConfiguration;

import java.util.Map;
import java.util.Objects;
import java.util.stream.Collectors;

/**
 * 用来添加数据库注释
 */
public class BeanRemarkPlugin extends BasePlugin {

    @Override
    public boolean modelBaseRecordClassGenerated(TopLevelClass topLevelClass, IntrospectedTable introspectedTable) {
        String tableRemarks = introspectedTable.getRemarks();
        topLevelClass.addJavaDocLine("/**");
        TableConfiguration tableConfiguration = introspectedTable.getTableConfiguration();
        topLevelClass.addJavaDocLine(String.format(" * 数据库表名 %s.%s ", tableConfiguration.getSchema(), tableConfiguration.getTableName()));
        topLevelClass.addJavaDocLine(" * " + tableRemarks);
        topLevelClass.addJavaDocLine(" */");
        Map<String, String> allColumns = introspectedTable.getAllColumns().stream().filter(introspectedColumn -> Objects.nonNull(introspectedColumn.getRemarks()))
                .collect(Collectors.toMap(IntrospectedColumn::getJavaProperty, IntrospectedColumn::getRemarks));
//        忽略 serialVersionUID
        topLevelClass.getFields().stream().filter(i -> !Objects.equals("serialVersionUID", i.getName()))
                .forEach(field -> {
                    String remark = allColumns.get(field.getName());
                    if (Objects.nonNull(remark)) {
                        field.addJavaDocLine("/**");
                        field.addJavaDocLine(" * " + remark);
                        field.addJavaDocLine(" */");
                    }
                });

        return super.modelBaseRecordClassGenerated(topLevelClass, introspectedTable);
    }
}
