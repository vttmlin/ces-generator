package com.tmdaq.ces.generator.plugin.template;

import org.mybatis.generator.api.IntrospectedTable;
import org.mybatis.generator.api.dom.java.TopLevelClass;

import static com.tmdaq.ces.generator.api.Mode.DUAL;
import static com.tmdaq.ces.generator.api.Mode.SINGLE;

public class DualTemplate extends TemplatePlugin {
    public DualTemplate() {
        cache.put(DUAL, this);
    }

    private TemplatePlugin plugin = cache.get(SINGLE);

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
