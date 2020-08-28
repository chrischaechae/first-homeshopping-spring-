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
#title{
	text-align: center;
	padding-bottom: 20px;
}
#mainimg{
	width: 300px;
	height: 200px;
	position: absolute;
	left: 250px;
}
#detail{
	position: relative;
	top: 500px;
}
#name{
	position: absolute;
	left: 650px;
	font-size: 20px;
	font-weight: bold;
	
}
#price{
	position: absolute;
	left: 650px;
	padding-top: 30px;
	font-size: 20px;
	font-weight: bold;
}
#quantity{
	position: absolute;
	left: 650px;
	padding-top: 60px;
	font-size: 20px;
	font-weight: bold;
}
#choice{
	position: absolute;
	left: 650px;
	margin-top: 100px;
	font-size: 20px;
	font-weight: bold;
}
#num{
	width: 40px;
}
#dropbtn{
	width: 350px;
	color: gray;
	font: bold;
	
}
#choicebar{
	overflow: auto;
	font-size: 15px;
	width: 350px;
	height: 100px;
}
.detailmenu{
	margin-top: 7px;
}
.basketbtn{
	position: absolute;
	left: 680px;
	top: 550px;
	width: 100px;
}
.purchasebtn{
	position: absolute;
	left: 800px;
	top: 550px;
	width: 100px;
}
#dimg{
	width: 400px;
	height: 200px;
	position: absolute;
	left: 150px;
	top: 500px;
}
</style>
</head>
<body>
<div id="container">
<jsp:include page="/board/menu.jsp"/>
<h1 id="title">상세보기</h1>
	<input type="hidden" value="${bean.pro_no }">
	<img id="mainimg" src="http://localhost:8098/admin/upload/${bean.pro_img }">
	<div id="detail">${bean.pro_detail }</div>
	<img id="dimg" src="http://localhost:8098/admin/upload/${bean1.img_name }">
	<div id="name" >상품명 : ${bean.pro_name }</div>
	<div id="price">가격 : <fmt:formatNumber value="${bean.pro_price }" pattern="#,###"/>원</div>
	<div id="quantity">
		<label>수량 : </label>
		<input type="number" id="num" value="1" style="text-align: center;", min="1" max="9" onkeydown="keyevent(this)">
	</div>
	
	
<select id="choice">
    <option value="">옵션선택</option>
    <c:forEach var="bean1" items="${list1}">
    <option value="${bean1.choice_no }">${bean1.choice_size } / 색 : ${bean1.choice_color } / 재고 : ${bean1.choice_stock }개</option>
    </c:forEach>
</select>
	<c:if test="${login!=null }">
	<button id="basketbtn" class="basketbtn">장바구니</button>
	</c:if>
	<c:if test="${login==null }">
	<button id="basketbtn1"  class="basketbtn">장바구니</button>
	</c:if>
	<form action="buy.do "id="buyform">
		<input type="hidden" name="client_id" value="${sessionScope.login.client_id}">
		<input type="hidden" name="pro_no" value="${bean.pro_no }">
		<input type="hidden" id="choice_no" name="choice_no">
		<input type="hidden" id="num_no" name="ordering_num" value="1">
	<c:if test="${login!=null }">	
	<button type="submit" id="purchasebtn" class="purchasebtn">구매하기</button>
	</c:if>
	</form>
	<c:if test="${login==null }">
	<button id="purchasebtn1" class="purchasebtn">구매하기</button>
	</c:if>
</div>


<script type="text/javascript">
	
	
	function keyevent(){  
		event.preventDefault();		
	}
$(document).ready(function(){
	
	
	 $('#choice').change(function(){
		 var choice=$("#choice option:selected").val();
	 	$('#choice_no').val(choice);
	 	
	 });
	 
	 $('#basketbtn').click(function(){
		 var basket_cnt=$("#num").val();

		 if($.isNumeric(basket_cnt)==false){
			 alert('수량란에 숫자만 입력해주세요');
				return false;			 
		 } 
		 
		 if($('#choice').val()==""){
			 alert('옵션을 선택해주세요');
			 return false;
		 }
		 
		 var client_id="${sessionScope.login.client_id}";
		 var pro_no="${bean.pro_no}";
		 var choice_no=$("#choice option:selected").val();
		
		  
		 $.ajax({
				url:'checkbasket.do',
				type:'POST',
				async: false,
				data:{choice_no:choice_no,basket_cnt:basket_cnt,client_id:client_id},
				dataType:"json",
				success:function(data){
					if(data.chkk==0){
						 $.ajax({
								url:'addbasket.do',
								type:'POST',
								data:{client_id:client_id,pro_no:pro_no,choice_no:choice_no,basket_cnt:basket_cnt},
								success:function(){
									alert('장바구니에 등록되었습니다.');
								},
								error:function(){
									alert('장바구니 등록 실패');
								}
							});
					}else{
						alert('장바구니에 등록되었습니다.');
					}
				},
				error:function(){
					alert('실패');
				}
			});		
		 
	});
	 $('#num').change(function(){
		
		 var num=$("#num").val();
		 $('#num_no').val(num);
		 
	});
	  $('#purchasebtn').click(function(){
		  var choice=$("#choice option:selected").val();
		  if(choice==""){
			  alert('옵션을 선택해주세요');
			  return false;
		  } 
	 });
	  $('#purchasebtn1').click(function(){
		  alert('로그인해주세요');
	  });
	  $('#basketbtn1').click(function(){
		  alert('로그인해주세요');
	  });
});
</script>

	</body>
</html>