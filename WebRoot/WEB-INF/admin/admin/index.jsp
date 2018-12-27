<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE>
<html>
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



<body>
	 <jsp:include page="/WEB-INF/admin/common/header.jsp"></jsp:include>
	 <div class="content">
        
        <div class="header">
            <h1 class="page-title">欢迎进入管理员界面</h1>
        </div>
       </div>

	<footer>
		<p class="pull-right">
			&copy; 2017.6<a href="#"></a>
		</p>
	</footer>
	
	

	<script type="text/javascript">
		var xmlhttp;
		$('.make-switch').on('switch-change', function(e, data) {
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

		function state_Change() {
			if (xmlhttp.readyState == 4) {
				if (xmlhttp.status == 200) {

				}
			}
		}

		function del(obj) {
			var delid = $(obj).attr("delid");
			var pNow = $(obj).attr("pNow");
			var delurl = "Hotel_delete.action?instance.id=" + delid
					+ "&pageNow=" + pNow;
			$("#myModal").modal("show").on("shown", function() {
				$("#delbtn2").attr('href', delurl);
			});
		}
	</script>
</body>
</html>
