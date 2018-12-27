<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE>
<html>
<head>
<title>校园二手商品交易系统后台</title>

<link rel="stylesheet" type="text/css"
	href="<%=path%>/bootstrap/css/bootstrap.css">
<link rel="stylesheet" type="text/css" href="<%=path%>/css/theme.css">
<link rel="stylesheet"
	href="<%=path%>/font-awesome/css/font-awesome.css">
<link rel="stylesheet"
	href="<%=path%>/assets/common/artDialog/skins/default.css">


<script src="<%=path%>/js/jquery-1.7.2.min.js" type="text/javascript"></script>
<script src="<%=path%>/bootstrap/js/bootstrap.js"></script>

<link rel="stylesheet"
	href="<%=path%>/bootstrap/css/bootstrap-switch.css" />
<script src="<%=path%>/bootstrap/js/bootstrap-switch.js"></script>
<script src="<%=path%>/assets/common/artDialog/artDialog.js"></script>

<!-- Demo page code -->

<style type="text/css">
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
<body>
	

<jsp:include page="/WEB-INF/admin/common/header.jsp"></jsp:include>
	<div class="content" >
		<form class="form-signin container"  method="post" id="modifyPwdForm" >
			<div class="page-header">
				<h2>修改密码</h2>
			</div>
			<input type="hidden" name="admin.id" value="${admin.id }"/>
			<input type="password" class="input-block-level" placeholder="原始密码" id="oldPassword"
				name="oldPassword"> 
			<input type="password"
				class="input-block-level" placeholder="新密码" name="admin.password" id="password">
			<input type="password"
				class="input-block-level" placeholder="确认密码" name="repassword" id="repassword">
				
			<button class="btn  btn-primary" type="button" onclick="modify()">修改</button>
			<button class="btn  " type="reset">重置</button>
		</form>
	</div>

	<footer>
		<p class="pull-right">
			&copy; 2017.6<a href="#"></a>
		</p>
	</footer>



	<script type="text/javascript">
		var xmlhttp;
		$('.make-switch').on('switch-change', function(e, data) {
			createXMLHttpRequest();
			var url = "<%=path%>/OrderServlet?oid=" + $(this).attr('id');
			xmlhttp.onreadystatechange = state_Change;
			xmlhttp.open("POST", url, true);
			xmlhttp.send(null);
		})

		function createXMLHttpRequest() {
			if (window.XMLHttpRequest) {// code for IE7, Firefox, Opera, etc.
				xmlhttp = new XMLHttpRequest();
			} else if (window.ActiveXObject) {// code for IE6, IE5
				xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
			}
		}

		function state_Change() {
			if (xmlhttp.readyState == 4) {
				if (xmlhttp.status == 200) {

				}
			}
		}

		function modify(){
			var oldPassword = $("#oldPassword").val();
			var password = $("#password").val();
			var repassword = $("#repassword").val();
			if(null==oldPassword||oldPassword.trim()==""){
				art.dialog({
				    title: '提示信息',
				    content: '请输入原始密码！',
				    icon: 'error',			   
				    ok: function(){		              
				        return;
				    }
				});
			}else if(null==password||password.trim()==""){
				art.dialog({
				    title: '提示信息',
				    content: '请输入新密码！',
				    icon: 'error',			   
				    ok: function(){		              
				        return;
				    }
				});
			}else if(null==repassword||repassword.trim()==""){
				art.dialog({
				    title: '提示信息',
				    content: '请确认密码！',
				    icon: 'error',			   
				    ok: function(){		              
				        return;
				    }
				});
			}else if(password!=repassword){
				art.dialog({
				    title: '提示信息',
				    content: '两次输入密码不一致！',
				    icon: 'error',			   
				    ok: function(){		       
				       
				        return;
				    }
				});
			}else{
				$.post("<%=path%>/admin/modifyPassword.action",$("#modifyPwdForm").serialize(),function(data){
					if(data.message == "success"){
						art.dialog({
						    title: '提示信息',
						    content: '密码修改成功，请重新登陆！',
						    icon: 'succeed',			   
						    ok: function(){		       
						       	location.href = "<%=path%>/admin/logout.action";
						        return;
						    }
						});
					}else if(data.message == "failed"){
						art.dialog({
						    title: '提示信息',
						    content: '原始密码输入错误！',
						    icon: 'error',			   
						    ok: function(){		       				       
						        return;
						    }
						});
					}else {
						art.dialog({
						    title: '提示信息',
						    content: '请求发生错误！',
						    icon: 'error',			   
						    ok: function(){		       				       
						        return;
						    }
						});
					}
				})
			}
		}
	</script>
</body>
</html>
