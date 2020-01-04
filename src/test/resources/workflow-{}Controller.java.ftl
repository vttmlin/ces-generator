package ${controllerPackageName};

import javax.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import com.cesgroup.prison.platform.common.system.base.web.BaseController;
import com.cesgroup.prison.platform.common.system.log.annotation.Log;
import com.cesgroup.prison.platform.common.constant.ModuleConst;
import ${entityPath};
import ${servicePath};
import org.apache.commons.lang3.StringUtils;
import com.cesgroup.prison.platform.common.util.PagerModel;
import com.cesgroup.prison.platform.common.util.ResultInfo;
import java.util.List;
import java.util.Objects;

@RestController
@RequestMapping("/${path}")
public class ${objectNameUpper}Controller extends BaseController {

	@Autowired
	private I${objectNameUpper}Service ${objectNameLower}Service;   

    /**
     * 保存数据或修改数据
     */
    @Log(root = true, module = ModuleConst., operation = OperationConst.FIND)
    @RequestMapping("/save")
    public ResultInfo save(${objectNameUpper} record) {
        ResultInfo resultInfo = new ResultInfo();
        try {
            if (StringUtils.isBlank(record.getId())) {
${objectNameLower}Service.save(record);
            } else {
${objectNameLower}Service.update(record);
            }
            resultInfo.setStatus(SUCCESS);
        } catch (Exception e) {
            resultInfo.setStatus(ERROR);
            e.printStackTrace();
            log(e);
        }
        return resultInfo;
    }


    /**
     * 删除数据
     */
    @Log(root = true, module = ModuleConst, operation = OperationConst.REMOVE)
    @RequestMapping("/remove")
    public ResultInfo remove(String id) {
        ResultInfo resultInfo = new ResultInfo();
        try {
${objectNameLower}Service.remove(id);
            resultInfo.setStatus(SUCCESS);
        } catch (Exception e) {
            resultInfo.setStatus(ERROR);
            e.printStackTrace();
            log(e);
        }
        return resultInfo;
    }

    /**
     * 获取数据
     */
    @Log(root = true, module = ModuleConst, operation = OperationConst.FIND)
    @RequestMapping("/find")
    public ResultInfo find(String id) {
        ResultInfo resultInfo = new ResultInfo();
        try {
            resultInfo.setData(${objectNameLower}Service.find(id));
            resultInfo.setStatus(SUCCESS);
        } catch (Exception e) {
            resultInfo.setStatus(ERROR);
            e.printStackTrace();
            log(e);
        }
        return resultInfo;
    }

    /**
     * 保存并启动
     */
    @Log(root = true, module = ModuleConst, operation = OperationConst.PROCESS_QD)
    @RequestMapping("/saveAndStartPrcess")
    public ResultInfo saveAndStartPrcess(${objectNameUpper} record) {
        ResultInfo resultInfo = new ResultInfo();
        try {
            resultInfo.setData(${objectNameLower}Service.saveAndStartPrcess(record));
            resultInfo.setStatus(SUCCESS);
        } catch (Exception e) {
            resultInfo.setStatus(ERROR);
            e.printStackTrace();
            log(e);
            log(e);
        }
        return resultInfo;
    }

    /**
     * 处理流程
     */
    @Log(root = true, module = ModuleConst, operation = OperationConst.PROCESS_TJ)
    @RequestMapping("/completeProcess")
    public ResultInfo completeProcess(@RequestParam Map
<String, Object> map) {
        ResultInfo resultInfo = new ResultInfo();
        try {
${objectNameLower}Service.completeProcess(map);
            resultInfo.setStatus(SUCCESS);
        } catch (Exception e) {
            resultInfo.setStatus(ERROR);
            e.printStackTrace();
            log(e);
            log(e);
        }
        return resultInfo;
    }

    /**
     * 获取申请箱
     */
    @RequestMapping("/findSqList")
    public PagerModel findSqList(@RequestParam(name = "P_pageNumber") Integer pageNum,
                                 @RequestParam(name = "P_pagesize") Integer pageSize,
                                 @RequestParam(name = "P_orders", required = false) String orders,
${objectNameUpper} record) {
        PagerModel page = null;
        try {
            page = ${objectNameLower}Service.findSqList(record, pageNum, pageSize, getOrder(Collections.singletonMap("P_orders", orders), "C_CJ_RQ DESC"));
        } catch (Exception e) {
            e.printStackTrace();
        }
        return page;
    }

    /**
     * 获取待办箱
     */
    @RequestMapping("/findDbList")
    public PagerModel findDbList(@RequestParam Map
<String, Object> map) {
        PagerModel page = null;
        try {
            page = ${objectNameLower}Service.findDbList(map, getIntValue(map.get("P_pageNumber")),
                    getIntValue(map.get("P_pagesize")), getOrder(map, "C_CJ_RQ DESC"));
        } catch (Exception e) {
            e.printStackTrace();
        }
        return page;
    }

    /**
     * 获取已办箱
     */
    @RequestMapping("/findYbList")
    public PagerModel findYbList(@RequestParam Map
<String, Object> map) {
        PagerModel page = null;
        try {
            page = ${objectNameLower}Service.findYbList(map, getIntValue(map.get("P_pageNumber")),
                    getIntValue(map.get("P_pagesize")), getOrder(map, "C_CJ_RQ DESC"));
        } catch (Exception e) {
            e.printStackTrace();
        }
        return page;
    }

    /**
     * 获取办结箱
     */
    @RequestMapping("/findBjList")
    public PagerModel findBjList(@RequestParam Map
<String, Object> map) {
        PagerModel page = null;
        try {
            page = ${objectNameLower}Service.findBjList(map, getIntValue(map.get("P_pageNumber")),
                    getIntValue(map.get("P_pagesize")), getOrder(map, "C_CJ_RQ DESC"));
        } catch (Exception e) {
            e.printStackTrace();
        }
        return page;
    }

    /**
     * 获取登记箱
     */
    @RequestMapping("/findDjList")
    public PagerModel findDjList(@RequestParam(name = "P_pageNumber") Integer pageNum,
                                 @RequestParam(name = "P_pagesize") Integer pageSize,
                                 @RequestParam(name = "P_orders", required = false) String orders,
${objectNameUpper} record) {
        PagerModel page = null;
        try {
            page = ${objectNameLower}Service.findDjList(record, pageNum, pageSize, StringUtils.isBlank(orders) ? "C_CJ_RQ DESC" : orders);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return page;
    }

    /**
     * 签收流程
     */
    @Log(root = true, module = ModuleConst, operation = OperationConst.PROCESS_QS)
    @RequestMapping("/claimTaskByProcessInstanceId")
    public ResultInfo claimTaskByProcessInstanceId(@RequestParam Map
<String, Object> map) {
        ResultInfo resultInfo = new ResultInfo();
        try {
${objectNameLower}Service.claimTaskByProcessInstanceId(map.get("processInstanceId").toString(), map.get("taskId").toString());
            resultInfo.setStatus(SUCCESS);
        } catch (Exception e) {
            resultInfo.setStatus(ERROR);
            e.printStackTrace();
            log(e);
        }
        return resultInfo;
    }

    /**
     * 退回申请人
     */
    @Log(root = true, module = ModuleConst, operation = OperationConst.PROCESS_THSQR)
    @RequestMapping("/sendBackApplicant")
    public ResultInfo sendBackApplicant(@RequestParam Map
<String, Object> map) {
        ResultInfo resultInfo = new ResultInfo();
        try {
${objectNameLower}Service.sendBackApplicant(map.get("processInstanceId").toString(), map.get("taskId").toString());
            resultInfo.setStatus(SUCCESS);
        } catch (Exception e) {
            resultInfo.setStatus(ERROR);
            e.printStackTrace();
            log(e);
        }
        return resultInfo;
    }

    /**
     * 退回上一步
     */
    @Log(root = true, module = ModuleConst, operation = OperationConst.PROCESS_THSYB)
    @RequestMapping("/sendBackLastStep")
    public ResultInfo sendBackLastStep(@RequestParam Map
<String, Object> map) {
        ResultInfo resultInfo = new ResultInfo();
        try {
${objectNameLower}Service.sendBackLastStep(map.get("processInstanceId").toString(), map.get("taskId").toString());
            resultInfo.setStatus(SUCCESS);
        } catch (Exception e) {
            resultInfo.setStatus(ERROR);
            e.printStackTrace();
            log(e);
        }
        return resultInfo;
    }

    /**
     * 转办流程
     */
    @Log(root = true, module = ModuleConst, operation = OperationConst.PROCESS_ZB)
    @RequestMapping("/transfer")
    public ResultInfo transfer(@RequestParam Map
<String, Object> map) {
        ResultInfo resultInfo = new ResultInfo();
        try {
${objectNameLower}Service.transfer(map.get("processInstanceId").toString(), map.get("taskId").toString(), map.get("handlers").toString());
            resultInfo.setStatus(SUCCESS);
        } catch (Exception e) {
            resultInfo.setStatus(ERROR);
            e.printStackTrace();
            log(e);
        }
        return resultInfo;
    }

/**
     * 保存并启动
     */
    @Log(root = true, module = ModuleConst, operation = OperationConst.PROCESS_QD)
    @RequestMapping("/saveAndStartPrcess")
    public ResultInfo saveAndStartPrcess(${objectNameUpper} record) {
        ResultInfo resultInfo = new ResultInfo();
        try {
            resultInfo.setData(${objectNameLower}Service.saveAndStartPrcess(record));
            resultInfo.setStatus(SUCCESS);
        } catch (Exception e) {
            resultInfo.setStatus(ERROR);
            e.printStackTrace();
            log(e);
        }
        return resultInfo;
    }

    /**
     * 处理流程
     */
    @Log(root = true, module = ModuleConst, operation = OperationConst.PROCESS_TJ)
    @RequestMapping("/completeProcess")
    public ResultInfo completeProcess(@RequestParam Map
<String, Object> map) {
        ResultInfo resultInfo = new ResultInfo();
        try {
${objectNameLower}Service.completeProcess(map);
            resultInfo.setStatus(SUCCESS);
        } catch (Exception e) {
            resultInfo.setStatus(ERROR);
            e.printStackTrace();
            log(e);
        }
        return resultInfo;
    }

    /**
     * 获取申请箱
     */
    @RequestMapping("/findSqList")
    public PagerModel findSqList(@RequestParam(name = "P_pageNumber") Integer pageNum,
                                 @RequestParam(name = "P_pagesize") Integer pageSize,
                                 @RequestParam(name = "P_orders", required = false) String orders,
${objectNameUpper} record) {
        PagerModel page = null;
        try {
            page = ${objectNameLower}Service.findSqList(record, pageNum, pageSize, getOrder(Collections.singletonMap("P_orders", orders), "C_CJ_RQ DESC"));
        } catch (Exception e) {
            e.printStackTrace();
        }
        return page;
    }

    /**
     * 获取待办箱
     */
    @RequestMapping("/findDbList")
    public PagerModel findDbList(@RequestParam Map
<String, Object> map) {
        PagerModel page = null;
        try {
            page = ${objectNameLower}Service.findDbList(map, getIntValue(map.get("P_pageNumber")),
                    getIntValue(map.get("P_pagesize")), getOrder(map, "C_CJ_RQ DESC"));
        } catch (Exception e) {
            e.printStackTrace();
        }
        return page;
    }

    /**
     * 获取已办箱
     */
    @RequestMapping("/findYbList")
    public PagerModel findYbList(@RequestParam Map
<String, Object> map) {
        PagerModel page = null;
        try {
            page = ${objectNameLower}Service.findYbList(map, getIntValue(map.get("P_pageNumber")),
                    getIntValue(map.get("P_pagesize")), getOrder(map, "C_CJ_RQ DESC"));
        } catch (Exception e) {
            e.printStackTrace();
        }
        return page;
    }

    /**
     * 获取办结箱
     */
    @RequestMapping("/findBjList")
    public PagerModel findBjList(@RequestParam Map
<String, Object> map) {
        PagerModel page = null;
        try {
            page = ${objectNameLower}Service.findBjList(map, getIntValue(map.get("P_pageNumber")),
                    getIntValue(map.get("P_pagesize")), getOrder(map, "C_CJ_RQ DESC"));
        } catch (Exception e) {
            e.printStackTrace();
        }
        return page;
    }

    /**
     * 获取登记箱
     */
    @RequestMapping("/findDjList")
    public PagerModel findDjList(@RequestParam(name = "P_pageNumber") Integer pageNum,
                                 @RequestParam(name = "P_pagesize") Integer pageSize,
                                 @RequestParam(name = "P_orders", required = false) String orders,
${objectNameUpper} record) {
        PagerModel page = null;
        try {
            page = ${objectNameLower}Service.findDjList(record, pageNum, pageSize, getOrder(Collections.singletonMap("P_orders", orders), "C_CJ_RQ DESC"));
        } catch (Exception e) {
            e.printStackTrace();
        }
        return page;
    }

    /**
     * 签收流程
     */
    @Log(root = true, module = ModuleConst, operation = OperationConst.PROCESS_QS)
    @RequestMapping("/claimTaskByProcessInstanceId")
    public ResultInfo claimTaskByProcessInstanceId(@RequestParam Map
<String, Object> map) {
        ResultInfo resultInfo = new ResultInfo();
        try {
${objectNameLower}Service.claimTaskByProcessInstanceId(map.get("processInstanceId").toString(), map.get("taskId").toString());
            resultInfo.setStatus(SUCCESS);
        } catch (Exception e) {
            resultInfo.setStatus(ERROR);
            e.printStackTrace();
            log(e);
        }
        return resultInfo;
    }

    /**
     * 退回申请人
     */
    @Log(root = true, module = ModuleConst, operation = OperationConst.PROCESS_THSQR)
    @RequestMapping("/sendBackApplicant")
    public ResultInfo sendBackApplicant(@RequestParam Map
<String, Object> map) {
        ResultInfo resultInfo = new ResultInfo();
        try {
${objectNameLower}Service.sendBackApplicant(map.get("processInstanceId").toString(), map.get("taskId").toString());
            resultInfo.setStatus(SUCCESS);
        } catch (Exception e) {
            resultInfo.setStatus(ERROR);
            e.printStackTrace();
            log(e);
        }
        return resultInfo;
    }

    /**
     * 退回上一步
     */
    @Log(root = true, module = ModuleConst, operation = OperationConst.PROCESS_THSYB)
    @RequestMapping("/sendBackLastStep")
    public ResultInfo sendBackLastStep(@RequestParam Map
<String, Object> map) {
        ResultInfo resultInfo = new ResultInfo();
        try {
${objectNameLower}Service.sendBackLastStep(map.get("processInstanceId").toString(), map.get("taskId").toString());
            resultInfo.setStatus(SUCCESS);
        } catch (Exception e) {
            resultInfo.setStatus(ERROR);
            e.printStackTrace();
            log(e);
        }
        return resultInfo;
    }

    /**
     * 转办流程
     */
    @Log(root = true, module = ModuleConst, operation = OperationConst.PROCESS_ZB)
    @RequestMapping("/transfer")
    public ResultInfo transfer(@RequestParam Map
<String, Object> map) {
        ResultInfo resultInfo = new ResultInfo();
        try {
${objectNameLower}Service.transfer(map.get("processInstanceId").toString(), map.get("taskId").toString(), map.get("handlers").toString());
            resultInfo.setStatus(SUCCESS);
        } catch (Exception e) {
            resultInfo.setStatus(ERROR);
            e.printStackTrace();
            log(e);
        }
        return resultInfo;
    }
}
