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
			<div class="banner"></div>
			<div class="row content">
				<div class="col-md-3 content_top">					
					<jsp:include page="/WEB-INF/mall/common/left.jsp"></jsp:include>
				</div>
				<div class="col-md-9">
					<div class="breadcrumb">
						<a href="index.jsp">首页</a> >> <span class="last">在线商品</span>
					</div>					
					<div class="row content_bottom">
						<c:forEach items="${goodsList}" var="goods">
							<div class="col-md-3">
								<div class="content_box">									
										<div class="view view-fifth">
											<img src="${goods.img }" class="img-responsive" alt="${goods.name }">
											<div class="content_box-grid">
												<p class="m_1">${goods.name }</p>
												<div class="price">
													名称: <span class="actual">${goods.name }</span>
												</div>
												<ul class="product_but">
													<li class="but3"><a  href="<%=path%>/mall/goodsInfo.action?goods.id=${goods.id}">进入</a></li>
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
</html>

