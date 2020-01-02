package com.tmdaq.ces.generator.util;

import org.mybatis.generator.api.CommentGenerator;
import org.mybatis.generator.config.*;
import org.mybatis.generator.internal.DefaultCommentGenerator;

import java.util.Properties;

import static com.tmdaq.ces.generator.util.JdbcUtil.PROPERTIES;


public class ConfigurationUtil {
    /*        <plugin type="com.tmdaq.ces.generator.plugin.IgnorePlugin" />
        <plugin type="com.tmdaq.ces.generator.plugin.SetterPlugin" />
        <plugin type="com.tmdaq.ces.generator.plugin.BeanRemarkPlugin" />
        <plugin type="com.tmdaq.ces.generator.plugin.DateFieldPlugin" />
        <plugin type="com.tmdaq.ces.generator.plugin.ListPagePlugin" />
        <plugin type="com.tmdaq.ces.generator.plugin.template.SingleTemplate" />
        <plugin type="com.tmdaq.ces.generator.plugin.template.DualTemplate" />
        <plugin type="com.tmdaq.ces.generator.plugin.template.WorkFlowTemplate" />*/
    private static String[] pluginArr = new String[]{
            "com.tmdaq.ces.generator.plugin.IgnorePlugin",
            "com.tmdaq.ces.generator.plugin.SetterPlugin",
            "com.tmdaq.ces.generator.plugin.BeanRemarkPlugin",
            "com.tmdaq.ces.generator.plugin.DateFieldPlugin",
            "com.tmdaq.ces.generator.plugin.ListPagePlugin",
            "com.tmdaq.ces.generator.plugin.template.SingleTemplate",
            "com.tmdaq.ces.generator.plugin.template.DualTemplate",
            "com.tmdaq.ces.generator.plugin.template.WorkFlowTemplate"
    };

    public static Configuration getConfiguration(String tableName, String objectName, String schema) {
        Configuration configuration = new Configuration();
        configuration.addContext(getContext(tableName, objectName, schema));
        return configuration;
    }

    public static Context getContext(String tableName, String objectName, String schema) {
        Context context = new Context(null);
        context.setId("mybatis");
        context.setTargetRuntime("MyBatis3");

        context.addProperty("javaFileEncoding", "UTF-8");

        for (String plugin : pluginArr) {
            context.addPluginConfiguration(getPluginConfiguration(plugin));
        }

        context.setCommentGeneratorConfiguration(getCommentGeneratorConfiguration());

        context.setJdbcConnectionConfiguration(getJdbcConnectionConfiguration(PROPERTIES));
        context.setJavaModelGeneratorConfiguration(getJavaModelGeneratorConfiguration());
        context.setSqlMapGeneratorConfiguration(getSqlMapGeneratorConfiguration());
        context.setJavaClientGeneratorConfiguration(getJavaClientGeneratorConfiguration());
        context.addTableConfiguration(getTableConfiguration(context, tableName, objectName, schema));


        return context;
    }

    private static CommentGeneratorConfiguration getCommentGeneratorConfiguration() {
        CommentGeneratorConfiguration configuration = new CommentGeneratorConfiguration();
        configuration.addProperty("suppressDate", "true");
        configuration.addProperty("suppressAllComments", "true");
        return configuration;
    }

    private static JavaClientGeneratorConfiguration getJavaClientGeneratorConfiguration() {
        JavaClientGeneratorConfiguration configuration = new JavaClientGeneratorConfiguration();
        configuration.setTargetPackage("com.cesgroup.prison.platform.yzgl.sjgl.ynfl.dao");
//        configuration.setTargetProject("src/main/java");
        configuration.setTargetProject("out");
        configuration.setConfigurationType("XMLMAPPER");
        return configuration;
    }

    private static SqlMapGeneratorConfiguration getSqlMapGeneratorConfiguration() {
        SqlMapGeneratorConfiguration configuration = new SqlMapGeneratorConfiguration();
        configuration.setTargetPackage("com");
//        configuration.setTargetProject("src/main/java");
        configuration.setTargetProject("out");
        return configuration;
    }

    private static JavaModelGeneratorConfiguration getJavaModelGeneratorConfiguration() {
        JavaModelGeneratorConfiguration configuration = new JavaModelGeneratorConfiguration();
        configuration.setTargetPackage("com.cesgroup.prison.platform.yzgl.sjgl.ynfl.entity");
//        configuration.setTargetProject("src/main/java");
        configuration.setTargetProject("out");
        return configuration;
    }

    public static TableConfiguration getTableConfiguration(Context context, String tableName, String objectName, String schema) {
        TableConfiguration tableConfiguration = new TableConfiguration(context);
        tableConfiguration.setTableName(tableName);
        tableConfiguration.setDomainObjectName(objectName);
        tableConfiguration.setSchema(schema);
        return tableConfiguration;
    }

    public static PluginConfiguration getPluginConfiguration(String type) {
        PluginConfiguration pluginConfiguration = new PluginConfiguration();
        pluginConfiguration.setConfigurationType(type);
        return pluginConfiguration;
    }

    public static JDBCConnectionConfiguration getJdbcConnectionConfiguration(Properties properties) {
        JDBCConnectionConfiguration configuration = new JDBCConnectionConfiguration();
        configuration.setDriverClass(properties.getProperty("driver"));
        configuration.setConnectionURL(properties.getProperty("url"));
        configuration.setUserId(properties.getProperty("user"));
        configuration.setPassword(properties.getProperty("password"));
        return configuration;
    }


    public static CommentGenerator getCommentGenerator() {
        CommentGenerator commentGenerator = new DefaultCommentGenerator();
        Properties properties = new Properties();
        properties.setProperty("suppressDate", "true");
        properties.setProperty("suppressAllComments", "true");
        commentGenerator.addConfigurationProperties(properties);
        return commentGenerator;
    }
}
