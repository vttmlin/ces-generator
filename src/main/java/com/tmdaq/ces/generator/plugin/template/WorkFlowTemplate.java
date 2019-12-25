package com.tmdaq.ces.generator.plugin.template;

import org.mybatis.generator.api.IntrospectedTable;
import org.mybatis.generator.api.dom.java.TopLevelClass;

import static com.tmdaq.ces.generator.api.Mode.WORKFLOW;

public class WorkFlowTemplate extends TemplatePlugin {
    public WorkFlowTemplate() {
        cache.put(WORKFLOW, this);
    }

    @Override
    public void setDataMap(TopLevelClass topLevelClass, IntrospectedTable introspectedTable) {

    }

    @Override
    public void generator(TopLevelClass topLevelClass, IntrospectedTable introspectedTable) {
        setDataMap(topLevelClass, introspectedTable);
    }
}
