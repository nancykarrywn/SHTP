package com.action;

import java.awt.Color;
import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.util.Date;
import java.util.List;
import java.util.Random;

import javax.imageio.ImageIO;
import javax.servlet.ServletException;

import org.apache.struts2.ServletActionContext;
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
import com.entity.Member;
import com.utils.Encryption;
import com.utils.Page;
import com.utils.VerificationCodeUtil;

@Controller
@Scope("prototype")
@Namespace("/member")
@ParentPackage("json-default")
@ExceptionMappings({ @ExceptionMapping(exception = "java.lange.RuntimeException", result = "exception") })
@Results({ @Result(name = "exception", location = "/WEB-INF/common/exception.jsp"),
		@Result(name = "error", location = "/WEB-INF/common/error.jsp") })
public class MemberAction extends BaseAction {
	private static final long serialVersionUID = -4058841194629832924L;

	@Autowired
	private BaseService<Member, Integer> memberService;
	//封装注册表单参数
	private Member member;

	private List<Member> memberList;

	private String message;

	public Member getMember() {
		return member;
	}

	public void setMember(Member member) {
		this.member = member;
	}

	public List<Member> getMemberList() {
		return memberList;
	}

	public void setMemberList(List<Member> memberList) {
		this.memberList = memberList;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}
   //后台用户信息列表显示，跳转到/WEB-INF/admin/member/index.jsp页面
	@Action(value = "list", results = { @Result(name = "index", location = "/WEB-INF/admin/member/index.jsp") })
	public String list() {
		String pageNoStr = request.getParameter("pageNo");//分页显示部分
		int pageNo, pageSize;
		if (null == pageNoStr)//判断页数
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
		page.setTotalRecord(memberService.findAll("Member").size());
		request.setAttribute("page", page);
		memberList = memberService.pageQuery("from Member", firstResult, pageSize);
		return "index";
	}
    //后台用户详细信息查看
	@Action(value = "info", results = { @Result(name = "info", location = "/WEB-INF/admin/member/info.jsp") })
	public String info() {
		member = memberService.findById(Member.class, member.getId());
		return "info";
	}
    //跳转到后台用户信息添加页面
	@Action(value = "toInsert", results = { @Result(name = "toInsert", location = "/WEB-INF/admin/member/insert.jsp") })
	public String toInsert() {
		return "toInsert";
	}
   //后台用户信息添加功能实现
	@Action(value = "insert", results = { @Result(name = "insert", type = "json") })
	public String insert() {
		String password = member.getPassword();
		member.setPassword(Encryption.toMD5(password.getBytes()));
		member.setRegisterTime(new Date());
		memberService.save(member);
		setMessage("success");
		return "insert";
	}
   //跳转前台用户更新信息页面
	@Action(value = "toUpdate", results = { @Result(name = "toUpdate", location = "/WEB-INF/mall/user/update.jsp") })
	public String toUpdate() {
		return "toUpdate";
	}
    //前台用户更新信息功能实现
	@Action(value = "update", results = { @Result(name = "update", type = "json") })
	public String update() {
		memberService.update(member);
		member = memberService.findById(Member.class, member.getId());
		session.removeAttribute("loginMember");
		session.setAttribute("loginMember", member);
		setMessage("success");
		return "update";
	}
    //删除用户信息
	@Action(value = "del", results = { @Result(name = "del", type = "json") })
	public String del() {
		member = memberService.findById(Member.class, member.getId());
		memberService.delete(member);
		setMessage("success");
		return "del";
	}
   //跳转到用户登录界面
	@Action(value = "toLogin", results = { @Result(name = "toLogin", location = "/WEB-INF/mall/user/login.jsp") })
	public String toLogin() {
		return "toLogin";
	}
   //跳转到用户注册界面
	@Action(value = "toRegister", results = {
			@Result(name = "toRegister", location = "/WEB-INF/mall/user/register.jsp") })
	public String toRegister() {
		//转到名为toRegister的Action
		return "toRegister";
	}
   
	
	//登录验证	验证码
	@Action(value = "code")
	public void code() throws ServletException, IOException {
		VerificationCodeUtil vc = new VerificationCodeUtil();
		response.setHeader("Pragma", "No-cache");
		response.setHeader("Cache-Control", "no-cache");
		response.setDateHeader("Expires", 0);
		response.setContentType("image/gif");
		final BufferedImage image = new BufferedImage(vc.width, vc.height, BufferedImage.TYPE_INT_RGB);
		final Graphics2D g = (Graphics2D) image.getGraphics();
		final Random random = new Random();
		g.setColor(vc.getRandColor(200, 250));
		g.fillRect(0, 0, vc.width, vc.height);
		g.setFont(vc.mFont);
		g.setColor(vc.getRandColor(0, 20));
		g.drawRect(0, 0, vc.width - 1, vc.height - 1);
		for (int i = 0; i < vc.count; i++) {
			g.setColor(vc.getRandColor(150, 200));
			final int x = random.nextInt(vc.width - vc.lineWidth - 1) + 1;
			final int y = random.nextInt(vc.height - vc.lineWidth - 1) + 1;
			final int xl = random.nextInt(vc.lineWidth);
			final int yl = random.nextInt(vc.lineWidth);
			g.drawLine(x, y, x + xl, y + yl);
		}
		String sRand = "";
		for (int i = 0; i < 4; i++) {
			final String rand = String.valueOf(random.nextInt(10));
			sRand += rand;
			g.setColor(new Color(20 + random.nextInt(130), 20 + random.nextInt(130), 20 + random.nextInt(130)));
			g.drawString(rand, (13 * i) + 6, 16);
		}
		session.setAttribute("validateCode1", sRand);
		g.dispose();
		final java.io.OutputStream os = response.getOutputStream();
		ImageIO.write(image, "PNG", os);
		os.flush();
		os.close();
	}
    
	//用户的登录实现，登陆成功跳转到index页面，登录不成功跳转到/WEB-INF/mall/user/login.jsp页面
	@Action(value = "login", results = {
			@Result(name = "index", type = "chain", params = { "namespace", "/mall", "actionName", "index" }),
			@Result(name = "login", location = "/WEB-INF/mall/user/login.jsp") })
	public String login() {
		//用户登录验证
			String password = member.getPassword();
			Member loginMember = memberService.uniqueQuery("from Member where username=? and password=?",
					member.getUsername(), password);
			if (null != loginMember) {
				ServletActionContext.getRequest().getSession().setAttribute("loginMember", loginMember);
				
								return "index";
			} else {
				setMessage("用户名密码错误！");
				return LOGIN;
			}
		
	}
    //用户注销实现
	@Action(value = "logout", results = { @Result(name = "login", location = "/WEB-INF/mall/user/login.jsp") })
	public String logout() {
		session.removeAttribute("loginMember");
		session.invalidate();
		return "login";
	}
   //用户注册实现
	@Action(value = "register", results = { @Result(name = "register", type = "json") })
	public String register() {
		String password = member.getPassword();
		password = Encryption.toMD5(password.getBytes());
		member.setPassword(password);
		member.setRegisterTime(new Date());
		memberService.save(member);
		setMessage("success");
		return "register";
	}

	@Action(value = "isExist", results = { @Result(name = "isExist", type = "json") })
	public String isExist() {
		Member mem = memberService.uniqueQuery("from Member where username = ?", member.getUsername());
		if (null != mem)
			setMessage("exist");
		else
			setMessage("notexist");
		return "isExist";
	}
    //用户人员信息显示
	@Action(value = "personal", results = { @Result(name = "personal", location = "/WEB-INF/mall/user/personal.jsp") })
	public String personal() {
		member = (Member) session.getAttribute("loginMember");
		return "personal";
	}

}
