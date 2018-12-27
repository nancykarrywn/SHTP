<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String path = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>校园二手商品交易系统后台</title>

<link rel="stylesheet" type="text/css"
	href="<%=path%>/bootstrap/css/bootstrap.css">
<link rel="stylesheet" type="text/css" href="<%=path%>/css/theme.css">
<link rel="stylesheet"
	href="<%=path%>/font-awesome/css/font-awesome.css">


<script src="<%=path%>/js/jquery-1.7.2.min.js" type="text/javascript"></script>
<script src="<%=path%>/bootstrap/js/bootstrap.js"></script>
<script src="<%=path%>/assets/common/ckeditor/ckeditor.js"></script>
</head>
<body>
	<jsp:include page="/WEB-INF/admin/common/header.jsp"></jsp:include>
	<div class="content">
		<div class="header">
			<h1 class="page-title">分类管理</h1>
		</div>
		<ul class="breadcrumb">
             <li><a href="<%=path%>/admin/index.action">主页</a> <span class="divider">/</span></li>           
            <li class="active">添加管理员</li>
        </ul>

		<div class="container-fluid">
			<c:if test="${requestScope.message=='success'}">
				<div class="alert alert-info">
					<button type="button" class="close" data-dismiss="alert">×</button>
					<strong>小提示：</strong> 添加成功！！
				</div>
			</c:if>
		</div>
		<div class="modal-header">
			<button type="button" class="close" data-dismiss="modal"
				aria-hidden="true">&times;</button>
			<h3>请填写管理员详细信息：</h3>
		</div>
		<form action="insert.action" method="post"
			 id="insertAnnouncementForm" class="container">

			<input type="text" class="input-block-level" placeholder="账 号"
				name="admin.username"> 
			
			<input type="password" class="input-block-level" placeholder="密 码"
				name="admin.password"> 

			<div class="modal-footer">
				<button onclick="history.back()" class="btn" aria-hidden="true">取
					消</button>
				<button type="submit" class="btn btn-primary" id="insertAnnouncementBtn">添
					加</button>
			</div>
		</form>
	</div>
</body>
<script src="<%=path%>/js/jquery-1.7.2.min.js" type="text/javascript"></script>

</html>