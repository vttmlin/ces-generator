package com.tmdaq.ces.generator.api;

import org.mybatis.generator.api.MyBatisGenerator;
import org.mybatis.generator.config.Configuration;
import org.mybatis.generator.config.Context;
import org.mybatis.generator.internal.DefaultShellCallback;
import org.testng.annotations.Test;

import java.util.ArrayList;
import java.util.List;

import static com.tmdaq.ces.generator.util.ConfigurationUtil.getConfiguration;
import static com.tmdaq.ces.generator.util.ConfigurationUtil.getPluginConfiguration;
import static org.testng.Assert.assertTrue;

public class ConstTest {


    @Test
    public void testGetOutPath() throws Exception {
        Configuration configuration = getConfiguration("T_XFZX_SW_SWDJ", "Swdj");
        Context mybatis = configuration.getContext("mybatis");
        mybatis.addPluginConfiguration(getPluginConfiguration("com.tmdaq.ces.generator.plugin.SetterPlugin"));
        DefaultShellCallback callback = new DefaultShellCallback(true);
        List<String> warnings = new ArrayList<>();
        MyBatisGenerator myBatisGenerator = new MyBatisGenerator(configuration, callback, warnings);
        myBatisGenerator.generate(null);
        assertTrue(!warnings.isEmpty(), "生成失败");
    }

}