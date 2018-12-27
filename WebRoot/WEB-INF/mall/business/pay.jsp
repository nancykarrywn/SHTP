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
<link href="<%=path%>/assets/common/slider/css/jquery.slideBox.css"
	rel="stylesheet" type="text/css" />
</head>
<body>
	<jsp:include page="/WEB-INF/mall/common/header.jsp"></jsp:include>
	<div class="main">
		<div class="container">
			<div class="Product_top" style="height: 460px;">
				<table class="table">
					<tbody>
						<tr>
							<td>姓名</td>
							<td>${sessionScope.loginMember.name }</td>
						</tr>
						<tr>
							<td>电话</td>
							<td>${sessionScope.loginMember.phone }</td>
						</tr>
						<tr>
							<td>下单时间</td>
							<td>${orders.orderTime }</td>
						</tr>
						<tr>
							<td>商品</td>
							<td>${orders.goods.name }</td>
						</tr>
						<tr>
							<td>商品类型</td>
							<td>${orders.goods.category.name }</td>
						</tr>
						<tr>
							<td>商品号</td>
							<td>${orders.goods.id }</td>
						</tr>
						<tr>
							<td>价格</td>
							<td>${orders.goods.price }</td>
						</tr>
					</tbody>
				</table>
				<div>
					<div class="col-md-6">
					1
					</div>
					<div class="col-md-6">
					2
					</div>
				</div>
				<button class="btn btn-primary" onclick="pay()">确认支付</button>
				<a class="btn" href="<%=path%>/mall/goods.action">返回浏览</a>
			</div>
		</div>
	</div>
	<jsp:include page="/WEB-INF/mall/common/footer.jsp"></jsp:include>
</body>
<script>
	function pay(){
		$.post("<%=path%>/orders/pay.action",{"orders.id":"${orders.id}"},function(data){
			if(data.message=="success"){
				alert("支付成功！");
				location.href="<%=path%>/orders/cart.action";
				return;
			}else{
				alert("支付失败！");
				return;
			}
		});
	}
</script>
</html>

