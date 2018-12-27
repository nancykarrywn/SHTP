<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String path = request.getContextPath();
%>
<!DOCTYPE html >
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
			<div id="banner" class="slideBox" >
				<ul class="items">
					<c:forEach items="${recommendGoods }" var="goods">
						<li><a><img src="${goods.img }"></a></li>
					</c:forEach>				
				</ul>
			</div>
			<div class="row content">
				<div class="col-md-3 content_top">
					<jsp:include page="/WEB-INF/mall/common/left.jsp"></jsp:include>
				</div>
				<div class="col-md-9">
					<div class="feature">
						<h3>
							<i class="arrow"> </i><span>今日推荐</span>
						</h3>
					</div>

					<div class="feature_grid">
						<c:forEach items="${recommendGoods}" var="goods">
							<div class="col-md-3">
								<div class="content_box">									
										<div class="view view-fifth">
											<img src="${goods.img }" class="img-responsive" alt="${goods.name }">
											<div class="content_box-grid">
												<p class="m_1">${goods.intro }</p>
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

						
					</div>
					<div class="clearfix"></div>
				
					<div class="row content_bottom">
						<c:forEach items="${popularHotel}" var="hotel">
							<div class="col-md-3">
								<div class="content_box">									
										<div class="view view-fifth">
											<img src="${hotel.cover }" class="img-responsive" alt="${hotel.name }">
											<div class="content_box-grid">
												<p class="m_1">${hotel.description }</p>
												<div class="price">
													名称: <span class="actual">${hotel.name }</span>
												</div>
												<ul class="product_but">
													<li class="but3"><a  href="<%=path%>/business!rooms.action?hotel.id=${hotel.id}">进入</a></li>
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
					</div>

				</div>
			</div>
		</div>
	</div>
	
	<jsp:include page="/WEB-INF/mall/common/footer.jsp"></jsp:include>
</body>
<script src="<%=path%>/assets/common/jQuery/jquery-1.9.1.min.js"></script>
<script src="<%=path%>/assets/common/slider/js/jquery.slideBox.js"
	type="text/javascript"></script>
<script type="text/javascript">
	jQuery(function($){
		$('#banner').slideBox();	
	});
</script>
</html>

