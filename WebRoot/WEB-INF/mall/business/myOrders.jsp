<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
				<table
					class="table table-striped table-bordered bootstrap-datatable datatable">
					<thead>
						<tr>
							<th>订单编号</th>						
							<th>下单时间</th>
							<th>交易状态</th>
							<th>操作</th>

						</tr>
					</thead>
					<tbody>
						<c:forEach items="${ordersList}" var="orders">
							<tr>
								<td>${orders.id}</td>
								<td><fmt:formatDate value="${orders.checkInTime}" pattern="yyyy-MM-dd HH:mm:SS"/></td>
								<td>
									<c:choose>
										<c:when test="${orders.checkInStatus eq '0'}">预定</c:when>
										<c:when test="${orders.checkInStatus eq '1'}">入住</c:when>
										<c:when test="${orders.checkInStatus eq '2'}">待退房</c:when>
										<c:when test="${orders.checkInStatus eq '3'}">已退房</c:when>
									</c:choose>
								</td>
								<td>
									<c:choose>
										<c:when test="${orders.paySatuts eq '0'}">未支付</c:when>
										<c:when test="${orders.paySatuts eq '1'}">已支付</c:when>										
									</c:choose>
								</td>
								<td>
									<button onclick="comment(${orders.id},${page.pageNo})"
										class="btn btn-danger" <c:if test="${orders.paySatuts eq '0'}">disabled</c:if>>
										<i class="icon-trash icon-white"></i> 评论
									</button></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				<div class="clearfix"></div>
			</div>
		</div>
	</div>
	<jsp:include page="/WEB-INF/mall/common/footer.jsp"></jsp:include>
</body>
<script type="text/javascript">
	function comment(orderId,pageNo){
		location.href="<%=path%>/business!toComment.action?orders.id="+orderId+"&pageNo="+pageNo;
	}
</script>
</html>

