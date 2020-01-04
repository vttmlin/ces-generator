<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/views/common/include.jsp"%>
<%@ page import="com.cesgroup.prison.platform.common.facade.system.AuthSystemFacade" %>
<%@ page import="com.cesgroup.prison.platform.common.constant.GroupKeyConst" %>
<%@ page import="com.cesgroup.prison.platform.common.util.CodeFacadeUtil" %>
<%@ page import="com.cesgroup.prison.platform.common.constant.UnitKeyConst" %>

<!DOCTYPE HTML>
<html>
<head>
    <title>请输入标题</title>
    <script type="text/javascript">
        var combobox_jy = cacheUtil.getKey('<%=CodeFacadeUtil.loadCode4ComboJson(GroupKeyConst.GROUP_CODE_KEY_JY ,2 ,UnitKeyConst.PROVINCE_CODE, UnitKeyConst.PRISON_BUREAU_CODE)%>');//从编码表中取监狱
        var combobox_jq = <%=AuthSystemFacade.getAllJqInfoByJyKeyJson(AuthSystemFacade.getOrgUnitKeyForLoginUser())%>; //获取当前单位所有监区
        var combobox_xb = cacheUtil.getKey('<%=CodeFacadeUtil.loadCode2Json(GroupKeyConst.GROUP_CODE_KEY_XB)%>');
        var combobox_zm = cacheUtil.getKey('<%=CodeFacadeUtil.loadCode2SimpleTreeJson(GroupKeyConst.GROUP_CODE_KEY_XFZM, null, 5)%>');//罪名
        var combobox_sf = cacheUtil.getKey('<%=CodeFacadeUtil.loadCode2Json(GroupKeyConst.GROUP_CODE_KEY_SF)%>');
    </script>
</head>

<body>
<div style="height: 100%">
    <cui:form id="queryForm">
    <#if otherColumns??>
        <#list otherColumns?keys as key>
        <!-- ${key} ${otherColumns['${key}']} -->
        </#list>
    </#if>
        <table class="table table-condensed table-bordered table-fixed">
            <tr>
                <td style="width:8%;" class="tdLabel">
                    <label>监狱</label>
                </td>
                <td style="width:17%;">
                    <input id="jyKey" name="jyId">
                </td>
                <td style="width:8%;" class="tdLabel">
                    <label>监区</label>
                </td>
                <td style="width:17%;">
                    <input id="jqKey" name="jqId">
                </td>
                <td style="width:8%;" class="tdLabel">
                    <label>姓名</label>
                </td>
                <td style="width:17%;">
                    <cui:input id="xm" name="xm" componentCls="form-control"/>
                </td>
                <td rowspan="2" style="width:25%;text-align: center;">
                    <cui:button onClick="${path}.search" label="查询"/>
                    <cui:button onClick="${path}.more" label="更多"/>
                    <cui:button onClick="${path}.reset" label="重置"/>
                </td>
            </tr>
            <tr class="moreCondition" style="display: none;">
                <td style="width:7%;" class="tdLabel">
                    <label>编号 </label>
                </td>
                <td>
                    <cui:input id="bh" name="bh" componentCls="form-control"/>
                </td>
                <td style="width:7%;" class="tdLabel">
                    <label>创建时间起</label>
                </td>
                <td>
                    <cui:datepicker componentCls="form-control" name="cCjRqStart" dateFormat="yyyy-MM-dd HH:mm:ss" showOn="button"/>
                </td>
                <td style="width:7%;" class="tdLabel">
                    <label>创建时间止</label>
                </td>
                <td>
                    <cui:datepicker componentCls="form-control" name="cCjRqEnd" dateFormat="yyyy-MM-dd HH:mm:ss" showOn="button"/>
                </td>
                <td rowspan="2">

                </td>
            </tr>
        </table>
    </cui:form>
    <cui:grid id="${path}Grid" width="auto" multiselect="true" fitStyle="fill">
        <cui:gridCols>
            <cui:gridCol name="id" hidden="true"/>
            <cui:gridCol align="center" name="jyId" frozen="true" sortable="false" revertCode="true"
                         formatter="convertCode" formatoptions="{'data':combobox_jy}">监狱</cui:gridCol>
            <cui:gridCol align="center" name="jqId" frozen="true" sortable="false" formatter="convertCode"
                         revertCode="true" formatoptions="{'data':combobox_jq}">监区</cui:gridCol>
            <cui:gridCol align="center" name="xm" sortable="false" frozen="true" formatter="setXmLink">姓名</cui:gridCol>
            <cui:gridCol align="center" name="bh" sortable="false" frozen="true">编号</cui:gridCol>
            <%-- 在这个地方会枚举出常用的字段属性 请一定要认真检查属性是否与你想要的属性相同 ！！！ --%>
    <#if fieldSet??>
        <#list fieldSet as field>
            <%--
            <cui:gridCol name="${field.name}" sortable="false">${field.remarks}</cui:gridCol>
            --%>
            <%-- 数据类型: ${field.type}  数据长度 ${field.length} 字段名 ${field.jdbcName} 字段类型 ${field.jdbcType}--%>

        </#list>
    </#if>
        </cui:gridCols>
        <cui:gridPager gridId="${path}Grid" toolbarOptions="onClick:'${path}.clickHandler',
			data:[{
				'id': 'add',
				'label': '新增',
				'icon': 'iconAdd',
				'type': 'button'
			}, {
				'id': 'edit',
				'label': '修改',
				'icon': 'iconDealWith',
				'type': 'button'
			}, {
				'id': 'show',
				'label': '查看',
				'icon': 'iconView',
				'type': 'button'
			}, {
				'id': 'remove',
				'label': '删除',
				'icon': 'iconDelete',
				'type': 'button'
			}]"/>
    </cui:grid>
</div>
<div>
    <cui:dialog id="${path}Dialog" position="center" reLoadOnOpen="true" modal="true" autoOpen="false" width="1000"
                height="500" autoDestroy="true"/>
</div>

</body>
<script type="text/javascript">
    var ${path} =
    (function () {
        return {
            editUrl: "${r'${ctx}'}/${path}?_url=/${path}/edit",  // Todo 这个URL 需要手动去修改
            dialog: $("#${path}Dialog"),
            grid: $("#${path}Grid"),
            form: $("#queryForm"),
            clickHandler: function (event, ui) {
                ${path}[ui.id]();
            },
            search: function () {
            ${path}.
                grid.grid("option", "url", "${r'${ctx}'}/${path}/findList");
            ${path}.
                grid.grid("option", "datatype", "json");
            ${path}.
                grid.grid("option", "postData", ${path}.form.form("formData", false)
            )
                ;
            ${path}.
                grid.grid("reload");
            },
            more: function () {
                var selector = $(".moreCondition");
                if (selector.css("display") === "none") {
                    selector.show();
                } else {
                    selector.hide();
                }
            },
            reset: function () {
                $("#queryForm").form("clear", {excluded: ["readonly"]});
            },
            add: function () {
            ${path}.
                dialog.dialog("option", {
                    title: "新增",
                    url: ${path}.editUrl
                });
            ${path}.
                dialog.dialog("open");
            },
            edit: function (show) {
                var id = ${path}.
                grid.grid("option", "selarrrow");
                var title = show ? "查看" : "修改";
                if (id && id.length === 1) {
                ${path}.
                    dialog.dialog("option", {
                        title: title,
                        url: ${path}.editUrl + "&id=" + id + "&readonly=" + (show ? "Y" : "")
                    });
                ${path}.
                    dialog.dialog("open");
                } else {
                    $.message({message: "请选择一条" + title + "的数据！", cls: "warning"});
                }
            },
            show: function () {
            ${path}.
                edit(true);
            },
            remove: function () {
                var id = ${path}.
                grid.grid("option", "selarrrow");
                if (id) {
                    $.confirm("确认是否删除？", function (r) {
                        if (r) {
                            $.ajax({
                                type: "POST",
                                url: "${r'${ctx}'}/${path}/remove",
                                data: JSON.stringify(id),
                                dataType: "json",
                                contentType: "application/json",
                                success: function (data) {
                                    $.message({message: "操作成功！", cls: "success"});
                                ${path}.
                                    grid.grid("reload");
                                }
                            });
                        } else {
                            $.message("取消");
                        }
                    });
                } else {
                    $.message({message: "请先选择需要删除的记录！", cls: "warning"});
                }
            }
        };
    })();


    $.parseDone(function() {
        /*
        * 监狱监区 根据用户权限的只读
        * */
        common.initJyJq('#jyKey', '#jqKey');
    ${path}.
        search();
    });

</script>
</html>
