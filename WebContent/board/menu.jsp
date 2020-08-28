<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>쇼핑몰</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js" type="text/javascript"></script>
<style type="text/css">
#logo{
	text-align: left;
	color: purple;
}
#menubar{
	text-align: right;
	margin-bottom: 30px;
	display: inline-block;
	width: 900px;
}
a{
	color: black;
	text-decoration: none;
}
#menu1,#menu2,#menu3,#menu4{
	font: bold;
	margin-right: 15px;
	
}
#welcome{
	float: right;
	margin-right: 50px;
	margin-bottom: 20px;
}
#editinfo,#orderlist{
	margin-top: 5px;
}
</style>
</head>
<body>
	<a href="list.do"><h1 id="logo">우식 쇼핑몰</h1></a>
	<c:if test="${login!=null }">
		<div id="welcome">${sessionScope.login.client_id}님 환영합니다.</div>
	</c:if>
	<c:if test="${login==null }">
		<div id="menubar"><a href="login.do"><span id="menu1">로그인</span></a><a href="join.do"><span id="menu2">회원가입</span></a><a href="login.do"><span id="menu3">장바구니</span></a><a href="login.do"><span id="menu4">마이페이지</span></a></div>
	</c:if>
	<c:if test="${login!=null }">	
		<div id="menubar"><a href="logout.do"><span id="menu1">로그아웃</span></a><a href='join.do'><span id="menu2">회원가입</span></a><a href="#"><span id="menu3">장바구니</span></a><a href="#"><span id="menu4">마이페이지</span></a><a href="#"><div id="editinfo">회원정보수정</div></a><a href="orderlist.do?client_id=${sessionScope.login.client_id}"><div id="orderlist">주문내역</div></a></div>
	</c:if>	
	
	<form action="editinfo.do" method="POST" id="infoinput">
	<input type="hidden" name="client_no" value="${sessionScope.login.client_no}">
	</form>
	
	<form action="basketlist.do" method="POST" id="basketinput">
	<input type="hidden" name="client_id" value="${sessionScope.login.client_id}">
	</form>
	
<%-- 	<form action="orderlist.do" method="POST" id="orderinput">
	<input type="hidden" name="client_id" value="${sessionScope.login.client_id}">
	<input type="hidden" name=currentPage value="1">

	</form> --%>
	
	
	
<script type="text/javascript">
	$(document).ready(function(){
		$('#editinfo').hide();
		$('#orderlist').hide();
		
		$('#menu4').on('click',function() {
			$('#editinfo').toggle();
			$('#orderlist').toggle();
		});	
		$('#editinfo').click(function(){
			$('#infoinput').submit();
		});
		$('#menu3').click(function(){
			$('#basketinput').submit();
		});
		
		$('#orderlist').click(function(){
			$('#orderinput').submit();
		});
});
	
</script>
</body>
</html>