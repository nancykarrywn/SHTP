package com.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionSupport;

public class BaseAction extends ActionSupport {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	protected HttpServletRequest request = ServletActionContext.getRequest();

	protected HttpSession session = ServletActionContext.getRequest()
			.getSession();

	protected HttpServletResponse response = ServletActionContext.getResponse();

	public String redirectUrl;

	public String goUrl(String redirectUrl) {
		this.redirectUrl = redirectUrl;		
		return "redirectUrl";
	}

}
