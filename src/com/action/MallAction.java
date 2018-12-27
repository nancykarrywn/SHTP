package com.action;

import java.util.ArrayList;
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
import com.entity.Goods;
import com.entity.Member;
import com.entity.Orders;
import com.utils.Page;

@Controller
@Scope("prototype")
@Namespace("/mall")
@ParentPackage("json-default")
@ExceptionMappings({ @ExceptionMapping(exception = "java.lange.RuntimeException", result = "exception") })
@Results({ @Result(name = "exception", location = "/WEB-INF/common/exception.jsp"),
		@Result(name = "error", location = "/WEB-INF/common/error.jsp") })
public class MallAction extends BaseAction {

	private static final long serialVersionUID = 1L;
	
	private Goods goods;
	private List<Goods> goodsList;

	public Goods getGoods() {
		return goods;
	}

	public void setGoods(Goods goods) {
		this.goods = goods;
	}

	public List<Goods> getGoodsList() {
		return goodsList;
	}

	public void setGoodsList(List<Goods> goodsList) {
		this.goodsList = goodsList;
	}

	@Autowired
	private BaseService<Goods, Integer> goodsService;
	@Autowired
	private BaseService<Orders, Integer> ordersService;

	//网站首页
	@Action(value = "index", results = { @Result(name = "index", location = "/WEB-INF/mall/index.jsp") })
	public String index() {
		List<Goods> recommendGoods = goodsService.getResult("from Goods where isRecommend = 1");
		session.setAttribute("recommendGoods", recommendGoods);
		return "index";
	}
	//商品主页显示所有发布的商品列表
	@Action(value = "goods", results = { @Result(name = "goods", location = "/WEB-INF/mall/business/goods.jsp") })
	public String goods() {
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
		page.setTotalRecord(goodsService.getResult("from Goods where isChecked = 1").size());		
		goodsList = goodsService.pageQuery("from Goods where isChecked = 1", firstResult, pageSize);
		request.setAttribute("page", page);		
		return "goods";
	}
	
	//商品主页点击查看某一个商品的信息
	@Action(value = "goodsInfo", results = { @Result(name = "goodsInfo", location = "/WEB-INF/mall/business/goodsInfo.jsp") })
	public String goodsInfo(){
		goods = goodsService.findById(Goods.class, goods.getId());
		Member member = (Member) session.getAttribute("loginMember");
		List<Orders> ol = ordersService.pageQuery("from Orders o where o.member.id = ?", null, null, member.getId());
		List<Category> favors = new ArrayList<Category>();
		for (Orders o : ol) {
			favors.add(o.getGoods().getCategory());
		}
		Integer[] ids = new Integer[favors.size()];
		for (int i=0;i<favors.size();i++)
			ids[i]=favors.get(i).getId();
		
		System.out.println(ids.length+"========");
		List<Goods> favorGoods = new ArrayList<Goods>();
		for(int i:ids)
			System.out.println(i);
		if (ids.length >= 1) {
			System.out.println("if");
			favorGoods = goodsService.pageQuerys("from Goods g where g.category.id in (:ids)", 0, 3, ids);
			for(Goods g:favorGoods)
				System.out.println(g.getName());
		} else {
			System.out.println("else");
			favorGoods = goodsService.pageQuery("from Goods", 0, 3);
		}
		
		
		request.setAttribute("favorGoods123", favorGoods);
		return "goodsInfo";
	}

}
