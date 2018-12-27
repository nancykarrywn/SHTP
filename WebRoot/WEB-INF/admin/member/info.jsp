<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
			<h1 class="page-title">会员信息</h1>
		</div>

		<ul class="breadcrumb">
			<li><a href=""<%=path%>/admin/index.action"">首页</a> <span class="divider">/</span></li>
			<li><a href="<%=path%>/member_list.action">会员</a> <span class="divider">/</span></li>
			<li class="active">会员信息</li>
		</ul>

		<div class="container-fluid">
			<div class="row-fluid">		
				<div>
					<h3>会员信息</h3>								
					<div>
						<table
							class="table table-striped table-bordered bootstrap-datatable datatable">
							<thead>
								<tr>
									<th>用户编号</th>
									<td>${member.id }</td>
									<th>姓名</th>
									<td>${member.name }</td>
									<th>性别</th>
									<td>${member.gender }</td>
								</tr>
								<tr>
									<th>出生日期</th>
									<td>${member.birthday }</td>
									<th>住址</th>
									<td>${member.address }</td>
									<th>联系方式</th>
									<td>${member.phone }</td>
								</tr>

								<tr>
									<th>注册时间</th>
									<td>${member.registerTime }</td>
									<th>登录名</th>
									<td>${member.username }</td>
									<th>密码</th>
									<td>********</td>
								</tr>
								<tr>
									<th>用户权限</th>
									<c:choose>
										<c:when test="${member.permission eq 1 }">
											<td>平台管理员</td>
										</c:when>
										<c:otherwise>
											<td>商品管理员</td>
										</c:otherwise>
									</c:choose>
									<th>上次登录时间</th>
									<td>${member.lastLoginTime }</td>
									<th></th>
									<td></td>
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
