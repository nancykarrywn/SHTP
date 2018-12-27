function loginCheck() {
	var username = $("#username").val();
	var password = $("#password").val();
	var code = $("#code").val();
	if (username.trim() == "") {		
		art.dialog({
		    title: '提示信息',
		    content: '请输入用户名！',
		    icon: 'error',			   
		    ok: function(){		       				       
		        return;
		    }
		});
		return false;
	} else {
		if (password.trim() == "") {		
			art.dialog({
			    title: '提示信息',
			    content: '请输入密码！',
			    icon: 'error',			   
			    ok: function(){		       				       
			        return;
			    }
			});
			return false;
		} else {
			
				$("#loginForm").submit();
				return true;
			
		}
	}
}