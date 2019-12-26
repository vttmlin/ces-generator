package com.tmdaq.ces.generator.util;

import lombok.SneakyThrows;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.Statement;
import java.util.Properties;

public class JdbcUtil {
    static final Properties PROPERTIES = load();

    @SneakyThrows
    public static Connection getConnection() {
        return DriverManager.getConnection(PROPERTIES.getProperty("url"), PROPERTIES);
    }

    @SneakyThrows
    public static Properties load() {
        Properties properties = new Properties();
        properties.load(JdbcUtil.class.getResourceAsStream("/db.properties"));
        return properties;
    }

    @SneakyThrows
    public static Statement getStatement() {
        return getConnection().createStatement();
    }

    @SneakyThrows
    public static PreparedStatement getStatement(String sql) {
        return getConnection().prepareStatement(sql);
    }
}
