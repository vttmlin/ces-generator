package com.tmdaq.ces.generator.plugin.template;

import com.tmdaq.ces.generator.BaseTest;
import com.tmdaq.ces.generator.api.TableConfig;
import org.mybatis.generator.api.GeneratedJavaFile;
import org.mybatis.generator.api.GeneratedXmlFile;
import org.mybatis.generator.api.MyBatisGenerator;
import org.testng.annotations.Test;

import java.util.List;

import static org.testng.Assert.assertFalse;
import static org.testng.Assert.assertNotNull;

public class SingleTemplateTest extends BaseTest {

    @Test
    @TableConfig(tableName = "T_XFZX_SW_SWDJ", objectName = "Swdj", schema = "XFZX")
    public void testGenerator() throws Exception {
        MyBatisGenerator myBatisGenerator = new MyBatisGenerator(configuration, callback, warnings);
        myBatisGenerator.generate(null);
        List<GeneratedXmlFile> xmlFiles = myBatisGenerator.getGeneratedXmlFiles();
        List<GeneratedJavaFile> javaFiles = myBatisGenerator.getGeneratedJavaFiles();
        assertNotNull(javaFiles);
        assertFalse(javaFiles.isEmpty());
        assertNotNull(xmlFiles);
        assertFalse(xmlFiles.isEmpty());
        System.err.println(warnings);
    }
}