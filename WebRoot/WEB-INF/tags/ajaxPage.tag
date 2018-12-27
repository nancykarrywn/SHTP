<%@ tag pageEncoding="UTF-8"%>
<%@ attribute name="ajaxPage" type="com.utils.Page"
	required="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<% String path = request.getContextPath(); %>
<%
	int current = ajaxPage.getPageNo();
	int begin = 1;
	int end = ajaxPage.getTotalPage();
	request.setAttribute("current", current);
	request.setAttribute("begin", begin);
	request.setAttribute("end", end);
	request.setAttribute("pList", ajaxPage.getPageNoDisp());
%>

<script type="text/javascript" src="<%=path%>/assets/common/jQuery/jquery-1.9.1.min.js"></script>
<script src="<%=path%>/assets/common/jQuery/cookie.js"></script>
<script type="text/javascript">

  var paras = '<%=ajaxPage.getParaJson()%>';
  var paraJson = eval('(' + paras + ')');

  //将提交参数转换为JSON
  var paraLists = '<%=ajaxPage.getParaListJson()%>';
  var paraListJson = eval('(' + paraLists + ')');
 
  function pageClick( pNo ){
	$.cookie("pNo",pNo);
    paraJson["pageNo"] = pNo;
    current = pNo;
    var psize = "<%=ajaxPage.getPageSize()%>";
    paraJson["pageSize"] = psize;  	
    var jsPost = function(action, values, valueLists) {     
      var data = {};
      for (var key in values) {
    	  data[key]=values[key];    
      }
      for (var key2 in valueLists) {
        for (var index in valueLists[key2]) {
        	data[key2]=valueLists[key2][index];         
        }
      }
    
      $.ajax({
   	   type :'post',
   	   url : action,
   	   data : data,
   	   success:function(obj){   		
   		   $("#tableList").empty();
   		   $("#pagination").empty();
   		   $("#tableList").html(obj);
   		$("#pageSize").val(psize);
   	   },
   	   error:function(data){
   		   alert("error")
   	   }
      });
    }
   
   var url = 'list.action';
    //发送POST   
    jsPost(url, paraJson, paraListJson);
  }
  
</script>

<script type="text/javascript">

$(function(){
	if(null!=$.cookie("pNo"))
	 	$("#page").val($.cookie("pNo"));
	else
		$("#page").val(1);
	  $("#pageSize").change(function(){
		  var c = $.cookie("pNo");
		  if(null==c)
			  c=1;
		  paraJson["pageNo"] = c;		 
		    paraJson["pageSize"] = $(this).val();
		    $.cookie("pageSize",$(this).val());
		    var paSize = $(this).val();		    
		    var jsPost = function(action, values, valueLists) {     
		      var data = {};
		      for (var key in values) {
		    	  data[key]=values[key];    
		      }
		      for (var key2 in valueLists) {
		        for (var index in valueLists[key2]) {
		        	data[key2]=valueLists[key2][index];         
		        }
		      }
		    
		      $.ajax({
		   	   type :'post',
		   	   url : action,
		   	   data : data,
		   	   success:function(obj){		   		
		   		$("#tableList").empty();
		   		   $("#pagination").empty();
		   		   $("#tableList").html(obj);
		   		   $("#pageSize").val(paSize);
		   	   },
		   	   error:function(data){
		   		   alert("error")
		   	   }
		      });
		  }
		    var url = 'list.action';
		    //发送POST   
		    jsPost(url, paraJson, paraListJson);
	  });
});

function tiaozhuan(){
	var pageNo = $("#page").val();
	$.cookie("pNo",pageNo);
	if(pageNo==null||pageNo.trim()==""){
		alert("请输入页码！");
		return;
	}
	paraJson["pageNo"] = pageNo;
    current = pageNo;
    var psize = "<%=ajaxPage.getPageSize()%>";
    paraJson["pageSize"] = psize;
    var jsPost = function(action, values, valueLists) {     
      var data = {};
      for (var key in values) {
    	  data[key]=values[key];    
      }
      for (var key2 in valueLists) {
        for (var index in valueLists[key2]) {
        	data[key2]=valueLists[key2][index];         
        }
      }    
      $.ajax({
   	   type :'post',
   	   url : action,
   	   data : data,
   	   success:function(obj){   		 
   		   $("#tableList").empty();
   		   $("#pagination").empty();
   		   $("#tableList").html(obj);
   		$("#pageSize").val(psize);
   	   },
   	   error:function(data){
   		   alert("error")
   	   }
      });
    }
   
   var url = 'list.action';
    //发送POST   
    jsPost(url, paraJson, paraListJson);
}

</script>

<div class="ajaxPage">
	<span>共${ajaxPage.totalRecord }条记录/${ajaxPage.totalPage }页</span>
	<span>每页</span>
	<select id="pageSize" class="input-sm"
		style="width: auto; display: inline">
		<option value="5">5</option>
		<option value="10">10</option>
		<option value="15">15</option>
		<option value="20">20</option>
	</select>
	<span>条</span>
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
				<button class="btn btn-primary btn-sm" style="font-weight: bold;">${pNo}</button>
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
	<button class="btn btn-primary btn-sm" onclick="tiaozhuan()">转到</button>
	<select  id="page" class="input-sm">
		<c:forEach var="i" begin="1" end="${ajaxPage.totalPage }">
			<option>${i }</option>
		</c:forEach>
	</select>
	
</div>