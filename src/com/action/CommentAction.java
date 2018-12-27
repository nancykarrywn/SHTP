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
import com.utils.Page;
@Controller //使用@Controller注解在spring容器中注册action实例
@Scope("prototype")//指定原型模式
@Namespace("/comment")
@ParentPackage("json-default")
@ExceptionMappings({ @ExceptionMapping(exception = "java.lange.RuntimeException", result = "exception") })
@Results({ @Result(name = "exception", location = "/WEB-INF/common/exception.jsp"),
		@Result(name = "error", location = "/WEB-INF/common/error.jsp") })
public class CommentAction extends BaseAction {

	private static final long serialVersionUID = 1L;
   
	@Autowired//来完成自动装配的工作
	private BaseService<Comment, Integer> commentService;
	@Autowired
	private BaseService<Member, Integer> memberService;
	@Autowired
	private BaseService<Goods, Integer> goodsService;

	private Comment comment;

	private List<Comment> commentList;
	
	private String message;

	public Comment getComment() {
		return comment;
	}

	public void setComment(Comment comment) {
		this.comment = comment;
	}

	public List<Comment> getCommentList() {
		return commentList;
	}

	public void setCommentList(List<Comment> commentList) {
		this.commentList = commentList;
	}
	
	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}
   
    //跳转到评价页面，/WEB-INF/mall/business/comment.jsp
	@Action(value = "toComment", results = { @Result(name = "toComment", location = "/WEB-INF/mall/business/comment.jsp") })
	public String toInsert(){
		int id = Integer.valueOf(request.getParameter("goodsId"));//转换为Integer类型
		Goods goods = goodsService.findById(Goods.class, id);
		request.setAttribute("goods", goods);
		return "toComment";
	}
	//用户添加评价
	@Action(value = "insert", results = { @Result(name = "insert", type = "json") })
	public String insert() {	
		System.out.println("评价评价");
		comment.setCommentTime(new Date());
		commentService.save(comment);
		setMessage("success");
		return "insert";
	}
    
    //用户删除评价
	@Action(value = "del", results = { @Result(name = "del", type = "json") })
	public String del() {
		comment = commentService.findById(Comment.class, comment.getId());
		commentService.delete(comment);
		setMessage("success");
		return "del";
	}
	//用户查看我的评价列表
	@Action(value = "myComments", results = { @Result(name = "myComments", location = "/WEB-INF/mall/comment/myComments.jsp") })
	public String myComments() {
		Member mem = (Member) session.getAttribute("loginMember");//获取登录的用户
		Member member = memberService.findById(Member.class, mem.getId());
		Set<Comment> myComments = member.getComments();
		request.setAttribute("myComments", myComments);
		return "myComments";
	}
	//用户查看我的评价详细信息
	@Action(value = "commentInfo", results = { @Result(name = "commentInfo", location = "/WEB-INF/mall/comment/commentInfo.jsp") })
	public String commentInfo() {
		comment = commentService.findById(Comment.class, comment.getId());
		return "commentInfo";
	}
}
