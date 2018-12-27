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
							<img alt="尊享会员" src="<%=path %>/assets/images/mem.jpg" class="img img-thumbnail img-responsive">
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
							<a href="<%=path%>/mall/index.action">首页</a> &gt;&gt; <span class="last">用户/个人中心</span>
						</div>
						<div class="account_grid">
						<a class="btn btn-primary" href="toPublish.action">发 布 商 品</a>
							<table
					class="table table-striped table-bordered bootstrap-datatable datatable">
					<thead>
						<tr>
							<th>商品编号</th>
							<th>商品名称</th>
							<th>商品类型</th>
							<th>商品价格</th>
							<th>操作</th>

						</tr>
					</thead>
					<tbody>
						<c:forEach items="${myGoods}" var="goods">
							<tr>
								<td>${goods.id}</td>
								<td>${goods.name}</td>
								<td>${goods.category.name}</td>
								<td>${goods.price}</td>
								<td><a href="publishedInfo.action?goods.id=${goods.id}"
									class="btn btn-primary"> 查看</a> 
									<a href="publishedUpdate.action?goods.id=${goods.id}"
									class="btn btn-info"> 编辑</a> 
									<button onclick="del(${goods.id})"
										class="btn btn-danger">
										<i class="icon-trash icon-white"></i> 删除
									</button></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			<%-- 	<div class="pagination">
					<tags:page page="${page}" />
				</div>	 --%>
							<div class="clearfix"></div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<jsp:include page="/WEB-INF/mall/common/footer.jsp"></jsp:include>

</body>
	<script type="text/javascript">
		function del(delid) {
		    //弹出表单
			art.dialog({
			    title: '提示信息',
			    content: '确定要删除该记录吗？',
			    icon: 'warning',			   
			    ok: function(){	
			    	var delurl = "del.action";
			    	//以post形式向服务器发起AJAX请求     "del.action"-服务器端的地址   {"goods.id":delid}为需要传递到服务器的参数    function(data)请求完成时被调用
					$.post(delurl,{"goods.id":delid},function(data){
						if(data.message=="success"){							
							art.dialog({
							    title: '提示信息',
							    content: '删除成功！',
							    icon: 'succeed',			   
							    ok: function(){		       				       
							    	location.href="<%=path%>/goods/publishedGoods.action";
									return;
							    }
							    
							});
							
						}
						else if(data.message=="failed"){							
							art.dialog({
							    title: '提示信息',
							    content: '删除失败！',
							    icon: 'error',			   
							    ok: function(){		       				       
							        return;
							    }
							});
							return;
						}else{							
							art.dialog({
							    title: '提示信息',
							    content: '请求发生错误！',
							    icon: 'error',			   
							    ok: function(){		       				       
							        return;
							    }
							});
							return;
						}
					})
			        return;
			    },cancel:function(){
			    	return;
			    }
			});
		}	
	</script>

</html>

