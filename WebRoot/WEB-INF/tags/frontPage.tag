
<%@ tag pageEncoding="UTF-8"%>
<%@ attribute name="page" type="com.utils.Page"
	required="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String ctx = request.getContextPath();
%>
<%
	int current = page.getPageNo();
	int begin = 1;
	int end = page.getTotalPage();

	request.setAttribute("current", current);
	request.setAttribute("begin", begin);
	request.setAttribute("end", end);
	request.setAttribute("pList", page.getPageNoDisp());
%>
<script type="text/javascript">
  var paras = '<%=page.getParaJson()%>';
  var paraJson = eval('(' + paras + ')');

  //将提交参数转换为JSON
  var paraLists = '<%=page.getParaListJson()%>';
  var paraListJson = eval('(' + paraLists + ')');
  function pageClick( pNo ){
    paraJson["pageNo"] = pNo;
    paraJson["pageSize"] = "<%=page.getPageSize()%>";
    
    var jsPost = function(action, values, valueLists) {
      var id = Math.random();
      document.write('<form id="post' + id + '" name="post'+ id +'" action="' + action + '" method="post">');
      for (var key in values) {
        document.write('<input type="hidden" name="' + key + '" value="' + values[key] + '" />');
      }
      for (var key2 in valueLists) {
        for (var index in valueLists[key2]) {
          document.write('<input type="hidden" name="' + key2 + '" value="' + valueLists[key2][index] + '" />');
        }
      }
      document.write('</form>');    
      document.getElementById('post' + id).submit();
    }
    
    //发送POST
    jsPost("<%=page.getSearchUrl()%>", paraJson, paraListJson);
  }
  function skip(){
	 var pno=document.getElementById("skipInput").value;
	 var pc="${end}";
	 if (valid(pno)) {
			if (pno > 0 && pno < (parseInt(pc) + 1))
				pageClick( pno );
		}
  }
  
	function valid(e) {
		var reg = new RegExp("^[1-9]*[0-9]$");
		if (reg.test(e)) {
			return true;
		}
		return false;
	}
	function selectPage(e){
		 paraJson["pageNo"] = 1;
		 paraJson["pageSize"] = e;
		 var jsPost = function(action, values, valueLists) {
		 var id = Math.random();
		 document.write('<form id="post' + id + '" name="post'+ id +'" action="' + action + '" method="post">');
		 for (var key in values) {
		      document.write('<input type="hidden" name="' + key + '" value="' + values[key] + '" />');
		 }
		 for (var key2 in valueLists) {
		     for (var index in valueLists[key2]) {
		       document.write('<input type="hidden" name="' + key2 + '" value="' + valueLists[key2][index] + '" />');
		      }
		 }
		 document.write('<input type="hidden" name="pageSize" value="'+e+'" />');
		 document.write('</form>');    
		 document.getElementById('post' + id).submit();
		}
		    //发送POST
		jsPost("<%=page.getSearchUrl()%>", paraJson, paraListJson);
	}
</script>
<div class="page-pull-right" style="float: right; margin-right: 30px;">
	<button class="btn btn-default btn-sm">共${end }页</button>
	<input type="text" id="skipInput" placeholder="页码"
		style="width: 35px; height: 31px; text-align: center; border-radius: 5px; border: 1px solid #CCCCCC" />
	<button class="btn btn-default btn-sm" onclick="skip()">跳</button>
	<button class="btn btn-default btn-sm">第${current }页</button>
	<%
		if (current != 1 && end != 0) {
	%>
	<button class="btn btn-default btn-sm" onclick="pageClick(1)">首页</button>
	<button class="btn btn-default btn-sm"
		onclick="pageClick(${current-1})">前页</button>
	<%
		} else {
	%>
	<button class="btn btn-default btn-sm">首页</button>
	<button class="btn btn-default btn-sm">前页</button>
	<%
		}
	%>
	<c:forTokens items="${pList}" delims="|" var="pNo">
		<c:choose>
			<c:when test="${pNo == 0}">
				<label style="font-size: 10px; width: 20px; text-align: center;">•••</label>
			</c:when>
			<c:when test="${pNo != current}">
				<button class="btn btn-default btn-sm" onclick="pageClick(${pNo})">${pNo}</button>
			</c:when>
			<c:otherwise>
				<button class="btn bg_53 btn-sm" style="font-weight: bold;color:white">${pNo}</button>
			</c:otherwise>
		</c:choose>
	</c:forTokens>
	<%
		if (current < end && end != 0) {
	%>
	<button class="btn btn-default btn-sm"
		onclick="pageClick(${current+1})">后页</button>
	<button class="btn btn-default btn-sm" onclick="pageClick(${end})">末页</button>
	<%
		} else {
	%>
	<button class="btn btn-default btn-sm">后页</button>
	<button class="btn btn-default btn-sm">末页</button>
	<%
		}
	%>
	<select onchange="selectPage(this.value)" id="pageSelect"
		style="width: 45px; height: 31px; border-radius: 5px; border: 1px solid #CCCCCC">
		<c:choose>
			<c:when test="${page.pageSize==5 }">
				<option value="5" selected="selected">5</option>
				<option value="10">10</option>
				<option value="20">20</option>
			</c:when>
			<c:when test="${page.pageSize==10 }">
				<option value="5" >5</option>
				<option value="10" selected="selected">10</option>
				<option value="20">20</option>
			</c:when>
			<c:when test="${page.pageSize==20 }">
				<option value="5" >5</option>
				<option value="10">10</option>
				<option value="20" selected="selected">20</option>
			</c:when>
		</c:choose>
	</select>
</div>
