<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%> 
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
<link rel="stylesheet"
	href="<%=path%>/assets/common/artDialog/skins/default.css">
<script src="<%=path%>/assets/common/artDialog/artDialog.js"></script>
<script type="application/x-javascript">
	
	 addEventListener("load", function() { setTimeout(hideURLbar, 0); }, false); function hideURLbar(){ window.scrollTo(0,1); } 

</script>
<!----webfonts---->
<link href='http://fonts.googleapis.com/css?family=Exo+2:100,200,300,400,500,600,700,800,900' rel='stylesheet' type='text/css'>
 <!----details-product-slider--->
				<!-- Include the Etalage files -->
					<link rel="stylesheet" href="<%=path%>/assets/mall/css/etalage.css">
					<script src="<%=path%>/assets/mall/js/jquery.etalage.min.js"></script>
				<!-- Include the Etalage files -->
				<script>
						jQuery(document).ready(function($){
			
							$('#etalage').etalage({
								thumb_image_width: 300,
								thumb_image_height: 400,
								
								show_hint: true,
								click_callback: function(image_anchor, goods_id){
									alert('Callback example:\nYou clicked on an image with the anchor: "'+image_anchor+'"\n(in Etalage goods: "'+goods_id+'")');
								}
							});
							// This is for the dropdown list example:
							$('.dropdownlist').change(function(){
								etalage_show( $(this).find('option:selected').attr('class') );
							});

					});
				</script>
				<!----//details-product-slider--->	
				<script type="text/javascript">

	function add(id){
		$.post('mall!Orders_add.action',{id:id},function(msg){			
			
			if(msg.status=="success")
				alert("已成功加入购物车！");
			else
				alert("添加失败！");
		});
	}
	
	
</script>

</head>
<body>
	<jsp:include page="/WEB-INF/mall/common/header.jsp"></jsp:include>
	<div class="main">
		<div class="container">
			<div class="banner">
				
			</div>
			<div class="row content">
				<div class="col-md-3 content_top">
					<jsp:include page="/WEB-INF/mall/common/left.jsp"></jsp:include>
				</div>
				<div class="col-md-9">
		   	   <div class="single_image">
					     <ul id="etalage">
							<li>
								<a href="optionallink.html">
									<img class="etalage_thumb_image" src="${goods.img }" class="img-responsive" alt=""/>
									<img class="etalage_source_image"  src="${goods.img }" class="img-responsive" alt=""/>
								</a>
							</li>							
						</ul>
					    </div>
					    <div class="single_right">
				        	<h3>${goods.name }</h3>				        	
				        	<p class="m_5">分类：${goods.category.name }</p>
				        	<p class="m_5">商品ID：${goods.id }</p>
				        	<div class="price_single">
							  <span class="reducedfrom">￥${goods.price+100 }</span>
							  <span class="actual1">￥${goods.price }</span><!-- <a href="#">单击此处获得帮助</a> -->
							</div>
				        	<c:if test="${goods.member.id != loginMember.id }">
								<div class="btn_form">
								   <form action="" id="cartForm">							   		
								   		<input type="hidden" name="goods.id" value="${goods.id }">
								   		<input type="button" value="加入购物车" onclick="cart()">
								   		<!-- <input type="button" value="立即购买" onclick="buy()"> -->
								   	</form>							   	
								</div>
							</c:if>
							
							
           </div>
		   <div class="clearfix"> </div>
		   <!----product-rewies---->
			<div class="product-reviwes">
				<!--vertical Tabs-script-->
				<!---responsive-tabs---->
					<script src="<%=path %>/assets/mall/js/easyResponsiveTabs.js" type="text/javascript"></script>
					<script type="text/javascript">
						$(document).ready(function () {
							 $('#horizontalTab').easyResponsiveTabs({
									type: 'default', //Types: default, vertical, accordion           
									width: 'auto', //auto or any width like 600px
									fit: true,   // 100% fit in a container
									closed: 'accordion', // Start closed if in accordion view
									activate: function(event) { // Callback function if tab is switched
									var $tab = $(this);
									var $info = $('#tabInfo');
									var $name = $('span', $info);
										$name.text($tab.text());
										$info.show();
									}
								});
													
							 $('#verticalTab').easyResponsiveTabs({
									type: 'vertical',
									width: 'auto',
									fit: true
								 });
						 });
					</script>
				<!---//responsive-tabs---->
				<!--//vertical Tabs-script-->
				<!--vertical Tabs-->
        		<div id="verticalTab">
		            <ul class="resp-tabs-list">
		                <li>商品描述</li>
		                <li>商品类型</li>
		                <li>顾客推荐</li>
		            </ul>
		            <div class="resp-tabs-container vertical-tabs">
		                <div>
		                	<h3>商品描述</h3>
		                    <div>${goods.name }</div>
		                </div>
		                <div>
		                	<h3>商品类型</h3>
		                	<h4>${goods.category.name }</h4>		                	
		                </div>
		                <div>
		                	<h3>顾客评论</h3>
		                	<c:choose>
		                		<c:when test="${fn:length(goods.comments)>0}">
		                			<c:forEach items="${goods.comments }" var="comment">
		                			<div class="well">
		                				<h4>${comment.member.username }</h4>
		                				<p style="text-align:right">${comment.commentTime }</p>
		                				<p>${comment.commentContent }</p>
		                			</div>
				                	</c:forEach>
				                	<div class="pagination">										
									</div>
		                		</c:when>
		                		<c:otherwise>
		                			暂无评论。
		                		</c:otherwise>
		                	</c:choose>
		                	
		                </div>
		            </div>
       		     </div>
       		     <div class="clearfix"> </div>
		      </div>
		      <div class="related_products">
		      	<h3>猜你喜欢</h3>
		      
		      	<div class="row">
		      		<c:forEach items="${favorGoods123 }" var="favor">
				      		<div class="col-md-4 related">
				      			<a href="<%=path%>/mall/goodsInfo.action?goods.id=${favor.id}"><img src="${favor.img }" class="img-responsive" alt=""/></a>
				      		</div>
				     </c:forEach>	
		      				      		
		      	</div>
		      </div>
		   </div>    
		</div>
	  </div>
	 </div>
	<jsp:include page="/WEB-INF/mall/common/footer.jsp"></jsp:include>
</body>
<script type="text/javascript">
	function cart(){
		var loginUser = "${sessionScope.loginMember}";
		if(null==loginUser||loginUser==""){
			alert("请先登录！");
			location.href="<%=path%>/member/toLogin.action";
			return;
		}else{			
			$.post("<%=path%>/goods/addCart.action",$("#cartForm").serialize(),function(data){
				if(data.message=="success"){
					art.dialog({
					    title: '提示信息',
					    content: '已加入购物车！',
					    icon: 'succeed',			   
					    ok: function(){		       				       
					        return;
					    }
					});
				}
			});
		}
	}
	function buy(){
		var loginUser = "${sessionScope.loginMember}";
		if(null==loginUser||loginUser==""){
			alert("请先登录！");
			location.href="<%=path%>/member/toLogin.action";
			return;
		}else{
			document.reserveForm.submit();
		}
	}
</script>
</html>

