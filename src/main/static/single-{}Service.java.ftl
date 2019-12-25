package ${serviceImplPackageName};

import com.cesgroup.prison.platform.common.system.affix.service.IAffixService;
import ${daoPath};
import ${entityPath};
import org.apache.commons.lang3.StringUtils;
import com.cesgroup.prison.platform.common.util.StringUtil;
import ${servicePath};
import com.cesgroup.prison.platform.common.system.base.service.BaseService;
import com.cesgroup.prison.platform.common.util.PagerModel;
import com.github.pagehelper.Page;
import com.github.pagehelper.page.PageMethod;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Collections;
import java.util.List;

@Service
@Transactional
public class ${objectNameUpper}Service extends BaseService implements I${objectNameUpper}Service {
	@Autowired
	IAffixService affixService;

	@Autowired
	private ${objectNameUpper}Mapper ${objectNameLower}Mapper;

	/**
	 * 支持附件上传
	*/
	public ${objectNameUpper} save(${objectNameUpper} record, String affixIds){
		prepareSave(record);
		${objectNameLower}Mapper.insertSelective(record);
       	affixService.update(record.getId(), affixIds);
		return record;
	}

	@Override
	public void update(${objectNameUpper} record) {
		prepareUpdate(record);
		${objectNameLower}Mapper.updateByPrimaryKeySelective(record);
	}

	@Override
	public void update(${objectNameUpper} record, String affixIds) {
		prepareUpdate(record);
		${objectNameLower}Mapper.updateByPrimaryKeySelective(record);
		affixService.update(record.getId(), affixIds);
	}

	@Override
	public void remove(${objectNameUpper} record) {
		prepareRemove(record);
		${objectNameLower}Mapper.removeList(record, Collections.singletonList(record.getId()));
		affixService.removeByYwId(record.getId());
	}

	@Override
	@Transactional(readOnly = true)
	public PagerModel findList(${objectNameUpper} record, int pageNum, int pageSize,String orderBy) {
		String[] order = orderBy.split(",");
        Page<${objectNameUpper}> page = PageMethod.startPage(pageNum, pageSize, StringUtil.propertyToField(order[0]) + " " + order[1]);
		${objectNameLower}Mapper.selectList(record);
        return new PagerModel(page.getTotal(), page.getResult(), pageNum, pageSize);
    }

    @Override
    @Transactional(readOnly = true)
    public ${objectNameUpper} find(String id) {
    	return ${objectNameLower}Mapper.selectByPrimaryKey(id);
    }

	@Override
	public void remove(List<String> ids){
		${objectNameUpper} record = new ${objectNameUpper}();
    	prepareRemove(record);
		${objectNameLower}Mapper.removeList(record, ids);
    }


    @Override
    public void findListByIds(List<String> ids){
    	${objectNameLower}Mapper.selectListByIds(ids);
    }

}
