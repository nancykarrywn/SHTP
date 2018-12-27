package com.action;

import java.util.Date;
import java.util.List;
import java.util.Set;

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
import com.entity.Comment;
import com.entity.Goods;
import com.entity.Member;
import com.entity.Orders;
import com.entity.Return;
import com.utils.Page;
@Controller
@Scope("prototype")
@Namespace("/orders")
@ParentPackage("json-default")
@ExceptionMappings({ @ExceptionMapping(exception = "java.lange.RuntimeException", result = "exception") })
@Results({ @Result(name = "exception", location = "/WEB-INF/common/exception.jsp"),
		@Result(name = "error", location = "/WEB-INF/common/error.jsp") })
public class OrdersAction extends BaseAction {

	/*
	 * 状态
	 * 0：加入购入车
	 * 1：支付成功
	 * 2：申请退货
	 * 3：拒绝退货
	 * 4：同意退货
	 * 
	 * */
	
	
	
	private static final long serialVersionUID = 1L;

	@Autowired
	private BaseService<Orders, Integer> ordersService;
	@Autowired
	private BaseService<Goods, Integer> goodsService;
	@Autowired
	private BaseService<Return, Integer> returnService;
	@Autowired
	private BaseService<Member, Integer> memberService;
	
	private Orders orders;

	private List<Orders> ordersList;
	
	private String message;
	private Return re;

	private List<Return> reList;
	

	public Return getRe() {
		return re;
	}

	public void setRe(Return re) {
		this.re = re;
	}

	public List<Return> getReList() {
		return reList;
	}

	public void setReList(List<Return> reList) {
		this.reList = reList;
	}

	public Orders getOrders() {
		return orders;
	}

	public void setOrders(Orders orders) {
		this.orders = orders;
	}

	public List<Orders> getOrdersList() {
		return ordersList;
	}

	public void setOrdersList(List<Orders> ordersList) {
		this.ordersList = ordersList;
	}
	
	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	//后台订单分页显示
	@Action(value = "list", results = { @Result(name = "index", location = "/WEB-INF/admin/orders/index.jsp") })
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
		page.setTotalRecord(ordersService.findAll("Orders").size());
		request.setAttribute("page", page);
		ordersList = ordersService.pageQuery("from Orders", firstResult, pageSize);
		return "index";
	}
	
	//查看订单详细信息
	@Action(value = "info", results = { @Result(name = "info", location = "/WEB-INF/admin/orders/info.jsp") })
	public String info() {
		orders = ordersService.findById(Orders.class, orders.getId());  //通过id查找订单
		return "info";
	}

	//确定是否添加购物车， 跳转到/WEB-INF/admin/orders/insert.jsp页面，
	@Action(value = "toInsert", results = { @Result(name = "toInsert", location = "/WEB-INF/admin/orders/insert.jsp") })
	public String toInsert(){
		return "toInsert";
	}
	
	//添加购物车功能实现成功
	@Action(value = "insert", results = { @Result(name = "insert", type = "json") })
	public String insert() {		
		ordersService.save(orders);
		setMessage("success");
		return "insert";       
	}
	
   
	@Action(value = "toUpdate", results = { @Result(name = "toUpdate", location = "/WEB-INF/admin/orders/update.jsp") })
	public String toUpdate() {
		return "toUpdate";
	}

	@Action(value = "update", results = { @Result(name = "update", type = "json") })
	public String update() {
		ordersService.update(orders);
		setMessage("success");
		return "update";
	}
   
	
	
	
	
	//删除订单功能实现成功                                                  订单删除                                                      购物车删除
	@Action(value = "del", results = { @Result(name = "del", type = "json") })
	public String del() {
		orders = ordersService.findById(Orders.class, orders.getId());
		ordersService.delete(orders);
		setMessage("success");
		return "del";
	}
	
	
	//前台订单分页显示，跳转到/WEB-INF/mall/orders/myOrders.jsp页面
	@Action(value = "myOrders", results = { @Result(name = "myOrders", location = "/WEB-INF/mall/orders/myOrders.jsp") })
	public String myOrders() {
		Member member = (Member) session.getAttribute("loginMember");
		String pageNoStr = request.getParameter("pageNo");
		int pageNo, pageSize;
		if (null == pageNoStr)
			pageNo = 1;
		else
			pageNo = Integer.valueOf(pageNoStr);
		String pageSizeStr = request.getParameter("pageSize");//分页的记录数
		if (null == pageSizeStr)
			pageSize = 8;        //最多显示八条记录
		else
			pageSize = Integer.valueOf(pageSizeStr);
		int firstResult = (pageNo - 1) * pageSize;
		Page page = Page.newBuilder(pageNo, pageSize, "list.action");
		page.setTotalRecord(ordersService.getResult("from Orders o where o.member.id = ?",member.getId()).size());
		request.setAttribute("page", page);
		ordersList = ordersService.pageQuery("from Orders o where o.member.id = ?", firstResult, pageSize,member.getId());
		return "myOrders";
	}
	
	
	//前台订单详细显示                                                              订单查看                                          购物车查看
	@Action(value = "orderInfo", results = { @Result(name = "orderInfo", location = "/WEB-INF/mall/orders/orderInfo.jsp") })
	public String orderInfo() {
		orders = ordersService.findById(Orders.class, orders.getId());
		return "orderInfo";
	}
	
	
	//前台购物车列表显示
	@Action(value = "cart", results = { @Result(name = "cart", location = "/WEB-INF/mall/orders/cart.jsp") })
	public String cart() {
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
		page.setTotalRecord(ordersService.getResult("from Orders o where o.member.id = ? and o.tradingSatuts = '0'",member.getId()).size());
		request.setAttribute("page", page);
		ordersList = ordersService.pageQuery("from Orders o where o.member.id = ?  and o.tradingSatuts = '0'", firstResult, pageSize,member.getId());
		return "cart";
	}
	
	
	//前台支付页面跳转
	@Action(value = "toPay", results = { @Result(name = "toPay", location = "/WEB-INF/mall/business/pay.jsp") })
	public String toPay() {
		orders = ordersService.findById(Orders.class, orders.getId());
		return "toPay";
	}
	
	//前台支付功能实现
	@Action(value = "pay", results = { @Result(name = "pay", type = "json") })
	public String pay() {
		orders = ordersService.findById(Orders.class, orders.getId());//根据id查找
		orders.setTradingSatuts("1");     //状态改为1，说明已支付，变成订单
		ordersService.update(orders);     //更新订单信息
		setMessage("success");            
		return "pay";                     //返回/WEB-INF/mall/business/pay.jsp页面
	}
	
	//跳转到申请退货界面
	@Action(value = "toReturnGoods", results = { @Result(name = "toReturnGoods", location = "/WEB-INF/mall/orders/returnGoods.jsp") })
	public String toReturnGoods(){
		int id = Integer.valueOf(request.getParameter("goodsId"));
		Goods goods = goodsService.findById(Goods.class, id);
		request.setAttribute("goods", goods);
		Member member = (Member) session.getAttribute("loginMember");
		List<Orders> ol = ordersService.getResult("from Orders o where o.member.id = ? and o.goods.id = ?", member.getId(),goods.getId());
		request.setAttribute("orders", ol.get(0));
		return "toReturnGoods";
	}
	
	//申请退货功能实现
	@Action(value = "returnGoods", results = { @Result(name = "returnGoods", type = "json") })
	public String returnGoods(){
		orders = ordersService.findById(Orders.class, orders.getId());
		orders.setTradingSatuts("2");        //状态为2，申请退货
		ordersService.update(orders);
		setMessage("success");
		return "returnGoods";
	}
	
	//卖家查看需要处理的买家退货列表
	@Action(value = "myReturn", results = { @Result(name = "myReturn", location = "/WEB-INF/mall/orders/myReturn.jsp") })
	public String myReturn(){
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
		page.setTotalRecord(ordersService.getResult("from Orders o where o.goods.member.id = ? and o.tradingSatuts = '2'",member.getId()).size());
		request.setAttribute("page", page);
		ordersList = ordersService.pageQuery("from Orders o where o.goods.member.id = ?  and o.tradingSatuts = '2'", firstResult, pageSize,member.getId());
		return "myReturn";
	}
	//查看退货详细信息,来同意或拒绝退货
	@Action(value = "returnInfo", results = { @Result(name = "returnInfo", location = "/WEB-INF/mall/orders/returnInfo.jsp") })
	public String returnInfo(){
		orders = ordersService.findById(Orders.class, orders.getId());
		return "returnInfo";
	}
	
   //卖家用户同意退货,在mall/orders/returninfo.jsp
	@Action(value = "agree", results = { @Result(name = "agree", type = "json") })
	public String agree(){
		orders = ordersService.findById(Orders.class, orders.getId());
		orders.setTradingSatuts("4");      //状态改为4，退货成功
		ordersService.update(orders);
		Return re=new Return();//将退货记录添加到退货表
		re.setGoods(orders.getGoods());
		re.setMember(orders.getMember());
		re.setReturnTime(new Date());
		returnService.save(re);
		setMessage("success");
		return "agree";
	}
	
	//拒绝退货
	@Action(value = "refuse", results = { @Result(name = "refuse", type = "json") })
	public String refuse(){
		orders = ordersService.findById(Orders.class, orders.getId());
		orders.setTradingSatuts("3");    //状态为3，拒绝退货
		ordersService.update(orders);
		setMessage("success");
		return "refuse";
	}
	//用户查看我的退货记录,跳转到/WEB-INF/mall/orders/myReturnRecord.jsp
		@Action(value = "myReturnRecord", results = { @Result(name = "myReturnRecord", location = "/WEB-INF/mall/orders/myReturnRecord.jsp") })
		public String myComments() {
			Member mem = (Member) session.getAttribute("loginMember");
			Member member = memberService.findById(Member.class, mem.getId());
			Set<Return> myReturnRecord = member.getReturns();
			request.setAttribute("myReturnRecord", myReturnRecord);
			return "myReturnRecord";
		}
	
	//用户投诉，跳转到/WEB-INF/mall/goods/complain.jsp页面
	@Action(value = "toComplain", results = { @Result(name = "toComplain", location = "/WEB-INF/mall/goods/complain.jsp") })
	public String toComplain(){
		int goodsId = Integer.valueOf(request.getParameter("goodsId"));
		Goods good = goodsService.findById(Goods.class, goodsId);
		Member member = good.getMember();
		request.setAttribute("beComplainedMember", member);//被投诉人，其实是商品发布人
		request.setAttribute("beComplainedGoods", good);
		return "toComplain";
	}

}
