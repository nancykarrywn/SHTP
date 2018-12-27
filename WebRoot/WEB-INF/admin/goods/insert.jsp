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
<title>快捷商品速查平台后台</title>

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
	<div class="content">
		<div class="header">
			<h1 class="page-title">商品管理</h1>
		</div>
		<ul class="breadcrumb">
			<li><a href="<%=path%>/admin/index.action">首页</a> <span class="divider">/</span></li>
			<li class="active">商品管理</li>
		</ul>

		<div class="modal-header">
			<button type="button" class="close" data-dismiss="modal"
				aria-hidden="true">&times;</button>
			<h3>请填写商品详细信息：</h3>
		</div>
		<form action="room_insert.action" method="post"
			enctype="multipart/form-data" id="insertRoomForm">
			<input type="text" class="input-block-level" placeholder="所属商品"
				name="room.hotel"> 
			<input type="text" class="input-block-level" placeholder="商品名称"
				name="room.name"> 
			<input type="text"
				class="input-block-level" placeholder="商品编号" name="room.no">
			<input type="text" class="input-block-level" placeholder="商品类型"
				name="room.type">
			<input type="text" class="input-block-level" placeholder="房间价格"
				name="room.price">
			<input type="text" class="input-block-level" placeholder="是否为特价房"
				name="room.specialOffer">
			<div class="span5">
				<div class="fileupload fileupload-new" data-provides="fileupload">
					<div class="fileupload-preview  thumbnail"
						style="width: 220px; height: 170px;"></div>
					<div>
						<span class="btn btn-file"><span class="fileupload-new">上传图片</span><span
							class="fileupload-exists">更改</span> <input type="file"
							name="photo" /> </span> <a href="#" class="btn fileupload-exists"
							data-dismiss="fileupload">删除</a>
					</div>
				</div>

			</div>

			<input type="text" class="input-block-level" placeholder="商品介绍"
				name="room.introduction">

			<div class="modal-footer">
				<a href="#" class="btn" data-dismiss="modal" aria-hidden="true">取
					消</a>
				<button type="submit" class="btn btn-primary" >添
					加</button>
			</div>
		</form>
	</div>
</body>
<script src="<%=path%>/js/jquery-1.7.2.min.js" type="text/javascript"></script>
</html>