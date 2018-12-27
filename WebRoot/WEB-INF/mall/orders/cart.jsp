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
							<table
					class="table table-striped table-bordered bootstrap-datatable datatable">
					<thead>
						<tr>
							<th>订单编号</th>
							<th>下单人</th>
							<th>商品名称</th>
							<th>下单时间</th>
							<th>交易状态</th>
							<th>操作</th>

						</tr>
					</thead>
					<tbody>
						<c:forEach items="${ordersList}" var="orders">
							<tr>
								<td>${orders.id}</td>
								<td>${orders.member.name }</td>
								<td>${orders.goods.name }</td>
								<td>
									<fmt:formatDate value="${orders.orderTime}" pattern="yyyy-MM-dd HH:mm:SS"/>
								</td>
								<td>
									<c:choose>
										<c:when test="${orders.tradingSatuts eq '0'}">未支付</c:when>
										<c:when test="${orders.tradingSatuts eq '1'}">已支付</c:when>	
										<c:when test="${orders.tradingSatuts eq '2'}">申请退货</c:when>	
										<c:when test="${orders.tradingSatuts eq '3'}">拒绝退货</c:when>	
										<c:when test="${orders.tradingSatuts eq '4'}">退货成功</c:when>										
									</c:choose>
								</td>
								<td><a href="orderInfo.action?orders.id=${orders.id}"
									class="btn btn-primary"> 查看</a> 
									<button onclick="del(${orders.id},${page.pageNo})"
										class="btn btn-danger">
										<i class="icon-trash icon-white"></i> 删除
									</button>
									<c:if test="${orders.tradingSatuts eq '0' }">
										<a href="toPay.action?orders.id=${orders.id}"
										class="btn btn-info">支付
										
									</a>
									</c:if>
									</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				<div class="pagination">
					<tags:page page="${page}" />
				</div>	
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
		function del(delid,pageNo) {
			art.dialog({
			    title: '提示信息',
			    content: '确定要删除该记录吗？',
			    icon: 'warning',			   
			    ok: function(){	
			    	var delurl = "del.action";
			    	//url-发送请求的地址    {"goods.id":delid} 发送给后台的数据 以key/value  请求成功后的回调函数function(data)
					$.post(delurl,{"orders.id":delid,pageNo:pageNo},function(data){
						if(data.message=="success"){							
							art.dialog({
							    title: '提示信息',
							    content: '删除成功！',
							    icon: 'succeed',			   
							    ok: function(){		       				       
							    	location.href="<%=path%>/orders/myOrders.action";
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
			    }
			});
		}	
	</script>
<script type="text/javascript">
var msg = "${requestScope.message}";
if(!msg.trim()==""){	
	art.dialog({
	    title: '提示信息',
	    content: msg,
	    icon: 'error',			   
	    ok: function(){		       				       
	        return;
	    }
	});
	msg = null;
}
function loginCheck() {
	var username = $("#username").val();
	var password = $("#password").val();
	var code = $("#code").val();
	if (username.trim() == "") {		
		art.dialog({
		    title: '提示信息',
		    content: '请输入用户名！',
		    icon: 'error',			   
		    ok: function(){		       				       
		        return;
		    }
		});
		return false;
	} else {
		if (password.trim() == "") {		
			art.dialog({
			    title: '提示信息',
			    content: '请输入密码！',
			    icon: 'error',			   
			    ok: function(){		       				       
			        return;
			    }
			});
			return false;
		} else {
			if (code.trim() == "") {				
				art.dialog({
				    title: '提示信息',
				    content: '请输入验证码！',
				    icon: 'error',			   
				    ok: function(){		       				       
				        return;
				    }
				});
				return false;
			} else {
				$("#loginForm").submit();
				return true;
			}
		}
	}
}
</script>
</html>

