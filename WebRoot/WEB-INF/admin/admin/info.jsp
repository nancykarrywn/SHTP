<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
            <h1 class="page-title">管理员</h1>
        </div>
        
        <ul class="breadcrumb">
            <li><a href="<%=path%>/admin/index.action">主页</a> <span class="divider">/</span></li>
            <li><a href="<%=path%>/admin/list.action">管理员</a> <span class="divider">/</span></li>
            <li class="active">管理员信息</li>
        </ul>

        <div class="container-fluid">
            <div class="row-fluid">
            <div class="page-header" ></div> 
            <div class="row-fluid">
            <div class="span1"></div>
            	
               <div class="span6">  	
					<h2>
					<span class="label"> 管 理 员 编 号: </span> 
					<span class="label label-success" >  ${admin.id}</span>
					</h2>
					<h2>
					<span class="label"> 管 理 员 帐 号 : </span>
					</h2>
						${admin.username}	
					<h2>
					<span class="label"> 管 理 员  密 码: </span> 
					</h2>
					<p class="text-success">${admin.password}</p>		
               </div>
			
               </div>
               <div class="form-actions">		
					<a href="list.action">
						<input type="button" class="btn" value="返  回">
					</a>
				</div>
			<footer>
				<p class="pull-right">
					&copy; 2017.6<a href="#"></a>
				</p>
			</footer>

            </div>
        </div>
    </div>



	<script type="text/javascript">
		/*
		 $(document).ready(function(){
		 $("#delbtn").click(function(){
		 var delid=$("#delbtn").attr("delid");
		 $("#myModal").modal("show").on("shown", function () {
		 var delurl="<%=path%>/TableServlet?delid="+delid;
		 $("#delbtn2").attr('href',delurl);
		 });
		 });
		
		 });
		 */

		var xmlhttp;
		$('.make-switch').on('switch-change', function(e, data) {
			//创建xmlHttp  
			createXMLHttpRequest();
			var url = "<%=path%>/OrderServlet?oid=" + $(this).attr('id');
			xmlhttp.onreadystatechange = state_Change;
			xmlhttp.open("POST", url, true);
			xmlhttp.send(null);
		})

		function createXMLHttpRequest() {
			if (window.XMLHttpRequest) {// code for IE7, Firefox, Opera, etc.
				xmlhttp = new XMLHttpRequest();
			} else if (window.ActiveXObject) {// code for IE6, IE5
				xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
			}
		}

		//处理返回结果
		function state_Change() {
			if (xmlhttp.readyState == 4) {
				if (xmlhttp.status == 200) {

				}
			}
		}

		function del(obj) {
			var delid = $(obj).attr("delid");
			var pNow = $(obj).attr("pNow");
			var delurl = "Room_delete.action?admin.id=" + delid
					+ "&pageNow=" + pNow;
			$("#myModal").modal("show").on("shown", function() {
				$("#delbtn2").attr('href', delurl);
			});
		}
	</script>
</body>
</html>
