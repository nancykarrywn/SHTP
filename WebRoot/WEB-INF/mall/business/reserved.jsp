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
<link href="<%=path%>/mall/css/bootstrap.css" rel='stylesheet'
	type='text/css' />
<script src="<%=path%>/mall/js/jquery.min.js"></script>
<script src="<%=path%>/mall/js/bootstrap.min.js"></script>
<script src="<%=path%>/mall/js/check.js"></script>
<link href="<%=path%>/mall/css/style.css" rel='stylesheet'
	type='text/css' />
</head>
<body>
	<jsp:include page="/WEB-INF/mall/common/header.jsp"></jsp:include>
	<div class="main">
		<div class="container">
			<div class="Product_top" style="height:460px;">
				<p>恭喜您，预定成功！<a href="<%=path%>/business!online.action">继续浏览</a></p>
				<p><a href="<%=path%>/business!toPay.action?reserve.id=${reserve.id}">去支付</a></p>
				<div class="clearfix"></div>
			</div>
		</div>
	</div>
	<jsp:include page="/WEB-INF/mall/common/footer.jsp"></jsp:include>
</body>
</html>

