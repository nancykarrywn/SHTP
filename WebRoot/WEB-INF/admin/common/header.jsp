<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% String path = request.getContextPath(); %>
<!DOCTYPE html>
<style type="text/css">
#line-chart {
	height: 300px;
	width: 800px;
	margin: 0px auto;
	margin-top: 1em;
}

.brand {
	font-family: georgia, serif;
}

.brand .first {
	color: #ccc;
	font-style: italic;
}

.brand .second {
	color: #fff;
	font-weight: bold;
}
</style>

	<div class="navbar">
		<div class="navbar-inner">
			<ul class="nav pull-right">

				<li id="fat-menu" class="dropdown"><a href="#" role="button"
					class="dropdown-toggle" data-toggle="dropdown"> <i
						class="icon-user"></i>${sessionScope.loginAdmin.username} <i
						class="icon-caret-down"></i>
				</a>

					<ul class="dropdown-menu">
						<li><a tabindex="-1" href="<%=path %>/admin/password.action">修改密码</a></li>
						<li class="divider"></li>
						<li><a tabindex="-1" href="<%=path %>/admin/logout.action">退出</a></li>
					</ul></li>

			</ul>
			<a class="brand" href="<%=path %>/admin/index.action"><span class="first">校园二手商品交易系统</span>
				<span class="second">后台</span></a>
		</div>
	</div>

	<div class="sidebar-nav">

			<a href="#index-menu" class="nav-header" data-toggle="collapse"><i
				class="icon-dashboard"></i>个人中心</a>
			<ul id="index-menu" class="nav nav-list collapse in">
					<li><a href="<%=path %>/admin/index.action">首页</a></li>	
				<li><a href="<%=path %>/admin/password.action">修改密码</a></li>
			</ul>
			
			<a href="#announcement-menu" class="nav-header" data-toggle="collapse"><i
				class="icon-table"></i>管理员 </a>
			<ul id="announcement-menu" class="nav nav-list collapse">
				<li><a href="<%=path %>/admin/list.action">管理员管理</a></li>
				<li><a href="<%=path %>/admin/toInsert.action">添加管理员</a></li>
			</ul>

			<a href="#member-menu" class="nav-header" data-toggle="collapse"><i
				class="icon-th-large"></i>会员</a>
			<ul id="member-menu" class="nav nav-list collapse">
				<li><a href="<%=path %>/member/list.action">会员管理</a></li>				
			</ul>
		
			<a href="#hotel-menu" class="nav-header" data-toggle="collapse"><i
				class="icon-table"></i>商品 </a>
			<ul id="hotel-menu" class="nav nav-list collapse">
				<li><a href="<%=path %>/category/list.action">分类管理</a></li>
				<li><a href="<%=path %>/category/toInsert.action">添加分类</a></li>
				<li><a href="<%=path %>/goods/list.action">商品管理</a></li>				
			</ul>
			
			<a href="#room-menu" class="nav-header collapsed"
				data-toggle="collapse"><i class="icon-reorder"></i>商品推荐 </a>
			<ul id="room-menu" class="nav nav-list collapse">
				<li><a href="<%=path %>/goods/recommend1.action">推荐管理</a></li>				
			</ul>

			<a href="#order-menu" class="nav-header" data-toggle="collapse"><i
				class="icon-table"></i>订单 </a>
			<ul id="order-menu" class="nav nav-list collapse">
				<li><a href="<%=path %>/orders/list.action">订单管理</a></li>
			</ul>
			
			<a href="#comment-menu" class="nav-header" data-toggle="collapse"><i
				class="icon-table"></i>评论 </a>
			<ul id="comment-menu" class="nav nav-list collapse">
				<li><a href="<%=path %>/comment/list.action">评论管理</a></li>
			</ul>
			
			<a href="#announcement-menu1" class="nav-header" data-toggle="collapse"><i
				class="icon-table"></i>投诉 </a>
			<ul id="announcement-menu1" class="nav nav-list collapse">
				<li><a href="<%=path %>/complain/list.action">投诉管理</a></li>
				
			</ul>

	</div>