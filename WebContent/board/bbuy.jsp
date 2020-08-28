<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

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
	top: 600px;
}
#paybtn{
	position: absolute;
	left: 750px;
	top: 750px;
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
				
		<table id="table1">
			 <c:set var = "total" value = "0" />
			<c:forEach var="bean" items="${list}" varStatus="status">
			<tr>
				<td><img id="img1" src="http://localhost:8098/admin/upload/${bean.productVO.pro_img }"></td>
				  <td><div>사이즈 :${bean.choiceVO.choice_size } mm ,색 :${bean.choiceVO.choice_color } </div><div><span>가격 : ${bean.productVO.pro_price }원 </span><span> /  갯수 :${bean.basket_cnt }개  </span></div></td>
				  <td id="tot${status.index }">${bean.productVO.pro_price}</td> 
			</tr>
			 <c:set var= "total" value="${total+bean.productVO.pro_price*bean.basket_cnt}"/> 
			<div id="basket_no${status.index }">/${bean.basket_no }</div>
			<input type="hidden" value="${bean.choiceVO.choice_no }" id="hidden${status.index }">
			<input type="hidden" value="${bean.basket_cnt }" id="cnt${status.index }">
			<input type="hidden" value="${bean.basket_no }" id="hidden1${status.index }">
			</c:forEach>
			 
			<%-- <c:out value="${total}"/> --%>
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
		<h2>결제최종정보 </h2>
		<table id="table2">
			<tr>
				<td><div id="cost">상품가격 : <c:out value="${total}"/> 원</div><div id="delfee"></div></td>
			</tr>
			<tr>
				<td><div id="allfee"></div></td>
			</tr>
		</table>
			
	</div>
	<div>
		<button id="paybtn">결제하기</button>
	</div>
</div>


<script type="text/javascript">
$(document).ready(function(){
	
	var chono = new Array();
	var basno= new Array();
	var d="${fn:length(list) }";
	for(var i=0; i<d;i++){
	chono.push($('#hidden'+i).val());
	basno.push($('#hidden1'+i).val());
	}
	console.log("sdf"+chono[0]);
	console.log("sdf"+chono[1]);
	 $.ajax({
		url:'ccheckstock.do',
		type:'POST',
		async: false,
		traditional : true,
		data:{chono:chono,basno:basno},
		dataType:"json",
		success:function(data){
			console.log("123"+data.stock);
			 if(data.stock==1){
					alert('주문상품의 재고보다 구매 수량이 더 많습니다.');
					window.history.back();
				}else{
					return true;
				}
		},
		error:function(){
		}
		
	});//ajax 끝 

	
	$("#request1").hide();
	$("[id^='tot']").hide();
	
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
	var total= "${total}";
	var tax=3000;
	var ttotal=Number(total)+Number(tax);
	  if(Number(total)>100000){
		$('#delfee').text("배송비 : 0원");
		$('#allfee').text("결제예정액 : "+total+ "원");
	}else{
		$('#delfee').text("배송비 : 3000원");
		$('#allfee').text("결제예정액 :"+ttotal+"원");
	}  
	$("[id^='way']").click(function(){
		$("[id^='way']").css("background-color","white");
		$(this).css("background-color","silver");
		var way=$(this).text();
		$('#wayinput').val(way);
		
	});
	$("[id^='basket_no']").hide();
	$('#paybtn').click(function(){
		var rtn=false;
		var a= $("[id^='basket_no']").text();
		var basket_no=new Array();
		basket_no=a.split("/");
		
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
		
		//ajax 끝
		 $ .ajax({
				url:'bpay.do',
				type:'POST',
				async: false,
				traditional : true,
				data:{basket_no:basket_no,ordering_request:ordering_request,ordering_payment:ordering_payment},
				success:function(){
					alert('결제되었습니다.');
					$.ajax({
						url:'ddelbasket.do',
						type:'POST',
						traditional : true,
						data:{basket_no:basket_no},
						success:function(){
						},
						error:function(){
							
						}
				}); 
					
					location.href="list.do";
					
				},
				error:function(){
					alert('실패');
				}
			}); 
	});
	
	
	
});
</script>

	</body>
</html>