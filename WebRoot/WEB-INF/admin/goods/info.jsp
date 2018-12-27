<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML>
<html lang="en">
<head>
<title>校园二手商品交易系统后台</title>

<link rel="stylesheet" type="text/css"
	href="<%=path%>/bootstrap/css/bootstrap.css">
<link rel="stylesheet" type="text/css" href="<%=path%>/css/theme.css">
<link rel="stylesheet"
	href="<%=path%>/font-awesome/css/font-awesome.css">


<script src="<%=path%>/js/jquery-1.7.2.min.js" type="text/javascript"></script>
<script src="<%=path%>/bootstrap/js/bootstrap.js"></script>

<link rel="stylesheet"
	href="<%=path%>/bootstrap/css/bootstrap-switch.css" />
<script src="<%=path%>/bootstrap/js/bootstrap-switch.js"></script>

</head>
<body>
<jsp:include page="/WEB-INF/admin/common/header.jsp"></jsp:include>
	  <!-- 内容 开始 -->
<div class="content">
        
        <div class="header">
            <h1 class="page-title">商品</h1>
        </div>
        
        <ul class="breadcrumb">
            <li><a href="admin_home.action">主页</a> <span class="divider">/</span></li>
            <li class="active">商品</li>
        </ul>

        <div class="container-fluid">
            <div class="row-fluid">
            <div class="page-header" ></div> 
            <div class="row-fluid">
            <div class="span1"></div>
            	<div class="span5">
					<h2 style="color:#666">${auditedgoods.name}</h2>
					<img src="${auditedgoods.img}" alt="" width="300" height="350">	
               </div>
               <div class="span6">  	
					<h2>
					<span class="label"> 所 属 分 类 : </span> 
					<span class="label label-success" >  ${auditedgoods.category.name}</span>
					</h2>
					<h2>
					<span class="label"> 类 型 : </span>
					</h2>
						${auditedgoods.category.name }			
					<h2>
					<span class="label"> 价 格 : </span>
					</h2>
						${auditedgoods.price }			
					
					<h2>
					<span class="label"> 简 介 : </span> 
					</h2>
					<p class="text-success">${auditedgoods.intro}</p>		
               </div>
			
               </div>
               <div class="form-actions">	
               		
               		<c:if test="${auditedgoods.isRecommend eq '0' }">
               			<button onclick="recommend(${goods.id})"
										class="btn btn-danger">
										推荐
									</button>
               		</c:if>	
               		<c:if test="${auditedgoods.state eq '0' }">
               			            <button onclick="checked(${auditedgoods.id})"
										class="btn btn-primary">
										审核通过
									</button>
									<button onclick="cancelChecked(${auditedgoods.id})"
										class="btn btn-info">
										审核不通过
									</button>
					
               		</c:if>
					<button type="button" class="btn" onclick="history.back()">返  回</button>					
				</div>
			<footer>
				<p class="pull-right">
					&copy; 2017.6<a href="#"></a>
				</p>
			</footer>

            </div>
        </div>
    </div>
	<script>
	function checked(delid){		
		var url = "checked.action";
		//url-发送请求的地址    {"auditedgoods.id":delid} 发送给后台的数据 以key/value  请求成功后的回调函数function(data)
		$.post(url,{"auditedgoods.id":delid},function(data){
			if(data.message=="success"){
				alert("审核成功！");
				location.href="<%=path%>/goods/list.action";
				return;
			}
			else if(data.message=="failed"){
				alert("审核失败！");
				return;
			}else{
				alert("请求发生错误！");
				return;
			}
		})
	}
	function cancelChecked(delid){		
		var url = "cancelChecked.action";
		$.post(url,{"auditedgoods.id":delid},function(data){
			if(data.message=="success"){
				alert("操作成功！");
				location.href="<%=path%>/goods/list.action";
				return;
			}
			else if(data.message=="failed"){
				alert("操作失败！");
				return;
			}else{
				alert("请求发生错误！");
				return;
			}
		})
	}
	function recommend(delid){		
		var url = "recommended.action";
		$.post(url,{"goods.id":delid},function(data){
			if(data.message=="success"){
				alert("推荐成功！");
				location.href="<%=path%>/goods/list.action";
				return;
			}
			else if(data.message=="failed"){
				alert("推荐失败！");
				return;
			}else{
				alert("请求发生错误！");
				return;
			}
		})
	}
	</script>
</body>
</html>
