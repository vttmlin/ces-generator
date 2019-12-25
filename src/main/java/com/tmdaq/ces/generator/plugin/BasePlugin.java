package com.tmdaq.ces.generator.plugin;

import org.mybatis.generator.api.PluginAdapter;

import java.util.List;

public abstract class BasePlugin extends PluginAdapter {

    @Override
    public boolean validate(List<String> warnings) {
        return true;
    }

    protected BasePlugin() {

    }
}
