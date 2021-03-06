package org.sz.platform.system.service.impl;

import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.sz.core.dao.IEntityDao;
import org.sz.core.service.impl.BaseServiceImpl;
import org.sz.core.util.UniqueIdUtil;
import org.sz.platform.system.dao.MessageReadDao;
import org.sz.platform.system.model.MessageRead;
import org.sz.platform.system.model.SysUser;
import org.sz.platform.system.service.MessageReadService;

@Service("messageReadService")
public class MessageReadServiceImpl extends BaseServiceImpl<MessageRead>
		implements MessageReadService {

	@Resource
	private MessageReadDao dao;

	protected IEntityDao<MessageRead, Long> getEntityDao() {
		return this.dao;
	}

	public void addMessageRead(Long messageId, SysUser sysUser)
			throws Exception {
		MessageRead msgRead = this.dao.getReadByUser(messageId,
				sysUser.getUserId());
		if (msgRead == null) {
			Date now = new Date();
			MessageRead messageRead = new MessageRead();
			messageRead.setId(Long.valueOf(UniqueIdUtil.genId()));
			messageRead.setMessageId(messageId);
			messageRead.setReceiverId(sysUser.getUserId());
			messageRead.setReceiver(sysUser.getFullname());
			messageRead.setReceiveTime(now);
			add(messageRead);
		}
	}

	public List<MessageRead> getReadByMsgId(Long messageId) {
		return this.dao.getReadByMsgId(messageId);
	}
}
