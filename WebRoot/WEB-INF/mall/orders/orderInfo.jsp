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
							<img alt="尊享会员" src="<%=path%>/assets/images/mem.jpg"
								class="img img-thumbnail img-responsive">
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
							<a href="<%=path%>/mall/index.action">首页</a> &gt;&gt; <span
								class="last">用户/个人中心</span>
						</div>
						<div class="account_grid">
							<h5>
								<span> 买 家 : </span> <span>
									${orders.member.name}</span>
							</h5>
							<h5>
								<span> 商 品 : </span> <span>
									${orders.goods.name}</span>
							</h5>
							<h5>
								<span> 下单时间 : </span> <span> <fmt:formatDate
										value="${orders.orderTime}" pattern="yyyy-MM-dd HH:mm:SS" /></span>
							</h5>
							<h5>
								<span> 状 态 : </span> <span> <c:choose>
										<c:when test="${orders.tradingSatuts eq '0'}">未支付</c:when>
										<c:when test="${orders.tradingSatuts eq '1'}">已支付</c:when>
										<c:when test="${orders.tradingSatuts eq '2'}">申请退货</c:when>
										<c:when test="${orders.tradingSatuts eq '3'}">拒绝退货</c:when>
										<c:when test="${orders.tradingSatuts eq '4'}">退货成功</c:when>
									</c:choose>
								</span>
							</h5>


							<h5>
								<span> 备 注 : </span>
							</h5>
							<p class="text-success">${orders.memo}</p>
							<BR/>
							<div class="form-actions">
						
								<button type="button" class="btn btn-default" onclick="history.back()">返
									回</button>
							</div>
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

