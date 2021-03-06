package org.sz.platform.oa.model.mail;

import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeUtility;

public class EmailAddress {
	protected String address;
	protected String name;

	public String getAddress() {
		return this.address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public EmailAddress() {
	}

	public EmailAddress(String address, String name) {
		this.address = address;
		this.name = name;
	}

	public InternetAddress toInternetAddress() throws Exception {
		if ((this.name != null) && (!this.name.trim().equals(""))) {
			return new InternetAddress(this.address, MimeUtility.encodeWord(
					this.name, "utf-8", "Q"));
		}

		return new InternetAddress(this.address);
	}
}
