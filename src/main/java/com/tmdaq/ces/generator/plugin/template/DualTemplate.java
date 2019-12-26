package com.tmdaq.ces.generator.plugin.template;

import org.mybatis.generator.api.IntrospectedTable;
import org.mybatis.generator.api.dom.java.TopLevelClass;

import java.util.HashMap;
import java.util.Map;

import static com.tmdaq.ces.generator.api.Mode.DUAL;

public class DualTemplate extends TemplatePlugin {
    public DualTemplate() {
        cache.put(DUAL, this);
    }

    private Map<String, TemplatePlugin> delegateMap = new HashMap<>();

    @Override
    public void setDataMap(TopLevelClass topLevelClass, IntrospectedTable introspectedTable) {

    }

    @Override
    public void generator(TopLevelClass topLevelClass, IntrospectedTable introspectedTable) {
        setDataMap(topLevelClass, introspectedTable);
        getTemplateStringList().forEach(s -> {

        });
    }
}
