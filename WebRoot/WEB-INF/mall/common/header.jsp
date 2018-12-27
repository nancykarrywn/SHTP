<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% String path = request.getContextPath(); %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="header">
		<div class="container">
			<div class="header_top">
				<ul class="phone">
					
					<li class="phone_right">温馨提示：天气转冷，请注意保暖！</li>
					<li class="clearfix"></li>	
				</ul>
				
				
			
				<c:if test="${!empty loginMember }">
					<ul class="shopping_cart">
						<li class="shop_left"><a href="<%=path %>/orders/cart.action"><i
								class="cart"> </i><span>购物车</span></a></li>
								<li class="shop_right"><a href="<%=path %>/member/personal.action"><span>个人中心</span></a></li>																
					</ul>
					<span style="margin-left:20px;"><a href="<%=path%>/member/logout.action">退出</a></span>
					<div class="clearfix"></div>	
				</c:if>
				<div class="clearfix"></div>
			</div>
			<div class="header_bottom">
				<div class="header_nav">
					<div class="logo">
						<a href="index.jsp"><img src="<%=path%>/assets/mall/images/logo.png"
							alt="" /><br></a>
					</div>
					<nav class="navbar navbar-default menu" role="navigation">
					<h3 class="nav_right">
						<a href="index.jsp"><img src="<%=path%>/assets/images/logo.png"
							class="img-responsive" alt="" /></a>
					</h3>
					<div class="container-fluid">						
						<div class="navbar-header">
							<button type="button" class="navbar-toggle"
								data-toggle="collapse"
								data-target="#bs-example-navbar-collapse-1">
								<span class="sr-only">Toggle navigation</span> <span
									class="icon-bar"></span> <span class="icon-bar"></span> <span
									class="icon-bar"></span>
							</button>
						</div>						
						<div class="collapse navbar-collapse"
							id="bs-example-navbar-collapse-1">
							<ul class="nav navbar-nav menu1">
								<li class="active"><a href="<%=path %>/mall/index.action">首页</a></li>
								<li><a href="<%=path %>/mall/goods.action">商品</a></li>
								<li><a href="<%=path %>/goods/recommend.action">推荐商品</a></li>
								<!-- <li><a href="business!toSearch.action">商品搜索</a></li> -->
								<li><a href="<%=path %>/member/personal.action">会员中心</a></li>
								<!-- <li><a href="contact.jsp">联系我们</a></li> -->
							</ul>
							<c:if test="${empty  loginMember}">
								<ul class="login">
									<li class="login_top"><a href="<%=path%>/member/toLogin.action"><i
											class="sign"> </i><span>登录</span></a></li>
									<li class="login_bottom"><a href="<%=path%>/member/toRegister.action"><i
											class="register"> </i><span>注册</span></a></li>
								</ul>
							</c:if>
							<div class="clearfix"></div>
						</div>						
					</div>
					</nav>
					<div class="clearfix"></div>
				</div>
				<div class="search">
					<form action="<%=path%>/goods/searchByName.action" method="post">
						<input type="text" class="text" name="goods.name" placeholder="输入商品名称"> 
						<input type="submit" value="搜索">
					</form>
				</div>
			</div>
		</div>
	</div>