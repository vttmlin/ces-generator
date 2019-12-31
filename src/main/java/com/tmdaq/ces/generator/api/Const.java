package com.tmdaq.ces.generator.api;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.Objects;
import java.util.stream.Stream;

import static java.io.File.separator;
import static java.util.stream.Collectors.joining;

public class Const {
    public static final String PATH = "path.";
    public static final String USER_DIR = System.getProperty("user.dir");
    private static final Logger log = LoggerFactory.getLogger(Const.class);
    private static String outPath;
    /**
     * 判断当前是否是开发模式 如果是开发模式 会从读取当前的配置信息加载到内存中
     */
    private static boolean devMode;

    static {
        String devModeStr = System.getProperty("devMode");
        if (Objects.equals("true", devModeStr) || Objects.equals("false", devModeStr)) {
            devMode = true;
        } else if (Objects.equals("false", devModeStr)) {
            devMode = false;
        } else {
            log.error("devMode 设置错误 只能是 true/false");
        }
        if (devMode) {
            outPath = Stream.of(USER_DIR, "out").collect(joining(separator));
        } else {
            outPath = Stream.of(USER_DIR, "src", "main", "java").collect(joining(separator));
        }
    }

    private Const() {
        throw new UnsupportedOperationException("无效的方法调用");
    }

    public static String getOutPath() {
        return outPath;
    }
}
