<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
<link href="<%=path%>/assets/common/slider/css/jquery.slideBox.css"
	rel="stylesheet" type="text/css" />
</head>
<body>
	<jsp:include page="/WEB-INF/mall/common/header.jsp"></jsp:include>
	<div class="main">
		<div class="container">
			<div class="Product_top">
				<form  method="post" id="registerForm">
					<div class="register-top-grid">
						<h3>个人信息</h3>
						<div>
							<span>姓名<label>*</label></span> <input type="text"
								name="member.name" id="name"> <input type="hidden"
								name="member.permission" value="3">
						</div>
						<div>
							<span>手机号<label>*</label></span> <input type="text"
								name="member.phone" id="phone">
						</div>
						<div>
							<span>出生日期<label></label></span> <input type="date"
								name="member.birthday" id="birthday" placeholder="xxxx-xx-xx">
						</div>
						<div>
							<span>性别<label></label></span> <label class="radio-inline">
								<input type="radio" value="2" checked name="member.gender">
								男
							</label> <label class="radio-inline"> <input type="radio"
								value="1" name="member.gender"> 女
							</label><label class="radio-inline"> <input type="radio"
								value="0" name="member.gender"> 保密
							</label>
						</div>
						<div class="clearfix"></div>
						<div>
							<span>住址<label>*</label></span> <input type="text" id="address"
								name="member.address">
						</div>
						<div class="clearfix"></div>
						<a class="news-letter" href="#"> <label class="checkbox"><input
								type="checkbox" name="checkbox" id="protocal"><i> </i>已阅读并同意注册协议</label>
						</a>
					</div>
					<div class="clearfix"></div>
					<div class="register-bottom-grid">
						<h3>登录信息</h3>
						<div>
							<span>用户名<label>*</label></span> <input type="text"
								name="member.username" id="username">
						</div>
						<div>
							<span>密码<label>*</label></span> <input type="password"
								name="member.password" id="password">
						</div>

					</div>


					<div class="clearfix"></div>
					<div class="register-but">

						<input type="button" value="注册" onclick="registerCheck()">


					</div>
				</form>
				<div class="clearfix"></div>
			</div>
		</div>
	</div>
	<jsp:include page="/WEB-INF/mall/common/footer.jsp"></jsp:include>
</body>
<script type="text/javascript">
function registerCheck() {
	var name = $("#name").val();
	var phone = $("#phone").val();
	var birthday = $("#birthday").val();
	var gender = $("#gender").val();
	var address = $("#address").val();
	var protocal = $("input[type='checkbox']").is(':checked');
	var username = $("#username").val();
	var password = $("#password").val();
	var reg = /(^0{0,1}1[3|4|5|6|7|8|9][0-9]{9}$)/;
	var date = /^(\d{4})-(\d{2})-(\d{2})$/;
	var flag;
	if (name.trim() == "") {
		alert("请输入姓名！");
		return false;
	} else {
		if (phone.trim() == "") {
			alert("请输入手机号码！");
			return false;
		} else {
			if (!reg.test(phone)) {
				alert("手机号码格式错误！");
				return false;
			} else {
				if (birthday.trim() == "") {
					alert("请输入出生日期！");
					return false;
				} else

				{
					if (!RQcheck(birthday)) {
						alert("生日格式错误！");
						return false;
					} else {
					if (address.trim() == "") {
										alert("请输入地址！");
										return false;
									} else {
										if (!protocal) {
											alert("必须同意注册协议内容方可注册！");
											return false;
										} else {
											if (username.trim() == "") {
												alert("请输入用户名！")
												return false;
											} else {
												var url = "isExist.action";
												$.ajax({
													type : "post",
													url : url,
													data : {
														"member.username" : username,

													},
													async : false,
													success : function(msg) {
														if (msg.message=="exist") {
															flag = "exist";
														} else {
															flag = "notexist";
														}
													}
												});
												if (flag == "exist") {
													alert("用户名已存在，请更换以便注册！");
													return false;
												}

												else {
													if (password.trim() == "") {
														alert("请输入密码");
														return false;
													} else{													
														$.post("/SHTP/member/register.action",$("#registerForm").serialize(),function(data){
															if(data.message=="success"){
																alert("注册成功！");
																location.href="/SHTP/member/toLogin.action";
																return;
															}else{
																alert("注册失败,请稍后重试！");
																return;
															}
														});
														return true;
														}

												}
											}

										}
									}
								}
							}

						}
					}
				}
			}
		
	
function RQcheck(RQ) {
    var date = RQ;
    var result = date.match(/^(\d{1,4})(-|\/)(\d{1,2})\2(\d{1,2})$/);

    if (result == null)
        return false;
    var d = new Date(result[1], result[3] - 1, result[4]);
    return (d.getFullYear() == result[1] && (d.getMonth() + 1) == result[3] && d.getDate() == result[4]);

}
</script>
</html>

