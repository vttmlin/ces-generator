<%@ page language="java" pageEncoding="UTF-8" %>
<%@ include file="/views/common/tag.jsp" %>
<%@ page import="com.cesgroup.prison.platform.common.system.workflow.util.BpmnConst" %>
<!DOCTYPE HTML>
<html>
<head>
    <title>医疗管理-老病残认定-老年犯认定</title>
</head>
<%

%>
<body>
<div style="height: 100%;">
    <cui:form id="queryForm">

    </cui:form>
    <cui:grid id="${path}Grid" width="auto" singleselect="true" fitStyle="fill">
        <cui:gridCols>
            <%-- 重用字段 --%>
            <cui:gridCol name="ID" hidden="true" key="true"/>
            <cui:gridCol align="center" name="JY_ID" frozen="true" sortable="false" revertCode="true"
                         formatter="convertCode" formatoptions="{'data':combobox_jy}">监狱
            </cui:gridCol>
            <cui:gridCol align="center" name="JQ_ID" frozen="true" sortable="true" formatter="convertCode"
                         revertCode="true" formatoptions="{'data':combobox_jq}">监区
            </cui:gridCol>
            <cui:gridCol align="center" name="XM" sortable="false" frozen="true" formatter="setXmLink">姓名</cui:gridCol>
            <cui:gridCol align="center" name="BH" sortable="true" frozen="true">编号</cui:gridCol>
            <cui:gridCol name="ZM" sortable="false" formatter="convertCode" revertCode="true"
                         formatoptions="{dataStructure:'tree','data':combobox_zm}">罪名
            </cui:gridCol>
            <cui:gridCol name="XQ" sortable="false" formatter="common.setXqWb">刑期</cui:gridCol>

            <%-- 归属业务字段 --%>
            <%-- 在这个地方会枚举出常用的字段属性 请一定要认真检查属性是否与你想要的属性相同 ！！！ --%>
    <#if fieldSet??>
        <#list fieldSet as field>
            <%--
            <cui:gridCol name="${field.jdbcName}" sortable="false">${field.remarks}</cui:gridCol>
            --%>
            <%-- 数据类型: ${field.type}  数据长度 ${field.length} 字段名 ${field.jdbcName} 字段类型 ${field.jdbcType}--%>

        </#list>
    </#if>

            <%-- 流程字段 --%>
            <c:if test="${r'${requestType == BpmnConst.DBX}'}">
                <cui:gridCol name="NAME_" sortable="false">流程节点</cui:gridCol>
                <cui:gridCol name="CREATE_TIME_" sortable="false">接收时间</cui:gridCol>
                <cui:gridCol name="TASK_DEF_KEY_" sortable="false" hidden="true">taskKey</cui:gridCol>
                <cui:gridCol name="ID_" sortable="false" hidden="true">taskId</cui:gridCol>
                <cui:gridCol name="ASSIGNEE_" sortable="false" hidden="true">签收人</cui:gridCol>
                <cui:gridCol name="PROCESS_INSTANCE_ID" sortable="false" hidden="true">processInstanceId</cui:gridCol>
                <cui:gridCol name="PROC_DEF_ID_" sortable="false" hidden="true">processDefKey</cui:gridCol>
            </c:if>

            <c:if test="${r'${requestType == BpmnConst.YBX}'}">
                <cui:gridCol name="NAME_" sortable="false">当前所在节点</cui:gridCol>
                <cui:gridCol name="START_TIME_" sortable="false">开始时间</cui:gridCol>
                <cui:gridCol name="TASK_DEF_KEY_" sortable="false" hidden="true">taskKey</cui:gridCol>
                <cui:gridCol name="ID_" sortable="false" hidden="true">taskId</cui:gridCol>
                <cui:gridCol name="CLAIM_TIME_" sortable="false" frozen="true"
                             formatter="process.setqsr">签收时间
                </cui:gridCol>
                <cui:gridCol name="PROCESS_INSTANCE_ID" sortable="false" hidden="true">processInstanceId</cui:gridCol>
                <cui:gridCol name="PROC_DEF_ID_" sortable="false" hidden="true">processDefKey</cui:gridCol>
            </c:if>

            <c:if test="${r'${requestType == BpmnConst.BJX}'}">
                <cui:gridCol name="START_TIME_" sortable="false">开始时间</cui:gridCol>
                <cui:gridCol name="END_TIME_" sortable="false">完成时间</cui:gridCol>
                <cui:gridCol name="PROCESS_INSTANCE_ID" sortable="false" hidden="true">processInstanceId</cui:gridCol>
                <cui:gridCol name="PROC_DEF_ID_" sortable="false" hidden="true">processDefKey</cui:gridCol>
            </c:if>
        </cui:gridCols>

        <c:if test="${r'${requestType == BpmnConst.SQX}'}">
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
        </c:if>
        <c:if test="${r'${requestType == BpmnConst.DBX}'}">
            <cui:gridPager gridId="${path}Grid" toolbarOptions="onClick:'${path}.clickHandler',
                data:[{
                    'id': 'pagerBtnDo',
                    'label': '办理',
                    'icon': 'iconDealWith',
                    'authorized12': false,
                    'type': 'button'
                }, {
                    'id': 'pagerBtnGraphUndo',
                    'label': '跟踪',
                    'icon': 'iconDetails',
                    'type': 'button'
                } ]"/>
        </c:if>
        <c:if test="${r'${requestType == BpmnConst.YBX || requestType == BpmnConst.BJX}'}">
            <cui:gridPager gridId="${path}Grid" toolbarOptions="onClick:'${path}.clickHandler',
                data:[{
				'id': 'show',
				'label': '查看',
				'icon': 'iconView',
				'type': 'button'
			}, {
				'id': 'pagerBtnGraphUndo',
				'label': '跟踪',
				'icon': 'iconDetails',
				'type': 'button'
			} ]"/>
        </c:if>
    </cui:grid>
</div>
<div>

    <cui:dialog id="${path}Dialog" position="center" reLoadOnOpen="true" modal="true" autoOpen="false" width="1000"
                height="600" autoDestroy="true"/>

    <cui:dialog id="graphDialog" position="center" reLoadOnOpen="true" modal="true" autoOpen="false" width="1000"
                height="500" autoDestroy="true"/>

</div>
<script type="text/javascript">
    $.parseDone(function () {
        $('#${path}Grid').grid('option', 'url', '${r'${ctx}'}/${r'${requestUrl}'}')
                .grid('option', 'datatype', 'json')
                .grid('reload');
    });

    var ${path} =
    (function () {
        return {
            editUrl: '${r'${ctx}'}/${path}?_url=/ylgl/${path}/edit',
            grid: $('#${path}Grid'),
            dialog: $('#${path}Dialog'),
            graphDialog: $('#graphDialog'),
            clickHandler: function (event, ui) {
                ${path}[ui.id]();
            },
            pagerBtnDo: function () {
                var id = ${path}.
                grid.grid('option', 'selrow');
                if (id) {
                    var rowData = ${path}.
                    grid.grid('getRowData', id);
                    var processDefKey = rowData['PROC_DEF_ID_'];
                    var processInstanceId = rowData['PROCESS_INSTANCE_ID'];
                    var taskId = rowData.ID_;
                    var taskKey = rowData.TASK_DEF_KEY_;
                    var claimStatus = 'N';//未签收
                    if (rowData.ASSIGNEE_) {
                        claimStatus = '';
                    }
                ${path}.
                    dialog.dialog('option', {
                        title: '老年犯认定流程审批表',
                        url: '{editUrl}&parentList={parentList}&id={id}&processDefKey={processDefKey}&processInstanceId={processInstanceId}&taskId={taskId}&taskKey={taskKey}&claimStatus={claimStatus}'
                                .format({
                                            'editUrl': ${path}.editUrl,
                                        'parentList'
                :
                    '${path}',
                            'id'
                :
                    id,
                            'processDefKey'
                :
                    processDefKey,
                            'processInstanceId'
                :
                    processInstanceId,
                            'taskId'
                :
                    taskId,
                            'taskKey'
                :
                    taskKey,
                            'claimStatus'
                :
                    claimStatus
                })
                })
                    ;
                ${path}.
                    dialog.dialog('open');
                } else {
                    $.message({message: '请先选择需要处理的记录！', cls: 'warning'});
                }

            },
            pagerBtnGraphUndo: function () {
                var id = ${path}.
                grid.grid('option', 'selrow');
                if (id) {
                    var rowData = ${path}.
                    grid.grid('getRowData', id);
                    var processInstanceId = rowData.PROCESS_INSTANCE_ID;
                    var processDefKey = rowData.PROC_DEF_ID_;
                ${path}.
                    graphDialog.dialog('option', {
                        title: '流程跟踪',
                        url: '${r'${ctx}'}/graph?_url=/common/activiti/graph&processInstanceId=' + processInstanceId + '&processDefKey=' + processDefKey
                    });
                ${path}.
                    graphDialog.dialog('open');
                } else {
                    $.message({message: '请先选择需要处理的记录！', cls: 'warning'});
                }
            },
            add: function () {
            ${path}.
                dialog.dialog('option', {
                    title: '新增',
                    url: '{0}&parentList={1}'.format(${path}.editUrl, '${path}')
            })
                ;
            ${path}.
                dialog.dialog('open');
            },
            remove: function () {
                var id = ${path}.
                grid.grid('option', 'selrow');
                if (id) {
                    $.confirm('确认是否删除？', function (r) {
                        if (r) {
                            $.ajax({
                                type: 'POST',
                                url: '${r'${ctx}'}/${path}/remove',
                                data: {id: id},
                                dataType: 'json',
                                success: function (data) {
                                    $.message({message: '操作成功！', cls: 'success'});
                                ${path}.
                                    grid.grid('reload');
                                }
                            });
                        } else {
                            $.message('取消');
                        }
                    });
                } else {
                    $.message({message: '请先选择需要删除的记录！', cls: 'warning'});
                }

            },
            edit: function (show) {
                var id = ${path}.
                grid.grid('option', 'selrow');
                if (id) {
                ${path}.
                    dialog.dialog('option', {
                        title: show ? '查看' : '修改',
                        url: '{url}&parentList={parentList}&id={id}&readonly={readonly}'.format({
                                    'url': ${path}.editUrl,
                                'parentList'
                :
                    '${path}',
                            'id'
                :
                    id,
                            'readonly'
                :
                    show ? 'Y' : ''
                })
                })
                    ;
                ${path}.
                    dialog.dialog('open');
                } else {
                    $.message({message: '请选择需要的数据！', cls: 'warning'});
                }
            },
            show: function () {
            ${path}.
                edit(true);
            }
        }
    })();

</script>
</body>

</html>
