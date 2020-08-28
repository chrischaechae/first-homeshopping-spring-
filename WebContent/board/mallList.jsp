<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>쇼핑몰</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js" type="text/javascript"></script>
<style type="text/css">
#container{
	width: 950px;
	margin: 0px auto;
}
#thumbnail{
	border: 1px solid gray;
	float: left;
	width: 300px;
	height: 250px;
	display: inline-block;
	text-align: center;
	margin-right: 10px;
	margin-bottom: 10px;
}
#mainimg{
	width: 200px;
	height: 150px;
}
#paging{
	position: absolute;
	top: 750px;
	left: 600px;
	
}
#search{
	padding-bottom: 10px;
}
#searchbtn{
	height: 30px;
}

</style>
</head>
<body>


<div id="container">
	<jsp:include page="/board/menu.jsp"/>
	<form action="list.do?client_id=${sessionScope.login.client_id}" method="GET" onsubmit="return searchCheck()">
	<div id="search">
		<select name="keyField">
					<option value="pro_name">제목</option>
		</select> 
			<input type="text" size="16" name="keyWord">
			<input type="submit" id="searchbtn" value="검색">
	</div>
	</form>
	
	<c:forEach var="mall" items="${list}">
			
			<a href="pro_detail.do?pro_no=${mall.pro_no }">
			    <div id="thumbnail">
			      <img id="mainimg" src="http://localhost:8098/admin/upload/${mall.pro_img }">
			      <div class="caption">
			        <h3>${mall.pro_name }</h3>
			        <p><fmt:formatNumber value="${mall.pro_price }"  pattern="#,###"/>원</p>
			      </div>
			    </div>
			 </a>	  
	</c:forEach>
		<table align="center" id="paging">
		<c:if test="${count>0}">
			<tr>
				<td align="center">${pagingHtml}</td>
			</tr>
		</c:if>
	</table>
</div>

<script type="text/javascript">
$(document).ready(function(){
	
	
	
});


</script>
</body>
</html>