package com.tmdaq.ces.generator.util;

import lombok.SneakyThrows;

import java.sql.Connection;
import java.sql.DriverManager;
import java.util.Properties;

public class JdbcUtil {
    static final Properties PROPERTIES = load();

    @SneakyThrows
    public static Connection getConnection() {
        return DriverManager.getConnection(PROPERTIES.getProperty("url"), PROPERTIES);
    }

    @SneakyThrows
    private static Properties load() {
        Properties properties = new Properties();
        properties.load(JdbcUtil.class.getResourceAsStream("/db.properties"));
        return properties;
    }

}
