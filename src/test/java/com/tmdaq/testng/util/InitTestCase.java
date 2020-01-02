package com.tmdaq.testng.util;

import com.tmdaq.ces.generator.api.Const;
import com.tmdaq.ces.generator.api.Mode;
import com.tmdaq.ces.generator.api.SystemUtil;
import com.tmdaq.ces.generator.api.TableConfig;
import com.tmdaq.ces.generator.util.ConfigurationUtil;
import com.tmdaq.ces.generator.util.JdbcUtil;
import com.tmdaq.toolbox.ReflectionUtils;
import lombok.SneakyThrows;
import org.apache.commons.io.FileUtils;
import org.testng.ITestContext;
import org.testng.ITestListener;
import org.testng.ITestResult;
import org.testng.internal.ConstructorOrMethod;

import java.io.File;
import java.lang.reflect.Field;
import java.sql.Connection;
import java.sql.Statement;
import java.util.*;

import static org.testng.Assert.assertNotNull;

public class InitTestCase implements ITestListener {

    private Set<Mode> holder = new HashSet<>();

    @Override
    @SneakyThrows
    public void onStart(ITestContext context) {
        System.setProperty("devMode", "true");

        FileUtils.forceMkdir(new File(Const.getOutPath()));
//        获取全部参数
//        context.getCurrentXmlTest().getAllParameters()
        String modeStr = context.getCurrentXmlTest().getParameter("mode");
        SystemUtil.getInstance.put("mode", modeStr);
        Mode mode = Mode.valueOf(String.valueOf(modeStr));
        Connection connection = JdbcUtil.getConnection();
        connection.setAutoCommit(false);
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
        statement.executeBatch();
        connection.commit();
    }

    @Override
    @SneakyThrows
    public void onTestStart(ITestResult result) {
        Object instance = result.getInstance();
        ConstructorOrMethod method = result.getMethod().getConstructorOrMethod();
        TableConfig config = method.getMethod().getAnnotation(TableConfig.class);
        if (Objects.nonNull(config)) {
            Field configuration = recursive(instance.getClass(), "configuration");
            ReflectionUtils.setFieldValue(configuration, instance, ConfigurationUtil.getConfiguration(config.tableName(), config.objectName(), config.schema()));
        }
    }

    private Field recursive(Class<?> superclass, String fieldName) {
        Optional<Field> first = Arrays.stream(superclass.getDeclaredFields()).filter(field -> Objects.equals(field.getName(), fieldName)).findFirst();
        if (first.isPresent()) {
            return first.get();
        } else {
            Class<?> superclassSuperclass = superclass.getSuperclass();
            return recursive(superclassSuperclass, fieldName);
        }
    }

    @Override
    @SneakyThrows
    public void onFinish(ITestContext context) {
        FileUtils.deleteDirectory(new File(Const.getOutPath()));
    }
}
