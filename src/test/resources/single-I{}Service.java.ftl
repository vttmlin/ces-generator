package ${servicePackageName};

import ${entityPath};
import com.cesgroup.prison.platform.common.util.PagerModel;

import java.util.List;

public interface I${objectNameUpper}Service {

    ${objectNameUpper} save(${objectNameUpper} record, String affixIds);

	void update(${objectNameUpper} record);

	void update(${objectNameUpper} record, String affixIds);

	void remove(${objectNameUpper} record);

    ${objectNameUpper} find(String id);

	PagerModel findList(${objectNameUpper} record, int pageNum, int pageSize,String orderBy);

    void remove(List<String> ids);

    void findListByIds(List<String> ids);

}
