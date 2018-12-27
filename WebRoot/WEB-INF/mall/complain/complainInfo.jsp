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
							<h3>评论信息</h3>								
					<div>
						<div class="row-fluid">
					<div class="span1"></div>

					<div class="span6">
						<h4>
							<span > 投 诉 人: </span> <span
								>
								${complain.memberByBuyer.name}</span>
						</h4>
						<h4>
							<span > 被 投 诉 人: </span> <span
								>
								${complain.memberBySaler.name}</span>
						</h4> 
						<h4>
							<span > 投 诉 时 间 : </span> <span
								> <fmt:formatDate
									value="${complain.complainTime}" pattern="yyyy-MM-dd HH:mm:SS" />
							</span>
						</h4>

						<h4>
							<span > 投 诉 内 容 : </span>
						</h4>
						<p class="">${complain.complainContent}</p>
						<h4>
							<span > 处 理 状 态 : </span> <span
								> <c:if
									test="${complain.status eq '0' }">未处理</c:if> <c:if
									test="${complain.status eq '1' }">已处理</c:if>
							</span>
						</h4>
						<c:if test="${complain.status eq '0' }">
							<form action="handle.action" method="post"
								id="handleForm" class="container">

							
								<div class="clearfix"></div>
								
								<input type="hidden" name="complain.id" value="${complain.id }">
								<input type="hidden" name="complain.handleResult" id="content">
								
							</form>
						</c:if>
						<c:if test="${complain.status eq '1' }">
							<h4>
							<span > 处 理 人: </span> <span
								>
								${complain.admin.username}</span>
						</h4>
						<h4>
							<span > 处 理 时 间 : </span> <span
								> <fmt:formatDate
									value="${complain.handleTime}" pattern="yyyy-MM-dd HH:mm:SS" />
							</span>
						</h4>

						<h4>
							<span >  处 理 结 果 : </span>
						</h4>
						<p class="">${complain.handleResult}</p>
						</c:if>
					</div>

				</div>
				
					</div>
					<a href="javascript:history.back()">
					<button class="btn btn-default">返 回</button>
				</a>
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

