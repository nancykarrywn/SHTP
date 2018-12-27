<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% String path = request.getContextPath(); %>
<%@ taglib uri="/struts-tags" prefix="s" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${initParam.appName}</title>
</head>
<body>
	<script type="text/javascript">
		location.href="/SHTP/mall/index.action";
	</script>
</body>
</html>