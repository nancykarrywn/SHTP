function loginCheck() {
	var username = $("#username").val();
	var password = $("#password").val();
	var code = $("#code").val();
	if (username.trim() == "") {
		alert("请输入用户名！");
		return false;
	} else {
		if (password.trim() == "") {
			alert("请输入密码！");
			return false;
		} else {
			if (code.trim() == "") {
				alert("请输入验证码！");
				return false;
			} else {
				$("#loginForm").submit();
				return true;
			}
		}
	}
}