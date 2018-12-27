<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="category_box">
	<h3 class="cate_head">推荐商品</h3>
	<ul class="category">
		<c:forEach items="${recommendGoods}" var="goods">
			<li><a href="<%=path %>/mall/goodsInfo.action?goods.id=${goods.id }">${goods.name }</a></li>

		</c:forEach>
	</ul>
</div>

