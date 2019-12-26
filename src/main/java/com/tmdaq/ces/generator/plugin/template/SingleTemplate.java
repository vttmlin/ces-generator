package com.tmdaq.ces.generator.plugin.template;

import com.tmdaq.ces.generator.api.Mode;
import freemarker.template.TemplateException;
import org.mybatis.generator.api.IntrospectedTable;
import org.mybatis.generator.api.dom.java.TopLevelClass;
import org.mybatis.generator.config.TableConfiguration;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.stream.Stream;

import static com.tmdaq.ces.generator.api.Const.PATH;
import static com.tmdaq.ces.generator.api.Mode.SINGLE;
import static com.tmdaq.ces.generator.api.SystemUtil.getInstance;
import static java.io.File.separator;
import static java.util.stream.Collectors.joining;

public class SingleTemplate extends TemplatePlugin {
    public SingleTemplate() {
        cache.put(SINGLE, this);
    }


    @Override
    public void setDataMap(TopLevelClass topLevelClass, IntrospectedTable introspectedTable) {
        Mode mode = getInstance.getMode();
        Map<String, Object> map = new HashMap<>();
        if (this.mode == mode) {
            TableConfiguration tableConfiguration = introspectedTable.getTableConfiguration();
            String domainObjectName = tableConfiguration.getDomainObjectName();
            String objectNameUpper = domainObjectName.substring(0, 1).toUpperCase() + domainObjectName.substring(1);
            String objectNameLower = domainObjectName.substring(0, 1).toLowerCase() + domainObjectName.substring(1);
            map.putIfAbsent("objectNameUpper", objectNameUpper);
            map.putIfAbsent("objectNameLower", objectNameLower);
            // 直接生成
//            controller上的注解 前台页面的请求地址
            final String path = getInstance.getConfig(PATH + tableConfiguration.getTableName());
            map.putIfAbsent("path", path);

            String packageName = topLevelClass.getType().getPackageName();
            map.putIfAbsent("entityPath", packageName);
            String basePackageName = packageName.substring(0, packageName.lastIndexOf('.'));

            String servicePackageName = basePackageName + ".service";
            map.putIfAbsent("servicePackageName", servicePackageName);

            String serviceImplPackageName = basePackageName + ".service.impl";
            map.putIfAbsent("serviceImplPackageName", serviceImplPackageName);

            String controllerPackageName = basePackageName + ".controller";
            map.putIfAbsent("controllerPackageName", controllerPackageName);

            String daoPath = basePackageName + ".dao." + domainObjectName + "Mapper";
            map.putIfAbsent("daoPath", daoPath);
            String servicePath = servicePackageName + 'I' + domainObjectName + "Service";
            map.putIfAbsent("servicePath", servicePath);
        } else {
            //todo 其他策略调用
        }
        TemplatePlugin.data.putAll(map);
    }

    @Override
    public void generator(TopLevelClass topLevelClass, IntrospectedTable introspectedTable) {
        setDataMap(topLevelClass, introspectedTable);
//        single-{}Service.java.ftl
        getTemplateStringList().forEach((String fileName) -> {
            try {
                String realName = fileName.substring(fileName.indexOf('-') + 1, fileName.length() - 4).replace("{}", topLevelClass.getType().getShortName());
                String outPath;
                if (realName.endsWith(".java")) {
                    String packageName;
                    if (realName.startsWith("I" + topLevelClass.getType().getShortName())) {
                        packageName = data.get("servicePackageName").toString();
                    } else if (realName.startsWith(topLevelClass.getType().getShortName() + "Service")) {
                        packageName = data.get("serviceImplPackageName").toString();
                    } else {
                        packageName = data.get("controllerPackageName").toString();
                    }
                    outPath = Stream.of(getOutPutPath(), packageName.replace(".", separator), realName).collect(joining(separator));
                } else {
                    outPath = Stream.of(getOutPutPath(), realName).collect(joining(separator));
                }
                File file = new File(outPath);
                if (!file.getParentFile().exists()) {
                    file.getParentFile().mkdirs();
                }
                getConfiguration().getTemplate(fileName).process(data, new FileWriter(file));
            } catch (IOException | TemplateException ignored) {
                ignored.printStackTrace();
            }
        });
    }
}
