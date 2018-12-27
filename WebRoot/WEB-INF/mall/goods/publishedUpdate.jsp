<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="tags"%>
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
<link rel="stylesheet"
	href="<%=path%>/assets/common/artDialog/skins/default.css">
<script src="<%=path%>/assets/common/artDialog/artDialog.js"></script>
</head>
<body>
	<jsp:include page="/WEB-INF/mall/common/header.jsp"></jsp:include>
	<div class="main">
		<div class="container">
			<div class="Product_top">
				<div class="row content">
					<div class="col-md-3 ">
						<div class="category_box">
							<h3 class="cate_head">个人中心</h3>
							<img alt="尊享会员" src="<%=path%>/assets/images/mem.jpg"
								class="img img-thumbnail img-responsive">
							<ul class="category">
								<li><a href="<%=path %>/member/toUpdate.action">修改资料</a></li>
								<li><a href="<%=path %>/orders/myOrders.action">我的订单</a></li>
								<li><a href="<%=path %>/goods/myGoods.action">已买到商品</a></li>
								<li><a href="<%=path %>/comment/myComments.action">我的评价</a></li>
								<li><a href="<%=path %>/goods/publishedGoods.action">已发布商品</a></li>	
								<li><a href="<%=path %>/orders/myReturn.action">退货中心</a></li>				
							</ul>
						</div>
					</div>
					<div class="col-md-9">
						<div class="breadcrumb">
							<a href="<%=path%>/mall/index.action">首页</a> &gt;&gt; <span
								class="last">用户/发布商品</span>
						</div>
						<div class="account_grid">
							<form class="form-horizontal" method="post"
								action="<%=path%>/goods/update.action"
								enctype="multipart/form-data" id="publishForm">
								<div class="form-group">
									<label class="col-sm-2 control-label">分 类</label>
									<div class="col-sm-10">
										<select  class="form-control" name="goods.category.id">
											<c:forEach items="${categoryList }" var="category">
												<option value="${category.id }" <c:if test="${category.id == goods.category.id }">selected</c:if>>${category.name }</option>
											</c:forEach>										
										</select>
									</div>
								</div>
								<div class="form-group">
									<label class="col-sm-2 control-label">名 称</label>
									<div class="col-sm-10">
										<input type="text" class="form-control" placeholder="名 称"
											name="goods.name" value="${goods.name }">
									</div>
								</div>
								<div class="form-group">
									<label class="col-sm-2 control-label">价 格</label>
									<div class="col-sm-10">
										<input type="text" class="form-control" placeholder="价 格"
											name="goods.price" value="${goods.price }">
									</div>
								</div>
								<div class="form-group">
									<label class="col-sm-2 control-label">简 介</label>
									<div class="col-sm-10">
										<textarea name="goods.intro" cols="20" rows="2" class="form-control">${goods.intro }</textarea>
										<!-- <input type="hidden"  name="goods.intro" id="content" > -->
									</div>
								</div>
								
								<div class="form-group">
									<label class="col-sm-2 control-label">选择图片</label>
									<div class="col-sm-10">
										<input type="file" class="form-control" name="file"
											accept=".gif,.jpg,.jpeg,.png">
											<input type="hidden" name="goods.img" value="${goods.img }"/>
											<input type="hidden" name="goods.isRecommend" value="${goods.isRecommend }"/>
											<input type="hidden" name="goods.isChecked" value="${goods.isChecked }"/>
											<input type="hidden" name="goods.member.id" value="${loginMember.id }"/>
											<input type="hidden" name="goods.id" value="${goods.id }"/>
									</div>
								</div>
								<div class="form-group">
									<div class="col-sm-offset-2 col-sm-10">
										<button type="button" class="btn btn-primary" id="uploadBtn">更新</button>
										<button type="button" class="btn btn-default"
											onclick="javascript:history.back()">返 回</button>
									</div>
								</div>
							</form>
						</div>
						<div class="clearfix"></div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<jsp:include page="/WEB-INF/mall/common/footer.jsp"></jsp:include>

</body>
<script src="<%=path%>/assets/common/ckeditor/ckeditor.js"></script>
<script type="text/javascript">
/* 	var editor = CKEDITOR.replace('TextArea1'); */
	$("#uploadBtn").click(function(){
		/* var content = editor.getData();
		$("#content").val(content); */
		$("#publishForm").submit();
	});
</script>
</html>


