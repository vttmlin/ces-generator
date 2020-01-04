package ${servicePackageName};

import ${entityPath};
import com.cesgroup.prison.platform.common.system.workflow.facade.WorkflowFacade;
import com.cesgroup.prison.platform.common.util.LoginUtil;
import com.cesgroup.prison.platform.common.util.PagerModel;
import com.cesgroup.prison.platform.xfzx.ylgl.lbcrdlc.entity.LbcRdLc;
import org.apache.commons.collections.CollectionUtils;
import com.cesgroup.prison.platform.common.util.PagerModel;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;

public interface I${objectNameUpper}Service {
    PagerModel findSqList(${objectNameUpper} record, int pageNum, int pageSize, String order);

${objectNameUpper} save(${objectNameUpper} record, String affixIds);

${objectNameUpper} save(${objectNameUpper} record);

${objectNameUpper} update(${objectNameUpper} record);

${objectNameUpper} update(${objectNameUpper} record, String affixIds);

    void remove(String id);

${objectNameUpper} find(String id);

    /**
     * 获取登记箱
     */
    PagerModel finDjList(${objectNameUpper} record, int pageNum, int pageSize, String order);

    /**
     * 获取待办箱
     */
    PagerModel findDjList(Map
<String, Object> map, int pageNum, int pageSize, String order);

    /**
     * 获取已办箱
     */
    PagerModel findYbList(Map
<String, Object> map, int pageNum, int pageSize, String order);

    /**
     * 获取办结箱
     */
    PagerModel findBjList(Map
<String, Object> map, int pageNum, int pageSize, String order);

    /**
     * 保存并启动流程
     */
    Map
<String, Object> saveAndStartPrcess(${objectNameUpper} record);

    /**
     * 签收
     */
    default void claimTaskByProcessInstanceId(String processInstanceId, String taskId) {
        WorkflowFacade.claimTaskByProcessInstanceId(LoginUtil.getUserFromCookie().getUserId(), processInstanceId, taskId);
    }

    /**
     * 提交至下一步
     */
    default void completeProcess(Map
<String, Object> map) {
        Map
<String, Object> variables = new HashMap<>();//此为扩展参数，暂时不用
        WorkflowFacade.completeProcess(String.valueOf(map.get("processInstanceId")), String.valueOf(map.get("taskId")),
                variables, String.valueOf(map.get("nextTaskKey")), String.valueOf(map.get("userIds")));
    }

    /**
    * 退回申请人
    *
    * @param taskId 流程节点id
    */
    default void sendBackApplicant(String processInstanceId, String taskId) {
        WorkflowFacade.sendBackApplicant(processInstanceId, taskId);
    }

    /**
    * 退回上一步
    *
    * @param taskId 流程节点id
    */
    default void sendBackLastStep(String processInstanceId, String taskId) {
        WorkflowFacade.sendBackLastStep(processInstanceId, taskId);
    }


    /**
    * 转办当前流程
    */
    default void transfer(String processInstanceId, String taskId, String handlers) {
        WorkflowFacade.transfer(processInstanceId, taskId, LoginUtil.getUserFromCookie().getUserId(), handlers);
    }

}
