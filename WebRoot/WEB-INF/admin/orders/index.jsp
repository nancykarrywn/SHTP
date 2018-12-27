<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
		<div id="delOrders" class="modal hide fade">
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
				<a id="delOrdersBtn" href="#" class="btn btn-primary"> 确 认</a>
			</div>
		</div>



		<div class="header">
			<h1 class="page-title">订单管理</h1>
		</div>
		
		<%-- <div class="btn-toolbar">
				<a href="<%=path%>/orders_payed.action" role="button"
					class="btn btn-primary"> 已 支 付
				</a>
				<a href="<%=path%>/orders_unpayed.action" role="button"
					class="btn btn-primary"> 未 支 付
				</a>
				
		</div> --%>
		
		<ul class="breadcrumb">
			<li><a href="<%=path%>/admin/index.action">首页</a> <span class="divider">/</span></li>
			<li class="active">订单管理</li>
		</ul>

		<div class="container-fluid">			

			<div class="well">
				<table
					class="table table-striped table-bordered bootstrap-datatable datatable">
					<thead>
						<tr>
							<th>订单编号</th>
							<th>下单人</th>
							<th>商品名称</th>
							<th>下单时间</th>
							<th>交易状态</th>
							<th>操作</th>

						</tr>
					</thead>
					<tbody>
						<c:forEach items="${ordersList}" var="orders">
							<tr>
								<td>${orders.id}</td>
								<td>${orders.member.name }</td>
								<td>${orders.goods.name }</td>
								<td>
									<fmt:formatDate value="${orders.orderTime}" pattern="yyyy-MM-dd HH:mm:SS"/>
								</td>
								<td>
									<c:choose>
										<c:when test="${orders.tradingSatuts eq '0'}">未支付</c:when>
										<c:when test="${orders.tradingSatuts eq '1'}">已支付</c:when>	
										<c:when test="${orders.tradingSatuts eq '2'}">申请退货</c:when>	
										<c:when test="${orders.tradingSatuts eq '3'}">拒绝退货</c:when>	
										<c:when test="${orders.tradingSatuts eq '4'}">退货成功</c:when>										
									</c:choose>
								</td>
								<td><a href="info.action?orders.id=${orders.id}"
									class="btn btn-primary"> 查看</a> 
									<button onclick="del(${orders.id},${page.pageNo})"
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
			$("#delOrders").modal("show").on("shown", function() {
				$("#delOrdersBtn").attr('onclick', "delOrders("+delid+","+pageNo+")");				
			});
		}
		function delOrders(delid,pageNo){
			$("#delOrders").modal("hide");
			var delurl = "del.action";
			$.post(delurl,{"orders.id":delid,pageNo:pageNo},function(data){
				if(data.message=="success"){
					alert("删除成功！");
					location.href="<%=path%>/orders/list.action";
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
