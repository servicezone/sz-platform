package org.sz.platform.system.dao;

import java.util.List;

import org.sz.core.dao.BaseDao;
import org.sz.platform.system.model.RoleSys;

public interface RoleSysDao extends BaseDao<RoleSys> {

	void delBySysAndRole(Long systemId, Long roleId);

	List<RoleSys> getByRole(Long roleId);

}