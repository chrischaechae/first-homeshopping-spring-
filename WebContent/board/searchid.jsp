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
#searchidbtn{
	width: 350px;
	height: 40px;
	margin-top: 20px;
	margin-left: 70px;
}
#client_name{
	padding-right: 18px;
}

</style>
</head>
<body>
<div id="container">
<jsp:include page="/board/menu.jsp"/>
<h1>아이디찾기</h1>
	<div>
		<label for="client_name">이름</label>
		<input type="text" id="client_name" name="client_name" placeholder="이름">
	</div>
	
	<div>
		<label for="client_phone">휴대폰</label>	
		<input type="text" id="client_phone" name="client_phone" placeholder="연락처">
	</div>	
	
	<div>
		 <button id="searchidbtn">확인</button>
	</div>
	
</div>


<script type="text/javascript">
$(document).ready(function(){
	$('#searchidbtn').click(function(){
		var client_name=$('#client_name').val();
		var client_phone=$('#client_phone').val();
		
		$.ajax({
			url:'findid.do',
			type:'POST',
			async: false,
			data:{client_name:client_name,client_phone:client_phone},
			dataType:"json",
			success:function(data){
				if(data.client_id!=null){
				  alert("아이디 : "+data.client_id);
				}
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