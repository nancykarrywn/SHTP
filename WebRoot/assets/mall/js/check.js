function loginCheck() {
	var username = $("#username").val();
	var password = $("#password").val();
	if (username.trim() == "") {
		alert("请输入用户名！");
		return false;
	} else {
		if (password.trim() == "") {
			alert("请输入密码！");
			return false;
		} else {
			$("#loginForm").submit();
			return true;
		}
	}
}

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
						if (gender.trim() == "") {
							alert("请输入性别！");
							return false;
						} else {
							if (gender.trim() != "男" & gender.trim() != "女"
									& gender.trim() != "保密") {
								alert("请输入正确的性别！");
								return false;
							} else {
								
									if (address.trim() == "") {
										alert("请输入地址！");
										return false;
									} else {
										if (!protocal) {
											alert("必须同意注册协议内容方可注册！");
											retrun
											false;
										} else {
											if (username.trim() == "") {
												alert("请输入用户名！")
												return false;
											} else {
												var url = "user!isExist.action";
												$.ajax({
													type : "post",
													url : url,
													data : {
														"user.username" : username,

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
														$.post("/QHIP/user!register.action",$("#registerForm").serialize(),function(data){
															if(data.message=="success"){
																alert("注册成功！");
																location.href="/QHIP/user!toLogin.action";
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
