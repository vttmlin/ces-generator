<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/views/common/tag.jsp"%>
<%@ include file="/views/common/upload.jsp"%>
<%@ page import="com.cesgroup.prison.platform.common.util.DateUtils" %>
<!DOCTYPE HTML>
<html>
<head>
    <title>请输入标题</title>
</head>
<body>
<div style="height: 100%">
    <cui:form id="addDialogForm" method="post"  heightStyle="fill">
        <cui:input id="id" type="hidden" name="id"/>
    <!-- 遍历主表字段 -->
<#if otherColumns??>
<#list otherColumns?keys as key>
        <%-- ${key} ${otherColumns['${key}']} --%>
</#list>
</#if>
        <table class="table table-condensed table-bordered table-fixed">
            <tr>
            <cui:input id="xm" type="hidden" name="xm"/>
            <cui:input id="jbxxId" type="hidden" name="jbxxId"/>
            <tr>
                <td>
                    <label>姓名</label>
                </td>
                <td>
                    <input id="xm" name="xm">
                </td>
                <td>
                    <label>编号</label>
                </td>
                <td>
                    <cui:input componentCls="form-control" id="bh" name="bh" readonly="true"/>

                <td>
                    <label>监狱</label>
                </td>
                <td>
                    <cui:combobox componentCls="form-control" id="jyId" name="jyId" data="combobox_jy" readonly="true"/>
                </td>
                <td>
                    <label>监区</label>
                </td>
                <td>
                    <cui:combobox componentCls="form-control" id="jqId" name="jqId" data="combobox_jq" readonly="true"/>
                </td>
            </tr>
            <tr>
                <td>
                    <label>性别</label>
                </td>
                <td>
                    <cui:combobox componentCls="form-control" id="xb" name="xb" data="combobox_xb" readonly="true"/>
                </td>
                <td>
                    <label>年龄</label>
                </td>
                <td>
                    <cui:input componentCls="form-control" id="nl" name="nl" readonly="true"/>
                </td>
                <td>
                    <label>籍贯</label>
                </td>
                <td>
                    <cui:input componentCls="form-control" id="jg" name="jg" readonly="true"/>
                </td>
                <td>
                    <label>文化程度</label>
                </td>
                <td>
                    <cui:combotree componentCls="form-control" id="whcd" name="whcd" data="combobox_whcd"
                                   readonly="true"/>
                </td>
            </tr>
            <tr>
                <td>
                    <label>婚姻状况</label>
                </td>
                <td>
                    <cui:combobox componentCls="form-control" id="hyzk" name="hyzk" data="combobox_hyzk"
                                  readonly="true"/>
                </td>
                <td>
                    <label>处遇等级</label>
                </td>
                <td>
                    <cui:combotree componentCls="form-control" id="cydj" name="cydj" data="combobox_cydj"
                                   readonly="true"/>
                </td>
                <td>
                    <label>入监日期</label>
                </td>
                <td>
                    <cui:datepicker componentCls="form-control" id="rjRq" name="rjRq"
                                    dateFormat="yyyy-MM-dd" showOn="button" readonly="true"/>
                </td>
                <td>
                    <label>刑期</label>
                </td>
                <td>
                    <cui:input componentCls="form-control" id="xq" name="xq" readonly="true"/>
                </td>
            </tr>
            <tr>
                <td>
                    <label>罪名</label>
                </td>
                <td colspan="7">
                    <cui:autocomplete searchField="jianpinLower,jianpinUpper" allowRepeat="true"
                                      componentCls="form-control" id="zm" name="zm" multiple="true"
                                      source="combobox_zm" valueField="id" textField="name" postMode="value"
                                      itemattr="common.customDeal" readonly="true"
                    />
                </td>
            </tr>
            <tr>
                <td>
                    <label>执行刑期</label>
                </td>
                <td>
                    <cui:input componentCls="form-control" id="zxxq" name="zxxq" readonly="true"/>
                </td>
                <td>
                    <label>执行刑期起日</label>
                </td>
                <td>
                    <cui:datepicker componentCls="form-control" id="zxxqQr" name="zxxqQr"
                                    dateFormat="yyyy-MM-dd" showOn="button" readonly="true"/>
                </td>
                <td>
                    <label>执行刑期止日</label>
                </td>
                <td>
                    <cui:datepicker componentCls="form-control" id="zxxqZr" name="zxxqZr"
                                    dateFormat="yyyy-MM-dd" showOn="button" readonly="true"/>
                </td>
                <td>
                    <label>余刑</label>
                </td>
                <td>
                    <cui:input componentCls="form-control" id="yx" name="yx" readonly="true"/>
                </td>
            </tr>
            <tr>
                <td>
                    <label>家庭住址</label>
                </td>
                <td colspan="7">
                    <cui:input componentCls="form-control" id="jtzz" name="jtzz" readonly="true"/>
                </td>
            </tr>
            <tr>
                <td>
                    <label>附件</label>
                </td>
                <td colspan="7" >
                    <cui:uploader id="affixUpload" uploader="${r'${ctx}'}/affix/upload"
                                  onUploadStart="common.onUploadStart"
                                  onUploadSuccess="common.onUploadSuccess"
                                  swf="${r'${uploadSwf}'}"/>
                </td>
            </tr>
            <tr>
                <td><label>备注</label></td>
                <td colspan="7" >
                    <cui:textarea id="cBz" name="cBz" componentCls="form-control"/>
                </td>
            </tr>
        </table>
            <div>
                <div style="padding-left: 15%;float: left">
                    填表人：<cui:input id="cCjr" name="cCjr" isLabel="true"/>
                </div>
                <div style="padding-right: 1%;float: right">
                    填表日期：<cui:datepicker id="cCjRq" name="cCjRq" dateFormat="yyyy-MM-dd" isLabel="true"/>
                </div>
            </div>
    </cui:form>
    <div class="dialog-buttons">
        <cui:button icons="iconSave" countdown="true" id="saveBtn" label="保存" onClick="${path}Edit.save"></cui:button>
        <cui:button icons="iconDelete" label="关闭" onClick="closeDialog"/>
    </div>
</div>
</body>
<script type="text/javascript">
    var ${path}Edit = (function () {
        return {
            form : $("#addDialogForm"),
            init : function() {
                if ("${r'${id}'}") {
                    ${path}Edit.loadForm("${r'${id}'}", "${r'${readonly}'}");
                }else {
                    $("#cCjRq").datepicker("setValue","<%=DateUtils.getCurrentDate(false)%>");
                    $("#cCjr").val(top.user.userName);
                    ${path}Edit._init();
                }
            },
            _init: function () {
                //设置监狱监区信息 目前没有设置成只读 如有需要 请自己设置
                $('#jyId').combobox("setValue", top.user.unitCode);
                $('#jqId').combobox("setValue", top.user.orgCode);
            },
            loadForm : function (id, readonly) {
                if (readonly) {
                    ${path}Edit.readonly();
                    common.loadAffix("affixUpload", id, true);
                    $("#affixUpload_uploader").remove();
                } else {
                    common.loadAffix("affixUpload", id, false);
                }
                    // // 不需要附件上传
                    // if (readonly) {
                //     ${path}Edit.readonly();
                    // }
                loadForm('addDialogForm', "${r'${ctx}'}/${path}/find?id=" + id, function(data) {
                });
            },
            readonly : function () {
                ${path}Edit.form.form("setIsLabel", true);
                $("#saveBtn").hide();
            },
            save : function() {
                if (${path}Edit.form.form("valid")) {
                    var formData = ${path}Edit.form.form("formData", false);
                    $.loading({text:"正在保存中，请稍后…"});
                    $.ajax({
                        type : 'post',
                        url : '${r'${ctx}'}/${path}/save',
                        data : formData,
                        dataType : 'json',
                        success : function (data) {
                            $.loading("hide");
                            if (data.status === "success") {
                                $.message("保存成功");
                            ${path}.
                                dialog.dialog("close");
                            ${path}.
                                grid.grid("reload");
                            } else {
                                $.alert("保存失败");
                            }
                        }
                    });
                }
            }
        };
    })();
    $.parseDone(function() {
        var option = {
            'url': '${r'${ctx}'}/jbxx/getZfxx?fxzt1=1',
            'user': top.user
        };
        common.initXmAutoComplete('#xm', '#addDialogForm', option);
        ${path}Edit.init();
    });

</script>
</html>
