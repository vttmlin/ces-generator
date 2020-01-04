=========================== 主键 =============================
<#if primaryKeys??>
    <#list primaryKeys?keys as key>
        ${key}  ==${primaryKeys['${key}']}
    </#list>
</#if>
=========================== 基础字段 =============================
<#if baseColumns??>
    <#list baseColumns?keys as key>
        ${key}  ==${baseColumns['${key}']}
    </#list>
</#if>
============================ 大字段 ============================
<#if blobColumns??>
    <#list blobColumns?keys as key>
        ${key}  ==${blobColumns['${key}']}
    </#list>
</#if>
