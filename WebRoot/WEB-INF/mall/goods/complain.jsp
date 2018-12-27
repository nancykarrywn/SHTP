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
<style type="text/css">
	#star{
		width:200px !important;
	}
</style>
</head>
<body>
	<jsp:include page="/WEB-INF/mall/common/header.jsp"></jsp:include>
	<div class="main">
		<div class="container">
			<div class="Product_top" style="min-height:460px;">
				<form action="<%=path %>/complain/insert.action" method="post" id="complainForm">
					<div class="register-top-grid">
						<h3>投诉</h3>						
						<div>
							<span>商品<label>*</label></span> <input type="text"
								value="${beComplainedGoods.name }" readonly> 
						</div>
						<div>
							<span>价格<label>*</label></span> <input type="text"
								value="${beComplainedGoods.price }" readonly>
						</div>
						<div>
							<span>商家<label>*</label></span> 
							<input type="text"value="${beComplainedMember.name }" readonly> 
							
						</div>
						<div>
							<span>手机号<label>*</label></span> 
							<input type="text" value="${beComplainedMember.phone }" readonly>
						</div>
						
						<div>
							<span>内容<label></label></span>
							<textarea name="complain.complainContent"></textarea>
						</div>


						<div class="clearfix"></div>

						<div class="register-but">
							<input type="button" value="投诉" id="commentBtn">
						</div>
					</div>
				</form>
				<div class="clearfix"></div>
			</div>
		</div>
	</div>
	<jsp:include page="/WEB-INF/mall/common/footer.jsp"></jsp:include>
</body>
<script type="text/javascript">
	$(function(){		 
		 $("#commentBtn").click(function(){
			 $.post("<%=path %>/complain/insert.action",$("#complainForm").serialize(),function(data){
				 if(data.message=="success"){
					 alert("投诉成功！");
					 location.href="<%=path%>/goods/goodsInfo.action?goods.id=${beComplainedGoods.id}";
					 return;
				 }else{
					 alert("投诉失败！");
					 return;
				 }
			 })
		 })
		
	});
</script>
</html>

