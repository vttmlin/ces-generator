package com.tmdaq.ces.generator.plugin.template;

import org.mybatis.generator.api.IntrospectedTable;
import org.mybatis.generator.api.dom.java.TopLevelClass;

import java.util.function.Consumer;

import static com.tmdaq.ces.generator.api.Mode.DUAL;

public class DualTemplate extends TemplatePlugin {
    public DualTemplate() {
        cache.put(DUAL, this);
    }

    private Consumer<String> consumer = s -> {
//        try {
//            String outPath = Stream.of(getOutPutPath()).collect(joining(File.separator));
//            getConfiguration().getTemplate(s).process(data, new FileWriter(new File(outPath)));
//        } catch (IOException | TemplateException ignored) {
//
//        }
    };

    @Override
    public void setDataMap(TopLevelClass topLevelClass, IntrospectedTable introspectedTable) {

    }

    @Override
    public void generator(TopLevelClass topLevelClass, IntrospectedTable introspectedTable) {
        setDataMap(topLevelClass, introspectedTable);
        getTemplateStringList().forEach(consumer);
    }
}
