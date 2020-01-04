package ${serviceImplPackageName};

import ${daoPath};
import ${entityPath};
import ${servicePath};

import com.cesgroup.prison.platform.common.constant.ProcessConst;
import com.cesgroup.prison.platform.common.system.affix.service.IAffixService;
import com.cesgroup.prison.platform.common.system.auth.entity.UserBean;
import com.cesgroup.prison.platform.common.system.base.service.BaseService;
import com.cesgroup.prison.platform.common.system.workflow.facade.WorkflowFacade;
import com.cesgroup.prison.platform.common.util.LoginUtil;
import com.cesgroup.prison.platform.common.util.PagerModel;
import com.cesgroup.prison.platform.common.util.StringUtil;
import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.page.PageMethod;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


@Service
@Transactional
public class ${objectNameUpper}Service extends BaseService implements I${objectNameUpper}Service {
	@Autowired
	IAffixService affixService;

	@Autowired
	private ${objectNameUpper}Mapper ${objectNameLower}Mapper;

    @Override
    public ${objectNameUpper} save(${objectNameUpper} record) {
        return save(record, null);
    }


    @Override
    public ${objectNameUpper} save(${objectNameUpper} record, String affixIds) {
        prepareSave(record);
${objectNameLower}Service.insertSelective(record);
        affixService.update(record.getId(), affixIds);
        return record;
    }

    @Override
    public ${objectNameUpper} update(${objectNameUpper} record) {
        return update(record, null);
    }

    @Override
    public ${objectNameUpper} update(${objectNameUpper} record, String affixIds) {
        prepareUpdate(record);
${objectNameLower}Service.updateByPrimaryKeySelective(record);
        affixService.update(record.getId(), affixIds);
        return record;
    }

    @Override
    public void remove(String id) {
${objectNameUpper} record = new ${objectNameUpper}();
        record.setId(id);
        prepareRemove(record);
${objectNameLower}Service.removeList(record, Collections.singletonList(record.getId()));
    }

    @Override
    @Transactional(readOnly = true)
    public ${objectNameUpper} find(String id) {
        return ${objectNameLower}Service.selectByPrimaryKey(id);
    }

    @Override
    @Transactional(readOnly = true)
    public PagerModel findSqList(${objectNameUpper} record, int pageNum, int pageSize, String orderBy) {
        String[] order = orderBy.split(",");
        Page<${objectNameUpper}> page = PageMethod.startPage(pageNum, pageSize, StringUtil.propertyToField(order[0]) + " " + order[1]);
    UserBean userBean = LoginUtil.getUserFromCookie();
    record.setcCjrId(userBean.getUserId());
${objectNameLower}Service.selectListMap(record);
    return new PagerModel(page.getTotal(), page.getResult(), pageNum, pageSize);
    }

    @Override
    @Transactional(readOnly = true)
    public PagerModel findDjList(${objectNameUpper} record, int pageNum, int pageSize, String order) {
    	Page<${objectNameUpper}> page = PageHelper.startPage(pageNum, pageSize, order);
${objectNameLower}Service.selectList(record);
        return new PagerModel(page.getTotal(), page.getResult(), pageNum, pageSize);
    }

    @Override
    @Transactional(readOnly = true)
    public PagerModel findDbList(Map
<String, Object> param, int pageNum, int pageSize, String order) {
        return WorkflowFacade.findDbListPage(pageNum, pageSize, order,
        	LoginUtil.getUserFromCookie().getUserId(), ProcessConst.Process.你的类.BUSINESS_TABLE, WorkflowFacade.getWhereSql(map));
    }

    @Override
    @Transactional(readOnly = true)
    public PagerModel findYbList(Map
<String, Object> map, int pageNum, int pageSize, String order) {
        return WorkflowFacade.findYbListPage(pageNum, pageSize, order,
        	LoginUtil.getUserFromCookie().getUserId(), ProcessConst.Process.你的类.BUSINESS_TABLE, WorkflowFacade.getWhereSql(map));
    }

    @Override
    @Transactional(readOnly = true)
    public PagerModel findBjList(Map
<String, Object> map, int pageNum, int pageSize, String order) {
        return WorkflowFacade.findBjListPage(pageNum, pageSize, order,
        	LoginUtil.getUserFromCookie().getUserId(), ProcessConst.Process.你的类.BUSINESS_TABLE, WorkflowFacade.getWhereSql(map));
    }

    @Override
    public Map
<String, Object> saveAndStartPrcess(${objectNameUpper} record) {
        if (StringUtils.isBlank(record.getId())) {
        	save(record);
        }
        Map
<String, Object> map = WorkflowFacade.startProcess(ProcessConst.Process.你的类.PROCESS_KEY, record.getId(), new HashMap<>(), LoginUtil.getUserFromCookie().getUserId());
        record.setProcessInstanceId(String.valueOf(map.get("processInstanceId")));
        update(record);
        return map;
    }

}
