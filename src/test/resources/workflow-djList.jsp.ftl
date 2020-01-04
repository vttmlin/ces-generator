<%@ page language="java" pageEncoding="UTF-8" %>
<%@ include file="/views/common/tag.jsp" %>
<!DOCTYPE HTML>
<html>
<head>
    <title>医疗管理-老病残认定-老年犯认定-登记页面</title>
</head>
<body>
<div style="height: 100%;">
    <cui:form id="queryForm">

    </cui:form>
    <cui:grid id="${path}DjGrid" width="auto" singleselect="true" fitStyle="fill">
        <cui:gridCols>
            <cui:gridCol name="id" hidden="true"/>
            <cui:gridCol name="jyId" hidden="false" frozen="true" sortable="true" formatter="convertCode"
                         revertCode="true" formatoptions="{'data':combobox_jy}">监狱
            </cui:gridCol>
            <cui:gridCol name="jqId" frozen="true" sortable="true" formatter="convertCode" revertCode="true"
                         formatoptions="{'data':combobox_jq}">监区
            </cui:gridCol>
            <cui:gridCol name="xm" sortable="false">姓名</cui:gridCol>
            <cui:gridCol name="bh" sortable="false">编号</cui:gridCol>
            <cui:gridCol name="zm" sortable="false" formatter="convertCode" revertCode="true"
                         formatoptions="{dataStructure:'tree','data':combobox_zm}">罪名
            </cui:gridCol>
            <cui:gridCol name="xq" sortable="false" revertCode="true" formatter="common.setXqWb"
                         width="100">刑期
            </cui:gridCol>
        </cui:gridCols>
        <%-- 在这个地方会枚举出常用的字段属性 请一定要认真检查属性是否与你想要的属性相同 ！！！ --%>
    <#if fieldSet??>
        <#list fieldSet as field>
            <%--
            <cui:gridCol name="${field.name}" sortable="false">${field.remarks}</cui:gridCol>
            --%>
            <%-- 数据类型: ${field.type}  数据长度 ${field.length} 字段名 ${field.jdbcName} 字段类型 ${field.jdbcType}--%>

        </#list>
    </#if>
        <cui:gridPager gridId="${path}DjGrid" toolbarOptions="onClick:'${path}Dj.clickHandler',
			data:[{
				'id': 'show',
				'label': '查看',
				'icon': 'iconView',
				'type': 'button'
			} ]"/>
    </cui:grid>
</div>
<div>

    <cui:dialog id="${path}DjDialog" position="center" reLoadOnOpen="true" modal="true" autoOpen="false" width="1000"
                height="600" autoDestroy="true"/>


</div>
<script type="text/javascript">
    var ${path}Dj = (function () {
        return {
            grid: $('#${path}DjGrid'),
            dialog: $('#${path}DjDialog'),
            clickHandler: function (event, ui) {
                ${path}Dj[ui.id]();
            },
            show: function () {
                var id = ${path}Dj.grid.grid('option', 'selrow');
                if (id) {
                    ${path}Dj.dialog.dialog('option', {
                        title: show ? '查看' : '修改',
                        url: '${r'${ctx}'}/${path}?_url=/ylgl/${path}/edit&parentList=${path}Dj&id=' + id + '&readonly=' + (true ? 'Y' : '')
                    });
                    ${path}Dj.dialog.dialog('open');
                } else {
                    $.message({message: '请先选择需要处理的记录！', cls: 'warning'});
                }

            }
        }
    })();

    $.parseDone(function () {
        $('#${path}DjGrid').grid('option', 'url', '${r'${ctx}'}/${path}/findDjList')
                .grid('option', 'datatype', 'json')
                .grid('reload');
    });


</script>
</body>

</html>
