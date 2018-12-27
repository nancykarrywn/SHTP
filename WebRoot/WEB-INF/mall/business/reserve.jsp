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
			<div class="Product_top" style="min-height:450px;">
				<form action="business!reserve.action" method="post" id="reserveForm">
					<div class="register-top-grid">
						<h3>预定信息</h3>
						<div>
							<span>商品<label>*</label></span> <input type="text"
								value="${hotel.name }" readonly> <input type="hidden"
								name="reserve.hotel" value="${hotel.id }">
						</div>
						<div>
							<span>房间号<label>*</label></span> <input type="text"
								value="${room.no }" readonly> <input type="hidden"
								name="reserve.room" value="${room.id }">
						</div>
						<div>
							<span>姓名<label>*</label></span> <input type="text"
								value="${member.name }" readonly> <input type="hidden"
								name="reserve.member" value="${member.id }">
						</div>
						<div>
							<span>手机号<label>*</label></span> <input type="text"
								value="${member.phone }" readonly>
						</div>
						<div>
							<span>最早到达时间<label></label></span> <input type="datetime-local"
								name="reserve.eat">
						</div>
						<div>
							<span>最晚到达时间<label></label></span> <input type="datetime-local"
								name="reserve.lat">
						</div>


						<div class="clearfix"></div>

						<div class="register-but">
							<input type="submit" value="预定">
						</div>
					</div>
				</form>
				<div class="clearfix"></div>
			</div>
		</div>
	</div>
	<jsp:include page="/WEB-INF/mall/common/footer.jsp"></jsp:include>
</body>
</html>

