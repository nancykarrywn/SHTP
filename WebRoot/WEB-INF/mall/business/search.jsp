<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="tags"%>
<%
	String path = request.getContextPath();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>校园二手商品交易系统</title>
<link href="<%=path%>/mall/css/bootstrap.css" rel='stylesheet'
	type='text/css' />
<script src="<%=path%>/mall/js/jquery.min.js"></script>
<script src="<%=path%>/mall/js/bootstrap.min.js"></script>
<link href="<%=path%>/mall/css/style.css" rel='stylesheet'
	type='text/css' />
</head>
<body>
	<jsp:include page="/WEB-INF/mall/common/header.jsp"></jsp:include>
	<div class="main">
		<div class="container">
			<div class="banner"></div>
			<div class="row content">
				<div class="col-md-3 content_top">
					<jsp:include page="/WEB-INF/mall/common/left.jsp"></jsp:include>
				</div>
				<div class="col-md-9">
					<div class="breadcrumb">
						<a href="index.jsp">首页</a> >> <span class="last">商品搜索</span>
					</div>

					<div class="product-filter">

					</div>

					<!-- <div class="product-compare">
							<a href="#" id="compare-total">商品对比 (0)</a>
						</div> -->
					<div class="clearfix"></div>

					<div class="row content_bottom">
						<c:forEach items="${hotelList}" var="hotel">
							<div class="col-md-3">
								<div class="content_box">
									<div class="view view-fifth">
										<img src="${hotel.cover }" class="img-responsive"
											alt="${hotel.name }">
										<div class="content_box-grid">
											<p class="m_1">${hotel.description }</p>
											<div class="price">
												名称: <span class="actual">${hotel.name }</span>
											</div>
											<ul class="product_but">
												<li class="but3"><a
													href="<%=path%>/business!rooms.action?hotel.id=${hotel.id}">进入</a></li>
												<li class="like"><span>120</span></li>
											</ul>
											<div class="clearfix"></div>
											<div class="mask">
												<div class="info">快速预览</div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</c:forEach>
						<div class="clearfix"></div>
						<div class="pagination">
							<tags:page page="${page}" />
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<jsp:include page="/WEB-INF/mall/common/footer.jsp"></jsp:include>
</body>
<script type="text/javascript">
	$("#searchBtn").click(function() {
		if ($("#four").val() != "" && null != $("#four").val())
			$("#area").val($("#four").val());
		else if ($("#three").val() != "" && null != $("#three").val())
			$("#area").val($("#three").val());
		else {
			$("#area").val($("#two").val());
		}
		var id = $("#area").val();
		location.href="<%=path%>/business!searchByArea.action?area.id="+id;
	});
</script>
</html>

