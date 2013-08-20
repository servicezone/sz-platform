package org.sz.platform.dao.system;

import java.util.List;

import org.sz.core.dao.BaseDao;
import org.sz.platform.model.system.UserPosition;

public interface UserPositionDao extends BaseDao<UserPosition> {

	List<UserPosition> getByPosId(Long posId);

	void delByPosId(Long posId);

	UserPosition getUserPosModel(Long userId, Long posId);

	int delUserPosByIds(Long userId, Long posId);

	List<Long> getUserIdsByPosId(Long posId);

	void delByUserId(Long userId);

	List<UserPosition> getByUserId(Long userId);

	void updNotPrimaryByUser(Long userId);

	UserPosition getMainPositionByUserId(Long userId);

}