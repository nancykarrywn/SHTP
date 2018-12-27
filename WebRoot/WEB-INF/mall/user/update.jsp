<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
								<li><a href="<%=path%>/member/toUpdate.action">修改资料</a></li>
								<li><a href="<%=path%>/orders/myOrders.action">我的订单</a></li>
								<li><a href="<%=path%>/orders/myGoods.action">已买到商品</a></li>
								<li><a href="<%=path%>/comment/myComments.action">我的评价</a></li>
								<li><a href="<%=path%>/goods/publishedGoods.action">发布商品</a></li>
							</ul>
						</div>
					</div>
					<div class="col-md-9">
						<div class="breadcrumb">
							<a href="<%=path%>/mall/index.action">首页</a> &gt;&gt; <span
								class="last">用户/个人中心</span>
						</div>
						<div class="account_grid well">

							<form class="form-horizontal" id="updateForm" method="post">
								<div class="form-group">
									<label class="control-label col-md-2" for="inputEmail">用户名</label>
									<div class="col-md-10">
										<input type="hidden" name="member.id"
											value="${sessionScope.loginMember.id }"> <input
											type="text" name="member.username"
											value="${sessionScope.loginMember.username }"
											class="form-control"> <input type="hidden"
											name="member.password"
											value="${sessionScope.loginMember.password }"> <input
											type="hidden" name="member.permission"
											value="${sessionScope.loginMember.permission }">
									</div>
								</div>
								<div class="form-group">
									<label class="control-label col-md-2" for="inputPassword">姓
										名</label>
									<div class="col-md-10">
										<input type="text" name="member.name"
											value="${sessionScope.loginMember.name }"
											class="form-control">
									</div>
								</div>
								<div class="form-group">
									<label class="control-label col-md-2" for="inputEmail">性
										别</label>
									<div class="col-md-10">
										<label class="radio-inline"> <input type="radio"
											name="member.gender" value="2"
											<c:if test="${sessionScope.loginMember.gender eq '2'}">checked</c:if>>
											男
										</label> <label class="radio-inline"> <input type="radio"
											name="member.gender" value="1"
											<c:if test="${sessionScope.loginMember.gender eq '1'}">checked</c:if>>
											女
										</label>

									</div>
								</div>
										 <input type="hidden"
											name="member.birthday"
											value="${sessionScope.loginMember.birthday }"
											class="form-control">					
								<div class="form-group">
									<label class="control-label col-md-2" for="inputEmail">手
										机</label>
									<div class="col-md-10">
										<input type="text" name="member.phone"
											value="${sessionScope.loginMember.phone }"
											class="form-control">
									</div>
								</div>								
								
								<div class="form-group">
									<label class="control-label col-md-2" for="inputEmail">住
										址</label>
									<div class="col-md-10">
										<input type="text" name="member.address"
											value="${sessionScope.loginMember.address }"
											class="form-control">  <input
											type="hidden" name="member.registerTime"
											value="${sessionScope.loginMember.registerTime }"> <input
											type="hidden" name="member.lastLoginTime"
											value="${sessionScope.loginMember.lastLoginTime }">
									</div>
								</div>
								<div class="form-group">
									<div class="col-md-push-2 col-md-8">
										<button type="button" class="btn btn-primary" id="updateBtn">更
											新</button>
										<button type="button" class="btn btn-default"
											onclick="javascript:history.back()">返 回</button>
									</div>
								</div>

							</form>
							<div class="clearfix"></div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<jsp:include page="/WEB-INF/mall/common/footer.jsp"></jsp:include>

</body>
<script type="text/javascript">
	$("#updateBtn").click(function(){
		$.post("<%=path%>/member/update.action",$("#updateForm").serialize(),function(data){			
			if(data.message == "success"){
				art.dialog({
					title : '会员信息',
					content : '会员信息修改成功！',
					okVal : '确定',
					ok : function() {
						location.href="<%=path%>/member/personal.action";
					}							
				});
			}else{
				art.dialog({
					title : '会员信息',
					content : data.message,
					okVal : '确定',
					ok : function() {
						
					}							
				});
			}
		});
	});
</script>
</html>

