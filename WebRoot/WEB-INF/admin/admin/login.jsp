<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html>
<head>
<base href="<%=basePath%>">

<title>校园二手商品交易系统 后台登录</title>

<link rel="stylesheet" type="text/css"
	href="<%=path%>/bootstrap/css/bootstrap.css">
<link rel="stylesheet" type="text/css" href="<%=path%>/css/theme.css">
<link rel="stylesheet"
	href="<%=path%>/font-awesome/css/font-awesome.css">

<script src="<%=path%>/js/jquery-1.7.2.min.js" type="text/javascript"></script>
<script src="<%=path%>/bootstrap/js/bootstrap.js"></script>
<script src="<%=path%>/assets/admin/js/check.js"></script>
<link rel="stylesheet"
	href="<%=path%>/assets/common/artDialog/skins/default.css">
<script src="<%=path%>/assets/common/artDialog/artDialog.js"></script>

<style type="text/css">
.form-signin {
	max-width: 300px;
	padding: 19px 29px 29px;
	margin: 0 auto 20px;
	background-color: #fff;
	border: 1px solid #e5e5e5;
	-webkit-border-radius: 5px;
	-moz-border-radius: 5px;
	border-radius: 5px;
	-webkit-box-shadow: 0 1px 2px rgba(0, 0, 0, .05);
	-moz-box-shadow: 0 1px 2px rgba(0, 0, 0, .05);
	box-shadow: 0 1px 2px rgba(0, 0, 0, .05);
}

.form-signin .form-signin-heading, .form-signin .checkbox {
	margin-bottom: 10px;
}

.form-signin input[type="text"], .form-signin input[type="password"] {
	font-size: 16px;
	height: auto;
	margin-bottom: 15px;
	padding: 7px 9px;
}

#line-chart {
	height: 300px;
	width: 800px;
	margin: 0px auto;
	margin-top: 1em;
}

.brand {
	font-family: georgia, serif;
}

.brand .first {
	color: #ccc;
	font-style: italic;
}

.brand .second {
	color: #fff;
	font-weight: bold;
}
</style>

</head>
<body class="">
	<div class="navbar">
		<div class="navbar-inner">
			<ul class="nav pull-right">

			</ul>
			<a class="brand" href="index.html"><span class="first">校园二手商品交易</span>
				<span class="second">系统</span></a>
		</div>
	</div>
	<div class="container" style="margin-top: 100px">
		<form class="form-signin" action="admin/login.action" method="post" id="loginForm">
			<div class="page-header">
				<h2>校园二手商品交易系统</h2>
			</div>
			<input type="text" class="input-block-level" placeholder="用户名" id="username"
				name="admin.username"> <input type="password"
				class="input-block-level" placeholder="密码" name="admin.password" id="password">
					
			<button class="btn  btn-primary" type="button" onclick="loginCheck()">登录</button>
			<button class="btn  " type="reset">重置</button>
		</form>
		<footer>
		<hr>
		<p class="pull-right">
			&copy; 2017.6<a href="#" target="_blank"></a>
		</p>
		</footer>
	</div>
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
</script>
</html>
