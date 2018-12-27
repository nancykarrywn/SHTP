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
			<h1 class="page-title">订单</h1>
		</div>

		<ul class="breadcrumb">
			<li><a href="<%=path%>/admin/index.action">首页</a> <span
				class="divider">/</span></li>
			<li class="active">订单管理</li>
		</ul>

		<div class="container-fluid">
			<div class="span1"></div>
			<div class="span6">
				<h2>
					<span class="label"> 买 家 : </span> <span
						class="label label-success"> ${orders.member.name}</span>
				</h2>
				<h2>
					<span class="label"> 商 品 : </span> <span
						class="label label-success"> ${orders.goods.name}</span>
				</h2>
				<h2>
					<span class="label"> 下单时间 : </span> <span
						class="label label-success"> 	<fmt:formatDate value="${orders.orderTime}" pattern="yyyy-MM-dd HH:mm:SS"/></span>
				</h2>
				<h2>
					<span class="label"> 状 态 : </span> <span
						class="label label-success"> <c:choose>
							<c:when test="${orders.tradingSatuts eq '0'}">未支付</c:when>
							<c:when test="${orders.tradingSatuts eq '1'}">已支付</c:when>
							<c:when test="${orders.tradingSatuts eq '2'}">申请退货</c:when>
							<c:when test="${orders.tradingSatuts eq '3'}">拒绝退货</c:when>
							<c:when test="${orders.tradingSatuts eq '4'}">退货成功</c:when>
						</c:choose>
					</span>
				</h2>
				<h2>
					<span class="label"> 支 付 状 态 : </span>
				</h2>
				<c:choose>
					<c:when test="${orders.tradingSatuts eq '0'}">未支付</c:when>
					<c:when test="${orders.tradingSatuts eq '1'}">已支付</c:when>
				</c:choose>

				<h2>
					<span class="label"> 备 注 : </span>
				</h2>
				<p class="text-success">${orders.memo}</p>
			</div>

		</div>
		<div class="form-actions">
			<button type="button" class="btn" onclick="history.back()">返  回</button>			
		</div>
		<footer>
			<p class="pull-right">
				&copy; 2017.6<a href="#"></a>
			</p>
		</footer>

	</div>

</body>
</html>
