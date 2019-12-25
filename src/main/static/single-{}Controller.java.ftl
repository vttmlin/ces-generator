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

    @Log(root = true)
    @RequestMapping(value = "/findList")
    public PagerModel findList(@RequestParam(name = "P_pageNumber") Integer pageNum,
                               @RequestParam(name = "P_pagesize") Integer pageSize,
                               @RequestParam(name = "P_orders",required = false) String orders,
        ${objectNameUpper} record) {
        PagerModel page = null;
        try {
            page = ${objectNameLower}Service.findList(record, pageNum, pageSize,orders);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return page;
    }

    @RequestMapping(value = "/save")
    public ResultInfo save(${objectNameUpper} record, String affixIds, HttpServletRequest request) {
        ResultInfo resultInfo = new ResultInfo();
        try {
            if (Objects.nonNull(record) && StringUtils.isEmpty(record.getId())) {
                ${objectNameLower}Service.save(record, affixIds);
            } else {
                ${objectNameLower}Service.update(record, affixIds);
            }
            resultInfo.setStatus(SUCCESS);
        } catch (Exception e) {
            resultInfo.setStatus(ERROR);
            e.printStackTrace();
        }
        return resultInfo;
    }

    @Log(root = true)
    @RequestMapping(value = "/find")
    public ResultInfo find(String id) {
        ResultInfo resultInfo = new ResultInfo();
        try {
            resultInfo.setData(${objectNameLower}Service.find(id));
            resultInfo.setStatus(SUCCESS);
        } catch (Exception e) {
            resultInfo.setStatus(ERROR);
            e.printStackTrace();
        }
        return resultInfo;
    }

    @RequestMapping(value = "/remove")
    public ResultInfo remove(@RequestBody List<String> list) {
    ResultInfo resultInfo = new ResultInfo();
        try {
            ${objectNameLower}Service.remove(list);
            resultInfo.setStatus(SUCCESS);
        } catch (Exception e) {
            resultInfo.setStatus(ERROR);
            e.printStackTrace();
        }
        return resultInfo;
    }
}
