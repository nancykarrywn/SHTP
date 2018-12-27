<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="tags"%>
<%
	String path = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<title>校园二手商品交易系统</title>
<link href="<%=path%>/assets/mall/css/bootstrap.css" rel='stylesheet'
	type='text/css' />
<script src="<%=path%>/assets/mall/js/jquery.min.js"></script>
<script src="<%=path%>/assets/mall/js/bootstrap.min.js"></script>
<link href="<%=path%>/assets/mall/css/style.css" rel='stylesheet'
	type='text/css' />
<link rel="stylesheet"
	href="<%=path%>/assets/common/artDialog/skins/default.css">
<script src="<%=path%>/assets/common/artDialog/artDialog.js"></script>
</head>
<body>
	<jsp:include page="/WEB-INF/mall/common/header.jsp"></jsp:include>
	<div class="main">
		<div class="container">
			<div class="Product_top">
				<div class="row content">
					<div class="col-md-3 ">
						<div class="category_box">
							<h3 class="cate_head">个人中心</h3>
							<img alt="尊享会员" src="<%=path %>/assets/images/mem.jpg" class="img img-thumbnail img-responsive">
							<ul class="category">								
								<li><a href="<%=path %>/member/toUpdate.action">修改资料</a></li>
								<li><a href="<%=path %>/orders/myOrders.action">我的订单</a></li>
								<li><a href="<%=path %>/goods/myGoods.action">已买到商品</a></li>
								<li><a href="<%=path %>/comment/myComments.action">我的评价</a></li>
								<li><a href="<%=path %>/goods/publishedGoods.action">已发布商品</a></li>	
								<li><a href="<%=path %>/orders/myReturn.action">退货中心</a></li>								
							</ul>
						</div>
					</div>
					<div class="col-md-9">
						<div class="breadcrumb">
							<a href="<%=path%>/mall/index.action">首页</a> &gt;&gt; <span class="last">用户/个人中心</span>
						</div>
						<div class="account_grid">
							<table
				class="table table-striped table-bordered bootstrap-datatable datatable">
				<thead>
					<tr>
						<th>退货编号</th>
						<th>退货人</th>
						<th>商品</th>
						<th>退货时间</th>
													
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${myReturnRecord}" var="re">
						<tr>
							<td>${re.id}</td>
							<td>${re.member.username}</td>
							<td>${re.goods.name}</td>							
							<td>
									<fmt:formatDate value="${re.returnTime}" pattern="yyyy-MM-dd HH:mm:SS"/>
								</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
							<div class="clearfix"></div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<jsp:include page="/WEB-INF/mall/common/footer.jsp"></jsp:include>

</body>
	

</html>

