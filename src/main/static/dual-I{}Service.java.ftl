package ${serivcePackage};

import ${entityPath};
import com.cesgroup.prison.platform.common.util.PagerModel;

import java.util.List;

public interface I${ObjectName}Service {

${ObjectName} save(${ObjectName} record, String affixIds);

	void update(${ObjectName} record);

	void update(${ObjectName} record, String affixIds);

	void remove(${ObjectName} record);

${ObjectName} find(String id);

	PagerModel findList(${ObjectName} record, int pageNum, int pageSize,String orderBy);

    void remove(List<String> ids);

    void findListByIds(List<String> ids);

<#if mode=='DUAL'>
	<#if isParent == false>
    void saveList(String parentId,List<${ObjectName}> recordList);

    public List<${ObjectName}> findListByZbId(String id);
	</#if>
</#if>


        }
