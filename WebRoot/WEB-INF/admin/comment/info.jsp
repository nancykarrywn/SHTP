<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML>
<html lang="en">
<head>
<title>校园二手商品交易系统后台</title>

<link rel="stylesheet" type="text/css"
	href="<%=path%>/bootstrap/css/bootstrap.css">
<link rel="stylesheet" type="text/css" href="<%=path%>/css/theme.css">
<link rel="stylesheet"
	href="<%=path%>/font-awesome/css/font-awesome.css">


<script src="<%=path%>/js/jquery-1.7.2.min.js" type="text/javascript"></script>
<script src="<%=path%>/bootstrap/js/bootstrap.js"></script>

<link rel="stylesheet"
	href="<%=path%>/bootstrap/css/bootstrap-switch.css" />
<script src="<%=path%>/bootstrap/js/bootstrap-switch.js"></script>
</head>
<body>
	<jsp:include page="/WEB-INF/admin/common/header.jsp"></jsp:include>
	<!-- 内容 开始 -->
	<div class="content">

		<div class="header">
			<h1 class="page-title">评论信息</h1>
		</div>

		<ul class="breadcrumb">
			<li><a href="<%=path%>/admin/index.action">首页</a> <span class="divider">/</span></li>
			<li><a href="<%=path%>/comment/list.action">评论</a> <span class="divider">/</span></li>
			<li class="active">评论信息</li>
		</ul>

		<div class="container-fluid">
			<div class="row-fluid">		
				<div>
					<h3>评论信息</h3>								
					<div>
						<table
							class="table table-striped table-bordered bootstrap-datatable datatable">
							<thead>
								<tr>
									<th>评论人</th>
									<td>${comment.member.username}</td>
									<th>商品</th>
									<td>${comment.goods.name}</td>
									<th>分类</th>
									<td>${comment.goods.category.name}</td>
								</tr>
								<tr>
									<th>评论时间</th>
									<td><fmt:formatDate value="${comment.commentTime }" pattern="yyyy-MM-dd HH:mm:SS"/></td>
									<th>评论内容</th>
									<td>${comment.commentContent }</td>
									<th>评论级别</th>
									<td>${comment.commentLevel }</td>
								</tr>

							
							</thead>
						</table>
					</div>

				</div>
			</div>
			<div class="form-actions">

				<a href="javascript:history.back()">
					<button class="btn">返 回</button>
				</a>
			</div>
			<footer>
				<p class="pull-right">
					&copy; 2017.6<a href="#"></a>
				</p>
			</footer>

		</div>
	</div>
</body>
</html>
