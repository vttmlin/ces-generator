package com.tmdaq.ces.generator.plugin;

import org.mybatis.generator.api.IntrospectedColumn;
import org.mybatis.generator.api.IntrospectedTable;
import org.mybatis.generator.api.dom.java.Method;
import org.mybatis.generator.api.dom.java.TopLevelClass;

import java.util.Objects;

public class SetterPlugin extends BasePlugin {
    @Override
    public boolean modelSetterMethodGenerated(Method method, TopLevelClass topLevelClass, IntrospectedColumn introspectedColumn, IntrospectedTable introspectedTable, ModelClassType modelClassType) {
        method.setReturnType(topLevelClass.getType());
        method.getBodyLines().clear();
        String fieldName = introspectedColumn.getJavaProperty();
        if (Objects.equals("String", introspectedColumn.getFullyQualifiedJavaType().getShortName())) {
            method.addBodyLine(String.format("this.%s = %s == null ? null : %s.trim();", fieldName, fieldName, fieldName));
        } else {
            method.addBodyLine(String.format("this.%s=%s;", fieldName, fieldName));
        }
        method.addBodyLine("return this;");
        return super.modelSetterMethodGenerated(method, topLevelClass, introspectedColumn, introspectedTable, modelClassType);
    }
}
