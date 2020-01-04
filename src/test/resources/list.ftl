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
                    <cui:button onClick="demo.search" label="查询"/>
                    <cui:button onClick="demo.more" label="更多"/>
                    <cui:button onClick="demo.reset" label="重置"/>
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
    <cui:grid id="demoGrid" width="auto" multiselect="true" fitStyle="fill">
        <cui:gridCols>
            <cui:gridCol name="id" hidden="true"/>
            <cui:gridCol align="center" name="jyId" frozen="true" sortable="false" revertCode="true"
                         formatter="convertCode" formatoptions="{'data':combobox_jy}">监狱</cui:gridCol>
            <cui:gridCol align="center" name="jqId" frozen="true" sortable="false" formatter="convertCode"
                         revertCode="true" formatoptions="{'data':combobox_jq}">监区</cui:gridCol>
            <cui:gridCol align="center" name="xm" sortable="false" frozen="true" formatter="setXmLink">姓名</cui:gridCol>
            <cui:gridCol align="center" name="bh" sortable="false" frozen="true">编号</cui:gridCol>
    <#if allColumnsRemarks??>
        <#list allColumnsRemarks?keys as key>
            <%-- <cui:gridCol name="${key}" sortable="false">${allColumnsRemarks['${key}']} </cui:gridCol> --%>
        </#list>
    </#if>
        </cui:gridCols>
        <cui:gridPager gridId="demoGrid" toolbarOptions="onClick:'demo.clickHandler',
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
    <cui:dialog id="demoDialog" position="center" reLoadOnOpen="true" modal="true" autoOpen="false" width="1000"
                height="500" autoDestroy="true"/>
</div>

</body>
<script type="text/javascript">
    var demo = (function () {
        return {
            editUrl: "${r'${ctx}'}/${path}?_url=/${path}/edit",  // Todo 这个URL 需要手动去修改
            dialog: $("#demoDialog"),
            grid: $("#demoGrid"),
            form: $("#queryForm"),
            clickHandler: function (event, ui) {
                demo[ui.id]();
            },
            search: function () {
                demo.grid.grid("option", "url", "${r'${ctx}'}/${path}/findList");
                demo.grid.grid("option", "datatype", "json");
                demo.grid.grid("option", "postData", demo.form.form("formData", false));
                demo.grid.grid("reload");
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
                demo.dialog.dialog("option", {
                    title: "新增",
                    url: demo.editUrl
                });
                demo.dialog.dialog("open");
            },
            edit: function (show) {
                var id = demo.grid.grid("option", "selarrrow");
                var title = show ? "查看" : "修改";
                if (id && id.length === 1) {
                    demo.dialog.dialog("option", {
                        title: title,
                        url: demo.editUrl+"&id=" + id + "&readonly=" + (show ? "Y" : "")
                    });
                    demo.dialog.dialog("open");
                } else {
                    $.message({message: "请选择一条" + title + "的数据！", cls: "warning"});
                }
            },
            show: function () {
                demo.edit(true);
            },
            remove: function () {
                var id = demo.grid.grid("option", "selarrrow");
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
                                    demo.grid.grid("reload");
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
        demo.search();
    });

</script>
</html>
