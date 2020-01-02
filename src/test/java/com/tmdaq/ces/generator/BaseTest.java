package com.tmdaq.ces.generator;

import org.mybatis.generator.api.ShellCallback;
import org.mybatis.generator.config.Configuration;
import org.mybatis.generator.internal.DefaultShellCallback;

import java.util.ArrayList;
import java.util.List;

public class BaseTest {
    protected static Configuration configuration;
    protected List<String> warnings = new ArrayList<>();
    protected ShellCallback callback = new DefaultShellCallback(true);
}
