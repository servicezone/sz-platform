package org.sz.core.web.listener;

import javax.servlet.http.HttpSessionAttributeListener;
import javax.servlet.http.HttpSessionBindingEvent;

import org.sz.core.model.OnlineUser;
<<<<<<< HEAD
import org.sz.core.util.ContextUtil;
import org.sz.core.web.util.AppUtil;
import org.sz.platform.system.model.SysUser;
=======
import org.sz.core.util.SpringContextHolder;
//import org.sz.core.util.ContextUtil;
//import org.sz.platform.model.system.SysUser;
>>>>>>> 8726cb0028c02e99622ed0e79e5568178788cf9f

public class UserSessionListener implements HttpSessionAttributeListener {
	public void attributeAdded(HttpSessionBindingEvent event) {
		if ("SPRING_SECURITY_LAST_USERNAME".equals(event.getName())) {
			SysUser user = ContextUtil.getCurrentUser();
			Long userId = user.getUserId();
			if (!AppUtil.getOnlineUsers().containsKey(userId)) {
				OnlineUser onlineUser = new OnlineUser();

				onlineUser.setUserId(user.getUserId());
				onlineUser.setUsername(ContextUtil.getCurrentUser()
						.getUsername());
				onlineUser
						.setOrgId(ContextUtil.getCurrentUser().getUserOrgId());
				onlineUser
						.setOrgName(ContextUtil.getCurrentUser().getOrgName());
				AppUtil.getOnlineUsers().put(user.getUserId(), onlineUser);
			}
		}
	}

	public void attributeRemoved(HttpSessionBindingEvent event) {
		if ("SPRING_SECURITY_LAST_USERNAME".equals(event.getName())) {
			SysUser user = ContextUtil.getCurrentUser();

			if (user != null)
				AppUtil.getOnlineUsers().remove(user.getUserId());
		}
	}

	public void attributeReplaced(HttpSessionBindingEvent event) {
		
	}
}
