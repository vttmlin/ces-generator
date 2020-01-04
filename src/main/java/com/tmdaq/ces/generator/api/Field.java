package com.tmdaq.ces.generator.api;

import lombok.Data;
import lombok.experimental.Accessors;
import org.mybatis.generator.api.IntrospectedColumn;

@Data
@Accessors(chain = true)
public class Field {
    private String name;
    private String type;
    private String remarks;
    private Integer length;
    private String jdbcName;
    private String jdbcType;

    public static Field toField(IntrospectedColumn column) {
        Field field = new Field();
        field.name = column.getJavaProperty();
        field.type = column.getFullyQualifiedJavaType().getFullyQualifiedName();
        field.remarks = column.getRemarks();
        field.length = column.getLength();
        field.jdbcName = column.getActualColumnName();
        field.jdbcType = column.getJdbcTypeName();
        return field;
    }

}
