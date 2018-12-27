<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="tags"%>
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

</head>
<body>
	<jsp:include page="/WEB-INF/admin/common/header.jsp"></jsp:include>
	<!-- 内容 开始 -->
	<div class="content">

		<!-- 提示框1 -->
		<div id="delMember" class="modal hide fade">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true">&times;</button>
				<h3>警告</h3>
			</div>
			<div class="modal-body">
				<p>你确定要删除吗？</p>
			</div>
			<div class="modal-footer">
				<a href="#" class="btn" data-dismiss="modal" aria-hidden="true">取消</a>
				<a id="delMemberBtn" href="#" class="btn btn-primary"> 确 认</a>
			</div>
		</div>


		<div class="header">
			<h1 class="page-title">会员管理</h1>
		</div>
		<ul class="breadcrumb">
			<li><a href="<%=path%>/admin/index.action">首页</a> <span
				class="divider">/</span></li>			
			<li class="active">会员</li>
		</ul>
	<div class="container-fluid">
			

		<div class="well">
			<table
				class="table table-striped table-bordered bootstrap-datatable datatable">
				<thead>
					<tr>
						<th>用户编号</th>
						<th>姓名</th>
						<th>登录名</th>
						<th>地址</th>
						<th>联系方式</th>
						<th>操作</th>
						<th style="width: 26px;"></th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${memberList}" var="member">
						<tr>
							<td>${member.id}</td>
							<td>${member.username}</td>
							<td>${member.name}</td>
							<td>${member.address}</td>
							<td>${member.phone}</td>
							<td><a href="info.action?member.id=${member.id}"
								class="btn btn-primary"> 查看</a>
								<button onclick="del(${member.id},${page.pageNo})"
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
			$("#delMember").modal("show").on("shown", function() {
				$("#delMemberBtn").attr('onclick', "delMember("+delid+","+pageNo+")");				
			});
		}
		function delMember(delid,pageNo){
			$("#delMember").modal("hide");
			var delurl = "del.action";
			$.post(delurl,{"member.id":delid,pageNo:pageNo},function(data){
				if(data.message=="success"){
					alert("删除成功！");
					location.href="<%=path%>/member/list.action";
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
