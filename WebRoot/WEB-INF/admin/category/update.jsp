<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML>
<html>
  <head>
    <title>校园二手商品交易系统</title>
    
    <link rel="stylesheet" type="text/css" href="<%=path%>/bootstrap/css/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="<%=path%>/bootstrap/css/bootstrap-select.css">
    <link rel="stylesheet" type="text/css" href="<%=path%>/css/theme.css">
    <link rel="stylesheet" href="<%=path%>/font-awesome/css/font-awesome.css">
    
	<script src="<%=path%>/js/jquery-1.7.2.min.js" type="text/javascript"></script>
    <script src="<%=path%>/bootstrap/js/bootstrap.js"></script>
    <script src="<%=path%>/bootstrap/js/bootstrap-select.js"></script>
    <script src="<%=path%>/bootstrap/js/bootstrap-file-input.js"></script>
   
    <link rel="stylesheet" href="<%=path%>/bootstrap/css/bootstrap-switch.css" />
    <script src="<%=path%>/bootstrap/js/bootstrap-switch.js"></script>    
  </head>
  <body> 
  	<jsp:include page="/WEB-INF/admin/common/header.jsp"></jsp:include>
  
	<div class="content">
        
        <div class="header">
            <h1 class="page-title">分类</h1>
        </div>
        
         <ul class="breadcrumb">
           <li><a href="<%=path%>/admin/index.action">主页</a> <span class="divider">/</span></li>
            <li><a href="<%=path%>/category/list.action">分类</a> <span class="divider">/</span></li>
            <li class="active">编辑分类</li>
        </ul>

        <div class="container-fluid">
            <div class="row-fluid">
            	<c:if test="${message=='success'}">
				    <div class="alert alert-info">
				        <button type="button" class="close" data-dismiss="alert">×</button>
				        <strong>小提示：</strong> 保存成功！！
				    </div>
			      </c:if>
            <div class="page-header" ></div>
            <form action="<%=path%>/category/update.action" method="post" class="form-horizontal"  >    
            <div class="row-fluid">
               <div class="span7">  	             
					<div class="control-group">
							<label class="control-label" for="names">分 类 名 称</label>
							<div class="controls">
							<input name="category.name" class="input-xlarge focused" id="categoryName" type="text" value="${category.name}">
							</div>
					</div>
					<div class="control-group">
							<label class="control-label" for="price">分 类 编 号</label>
							<div class="controls">
							<input name="category.id" class="input-xlarge focused"  type="text" value="${category.id}" readonly>							
							</div>
					</div>								
					
					<div class="control-group">
							<label class="control-label" for="remark">分 类 描 述</label>
							<div class="controls">
							<textarea rows="4" cols="20" name="category.descb" >${category.descb}</textarea>
							</div>
					</div>
					
               </div>
			
               </div>
               <div class="form-actions">
								<button type="submit" class="btn btn-primary">保  存</button>
								<a href="javascript:history.back()">
								<input type="button" class="btn" value="返  回">
							  </a>
				</div>
               </form>
			<footer>
			<hr>
			<p class="pull-right">
				&copy; 2017.6<a href="#" target="_blank"> </a>
			</p>
			</footer>
            </div>
        </div>
    </div>

		
  </body>
</html>
