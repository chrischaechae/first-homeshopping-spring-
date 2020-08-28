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
#searchpwbtn{
	width: 350px;
	height: 40px;
	margin-top: 20px;
	margin-left: 70px;
}
#client_id{
	padding-right: 18px;
}

</style>
</head>
<body>
<div id="container">
<jsp:include page="/board/menu.jsp"/>
<h1>비밀번호찾기</h1>
	<div>
		<label for="client_name">이름</label>	
		<input type="text" id="client_name" name="client_name" placeholder="이름">
	</div>
	
	<div>
		<label for="client_id">아이디</label>	
		<input type="text" id="client_id" name="client_id" placeholder="아이디">
	</div>	
	
	<div>
		 <button id="searchpwbtn">확인</button>
	</div>
	
</div>


<script type="text/javascript">
$(document).ready(function(){
	$('#searchpwbtn').click(function(){
		var client_id=$('#client_id').val();
		var client_name=$('#client_name').val();
	
		 $.ajax({
			url:'findpw.do',
			type:'POST',
			async: false,
			data:{client_name:client_name,client_id:client_id},
			dataType:"json",
			success:function(data){
				  alert("비밀번호 : "+data.client_pw);
			},
			error:function(){
				alert("입력한 정보가 틀렸습니다.");
			}
		}); 
	});
	
});
</script>

	</body>
</html>