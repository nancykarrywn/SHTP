<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String path = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<title>校园二手商品交易系统</title>
<link href="<%=path%>/assets/mall/css/bootstrap.css" rel='stylesheet'
	type='text/css' />
<script src="<%=path%>/assets/mall/js/jquery.min.js"></script>
<script src="<%=path%>/assets/mall/js/bootstrap.min.js"></script>
<link href="<%=path%>/assets/mall/css/style.css" rel='stylesheet'
	type='text/css' />
<link rel="stylesheet"
	href="<%=path%>/assets/common/artDialog/skins/default.css">
<script src="<%=path%>/assets/common/artDialog/artDialog.js"></script>
</head>
<body>
	<jsp:include page="/WEB-INF/mall/common/header.jsp"></jsp:include>
	<div class="main">
		<div class="container">
			<div class="Product_top">
				<div class="row content">
					<!-- <div class="col-md-3 ">
						<div class="category_box">
							<h3 class="cate_head">推荐商品</h3>
							<ul class="category">
								<li><a href="#">桂园商品</a></li>
								<li><a href="#">Beauty</a></li>
								<li><a href="#">Books</a></li>
								<li><a href="#">Cart Software</a></li>
								<li><a href="#">Electronics</a></li>
								<li><a href="#">Fashion / Clothing</a></li>
								<li><a href="#">Food</a></li>
								<li><a href="#">Furniture</a></li>
								<li><a href="#">Home Goods</a></li>
								<li><a href="#">Jewelry</a></li>
								<li><a href="#">Lingerie</a></li>
								<li><a href="#">Music</a></li>
								<li><a href="#">Office Supplies</a></li>
								<li><a href="#">Printing</a></li>
								<li><a href="#">Software</a></li>

							</ul>
						</div>
					</div> -->
					<div class="col-md-9">
						<div class="breadcrumb">
							<a href="<%=path%>/mall/index.action">首页</a> &gt;&gt; <span class="last">用户/登录</span>
						</div>
						<div class="account_grid">
							<div class="col-md-6 login-left">
								<h3>创建账户</h3>
								<p>在我们的网站注册账户, 你将可以体验快速检索, 收藏多种商品, 在个人中心查看跟踪订单等等.</p>
								<a class="acount-btn" href="<%=path%>/member/toRegister.action">创建一个新账户</a>
							</div>
							<div class="col-md-6 login-right">
								<h3>已有账户</h3>
								<p>如果您已经有我们的账户, 请登录.</p>
								<form action="<%=path %>/member/login.action" method="post" id="loginForm">
									<div>
										<span>用户名<label>*</label></span> <input name="member.username"
											type="text" id="username">
									</div>
									<div>
										<span>密码<label>*</label></span> <input name="member.password"
											type="password" id="password"> 
									</div>
									
									<input type="button" onclick="loginCheck()"
										value="登录">
								</form>
							</div>
							<div class="clearfix"></div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<jsp:include page="/WEB-INF/mall/common/footer.jsp"></jsp:include>

</body>
<script type="text/javascript">
var msg = "${requestScope.message}";
if(!msg.trim()==""){	
	art.dialog({
	    title: '提示信息',
	    content: msg,
	    icon: 'error',			   
	    ok: function(){		       				       
	        return;
	    }
	});
	msg = null;
}
function loginCheck() {
	var username = $("#username").val();
	var password = $("#password").val();
	var code = $("#code").val();
	if (username.trim() == "") {		
		art.dialog({
		    title: '提示信息',
		    content: '请输入用户名！',
		    icon: 'error',			   
		    ok: function(){		       				       
		        return;
		    }
		});
		return false;
	} else {
		if (password.trim() == "") {		
			art.dialog({
			    title: '提示信息',
			    content: '请输入密码！',
			    icon: 'error',			   
			    ok: function(){		       				       
			        return;
			    }
			});
			return false;
		} else {
			
				$("#loginForm").submit();
				return true;
			
		}
	}
}
</script>
</html>

