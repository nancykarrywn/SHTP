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
<script src="<%=path%>/assets/common/raty/jquery.raty.js"></script>
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
				<form action="<%=path %>/business!comment.action" method="post" id="commentForm">
					<div class="register-top-grid">
						<h3>评论</h3>						
						<div>
							<span>商品<label>*</label></span> <input type="text"
								value="${goods.name }" readonly> <input type="hidden"
								name="comment.goods.id" value="${goods.id }">
						</div>
						<div>
							<span>价格<label>*</label></span> <input type="text"
								value="${goods.price }" readonly>
						</div>
						<div>
							<span>姓名<label>*</label></span> <input type="text"
								value="${loginMember.name }" readonly> <input type="hidden"
								name="comment.member.id" value="${loginMember.id }">
						</div>
						<div>
							<span>手机号<label>*</label></span> <input type="text"
								value="${loginMember.phone }" readonly>
						</div>
						<!--  <div>
						<input type="hidden" name="comment.commentLevel" id="level" value="0">
						<span>满意程度<label></label></span> <div id="star" data-score="1"></div>
						</div>-->
						<div>
							<span>内容<label></label></span>
							<textarea name="comment.commentContent"></textarea>
						</div>


						<div class="clearfix"></div>

						<div class="register-but">
							<input type="button" value="评论" id="commentBtn">
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
			 $.post("<%=path %>/comment/insert.action",$("#commentForm").serialize(),function(data){
				 if(data.message=="success"){
					 alert("评论成功！");
					 history.back();
					 return;
				 }else{
					 alert("评论失败！");
					 return;
				 }
			 })
		 })
		
	});
</script>
</html>

