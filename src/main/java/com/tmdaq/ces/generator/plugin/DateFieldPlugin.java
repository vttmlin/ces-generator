package com.tmdaq.ces.generator.plugin;

import org.mybatis.generator.api.IntrospectedTable;
import org.mybatis.generator.api.dom.java.*;

import java.util.Objects;
import java.util.Set;
import java.util.stream.Stream;

import static java.util.stream.Collectors.toSet;

public class DateFieldPlugin extends BasePlugin {
    private FullyQualifiedJavaType javaType = new FullyQualifiedJavaType("java.lang.String");

    @Override
    public boolean modelBaseRecordClassGenerated(TopLevelClass topLevelClass, IntrospectedTable introspectedTable) {
        Set<String> collect = topLevelClass.getFields().stream()
                .filter(field -> Objects.equals("java.util.Date", field.getType().getFullyQualifiedName()))
                .flatMap(field -> {
                    String name = field.getName();
                    return Stream.of(name + "Start", name + "End");
                }).collect(toSet());
        for (String str : collect) {
            generateField(str, topLevelClass);
            generateGetterMethod(str, topLevelClass);
            generateSetterMethod(str, topLevelClass);
        }
//                .forEach(str -> {
//                    generateField(str, topLevelClass);
//                    generateGetterMethod(str, topLevelClass);
//                    generateSetterMethod(str, topLevelClass);
//                });
        return true;
    }

    private void generateField(String name, TopLevelClass topLevelClass) {
        Field field = new Field(name, javaType);
        field.setVisibility(JavaVisibility.PRIVATE);
        topLevelClass.addField(field);
    }

    private void generateGetterMethod(String name, TopLevelClass topLevelClass) {
        Method method = new Method("get" + name.substring(0, 1).toUpperCase() + name.substring(1));
        method.setVisibility(JavaVisibility.PUBLIC);
        method.setReturnType(javaType);
        method.addBodyLine(String.format("return this.%s;", name));
        topLevelClass.addMethod(method);
    }

    private void generateSetterMethod(String name, TopLevelClass topLevelClass) {
        Method method = new Method("set" + name.substring(0, 1).toUpperCase() + name.substring(1));
        method.setVisibility(JavaVisibility.PUBLIC);
        method.setReturnType(topLevelClass.getType());
        method.addParameter(new Parameter(javaType, name));
        method.addBodyLine(String.format("this.%s=%s;return this;", name, name));
        topLevelClass.addMethod(method);
    }

}
