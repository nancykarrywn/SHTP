<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="tags"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML>
<html>
<head>
<title>校园二手商品交易系统后台</title>

<link rel="stylesheet" type="text/css"
	href="<%=path%>/bootstrap/css/bootstrap.css">
<link rel="stylesheet" type="text/css" href="<%=path%>/css/theme.css">
<link rel="stylesheet"
	href="<%=path%>/font-awesome/css/font-awesome.css">
</head>
<body>
	<jsp:include page="/WEB-INF/admin/common/header.jsp"></jsp:include>
	<!-- 内容 开始 -->
	<div class="content">

		<!-- 提示框1 -->
		<div id="delHotel" class="modal hide fade">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true">&times;</button>
				<h3>警告</h3>
			</div>
			<div class="modal-body">
				<p>你确定要删除吗？</p>
			</div>
			<div class="modal-footer">
				<a href="#" class="btn" data-dismiss="modal" aria-hidden="true">关闭</a>
				<a id="delHotelBtn" href="#" class="btn btn-primary"> 确 认</a>
			</div>
		</div>



		<div class="header">
			<h1 class="page-title">投诉管理</h1>
		</div>
		<ul class="breadcrumb">
			<li><a href="<%=path%>/admin/index.action">首页</a> <span class="divider">/</span></li>
			<li class="active">投诉管理</li>
		</ul>

		<div class="container-fluid">		

			<div class="well">
				<table
					class="table table-striped table-bordered bootstrap-datatable datatable">
					<thead>
						<tr>
							<th>投诉编号</th>
							<th>投诉内容</th>
							<th>投诉时间</th>						
							<th>操作</th>

						</tr>
					</thead>
					<tbody>
						<c:forEach items="${complainList}" var="complain">
							<tr>
								<td>${complain.id}</td>
							 	<td>${complain.complainContent}</td>
								<td><fmt:formatDate value="${complain.complainTime}" pattern="yyyy-MM-dd HH:mm:SS"/></td>								
								<td>
									<button onclick="del(${complain.id},${page.pageNo})"
										class="btn btn-danger">
										<i class="icon-trash icon-white"></i> 删除
									</button></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
			<div class="pagination">
				<tags:page page="${page}" />
			</div>
			<footer>
				<p class="pull-right">
					&copy; 2017.6<a href="#"></a>
				</p>
			</footer>
		</div>

	</div>

	<script src="<%=path%>/js/jquery-1.7.2.min.js" type="text/javascript"></script>
	<script src="<%=path%>/bootstrap/js/bootstrap.js"></script>
	<script type="text/javascript">
		function del(delid,pageNo) {
			$("#delHotel").modal("show").on("shown", function() {
				$("#delHotelBtn").attr('onclick', "delHotel("+delid+","+pageNo+")");				
			});
		}
		function delHotel(delid,pageNo){
			$("#delHotel").modal("hide");
			var delurl = "del.action";
			$.post(delurl,{"complain.id":delid,pageNo:pageNo},function(data){
				if(data.message=="success"){
					alert("删除成功！");
					location.href="<%=path%>/complain/list.action";
					return;
				}
				else if(data.message=="failed"){
					alert("删除失败！");
					return;
				}else{
					alert("请求发生错误！");
					return;
				}
			})
		}
	</script>
</body>
</html>
