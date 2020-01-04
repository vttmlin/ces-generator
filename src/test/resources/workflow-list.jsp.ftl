<%@ page import="com.cesgroup.prison.platform.common.constant.GroupKeyConst" %>
<%@ page import="com.cesgroup.prison.platform.common.util.CodeFacadeUtil" %>
<%@ page language="java" pageEncoding="UTF-8" %>
<%@ include file="/views/common/include.jsp" %>
<%@ include file="/views/common/process.jsp" %>
<html>
<head>
    <title>自己改</title>
</head>
<script type="text/javascript">
    var combobox_jy = common.arrEach(top.jyInfo);
    var combobox_jq = common.arrEach(top.jqInfo);
    var combobox_xb = cacheUtil.getKey('<%=CodeFacadeUtil.loadCode2Json(GroupKeyConst.GROUP_CODE_KEY_XB)%>');
    var combobox_zm = cacheUtil.getKey('<%=CodeFacadeUtil.loadCode2SimpleTreeJson(GroupKeyConst.GROUP_CODE_KEY_XFZM, null, 5)%>');//罪名
    var combobox_sf = cacheUtil.getKey('<%=CodeFacadeUtil.loadCode2Json(GroupKeyConst.GROUP_CODE_KEY_SF)%>');
    var combobox_sfty = cacheUtil.getKey('<%=CodeFacadeUtil.loadCode2Json(GroupKeyConst.GROUP_CODE_KEY_SFTY )%>');//是否同意
    var combobox_whcd = cacheUtil.getKey('<%=CodeFacadeUtil.loadCode2Json(GroupKeyConst.GROUP_CODE_KEY_WHCD)%>'); //文化程度
    var combobox_hyzk = cacheUtil.getKey('<%=CodeFacadeUtil.loadCode2Json(GroupKeyConst.GROUP_CODE_KEY_HYZK)%>'); //婚姻状况
    var combobox_fgdj = cacheUtil.getKey('<%=CodeFacadeUtil.loadCode2Json(GroupKeyConst.GROUP_CODE_KEY_FGDJ)%>'); //分管等级
</script>
<body>
<cui:layout cls="layoutWrapper" fit="true">
    <cui:layoutRegion region="west" style="width:180px;">
        <cui:menubar data="process.list('${path}','老年犯认定')" singleOpen="true" simpleDataEnable="true" vertical="true"
                     onClick="${path}Index.onClick" firstIsactive="true" onCreate="${path}Index.onClick">
        </cui:menubar>
    </cui:layoutRegion>
    <cui:layoutRegion region="center">

    </cui:layoutRegion>
</cui:layout>
</body>
<script>
    var ${path}Index = (function () {
        return {
            panel: '',
            onClick: function (event, ui) {
                ${path}Index.panel = $(event.target).closest('.layoutWrapper').layout('panel', 'center');
                /**
                 * @param index 当前页面对象
                 * @param filePath 列表所在页面
                 * @param controller 操作的controller
                 */
                process.openMenu(ui.id, '${path}Index', '你的路径/${path}', '${path}');
            }
        }
    })();

</script>
</html>
