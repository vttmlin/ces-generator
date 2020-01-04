<%@ page import="com.cesgroup.prison.platform.common.system.workflow.util.BpmnConst" %>
<%@ page import="com.cesgroup.prison.platform.common.util.DateUtils" %>
<%@ page contentType='text/html;charset=UTF-8' language='java' %>
<%@ include file='/views/common/tag.jsp' %>
<%@ include file='/views/common/upload.jsp' %>
<html>
<head>
    <title>医疗管理-老病残认定-老年犯认定-审批页面</title>
</head>
<body>
<div style='height: 100%;'>
    <cui:form id='addDialogForm' method='post' heightStyle='fill'>
        <cui:input id='id' type='hidden' name='id'/>
        <cui:input id='processInstanceId' type='hidden' name='processInstanceId'/>
        <cui:input type='hidden' id='spJg' name='spJg' value='N'/>
        <cui:input id='jbxxId' type='hidden' name='jbxxId'/>
        <cui:input id='xmSzm' type='hidden' name='xmSzm'/>
        <cui:input id='lbcLb' type='hidden' name='lbcLb' value='1'/>
        <cui:input id='sfL' type='hidden' name='sfL' value='Y'/>
        <table class='table table-condensed table-bordered table-fixed'>
            <tr>
                <td>
                    <label>姓名</label>
                </td>
                <td>
                    <input id='xm' name='xm'>
                </td>
                <td>
                    <label>编号</label>
                </td>
                <td>
                    <cui:input componentCls='form-control' id='bh' name='bh' readonly='true'/>

                <td>
                    <label>监狱</label>
                </td>
                <td>
                    <cui:combobox componentCls='form-control' id='jyId' name='jyId' data='combobox_jy' readonly='true'/>
                </td>
                <td>
                    <label>监区</label>
                </td>
                <td>
                    <cui:combobox componentCls='form-control' id='jqId' name='jqId' data='combobox_jq' readonly='true'/>
                </td>
            </tr>
            <tr>
                <td>
                    <label>性别</label>
                </td>
                <td>
                    <cui:combobox componentCls='form-control' id='xb' name='xb' data='combobox_xb' readonly='true'/>
                </td>
                <td>
                    <label>年龄</label>
                </td>
                <td>
                    <cui:input componentCls='form-control' id='nl' name='nl' readonly='true'/>
                </td>
                <td>
                    <label>籍贯</label>
                </td>
                <td>
                    <cui:autocomplete componentCls='form-control' id='jg' name='jg'
                                      searchField='jianpinLower' source='combobox_xzqh' textField='text'
                                      valueField='value'
                                      postMode='value' readonly='true'/>
                </td>
                <td>
                    <label>文化程度</label>
                </td>
                <td>
                    <cui:combotree componentCls='form-control' id='whcd' name='whcd' data='combobox_whcd'
                                   readonly='true'/>
                </td>
            </tr>
            <tr>
                <td>
                    <label>婚姻状况</label>
                </td>
                <td>
                    <cui:combobox componentCls='form-control' id='hyzk' name='hyzk' data='combobox_hyzk'
                                  readonly='true'/>
                </td>
                <td>
                    <label>处遇等级</label>
                </td>
                <td>
                    <cui:combotree componentCls='form-control' id='cydj' name='cydj' data='combobox_fgdj'
                                   readonly='true'/>
                </td>
                <td>
                    <label>入监日期</label>
                </td>
                <td>
                    <cui:datepicker componentCls='form-control' id='rjRq' name='rjRq'
                                    dateFormat='yyyy-MM-dd' showOn='button' readonly='true'/>
                </td>
                <td>
                    <label>刑期</label>
                </td>
                <td>
                    <cui:input componentCls='form-control' id='xq' name='xq' readonly='true'/>
                </td>
            </tr>
            <tr>
                <td>
                    <label>罪名</label>
                </td>
                <td colspan='7'>
                    <cui:autocomplete searchField='jianpinLower,jianpinUpper' allowRepeat='true'
                                      componentCls='form-control' id='zm' name='zm' multiple='true'
                                      source='combobox_zm' valueField='id' textField='name' postMode='value'
                                      itemattr='common.customDeal' readonly='true'
                    />
                </td>
            </tr>
            <tr>
                <td>
                    <label>执行刑期</label>
                </td>
                <td>
                    <cui:input componentCls='form-control' id='zxxq' name='zxxq' readonly='true'/>
                </td>
                <td>
                    <label>执行刑期起日</label>
                </td>
                <td>
                    <cui:datepicker componentCls='form-control' id='zxxqQr' name='zxxqQr'
                                    dateFormat='yyyy-MM-dd' showOn='button' readonly='true'/>
                </td>
                <td>
                    <label>执行刑期止日</label>
                </td>
                <td>
                    <cui:datepicker componentCls='form-control' id='zxxqZr' name='zxxqZr'
                                    dateFormat='yyyy-MM-dd' showOn='button' readonly='true'/>
                </td>
                <td>
                    <label>余刑</label>
                </td>
                <td>
                    <cui:input componentCls='form-control' id='yx' name='yx' readonly='true'/>
                </td>
            </tr>

            <tr>
                <td rowspan='1'><label>情况说明</label></td>
                <td colspan='7'>
                    至
                    <cui:datepicker width='130' dateFormat='yyyy-MM-dd' maxDate='new Date()' required="true"
                                    id='lnfRdSj' name='lnfRdSj'/>
                    ，
                    该犯已满
                    <cui:input width='50' id='lnfRdNl' name='lnfRdNl' required="true"/>
                    周岁， 现申请认定为老年罪犯。
                </td>
            </tr>

            <tr>
                <td style='vertical-align: middle;' rowspan='3'><label>分监区意见</label></td>
                <td colspan='7'>
                    <cui:radiolist id='fjqyjJg' name='fjqyjJg' data='combobox_sfty'
                                   componentCls='form-control' readonly='true'
                                   showStar='false' onChange='${path}Edite.changeFjqsp'/>
                </td>
            </tr>
            <tr>
                <td colspan='7'>
                    <cui:textarea maxlength='100' componentCls='form-control' id='fjqyjWb' name='fjqyjWb'
                                  height='80' readonly='true'/>
                </td>
            </tr>

            <tr>
                <td colspan='7'>
                    <div style='float: right;'>
                        <div>
                            <label>签名:</label>
                            <cui:input componentCls='form-control' id='fjqyjQm' name='fjqyjQm' readonly='true'
                                       width='150'/>
                            <cui:input type='hidden' componentCls='form-control' id='fjqyjQmId' name='fjqyjQmId'
                                       width='150'/>
                            <input type='hidden' id='fjqyjQz' name='fjqyjQz' width='150'>
                        </div>
                        <div style='float: left;'>
                            <label>日期:</label>
                            <cui:datepicker componentCls='form-control' id='fjqyjRq' name='fjqyjRq'
                                            dateFormat='yyyy-MM-dd HH:ss:mm' showOn='button' readonly='true'
                                            width='150'/>
                        </div>
                    </div>
                </td>
            </tr>

            <tr>
                <td style='vertical-align: middle;' rowspan='3'><label>监区意见</label></td>
                <td colspan='7'>
                    <cui:radiolist id='jqyjJg' name='jqyjJg' data='combobox_sfty'
                                   componentCls='form-control' readonly='true'
                                   showStar='false' onChange='${path}Edite.changeJqsp'/>
                </td>
            </tr>
            <tr>
                <td colspan='7'>
                    <cui:textarea maxlength='100' componentCls='form-control' id='jqyjWb' name='jqyjWb'
                                  height='80' readonly='true'/>
                </td>
            </tr>

            <tr>
                <td colspan='7'>
                    <div style='float: right;'>
                        <div>
                            <label>签名:</label>
                            <cui:input componentCls='form-control' id='jqyjQm' name='jqyjQm' readonly='true'
                                       width='150'/>
                            <cui:input type='hidden' componentCls='form-control' id='jqyjQmId' name='jqyjQmId'
                                       width='150'/>
                            <input type='hidden' id='jqyjQz' name='jqyjQz' width='150'>
                        </div>
                        <div style='float: left;'>
                            <label>日期:</label>
                            <cui:datepicker componentCls='form-control' id='jqyjRq' name='jqyjRq'
                                            dateFormat='yyyy-MM-dd HH:ss:mm' showOn='button' readonly='true'
                                            width='150'/>
                        </div>
                    </div>
                </td>
            </tr>

            <tr>
                <td style='vertical-align: middle;' rowspan='3'><label>评审小组意见</label></td>
                <td colspan='7'>
                    <cui:radiolist id='psxzyjJg' name='psxzyjJg' data='combobox_sfty'
                                   componentCls='form-control' readonly='true'
                                   showStar='false' onChange='${path}Edite.changeYzksp'/>
                </td>
            </tr>
            <tr>
                <td colspan='7'>
                    <cui:textarea maxlength='100' componentCls='form-control' id='psxzyjWb' name='psxzyjWb'
                                  height='80' readonly='true'/>
                </td>
            </tr>
            <tr>
                <td colspan='7'>
                    <div style='float: right;'>
                        <div>
                            <label>签名:</label>
                            <cui:input componentCls='form-control' id='psxzyjQm' name='psxzyjQm' readonly='true'
                                       width='150'/>
                            <cui:input type='hidden' componentCls='form-control' id='psxzyjQmId' name='psxzyjQmId'
                                       width='150'/>
                            <input type='hidden' id='psxzyjQz' name='psxzyjQz' width='150'>
                        </div>
                        <div style='float: left;'>
                            <label>日期:</label>
                            <cui:datepicker componentCls='form-control' id='psxzyjRq' name='psxzyjRq'
                                            dateFormat='yyyy-MM-dd HH:ss:mm' showOn='button' readonly='true'
                                            width='150'/>
                        </div>
                    </div>
                </td>
            </tr>

            <tr>
                <td style='vertical-align: middle;' rowspan='3'><label>监狱意见</label></td>
                <td colspan='7'>
                    <cui:radiolist id='jyyjJg' name='jyyjJg' data='combobox_sfty'
                                   componentCls='form-control' readonly='true'
                                   showStar='false' onChange='${path}Edite.changeJysp'/>
                </td>
            </tr>
            <tr>
                <td colspan='7'>
                    <cui:textarea maxlength='100' componentCls='form-control' id='jyyjWb' name='jyyjWb'
                                  height='80' readonly='true'/>
                </td>
            </tr>
            <tr>
                <td colspan='7'>
                    <div style='float: right;'>
                        <div>
                            <label>签名:</label>
                            <cui:input componentCls='form-control' id='jyyjQm' name='jyyjQm' readonly='true'
                                       width='150'/>
                            <cui:input type='hidden' componentCls='form-control' id='jyyjQmId' name='jyyjQmId'
                                       width='150'/>
                            <input type='hidden' id='jyyjQz' name='jyyjQz' width='150'>
                        </div>
                        <div style='float: left;'>
                            <label>日期:</label>
                            <cui:datepicker componentCls='form-control' id='jyyjRq' name='jyyjRq'
                                            dateFormat='yyyy-MM-dd HH:ss:mm' showOn='button' readonly='true'
                                            width='150'/>
                        </div>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <label>附件</label>
                </td>
                <td colspan='7'>
                    <cui:uploader id='affixUpload' uploader='${r'${ctx}'}/affix/upload'
                                  onUploadStart='common.onUploadStart'
                                  onUploadSuccess='common.onUploadSuccess'
                                  swf='${r'${uploadSwf}'}'/>
                </td>
            </tr>
            <tr>
                <td><label>备注</label></td>
                <td colspan='7'>
                    <cui:textarea id='cBz' name='cBz' componentCls='form-control'/>
                </td>
            </tr>
        </table>
        <div>
            <div style='padding-left: 15%;float: left'>
                填表人：
                <cui:input id='cCjr' name='cCjr' isLabel='true'/>
            </div>
            <div style='padding-right: 1%;float: right'>
                填表日期：
                <cui:datepicker id='cCjRq' name='cCjRq' dateFormat='yyyy-MM-dd' isLabel='true'/>
            </div>
        </div>
    </cui:form>
    <div class='dialog-buttons'>
        <cui:button icons='iconSave' countdown='true' id='saveBtn' label='暂存' onClick='${path}Edite.save'
                    style='display:none'/>
        <cui:button icons='iconSign' countdown='true' id='signBtn' label='签收' onClick='${path}Edite.sign'
                    style='display:none'/>
        <cui:button icons='iconSendProcess' countdown='true' id='sendProcessBtn' label='提交'
                    onClick='${path}Edite.sendProcess' style='display:none'/>
        <cui:button icons='iconEndProcess' countdown='true' id='endProcess' label='办结'
                    onClick='${path}Edite.endProcess' style='display:none'/>
        <cui:button icons='iconEndProcess' countdown='true' id='suspendProcess' label='中止'
                    onClick='${path}Edite.endProcess' style='display:none'/>
        <cui:button icons='iconBack' countdown='true' id='sendbanckBtn' label='退回'
                    onClick='${path}Edite.sendBackOn' style='display:none'/>
        <%--
        <cui:button icons='iconBack' countdown='true' id='sendback2Btn' label='退回申请人'
                    onClick='${path}Edite.sendBackSqr' style='display:none'></cui:button>
        --%>
        <cui:button icons='iconChangeUser' countdown='true' id='changeUserBtn' label='转办'
                    onClick='${path}Edite.changeUser' style='display:none'/>
        <cui:button icons='iconDelete' label='关闭' onClick='closeDialog'/>
    </div>
</div>


<cui:dialog id='dialogChangeUser' position='center' reLoadOnOpen='true' modal='true' width='400' height='600'
            autoOpen='false'>
</cui:dialog>

<cui:dialog id='jtcyDialog' reLoadOnOpen='true' modal='true' width='600' height='300' autoOpen='false'>
</cui:dialog>

<cui:dialog id='yjryDialog' reLoadOnOpen='true' modal='true' width='600' height='300' autoOpen='false'>
</cui:dialog>

<cui:dialog id='yjclDialog' reLoadOnOpen='true' modal='true' width='600' height='300' autoOpen='false'>
</cui:dialog>
<script>
    var ${path}Edite = (function () {
        return {
            dialog: $('#dialogChangeUser'),
            form: $('#addDialogForm'),
            parentList: eval('${r'${parentList}'}'),
            id: '${r'${id}'}',
            init: function () {
                if (!'${r'${id}'}') {
                    //新增操作
                    ${path}Edite.showSqr();
                    $("#cCjRq").datepicker('setDate', new Date());
                    $("#cCjr").val(top.user.userName);
                } else if ('${r'${readonly}'}') {
                    //查看操作
                    ${path}Edite.readonly();
                    $('#xm').autocomplete('option', 'isLabel', true).autocomplete('option', 'readonly', true);
                    loadForm('addDialogForm', '${r'${ctx}'}/${path}/find?id=${r'${id}'}', function (data) {
                        $('#xq').textbox('setText', common.setXqWb(data['data']['xq']));
                        $('#zxxq').textbox('setText', common.setXqWb(data['data']['zxxq']));
                        $('#yx').textbox('setText', common.setXqWb(data['data']['yx']));
                    });
                } else {
                    //修改、办理操作
                    var sqr = (!'${r'${taskKey}'} || '${r'${taskKey}'} === 'sqlc');
                    if (sqr) {
                        //申请人节点
                        ${path}Edite.showSqr();
                    } else {
                        //审核、审批节点
                        ${path}Edite.readonly();
                        $('#xm').autocomplete('option', 'isLabel', true).autocomplete('option', 'readonly', true);
                    }
                    loadForm('addDialogForm', '${r'${ctx}'}/${path}/find?id=${r'${id}'}, function (data) {
                    $('#xq').textbox('setText', common.setXqWb(data['data']['xq']));
                    $('#zxxq').textbox('setText', common.setXqWb(data['data']['zxxq']));
                    $('#yx').textbox('setText', common.setXqWb(data['data']['yx']));
                    if (!sqr && '${r'${claimStatus}'}' === 'N') {
                        //审核、审批节点未签收
                        $('#signBtn').show();
                    } else if (!sqr) {
                        //审核、审批节点已签收
                        ${path}Edite.initButton();
                    }
                }
            );
    }
    },
    showSqr: function () {
        $('#saveBtn').show();
        $('#sendProcessBtn').show();
        ${path}Edite.loadAffix(false);
    }
    ,
    loadAffix: function (bool) { //boole 为true(隐藏) 和false
        common.loadAffix('affixUpload', '${r'${id}'}', bool);
        if (bool) {
            $('#affixUpload_uploader').remove();
        }
            },
    readonly: function () {
        ${path}Edite.loadAffix(true);
        ${path}Edite.form.form('setIsLabel', true);
    }
    ,

    initButton: function () {
        $('#saveBtn').show();
        ${path}Edite.initText()
    }
    ,
    initText: function () {
        if ('${r'${taskKey}'} === 'fjqsp_fjq
        ') {//监区节点
        ${path}Edite.initSpxx('fjqyjJg', 'fjqyjWb', 'fjqyjQmId', 'fjqyjQm', 'fjqyjRq');
        ${path}Edite.changeFjqsp();
    }
    else
    if ('${r'${taskKey}'}' === 'jqsp_jq') {//监区节点
        ${path}Edite.initSpxx('jqyjJg', 'jqyjWb', 'jqyjQmId', 'jqyjQm', 'jqyjRq');
        ${path}Edite.changeJqsp();
    } else if ('${r'${taskKey}'} === 'psxzsp
    ') {//科室节点
    ${path}Edite.initSpxx('psxzyjJg', 'psxzyjWb', 'psxzyjQmId', 'psxzyjQm', 'psxzyjRq');
    ${path}Edite.changeYzksp();
    } else
    if ('${r'${taskKey}'}' === 'jysp') {//监狱节点
        ${path}Edite.initSpxx('jyyjJg', 'jyyjWb', 'jyyjQmId', 'jyyjQm', 'jyyjRq');
        ${path}Edite.changeJysp();
    }
    },
    initSpxx: function (jg, yj, sprId, sprName, rq) {
        $('#' + jg).radiolist('option', 'readonly', false)
                .radiolist('option', 'isLabel', false)
                .radiolist('option', 'required', true);
        $('#' + yj).textbox('option', 'readonly', false);
        $('#' + sprId).textbox('setValue', top.user.userId);
        $('#' + sprName).textbox('setValue', top.user.userName);
        $('#' + rq).datepicker('option', 'value', '<%=DateUtils.getCurrentDate()%>');
    }
    ,
    changeFjqsp: function () {
        ${path}Edite.changeSpjg('fjqyjJg', 'fjqyjWb');
    }
    ,
    changeJqsp: function () {
        ${path}Edite.changeSpjg('jqyjJg', 'jqyjWb');
    }
    ,
    changeYzksp: function () {
        ${path}Edite.changeSpjg('psxzyjJg', 'psxzyjWb');
    }
    ,
    changeJysp: function () {
        ${path}Edite.changeSpjg('jyyjJg', 'jyyjWb');
    }
    ,
    changeYzcsp: function () {
        $('#spJg').textbox('setValue', ${path}Edite.changeSpjg('yzcyjJg', 'yzcyjWb'));
    }
    ,
    changeSpjg: function (spJg, spYj) {
        var jg = $('#' + spJg).radiolist('getValue');
        ${path}Edite.changeButton(jg);
        var value = $('#' + spYj).textbox('getValue')
        if (!value || value === '同意' || value === '不同意') {
            $('#' + spYj).textbox('setValue', $('#' + spJg).radiolist('getText'));
        }

    }
    ,
    changeButton: function (spjg) {
        if (spjg === 'Y') {
            if ('${r'${taskKey}'}' === 'jysp') {//最后节点
                $('#endProcess').show();
                $('#spJg').textbox('setValue', 'Y')
            } else {
                $('#sendProcessBtn').show();
            }
            $('#suspendProcess').hide();
            $('#sendbanckBtn').hide();
            /* $('#sendback2Btn').hide();*/
            $('#changeUserBtn').show();
        } else if (spjg === 'N') {
            $('#spJg').textbox('setValue', 'N');
            $('#suspendProcess').show();
            $('#sendbanckBtn').show();
            /* $('#sendback2Btn').show();*/
            $('#endProcess').hide();
            $('#sendProcessBtn').hide();
            $('#changeUserBtn').show();
        }
    }
    ,
    sign: function () {
        $.ajax({
            url: '${r'${ctx}'}/${path}/claimTaskByProcessInstanceId',
            type: 'post',
            data: {
                processInstanceId: '${r'${processInstanceId}'}', taskId: '${r'${taskId}'}',
                dataType: 'json',
                success: function (data) {
                    if (data.status === 'success') {
                        $.message('签收成功');
                        ${path}Edite.parentList.grid.grid('reload');
                        $('#signBtn').hide();
                        ${path}Edite.initButton();
                    } else {
                        $.message({message: '操作异常！', cls: 'warning'});
                    }
                }
            });
    }
    ,
    activtiSelect: function (processDefKey, processInstanceId, taskId, taskKey) {
        ${path}Edite.dialog.dialog('option', {
            title: '选择',
            //controller=?
            url: '${r'${ctx}'}/modelTaskUser?_url=/common/activiti/selectUser&parentEdit=${path}Edite&parentList=${r'${parentList}'}&controller=${path}&processDefKey=' + processDefKey + '&processInstanceId=' + processInstanceId + '&taskId=' + taskId + '&taskKey=' + taskKey
        });
        ${path}Edite.dialog.dialog('open');
            },
    save: function () {
        ${path}Edite.complete('${r'${ctx}'}/${path}/save', function (data) {
            if (data.status === 'success') {
                $.message('保存成功');
                ${path}Edite.parentList.grid.grid('reload');
                ${path}Edite.parentList.dialog.dialog('close');
            } else {
                $.message({message: '操作异常！', cls: 'warning'});
            }
        });
    }
    ,
    saveAndSendProcess: function () {
        ${path}Edite.complete('${r'${ctx}'}/${path}/saveAndStartPrcess', function (data) {
            if (data.status === 'success') {
                ${path}Edite.activtiSelect(data.data.processDefId, data.data.processInstanceId, data.data.taskId, data.data.taskKey);
                ${path}Edite.parentList.grid.grid('reload');
                ${path}Edite.parentList.dialog.dialog('close');
            } else {
                $.message({message: '操作异常！', cls: 'warning'});
            }
        });
    }
    ,
    sendProcess: function () {
        //保存并且提交
        if (!$('#processInstanceId').textbox('getValue')) {
            ${path}Edite.saveAndSendProcess();
        } else {
            ${path}Edite.complete('${r'${ctx}'}/${path}/save', function (data) {
                if (data.status === 'success') {
                    ${path}Edite.activtiSelect('${r'${processDefKey}'}', '${r'${processInstanceId}'}', '${r'${taskId}'}', '${r'${taskKey}'}');
                    ${path}Edite.parentList.dialog.dialog('close');
                } else {
                    $.message({message: '操作异常！', cls: 'warning'});
                }
            });
        }
    }
    ,
    sendBackOn: function () {
        ${path}Edite.complete('${r'${ctx}'}/${path}/save', function (data) {
            if (data.status === 'success') {
                $.ajax({
                    url: '${r'${ctx}'}/${path}/sendBackLastStep',
                    type: 'post',
                    data: {
                        processInstanceId: '${r'${processInstanceId}'}', taskId: '${r'${taskId}'}',
                        dataType: 'json',
                        success: function (data) {
                            if (data.status === 'success') {
                                $.message('退回成功');
                                ${path}Edite.parentList.grid.grid('reload');
                                ${path}Edite.parentList.dialog.dialog('close');
                            } else {
                                $.message({message: '操作异常！', cls: 'warning'});
                            }
                        }
                    });
            } else {
                $.message({message: '操作异常！', cls: 'warning'});
            }
        });
    }
    ,
    endProcess: function () {
        ${path}Edite.complete('${r'${ctx}'}/${path}/save', function (data) {
            if (data.status === 'success') {
                $.ajax({
                    url: '${r'${ctx}'}/${path}/completeProcess',
                    type: 'post',
                    data: {
                        userIds: '',
                        processInstanceId: '${r'${processInstanceId}'}',
                        taskId: '${r'${taskId}'}',
                        nextTaskKey: '<%=BpmnConst.ENDEVENT%>',
                        spJg: $('#spJg').textbox('getValue')
                    },
                    dataType: 'json',
                    success: function (data) {
                        if (data.status === 'success') {
                            ${path}Edite.parentList.grid.grid('reload');
                            ${path}Edite.parentList.dialog.dialog('close');
                            $.message({message: '操作成功！', cls: 'success'});
                        } else {
                            $.message({message: '操作异常！', cls: 'warning'});
                        }
                    }
                });
            } else {
                $.message({message: '操作异常！', cls: 'warning'});
            }
        });
    }
    ,
    changeUser: function () {
        ${path}Edite.complete('${r'${ctx}'}/${path}/save', function (data) {
            if (data.status === 'success') {
                ${path}Edite.dialog.dialog('option', {
                    title: '选择',
                    url: '${r'${ctx}'}/modelTaskUser?_url=/common/activiti/changeUser&parentEdit=${path}Edite&parentList=${r'${parentList}'}&processDefKey=${r'${processDefKey}'}&processInstanceId=${r'${processInstanceId}'}&taskId=${r'${taskId}'}&taskKey=${r'${taskKey}'}&controller=${path}'
                });
                ${path}Edite.dialog.dialog('open');
                ${path}Edite.parentList.dialog.dialog('close');
            } else {
                $.message({message: '操作异常！', cls: 'warning'});
            }
        });
    }
    ,
    complete: function (url, fn) {
        if (${path}Edite.form.form('valid')) {
            $.ajax({
                url: url,
                type: 'post',
                data: ${path}Edite.form.form('formData', false),
                dataType: 'json',
                success: fn
            });
        } else {
            $.alert('请填完所有的必输项，再保存！');
                }
            }
    }
    })();
    $.parseDone(function () {
        common.initXmAutoComplete(undefined, undefined, '${r'${ctx}'}/jbxx/getZfxx?fxzt1=1&sfL=N');
        ${path}Edite.init();
    });

</script>


</body>
</html>
