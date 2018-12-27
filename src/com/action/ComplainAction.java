package com.action;

import java.util.Date;
import java.util.List;

import javassist.bytecode.Descriptor.Iterator;

import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.ExceptionMapping;
import org.apache.struts2.convention.annotation.ExceptionMappings;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.biz.BaseService;
import com.entity.Admin;
import com.entity.Complain;
import com.entity.Member;
import com.utils.Page;
@Controller
@Scope("prototype")
@Namespace("/complain")
@ParentPackage("json-default")
@ExceptionMappings({ @ExceptionMapping(exception = "java.lange.RuntimeException", result = "exception") })
@Results({ @Result(name = "exception", location = "/WEB-INF/common/exception.jsp"),
		@Result(name = "error", location = "/WEB-INF/common/error.jsp") })
public class ComplainAction extends BaseAction {

	private static final long serialVersionUID = 1L;

	@Autowired
	private BaseService<Complain, Integer> complainService;

	private Complain complain;

	private List<Complain> complainList;
	
	private String message;

	public Complain getComplain() {
		return complain;
	}

	public void setComplain(Complain complain) {
		this.complain = complain;
	}

	public List<Complain> getComplainList() {
		return complainList;
	}

	public void setComplainList(List<Complain> complainList) {
		this.complainList = complainList;
	}
	
	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}
    //显示后台管理员投诉列表
	@Action(value = "list", results = { @Result(name = "index", location = "/WEB-INF/admin/complain/index.jsp") })
	public String list() {
		
		String pageNoStr = request.getParameter("pageNo");
		int pageNo, pageSize;
		if (null == pageNoStr)
			pageNo = 1;
		else
			pageNo = Integer.valueOf(pageNoStr);
		String pageSizeStr = request.getParameter("pageSize");
		if (null == pageSizeStr)
			pageSize = 8;
		else
			pageSize = Integer.valueOf(pageSizeStr);
		int firstResult = (pageNo - 1) * pageSize;
		Page page = Page.newBuilder(pageNo, pageSize, "list.action");
		page.setTotalRecord(complainService.findAll("Complain").size());
		request.setAttribute("page", page);
		complainList = complainService.pageQuery("from Complain", firstResult, pageSize);
		
		
		return "index";
	}
	
   
	
	//进行投诉，在mall/goods/complain.jsp
	@Action(value = "insert", results = { @Result(name = "insert", type = "json") })
	public String insert() {	
		
		System.out.println("投诉投诉");
		complain.setComplainTime(new Date());
		   
		complainService.save(complain);
		setMessage("success");
		return "insert";
	}

    //管理员删除投诉
	@Action(value = "del", results = { @Result(name = "del", type = "json") })
	public String del() {
		complain = complainService.findById(Complain.class, complain.getId());
		complainService.delete(complain);
		setMessage("success");
		return "del";
	}
	
	//查看我的投诉
/*@Action(value = "myComplain", results = { @Result(name = "myComplain", location = "/WEB-INF/mall/complain/myComplain.jsp") })
	public String myComplain() {
		Member member = (Member) session.getAttribute("loginMember");
		String pageNoStr = request.getParameter("pageNo");
		int pageNo, pageSize;
		if (null == pageNoStr)
			pageNo = 1;
		else
			pageNo = Integer.valueOf(pageNoStr);
		String pageSizeStr = request.getParameter("pageSize");
		if (null == pageSizeStr)
			pageSize = 8;
		else
			pageSize = Integer.valueOf(pageSizeStr);
		int firstResult = (pageNo - 1) * pageSize;
		Page page = Page.newBuilder(pageNo, pageSize, "list.action");
		page.setTotalRecord(complainService.getResult("from Complain c where c.memberByBuyer.id = ?",member.getId()).size());
		request.setAttribute("page", page);
		complainList = complainService.pageQuery("from Complain c where c.memberByBuyer.id = ?", firstResult, pageSize,member.getId());
		return "myComplain";
	}
	//投诉详细信息
	@Action(value = "complainInfo", results = { @Result(name = "complainInfo", location = "/WEB-INF/mall/complain/complainInfo.jsp") })
	public String complainInfo(){
		complain = complainService.findById(Complain.class, complain.getId());
		return "complainInfo";
	}*/
}
