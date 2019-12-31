package com.tmdaq.toolbox;


import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.*;
import java.util.stream.Collectors;

import static org.fest.assertions.Assertions.assertThat;

/**
 * 反射工具类
 */
public class ReflectionUtils {

    private static final Logger log = LoggerFactory.getLogger(ReflectionUtils.class);

    private ReflectionUtils() {
        throw new UnsupportedOperationException("无效的方法调用");
    }

    /**
     * 将对象的字段转化成 List<Field>
     */
    public static List<Field> getFieldList(Object target) {
        assertThat(target).isNotNull();
        return Arrays.stream(target.getClass().getDeclaredFields()).collect(Collectors.toList());
    }

    /**
     * 将对象的字段转化成 Set<Field>
     */
    public static Set<Field> getFieldSet(Object target) {
        assertThat(target).isNotNull();
        return Arrays.stream(target.getClass().getDeclaredFields()).collect(Collectors.toSet());
    }

    /**
     * 将对象的字段转化成 Map<String,Field>
     */
    public static Map<String, Field> getFieldMap(Object target) {
        assertThat(target).isNotNull();
        return Arrays.stream(target.getClass().getDeclaredFields()).collect(Collectors.toMap(Field::getName, field -> field));
    }

    /**
     * 将对象转化成 Map<String,Object> 实例
     *
     * @param target     目标对象
     * @param ignoreNull 是否忽略为空属性
     * @return map对象
     */
    public static Map<String, Object> getMapByObject(Object target, final boolean ignoreNull) {
        assertThat(target).isNotNull();
        return Arrays.stream(target.getClass().getDeclaredFields()).filter(field -> !ignoreNull || Objects.nonNull(getFieldValue(field, target))).collect(Collectors.toMap(Field::getName, field -> getFieldValue(field, target)));
    }

    public static Map<String, Object> getMapByObject(Object target) {
        assertThat(target).isNotNull();
        return getMapByObject(target, true);
    }

    public static List<Method> getMethodList(Object target) {
        assertThat(target).isNotNull();
        return Arrays.stream(target.getClass().getDeclaredMethods()).collect(Collectors.toList());
    }

    public static Set<Method> getMethodSet(Object target) {
        assertThat(target).isNotNull();
        return Arrays.stream(target.getClass().getDeclaredMethods()).collect(Collectors.toSet());
    }

    public static Object getFieldValue(Field field, Object target) {
        assertThat(field).isNotNull();
        assertThat(target).isNotNull();
        field.setAccessible(true);
        try {
            return field.get(target);
        } catch (IllegalAccessException e) {
            log.error("{}", e);
        }
        return null;
    }

    @SuppressWarnings({"unchecked", "unused"})
    public static <T> T getFieldValue(Field field, Object target, Class<T> cls) {
        assertThat(field).isNotNull();
        assertThat(target).isNotNull();
        assertThat(cls).isNotNull();
        assertThat(cls).isInstanceOf(Class.class);
        return ((T) getFieldValue(field, target));
    }

    @SuppressWarnings({"unchecked", "unused"})
    public static <T> T getFieldValueOrDefault(Field field, Object target, T t) {
        assertThat(field).isNotNull();
        assertThat(target).isNotNull();
        assertThat(t).isNotNull();
        return ((T) getFieldValue(field, target));
    }


    @SuppressWarnings("unchecked")
    public static void setFieldValue(Field field, Object target, Object value) {
        assertThat(field).isNotNull();
        assertThat(target).isNotNull();
        try {
            field.setAccessible(true);
            field.set(target, value);
        } catch (IllegalAccessException e) {
            log.error("{}", e);
        }
    }

    public static Object invoke(Method method, Object target, Object... param) {
        assertThat(method).isNotNull();
        assertThat(target).isNotNull();
        assertThat(param).isNotNull();
        try {
            return method.invoke(target, param);
        } catch (IllegalAccessException | InvocationTargetException e) {
            log.error("{}", e);
        }
        return null;
    }

    public static Object invoke(Method method, Object target, List<Object> param) {
        assertThat(method).isNotNull();
        assertThat(target).isNotNull();
        assertThat(param).isNotNull();
        return invoke(method, target, param.toArray());
    }
}
