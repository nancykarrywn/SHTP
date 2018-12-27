<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
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
<link rel="stylesheet"
	href="<%=path%>/assets/common/artDialog/skins/default.css">
<script src="<%=path%>/assets/common/artDialog/artDialog.js"></script>

</head>
<body>
	<jsp:include page="/WEB-INF/admin/common/header.jsp"></jsp:include>
	<!-- 内容 开始 -->
	<div class="content">

		<div class="header">
			<h1 class="page-title">投诉管理</h1>
		</div>

		<ul class="breadcrumb">
			<li><a href="<%=path%>/admin/index.action">主页</a> <span
				class="divider">/</span></li>
			<li><a href="list.action">投诉</a> <span class="divider">/</span></li>
			<li class="active">投诉信息</li>
		</ul>

		<div class="container-fluid">
			<div class="row-fluid">
				<div class="row-fluid">
					<div class="span1"></div>

					<div class="span6">
						<h2>
							<span class="label"> 投 诉 人: </span> <span
								class="label label-success">
								${complain.memberByBuyer.name}</span>
						</h2>
						<h2>
							<span class="label"> 被 投 诉 人: </span> <span
								class="label label-success">
								${complain.memberBySaler.name}</span>
						</h2>
						<h2>
							<span class="label"> 投 诉 时 间 : </span> <span
								class="label label-success"> <fmt:formatDate
									value="${complain.complainTime}" pattern="yyyy-MM-dd HH:mm:SS" />
							</span>
						</h2>

						<h2>
							<span class="label"> 投 诉 内 容 : </span>
						</h2>
						<p class="text-success">${complain.complainContent}</p>
						<h2>
							<span class="label"> 处 理 状 态 : </span> <span
								class="label label-success"> <c:if
									test="${complain.status eq '0' }">未处理</c:if> <c:if
									test="${complain.status eq '1' }">已处理</c:if>
							</span>
						</h2>
						<c:if test="${complain.status eq '0' }">
							<form action="handle.action" method="post"
								id="handleForm" class="container">

							
								<div class="clearfix"></div>
								<!-- <textarea id="TextArea1" cols="20" rows="2" class="ckeditor"></textarea> -->
								<input type="hidden" name="complain.id" value="${complain.id }">
								<textarea  name="complain.handleResult" class="form-control"></textarea>
								
							</form>
						</c:if>
						<c:if test="${complain.status eq '1' }">
							<h2>
							<span class="label"> 处 理 人: </span> <span
								class="label label-success">
								${complain.admin.username}</span>
						</h2>
						<h2>
							<span class="label"> 处 理 时 间 : </span> <span
								class="label label-success"> <fmt:formatDate
									value="${complain.handleTime}" pattern="yyyy-MM-dd HH:mm:SS" />
							</span>
						</h2>

						<h2>
							<span class="label">  处 理 结 果 : </span>
						</h2>
						<p class="text-success">${complain.handleResult}</p>
						</c:if>
					</div>

				</div>
				<div class="form-actions">
					<c:if test="${complain.status eq '0' }">
						<button class="btn btn-primary" id="handleBtn">完成处理</button>
					</c:if>
					<a href="javascript:history.back()"> <input type="button"
						class="btn" value="返  回">
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

	<script src="<%=path%>/js/jquery-1.7.2.min.js" type="text/javascript"></script>
	<script src="<%=path%>/assets/common/ckeditor/ckeditor.js"></script>
<script type="text/javascript">
	/* var editor = CKEDITOR.replace('TextArea1'); */
	$("#handleBtn").click(function(){
		/* var content = editor.getData(); */
		/* $("#content").val(content);		 */
		$.post("handle.action",$("#handleForm").serialize(),function(data){
			if(data.message == "success"){
				art.dialog({
				    title: '提示信息',
				    content: '处理成功',
				    icon: 'succeed',			   
				    ok: function(){	
				    	location.href="list.action";
				        return;
				    }
				});
			}else{
				art.dialog({
				    title: '提示信息',
				    content: '处理失败！',
				    icon: 'error',			   
				    ok: function(){		       				       
				        return;
				    }
				});
			}
		});
	});
</script>

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
			var delurl = "Room_delete.action?complain.id=" + delid
					+ "&pageNow=" + pNow;
			$("#myModal").modal("show").on("shown", function() {
				$("#delbtn2").attr('href', delurl);
			});
		}
	</script>
</body>
</html>
