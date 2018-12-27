package com.action;

import java.awt.Color;
import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.io.IOException;
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
import com.entity.Admin;
import com.utils.Page;
import com.utils.VerificationCodeUtil;

@Controller
@Scope("prototype")
@Namespace("/admin")
@ParentPackage("json-default")
@ExceptionMappings({ @ExceptionMapping(exception = "java.lange.RuntimeException", result = "exception") })
@Results({ @Result(name = "exception", location = "/WEB-INF/common/exception.jsp"),
		@Result(name = "error", location = "/WEB-INF/common/error.jsp") })
public class AdminAction extends BaseAction{

	private static final long serialVersionUID = -9119509135334701242L;

	@Autowired
	private BaseService<Admin,Integer> adminService;
	
	private Admin admin;
	
	private String message;
	
	public Admin getAdmin() {
		return admin;
	}

	public void setAdmin(Admin admin) {
		this.admin = admin;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}
    //分页显示实现
	@Action(value = "code")
	public void code() throws ServletException, IOException {
		VerificationCodeUtil vc = new VerificationCodeUtil();
		response.setHeader("Pragma", "No-cache");
		response.setHeader("Cache-Control", "no-cache");
		response.setDateHeader("Expires", 0);
		response.setContentType("image/gif");
		final BufferedImage image = new BufferedImage(vc.width, vc.height,
				BufferedImage.TYPE_INT_RGB);
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
			g.setColor(new Color(20 + random.nextInt(130), 20 + random
					.nextInt(130), 20 + random.nextInt(130)));
			g.drawString(rand, (13 * i) + 6, 16);
		}
		session.setAttribute("validateCode", sRand);
		g.dispose();
		final java.io.OutputStream os = response.getOutputStream();
		ImageIO.write(image, "PNG", os);
		os.flush();
		os.close();
	}
	//实现管理员登录，登录成功跳转到/WEB-INF/admin/admin/index.jsp页面，不成功则跳转到/WEB-INF/admin/admin/login.jsp页面
	@Action(value = "login", results = { @Result(name = "index", location = "/WEB-INF/admin/admin/index.jsp"),
			@Result(name = "login", location = "/WEB-INF/admin/admin/login.jsp") })
	public String login(){
		//管理员登录验证
			String password = admin.getPassword();
			Admin loginAdmin = adminService.uniqueQuery("from Admin where username=? and password=?", admin.getUsername(),password);		
			if (null != loginAdmin) {
				ServletActionContext.getRequest().getSession().setAttribute("loginAdmin", loginAdmin);
				return "index";
			} else {
				setMessage("用户名密码错误！");
				return LOGIN;
			}
		
	}
	//实现管理员注销
	@Action(value = "logout", results = {
			@Result(name = "login", location = "/WEB-INF/admin/admin/login.jsp") })
	public String logout(){		
		session.removeAttribute("loginAdmin");
		session.invalidate();
		//转到管理员login.jsp界面
		return "login";
	}
	//跳转到首页
	@Action(value = "index", results = { @Result(name = "index", location = "/WEB-INF/admin/admin/index.jsp")
			})
	public String index(){
		return "index";
	}
	//修改密码页面
	@Action(value = "password", results = { @Result(name = "password", location = "/WEB-INF/admin/admin/password.jsp")})
	public String password(){
		admin = (Admin) session.getAttribute("loginAdmin");
		return "password";
	}
	//实现修改密码功能
	@Action(value = "modifyPassword", results = { @Result(name = "success", type = "json") })
	public String modifyPassword(){
		String oldPassword = request.getParameter("oldPassword");//得到旧密码
		Admin ad = adminService.findById(Admin.class, admin.getId());
		if(oldPassword.equals(ad.getPassword())){
			setMessage("failed");
			return "success";
		}
		String password = admin.getPassword();
		//password = Encryption.toMD5(password.getBytes());
		adminService.updateQuery("update Admin set password = ? where id = ?", password,admin.getId());	
		setMessage("success"); 
		return "success";
	}
    //跳转到添加管理员界面
	@Action(value = "toInsert", results = { @Result(name = "toInsert", location = "/WEB-INF/admin/admin/insert.jsp") })
	public String toInsert() {
		return "toInsert";
	}
    //实现添加管理员功能
	@Action(value = "insert", results = { @Result(name = "insert", type = "chain",params={"namespace","/admin","actionName","list"}) })
	public String insert() {
		String password = admin.getPassword();	
		Admin a = new Admin();
		a.setUsername(admin.getUsername());
		a.setPassword(password);	
		adminService.save(a);
		setMessage("success");
		return "insert";
	}
	//显示管理员列表信息
	@Action(value = "list", results = { @Result(name = "index", location = "/WEB-INF/admin/admin/list.jsp") })
	public String list() {
		String pageNoStr = request.getParameter("pageNo");//分页显示
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
		page.setTotalRecord(adminService.findAll("Admin").size());
		request.setAttribute("page", page);
		List<Admin>  adminList = adminService.pageQuery("from Admin", firstResult, pageSize);
		request.setAttribute("adminList", adminList);
		return "index";
	}
   //实现删除功能	
	@Action(value = "del", results = { @Result(name = "del", type = "json") })
	public String del() {
		admin = adminService.findById(Admin.class, admin.getId());
		adminService.delete(admin);
		setMessage("success");
		return "del";
	}
   //查看管理员详细信息
	@Action(value = "info", results = { @Result(name = "info", location = "/WEB-INF/admin/admin/info.jsp") })
	public String info() {
		admin = adminService.findById(Admin.class, admin.getId());
		return "info";
	}
	
}
