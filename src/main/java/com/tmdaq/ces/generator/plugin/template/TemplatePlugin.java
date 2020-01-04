package com.tmdaq.ces.generator.plugin.template;

import com.tmdaq.ces.generator.api.Mode;
import com.tmdaq.ces.generator.api.SystemUtil;
import com.tmdaq.ces.generator.plugin.BasePlugin;
import freemarker.template.Configuration;
import freemarker.template.Version;
import lombok.SneakyThrows;
import org.mybatis.generator.api.IntrospectedTable;
import org.mybatis.generator.api.dom.java.TopLevelClass;

import java.io.File;
import java.util.*;

import static java.util.stream.Collectors.toList;

public abstract class TemplatePlugin extends BasePlugin {
    protected static final String EXT = ".ftl";
    public static Map<String, String> FILE_MAPPING = new HashMap<>();
    protected static Map<Mode, TemplatePlugin> cache = new HashMap<>();
    protected static Map<String, Object> data = new HashMap<>();

    static {
//        getTemplateStringList().stream()
    }

    protected Mode mode = SystemUtil.getInstance.getMode();
    private Version version = Configuration.VERSION_2_3_29;

    protected static String getTemplatePath() {
        return TemplatePlugin.class.getResource("/").getFile();
    }

    /**
     * 这个地方塞数据
     *
     * @param topLevelClass     实体类信息
     * @param introspectedTable 表信息
     */
    public abstract void setDataMap(TopLevelClass topLevelClass, IntrospectedTable introspectedTable);

    /**
     * 获取所有模板文件
     *
     * @return 文件的list
     */
    protected List<File> getTemplateFileList() {
        File[] files = new File(getTemplatePath()).listFiles();
        if (Objects.isNull(files)) return Collections.emptyList();
        return Arrays.stream(files)
                .filter(file -> file.getName().endsWith(".ftl") && file.getName().startsWith(mode.toString().toLowerCase()))
                .collect(toList());
    }

    /**
     * 获取所有模板文件
     *
     * @return 文件名的list
     */
    protected List<String> getTemplateStringList() {
        return getTemplateFileList().stream().map(File::getName).collect(toList());
    }


    @Override
    public boolean modelBaseRecordClassGenerated(TopLevelClass topLevelClass, IntrospectedTable introspectedTable) {
        TemplatePlugin templatePlugin = cache.get(mode);
        templatePlugin.generator(topLevelClass, introspectedTable);
        return true;
    }

    /**
     * 生成的逻辑
     */
    public abstract void generator(TopLevelClass topLevelClass, IntrospectedTable introspectedTable);

    @SneakyThrows
    protected Configuration getConfiguration() {
        Configuration configuration = new Configuration(version);
        configuration.setDirectoryForTemplateLoading(new File(getTemplatePath()));
        return configuration;
    }

}


