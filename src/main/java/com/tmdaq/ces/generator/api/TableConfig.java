package com.tmdaq.ces.generator.api;

import java.lang.annotation.Retention;
import java.lang.annotation.Target;

import static java.lang.annotation.ElementType.METHOD;
import static java.lang.annotation.RetentionPolicy.RUNTIME;

@Retention(RUNTIME)
@Target({METHOD})
public @interface TableConfig {
    String tableName();

    String objectName();

    String schema();
}
