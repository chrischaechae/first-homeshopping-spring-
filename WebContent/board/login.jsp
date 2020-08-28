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
	text-align: center;
	margin: 0px auto;
}
input{
	width: 350px;
	height: 30px;
	margin-bottom: 10px;
}
#client_id{
	margin-left: 14px;
}
#loginbtn{
	width: 350px;
	height: 40px;
	margin-top: 20px;
	margin-left: 70px;
}
#bar{
	margin-top: 30px;
}
#menu1,#menu2,#menu3{
	margin-right: 15px;
</style>
</head>
<body>
<div id="container">
<jsp:include page="/board/menu.jsp"/>
<h1>로그인</h1>
<form action="loginconfirm.do" method="post">
	<div>
		<label for="client_id">아이디</label>
		<input type="text" id="client_id" name="client_id" placeholder="아이디">
	</div>
	
	<div>
		<label for="client_pw">비밀번호</label>	
		<input type="password" id="client_pw" name="client_pw" placeholder="비밀번호">
	</div>	
	
	<div>
		 <button type="submit" id="loginbtn">로그인</button>
	</div>
	
	<div id="bar"><a href=searchid.do><span id="menu1">아이디찾기 &nbsp;|</span></a><a href="searchpw.do"><span id="menu2">비밀번호찾기 &nbsp;|</span></a><a href="join.do"><span id="menu3">회원가입</span></a></div>
</form>	
</div>


<script type="text/javascript">
$(document).ready(function(){

	$('#loginbtn').click(function(){
		var rtn=true;	
		var client_id=$('#client_id').val();
		var client_pw=$('#client_pw').val();
		$.ajax({
			url:'checkinfo.do',
			type:'POST',
			async: false,
			data:{client_id:client_id,client_pw:client_pw},
			dataType:"json",
			success:function(data){
				 if(data.chk!=1){
				  alert("정보가 틀렸습니다");
				  rtn=false;
				}
			},
			error:function(){
			}
		});	
		return rtn;
	});
	$("client_id").blur(function(){ 
	
		alert('sdf');
	});
	
	
});
</script>

	</body>
</html>