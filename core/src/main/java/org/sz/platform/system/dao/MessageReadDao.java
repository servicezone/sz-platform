package org.sz.platform.system.dao;

import java.util.List;

import org.sz.core.dao.BaseDao;
import org.sz.platform.system.model.MessageRead;

public interface MessageReadDao extends BaseDao<MessageRead>{

	List<MessageRead> getMessageReadList(Long messageId);

	MessageRead getReadByUser(Long messageId, Long receiverId);

	List<MessageRead> getReadByMsgId(Long messageId);

}