package ${serivceImplPackage};

import com.cesgroup.prison.platform.common.system.affix.service.IAffixService;
import ${daoPath};
import ${entityPath};
<#if mode=='DUAL'>
    <#if importTypes??>
        <#list importTypes as path>
import ${path};
        </#list>
    </#if>
</#if>
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
public class ${ObjectName}Service extends BaseService implements I${ObjectName}Service {
	@Autowired
	IAffixService affixService;

	@Autowired
	private ${ObjectName}Mapper ${objectName}Mapper;
<#if mode=='DUAL'>
    <#if map??>
        <#list map?keys as key>
    @Autowired
    private I${map['${key}']['entityName']}Service  ${map['${key}']['objectName']}Service;
        </#list>
    </#if>
</#if>

	/**
	 * 支持附件上传
	*/
	public ${ObjectName} save(${ObjectName} record, String affixIds){
		prepareSave(record);
${objectName}Mapper.insertSelective(record);
<#if mode=='DUAL'>
    <#if map??>
        <#list map?keys as key>
            ${map['${key}']['objectName']}Service.saveList(record.getId(),record.get${map['${key}']['entityName']}List());
        </#list>
    </#if>
</#if>
       	affixService.update(record.getId(), affixIds);
		return record;
	}

	@Override
	public void update(${ObjectName} record) {
		prepareUpdate(record);
${objectName}Mapper.updateByPrimaryKeySelective(record);
	}

	@Override
	public void update(${ObjectName} record, String affixIds) {
		prepareUpdate(record);
${objectName}Mapper.updateByPrimaryKeySelective(record);
		affixService.update(record.getId(), affixIds);
	}

	@Override
	public void remove(${ObjectName} record) {
		prepareRemove(record);
${objectName}Mapper.removeList(record, Collections.singletonList(record.getId()));
		affixService.removeByYwId(record.getId());
	}

	@Override
	@Transactional(readOnly = true)
	public PagerModel findList(${ObjectName} record, int pageNum, int pageSize,String orderBy) {
		String[] order = orderBy.split(",");
        Page<${ObjectName}> page = PageMethod.startPage(pageNum, pageSize, StringUtil.propertyToField(order[0]) + " " + order[1]);
${objectName}Mapper.selectList(record);
        return new PagerModel(page.getTotal(), page.getResult(), pageNum, pageSize);
    }

    @Override
    @Transactional(readOnly = true)
    public ${ObjectName} find(String id) {
<#if mode='SINGLE'>
    	return ${objectName}Mapper.selectByPrimaryKey(id);
</#if>
<#if mode=='DUAL'>
    <#if map??>
        <#list map?keys as key>
            ${ObjectName} record = ${objectName}Mapper.selectByPrimaryKey(id);
		record.set${map['${key}']['entityName']}List(${map['${key}']['objectName']}Service.findListByZbId(record.getId()));
		return record;
        </#list>
    </#if>
    <#if isParent == false>
    	return ${objectName}Mapper.selectByPrimaryKey(id);
    </#if>
</#if>
    }

	@Override
	public void remove(List<String> ids){
${ObjectName} record = new ${ObjectName}();
    prepareRemove(record);
${objectName}Mapper.removeList(record, ids);
    }


    @Override
    public void findListByIds(List<String> ids){
    ${objectName}Mapper.selectListByIds(ids);
        }
<#if mode=='DUAL'>
    <#if isParent == false>
    <#--子表生成方法调用-->
	@Override
    public void saveList(String parentId,List<${ObjectName}> recordList){
		recordList.forEach(record->{
			prepareSave(record);
			record.${setMethodName}(parentId);
        ${objectName}Mapper.insertSelective(record);
		});
	}

	@Override
	public List<${ObjectName}> findListByZbId(String id) {
        ${ObjectName} record = new ${ObjectName}();
		record.${setMethodName}(id);
		return ${objectName}Mapper.selectList(record);
	}
    </#if>
</#if>
        }
