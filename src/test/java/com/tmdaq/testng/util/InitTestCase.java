package com.tmdaq.testng.util;

import com.tmdaq.ces.generator.api.Mode;
import com.tmdaq.ces.generator.util.ConfigurationUtil;
import com.tmdaq.ces.generator.util.JdbcUtil;
import com.tmdaq.toolbox.ReflectionUtils;
import lombok.SneakyThrows;
import org.apache.commons.io.FileUtils;
import org.mybatis.generator.config.Configuration;
import org.testng.ITestContext;
import org.testng.ITestListener;
import org.testng.ITestResult;

import java.io.File;
import java.lang.reflect.Field;
import java.sql.Connection;
import java.sql.Statement;

import static org.testng.Assert.assertNotNull;

public class InitTestCase implements ITestListener {

    private Configuration configuration;

    @Override
    @SneakyThrows
    public void onStart(ITestContext context) {
        System.setProperty("devMode", "true");
//        获取全部参数
//        context.getCurrentXmlTest().getAllParameters()
        Mode mode = Mode.valueOf(String.valueOf(context.getCurrentXmlTest().getParameter("mode")));
        Connection connection = JdbcUtil.getConnection();
        Statement statement = connection.createStatement();
        assertNotNull(mode);
        switch (mode) {
            case SINGLE:
                statement.addBatch(FileUtils.readFileToString(new File(this.getClass().getResource("/ddl-single.sql").getFile()), "utf-8"));
                break;
            case DUAL:
                statement.addBatch(FileUtils.readFileToString(new File(this.getClass().getResource("/ddl-dual.sql").getFile()), "utf-8"));
                break;
            case WORKFLOW:
                statement.addBatch(FileUtils.readFileToString(new File(this.getClass().getResource("/ddl-workflow.sql").getFile()), "utf-8"));
                break;
            default:
                throw new RuntimeException();
        }
    }

    @Override
    @SneakyThrows
    public void onTestStart(ITestResult result) {
        Class realClass = result.getMethod().getRealClass();
        Object instance = result.getMethod().getInstance();
        Field configuration = realClass.getSuperclass().getDeclaredField("configuration");
        ReflectionUtils.setFieldValue(configuration, instance, ConfigurationUtil.getConfiguration("T_XFZX_SW_SWDJ", "Swdj", "XFZX"));
    }
}
