package com.tmdaq.ces.generator.api;

import com.tmdaq.toolbox.ReflectionUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.*;
import java.util.function.Predicate;

import static com.tmdaq.ces.generator.api.Mode.SINGLE;
import static java.util.stream.Collectors.toMap;

public class SystemUtil {
    public static final SystemUtil getInstance = new SystemUtil();
    private static final Logger log = LoggerFactory.getLogger(ReflectionUtils.class);
    private static final Map<String, String> CONFIG_MAP = load();

    private static Map<String, String> load() {
        String property = System.getProperty("user.dir");
        List<File> result = new ArrayList<>();
        getAllFile(new File(property), file -> file.getName().endsWith("properties"), result);
        Map<String, String> map = new HashMap<>();
        result.stream().map(file -> {
            Properties properties = new Properties();
            try {
                properties.load(new FileInputStream(file));
            } catch (IOException e) {
                log.error("{}", e);
            }
            return properties.entrySet()
                    .stream()
                    .distinct()
                    .collect(toMap(entry -> entry.getKey().toString(), entry -> entry.getValue().toString()));
        }).forEach(map::putAll);
        return map;
    }

    private static void getAllFile(File file, Predicate<File> predicate, List<File> result) {
        if (file.isDirectory()) {
            File[] files = file.listFiles();
            if (Objects.isNull(files)) return;
            for (File file1 : files) {
                getAllFile(file1, predicate, result);
            }
        } else {
            if (predicate.test(file)) {
                result.add(file);
            }
        }
    }

    /**
     * @return 返回当前生成策略 默认单表生成
     */
    public Mode getMode() {
        Object mode = getConfig("mode");
        return Objects.nonNull(mode) ? Mode.valueOf(mode.toString()) : SINGLE;
    }

    public String getConfig(String key) {
        return CONFIG_MAP.get(key);
    }

}
