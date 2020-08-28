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

#personal{
	position: absolute;
	left: 300px;
	margin-top: 50px;
}
.person{
	margin-bottom: 10px;
}
#request{
	height: 30px;
	width: 300px; 
}
#request1{
	width: 300px;
	margin-top: 10px;
	width: 300px;
	height: 20px;
}
#pay{
	position: absolute;
	left: 250px;
	top: 600px;
}
table{
	width: 350px;
	border: 1px solid gray;
	border-collapse: collapse;
	margin-bottom: 30px;
}
th,tr,td{
 	border: 1px solid gray;
}
#product{
	position: absolute;
	left: 700px;
	margin-top: 50px;
}
#table1{
	width: 400px;
}
#img1{
	width: 50px;
	height: 50px;
}
#finalpay{
	position: absolute;
	left: 750px;
	top: 500px;
}
#paybtn{
	position: absolute;
	left: 750px;
	top: 650px;
	width: 350px;
	margin-bottom: 50px;
}
</style>
</head>
<body>
<div id="container">
<jsp:include page="/board/menu.jsp"/>
<h1>주문결제</h1>

	<div id="personal">
		<h2>배송지</h2>
		<div class="person">주문자 : ${sessionScope.login.client_name}</div>
		<div class="person">주소 : ${sessionScope.login.client_address}</div>
		<div class="person">연락처 : ${sessionScope.login.client_phone}</div>
		
		
		<select id="request">
			<option value="">배송시 요청사항(선택사항)</option>
		    <option value="배송전 연락바랍니다.">배송전 연락바랍니다.</option>
		    <option value="부재시 전화 또는 연락주세요">부재시 전화 또는 연락주세요</option>
		    <option value="부재시 경비실에 맞겨주세요">부재시 경비실에 맞겨주세요</option>
		    <option value="1">직접입력</option>
		</select>
		<div>
		<input id="request1" type="text" placeholder="요청사항입력">
		</div>
	</div>
	
	<div id="product">
		<h2>주문상품정보</h2>
				<input type="hidden" value="${bean1.pro_no }">
				<input type="hidden" value="${bean2.choice_no }">
		<table id="table1">
			<tr>
				<td><img id="img1" src="http://localhost:8098/admin/upload/${bean1.pro_img }"></td>
				<td><div>사이즈 : ${bean2.choice_size }mm ,색 : ${bean2.choice_color }</div><div>가격 : ${bean1.pro_price }원 / 갯수 : ${bean.ordering_num } 개</div> </td>
			</tr>
		</table>
		
	</div>
	<div id="pay">
	<table>
		<thead>
			<tr>
				<th><a id="card" href="#" >체크/신용카드</a></th>
				<th><a id="transfer" href="#" >은행계좌이체</a></th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td id="td1" colspan="2"><a class="way" id="way1" href="#">신한카드</a>   <a class="way" id="way2" href="#">비씨카드</a>  <a class="way" id="way3" href="#">현대카드</a>  <a class="way" id="way4" href="#">삼성카드</a></td>
			</tr>
			<tr>
				<td id="td2" colspan="2"><a class="way" name="계좌이체" id="way5" href="#">계좌이체 110-292-453013(신한은행)</a></td>
			</tr>
		</tbody>		
	</table>
	<input type="hidden" id="wayinput">
	</div>
	<div id="finalpay">
		<h2>결제최종정보</h2>
		<table id="table2">
			<tr>
				<td><div id="cost"></div><div id="delfee"></div></td>
			</tr>
			<tr>
				<td> <div id="totalcost"></div></td>
			</tr>
		</table>
			
	</div>
	<div>
		<button id="paybtn">결제하기</button>
	</div>
</div>


<script type="text/javascript">
$(document).ready(function(){

/* var abc="${sessionScope.login.client_id}";
	
	if(abc==null || abc==""){
		location.href="login.do";
	} */
	
	$("#request1").hide();
	
	$("#request").change(function() {

		if($("#request").val() == "1") {
			$("#request1").show();	
		}  else {		
			$("#request1").hide();	
		}
	});
	$("#td2").hide();
	$('#card').click(function(){
		$("#td1").show();
		$("#td2").hide();
	});
	$('#transfer').click(function(){
		$("#td2").show();
		$("#td1").hide();
	});
	var cost="${bean1.pro_price }";
	var cnt="${bean.ordering_num }";
	$('#cost').text("상품가격 : "+cost*cnt);
	if(cost*cnt>100000){
		$('#delfee').text("배송비 : 0원");
		$('#totalcost').text("결제예정액 : "+cost*cnt);
	}else{
		$('#delfee').text("배송비 : 3000원");
		$('#totalcost').text("결제예정액 : "+cost*cnt+3000);
	}
	$("[id^='way']").click(function(){
		$("[id^='way']").css("background-color","white");
		$(this).css("background-color","silver");
		var way=$(this).text();
		$('#wayinput').val(way);
	});
	
	$('#paybtn').click(function(){
		var rtn=true;
		var pro_no="${bean1.pro_no }";
		var choice_no="${bean2.choice_no }";
		var ordering_num="${bean.ordering_num }";
		var ordering_price="${bean1.pro_price }";
		var client_id="${sessionScope.login.client_id}";
		
		      /* $.ajax({
			url:'checkstock.do',
			type:'POST',
			async: false,
			data:{choice_no:choice_no},
			dataType:"json",
			success:function(data){
				
				if(Number(data.stock)<Number(ordering_num)){
					alert('재고보다 구매 수량이 더 많습니다.');
					return false;
				}
			},
			error:function(){
			}
		}); */
		    
		if($('#request').val()=='1'){
			var ordering_request=$('#request1').val();
		}else if($('#request').val()==""){
			alert('요청사항을 작성해주세요');
			return false;
		}else{
			var ordering_request=$('#request').val();
		}
		if($('#wayinput').val()=="" || null){
			alert('결제방법을 선택해주세요');
			return false;
		}else{
			var ordering_payment=$('#wayinput').val();
		}
		 $.ajax({
				url:'checkstock.do',
				type:'POST',
				async: false,
				data:{choice_no:choice_no},
				dataType:"json",
				success:function(data){
					if(Number(data.stock)<Number(ordering_num)){
						alert('재고보다 구매 수량이 더 많습니다.');
						return false;
					}else{
						$.ajax({
							url:'pay.do',
							type:'POST',
							data:{pro_no:pro_no,choice_no:choice_no,ordering_num:ordering_num,ordering_price:ordering_price,client_id:client_id,ordering_request:ordering_request,ordering_payment:ordering_payment},
							success:function(){
								alert('결제되었습니다.');
								location.href="list.do";
							},
							error:function(){
								alert('실패');
							}
						});  
						
					}
				},
				error:function(){
				}
			});
	});
});
</script>

	</body>
</html>