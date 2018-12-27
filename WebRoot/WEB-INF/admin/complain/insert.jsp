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
			<h1 class="page-title">商品管理</h1>
		</div>
		<ul class="breadcrumb">
            <li><a href="<%=path%>/admin/index.action">主页</a> <span class="divider">/</span></li>
            <li><a href="announcement_list.action">公告</a> <span class="divider">/</span></li>
            <li class="active">添加公告</li>
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
			<h3>请填写公告详细信息：</h3>
		</div>
		<form action="announcement_insert.action" method="post"
			enctype="multipart/form-data" id="insertAnnouncementForm">

			<input type="text" class="input-block-level" placeholder="公告标题"
				name="announcement.title"> 
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
			<div class="clearfix"></div>
			<textarea id="TextArea1" cols="20" rows="2" class="ckeditor"></textarea>
			<input type="hidden"  name="announcement.content" id="content" >

			<div class="modal-footer">
				<a href="#" class="btn" data-dismiss="modal" aria-hidden="true">取
					消</a>
				<button type="button" class="btn btn-primary" id="insertAnnouncementBtn">添
					加</button>
			</div>
		</form>
	</div>
</body>
<script src="<%=path%>/js/jquery-1.7.2.min.js" type="text/javascript"></script>
<script type="text/javascript">
	var editor = CKEDITOR.replace('TextArea1');
	$("#insertAnnouncementBtn").click(function(){
		var content = editor.getData();
		$("#content").val(content);
		$("#insertAnnouncementForm").submit();
	});
</script>
</html>