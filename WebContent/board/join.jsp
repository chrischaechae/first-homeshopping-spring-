<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>쇼핑몰</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js" type="text/javascript"></script>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
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
#joinbtn{
	width: 350px;
	height: 40px;
	margin-top: 20px;
}
#sample6_postcode{
	width: 100px;
}
#postbtn{
	width: 100px;
}
#sample6_detailAddress,#sample6_extraAddress{
	width: 150px;
}
</style>
</head>
<body>
<div id="container">
<jsp:include page="/board/menu.jsp"/>
<h1>회원가입</h1>
<form action="joinconfirm.do" method="post">
	<div>
		<input type="text" id="client_id" name="client_id" placeholder="아이디">
	</div>
	
	<div>
		<input type="password" id="client_pw" name="client_pw" placeholder="비밀번호">
	</div>
	
	<div>
		<input type="password" id="check_pw" name="check_pw" placeholder="비밀번호확인">
	</div>
	
	<div>
		<input type="text" id="client_name" name="client_name" placeholder="이름">
	</div>
	
	<div>
		<input type="text" id="client_phone" name="client_phone" placeholder="휴대폰번호">
	</div>
	
	
	<input type="text" id="sample6_postcode" placeholder="우편번호">
	<input type="button" id="postbtn" onclick="sample6_execDaumPostcode()" value="우편번호 찾기"><br>
	<input type="text" id="client_address" name="client_address" placeholder="주소"><br>
	<input type="text" id="sample6_detailAddress" placeholder="상세주소">
	<input type="text" id="sample6_extraAddress" placeholder="참고항목">
	
	
	<div>
		 <button type="submit" id="joinbtn">회원가입</button>
	</div>	 
</form>	
</div>


<script type="text/javascript">
$(document).ready(function(){
	
	$("#client_id").blur(function(){ 
		var client_id=$('#client_id').val();
		 $.ajax({
				url:'duplid.do',
				type:'POST',
				async: false,
				data:{client_id:client_id},
				dataType:"json",
				success:function(data){
					if(data.duplnum!=0){
						alert('아이디 중복입니다.');
						$('#client_id').val("");
					}	
				},
				error:function(){				
				}
			}); 
	});
	$("#client_phone").blur(function(){
		var client_name=$('#client_name').val();
		var client_phone=$('#client_phone').val();
		  $.ajax({
				url:'duplname.do',
				type:'POST',
				async: false,
				data:{client_name:client_name,client_phone:client_phone},
				dataType:"json",
				success:function(data){
					if(data.duplname!=0){
						alert('연락처/이름이 존재합니다.');
						$('#client_name').val("");
						$('#client_phone').val("");
					}	
				},
				error:function(){				
				}
			});
		
	});
	$('#joinbtn').click(function(){
		var pwchk=$('#check_pw').val();
		var client_id=$('#client_id').val();
		var client_pw=$('#client_pw').val();
		var client_name=$('#client_name').val();
		var client_phone=$('#client_phone').val();
		var client_address=$('#client_address').val();
		var space = /\s/;
		var regExp = /^((01[1|6|7|8|9])[1-9]+[0-9]{6,7})|(010[1-9][0-9]{7})$/;
		if(client_id=='' || client_id==null || space.exec(client_id)){ 
			alert('아이디를 작성해주세요');
			return false;
		}else if(client_pw=='' || client_pw==null || space.exec(client_pw)){
			alert('비밀번호를 작성해주세요');
			return false;
		}else if(client_name=='' || client_name==null || space.exec(client_name)){
			alert('이름을 작성해주세요');
			return false;
		}else if(client_phone=='' || client_phone==null || space.exec(client_phone)){
			alert('연락처를 작성해주세요');
			return false;
		}else if(client_address=='' || client_address==null){
			alert('주소를 작성해주세요');
			return false;
		}
		if($.isNumeric(client_name)==true){
			alert('이름한글로 입력해주세요');
			return false;
		}
		if(client_id.length>20 || client_pw.length>20 || client_name>15 || client_phone.length>20) {
			alert('글자수가 너무 많습니다.');
			return false;
		}
		if(client_pw!=pwchk){
			alert('비밀번호가 틀립니다.');
			return false;
		}
		if (!regExp.test(client_phone)){
		      alert("잘못된 휴대폰 번호입니다.");
		      return false;
		}
	});

});

function sample6_execDaumPostcode() {
    new daum.Postcode({
        oncomplete: function(data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

            // 각 주소의 노출 규칙에 따라 주소를 조합한다.
            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
            var addr = ''; // 주소 변수
            var extraAddr = ''; // 참고항목 변수

            //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                addr = data.roadAddress;
            } else { // 사용자가 지번 주소를 선택했을 경우(J)
                addr = data.jibunAddress;
            }

            // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
            if(data.userSelectedType === 'R'){
                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraAddr !== ''){
                    extraAddr = ' (' + extraAddr + ')';
                }
                // 조합된 참고항목을 해당 필드에 넣는다.
                document.getElementById("sample6_extraAddress").value = extraAddr;
            
            } else {
                document.getElementById("sample6_extraAddress").value = '';
            }

            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            document.getElementById('sample6_postcode').value = data.zonecode;
            document.getElementById("client_address").value = addr;
            // 커서를 상세주소 필드로 이동한다.
            document.getElementById("sample6_detailAddress").focus();
        }
    }).open();
}
</script>

	</body>
</html>