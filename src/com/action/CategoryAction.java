package com.action;

import java.util.List;

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
import com.entity.Category;
import com.utils.Page;
@Controller
@Scope("prototype")
@Namespace("/category")
@ParentPackage("json-default")
@ExceptionMappings({ @ExceptionMapping(exception = "java.lange.RuntimeException", result = "exception") })
@Results({ @Result(name = "exception", location = "/WEB-INF/common/exception.jsp"),
		@Result(name = "error", location = "/WEB-INF/common/error.jsp") })
public class CategoryAction extends BaseAction {

	private static final long serialVersionUID = 1L;

	@Autowired
	private BaseService<Category, Integer> categoryService;

	private Category category;

	private List<Category> categoryList;
	
	private String message;

	public Category getCategory() {
		return category;
	}

	public void setCategory(Category category) {
		this.category = category;
	}

	public List<Category> getCategoryList() {
		return categoryList;
	}

	public void setCategoryList(List<Category> categoryList) {
		this.categoryList = categoryList;
	}
	
	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}
	//管理员后台 显示商品类别列表
	@Action(value = "list", results = { @Result(name = "index", location = "/WEB-INF/admin/category/index.jsp") })
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
		page.setTotalRecord(categoryService.findAll("Category").size());
		request.setAttribute("page", page);
		categoryList = categoryService.pageQuery("from Category", firstResult, pageSize);
		return "index";
	}
	//点击查看类别的详细信息
	@Action(value = "info", results = { @Result(name = "info", location = "/WEB-INF/admin/category/info.jsp") })
	public String info() {
		category = categoryService.findById(Category.class, category.getId());
		return "info";
	}
	 //添加商品类别
	@Action(value = "toInsert", results = { @Result(name = "toInsert", location = "/WEB-INF/admin/category/insert.jsp") })
	public String toInsert(){
		return "toInsert";
	}
	
	@Action(value = "insert", results = { @Result(name = "insert", type = "json") })
	public String insert() {		
		categoryService.save(category);
		setMessage("success");
		return "insert";
	}
	//编辑商品类别的信息
	@Action(value = "toUpdate", results = { @Result(name = "toUpdate", location = "/WEB-INF/admin/category/update.jsp") })
	public String toUpdate() {
		category = categoryService.findById(Category.class, category.getId());
		return "toUpdate";
	}

	@Action(value = "update", results = { @Result(name = "update", type = "json") })
	public String update() {
		categoryService.update(category);
		setMessage("success");
		return "update";
	}
	//删除商品类别
	@Action(value = "del", results = { @Result(name = "del", type = "json") })
	public String del() {
		category = categoryService.findById(Category.class, category.getId());
		categoryService.delete(category);
		setMessage("success");
		return "del";
	}
}
