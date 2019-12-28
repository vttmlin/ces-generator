package com.tmdaq.ces.generator.api;

import java.util.Objects;
import java.util.stream.Stream;

import static java.io.File.separator;
import static java.util.stream.Collectors.joining;

public class Const {
    public static final String PATH = "path.";

    public static final String USER_DIR = System.getProperty("user.dir");

    /**
     * 判断当前是否是开发模式 如果是开发模式 会从读取当前的配置信息加载到内存中
     */
    public static final Boolean DEV_MODE = Objects.equals("true", System.getProperty("devMode"));

    public static final String OUT_PATH = Stream.of(USER_DIR, "src", "main", "java").collect(joining(separator));

}
