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
table{
	width: 850px;
	border: 1px solid gray;
	border-collapse: collapse;
}
 th,tr,td{
 	border: 1px solid gray;
 }
#img1{
	width: 40px;
	height: 40px;
}
#num{
	width: 40px;
}
#basketdel{
	position: absolute;
	width: 150px;
	height: 30px;
	margin-top: 30px;
	left: 250px;
}
#orderbtn{
	position: absolute;
	width: 150px;
	height: 30px;
	margin-top: 30px;
	left: 450px;
}
#finalcnt{
	width: 300px;
	position: absolute;
	margin-top: 30px;
	left: 750px;
}
</style>
</head>
<body>
<div id="container">
<jsp:include page="/board/menu.jsp"/>
<h1>장바구니</h1>

	<table>
		<thead>
		<tr>
			<th><input type="checkbox" id="allcheck"></th>
			<th>상품</th>
			<th>수량</th>
			<th>가격</th>
			<th>배송정보</th>
		</tr>
	</thead>
	<tbody>
	<c:forEach var="bean" items="${list}" varStatus="status">
	<c:forEach var="bean1" items="${list1}">
	<tr>
			<td> <input type="checkbox" name="chk" class="chk" value="${bean.basket_no }">
			<td> <img id="img1" src="http://localhost:8098/admin/upload/${bean.productVO.pro_img }"> ${bean.productVO.pro_name } / 사이즈: ${bean.choiceVO.choice_size } / 색: ${bean.choiceVO.choice_color }</td>
			<td><input type="number" name="amount" id="num${status.index }" min="1" max="9" value="${bean.basket_cnt }" onkeydown="keyevent(this)"></td>
			<td id="price${status.index }">${bean.productVO.pro_price } 원</td>
			<td id="shipfee${status.index }">0 원</td>
		</tr>
	</c:forEach>
	</c:forEach>
	
	</table>
<div>
<button type="button" id="basketdel">삭제</button>
</div>	

<div>
<a href="#" id="aorder"><button type="button" id="orderbtn">주문결제</button></a>
</div>

	<table id="finalcnt">
		<tr>
			<th>결제 예정금액</th>
		</tr>
		<tr>
			<td id="total">상품가격(총 0개) :       0원</td>
		</tr>
		<tr>
			<td id="delcost">배송비 :           0원</td>
		</tr>
		<tr>
			<td id="allfee">총금액 : 0원 </td>
		</tr>
	
	</table>

</div>

<script type="text/javascript">
function keyevent(){  
	event.preventDefault();		
}
$(document).ready(function(){
	
	$('#basketdel').click(function(){

		var delchk = new Array(); // key 값을 담을 배열
		var cnt=$("input[name='chk']:checked").length;
		$('.chk:checked').each(function(){
	        delchk.push($(this).val());
	       });
		
		  $.ajax({
				url:'delbasket.do',
				type:'POST',
				traditional : true,
				data:{basket_no:delchk,cnt:cnt},
				success:function(){
					location.reload();
				},
				error:function(){
					
				}
		}); 
	});
	$('#orderbtn').click(function(){
		
		if($("input[name='chk']").is(":checked") == false){
			alert("체크박스를 선택해주세요");
			return false;
		}
		
		
		var su=0;
		var numchk =[];
		var checkbox = $("input[name=chk]:checked");
		var paychk = []; // key 값을 담을 배열
		var cnt=$("input[name='chk']:checked").length;
		$('.chk:checked').each(function(){
			paychk.push($(this).val());
	       });
		
			checkbox.each(function(i) {
				var tr = checkbox.parent().parent().eq(i);
				var td = tr.children().children();
				var tdd= tr.children();
				
				su = td.eq(2).val();
				numchk.push(su);
			});
				console.log(numchk);
		
		 $('#aorder').attr("href", "bbuy.do?basket_no="+paychk+"&numchk="+numchk);
	});
	var rowData = new Array();
	var tdArr = new Array();
	var checkbox = $("input[name=chk]:checked");
	
	$("input:checkbox").on('click', function() {
		
		var rowData = new Array();
		var tdArr = new Array();
		var checkbox = $("input[name=chk]:checked");
		var sum=0;
		var fcost=0;
		var ffcost=0;
		var ddelfee=0;
		var totalfee=0;
		checkbox.each(function(i) {
			
			var tr = checkbox.parent().parent().eq(i);
			var td = tr.children().children();
			var tdd= tr.children();
			//rowData.push(tr.text());
			
			var su = td.eq(2).val();
			var cost=tdd.eq(3).text();
			var delfeee=tdd.eq(4).text();
			var allfeee=$('#allfee').text();
			var sallfeee=allfeee.split(":");
			
			var rcost=cost.slice(0,-1);//원 뺀 숫자만
			 if(su*rcost>100000){
				delfee=0;
				var delfeee=tdd.eq(4).text('0원');
			}else{
				delfee=3000;
				var delfeee=tdd.eq(4).text('3000원');
			} 
			
			fcost=su*rcost;
			sum+=Number(su);
			ffcost+=Number(fcost);
			ddelfee+=Number(delfee);
			//totalfee=ffcost+ddelfee;
		});
			var docu1='상품가격(총';
			var docu2=sum;
			var docu3='개) :';
			var docu4=ffcost;
			
			var docu5=' 원';
			var result = docu1+docu2+docu3+docu4+docu5;
			var b= $('.chk:checked').length;
			if(b>0){
				$('#total').text(result);
				if(ffcost<100000){
					$('#delcost').text(ddelfee+" 원");
				}else{
					$('#delcost').text("0 원");
				}
				var ddelcost=$('#delcost').text();
				var dddelcost=ddelcost.slice(0,-1);
				totalfee=Number(ffcost)+Number(dddelcost);
				$('#allfee').text("총금액 :"+totalfee+" 원");
			}
			if(totalfee>100000){
				delfee=0;
				$("[id^='shipfee']").text("0 원");
			};
		if(!$("input[name=chk]:checked").is(":checked")){
			$('#total').text("상품가격(총 0개) :       0원");
			$('#delcost').text("배송비 :           0원");
			$('#allfee').text("총금액 : 0 원");
		}
	});
	$("[id^='num']").change(function(){
		var rowData = new Array();
		var tdArr = new Array();
		var checkbox = $("input[name=chk]:checked");
		var sum=0;
		var fcost=0;
		var ffcost=0;
		var delfee=0;
		var ddelfee=0;
		var totalfee=0;
		checkbox.each(function(i) {
			
			var tr = checkbox.parent().parent().eq(i);
			var td = tr.children().children();
			var tdd= tr.children();
			//rowData.push(tr.text());
			
			var su = td.eq(2).val();
			var cost=tdd.eq(3).text();
			var delfee=tdd.eq(4).text();
			var rcost=cost.slice(0,-1);//원 뺀 숫자만
			if(su*rcost>100000){
				delfee=0;
				var delfeee=tdd.eq(4).text('배송비 : 0원');
			}else{
				delfee=3000;
				var delfeee=tdd.eq(4).text('배송비 : 3000원');
			}
			if(su*rcost>100000){
				tdd.eq(4).text("0 원");
				
			}else{
				tdd.eq(4).text("3000 원");
				
			}
			fcost=su*rcost;
			sum+=Number(su);
			ffcost+=Number(fcost);
			ddelfee+=Number(delfee);
			totalfee=ffcost+ddelfee;
		});
			var docu1='상품가격(총';
			var docu2=sum;
			var docu3='개) :';
			var docu4=ffcost;
			var docu5=' 원';
			var result = docu1+docu2+docu3+docu4+docu5;
			var b= $('.chk:checked').length;
			if(b>0){
				$('#total').text(result);
				if(ffcost<100000){
					$('#delcost').text(ddelfee+" 원");
				}else{
					$('#delcost').text("0 원");
				}
				var ddelcost=$('#delcost').text();
				var dddelcost=ddelcost.slice(0,-1);
				totalfee=Number(ffcost)+Number(dddelcost);
				$('#allfee').text("총금액 :"+ totalfee+" 원");
			}	
			if(totalfee>100000){
				delfee=0;
				$("[id^='shipfee']").text("배송비 : 0 원");
			};
		});
	$('#allcheck').click(function(){
		if($("#allcheck").prop("checked")){
			$("input[name=chk]").prop("checked",true);
		}else{
			$("input[name=chk]").prop("checked",false);	
		}
		var rowData = new Array();
		var tdArr = new Array();
		var checkbox = $("input[name=chk]:checked");
		var sum=0;
		var fcost=0;
		var ffcost=0;
		var delfee=0;
		var ddelfee=0;
		var totalfee=0;
		checkbox.each(function(i) {
			
			var tr = checkbox.parent().parent().eq(i);
			var td = tr.children().children();
			var tdd= tr.children();
			//rowData.push(tr.text());
			
			var su = td.eq(2).val();
			var cost=tdd.eq(3).text();
			var delfee=tdd.eq(4).text();
			var rcost=cost.slice(0,-1);//원 뺀 숫자만
			if(su*rcost>100000){
				delfee=0;
				var delfeee=tdd.eq(4).text('배송비 : 0원');
			}else{
				delfee=3000;
				var delfeee=tdd.eq(4).text('배송비 : 3000원');
			}
			if(su*rcost>100000){
				tdd.eq(4).text("0 원");
				
			}else{
				tdd.eq(4).text("3000 원");
				
			}
			fcost=su*rcost;
			sum+=Number(su);
			ffcost+=Number(fcost);
			ddelfee+=Number(delfee);
			totalfee=ffcost+ddelfee;
		});
			var docu1='상품가격(총';
			var docu2=sum;
			var docu3='개) :';
			var docu4=ffcost;
			var docu5=' 원';
			var result = docu1+docu2+docu3+docu4+docu5;
			var b= $('.chk:checked').length;
			if(b>0){
				$('#total').text(result);
				if(ffcost<100000){
					$('#delcost').text(ddelfee+" 원");
				}else{
					$('#delcost').text("0 원");
				}
				var ddelcost=$('#delcost').text();
				var dddelcost=ddelcost.slice(0,-1);
				totalfee=Number(ffcost)+Number(dddelcost);
				$('#allfee').text("총금액 :"+ totalfee+" 원");
			}	
			if(totalfee>100000){
				delfee=0;
				$("[id^='shipfee']").text("배송비 : 0 원");
			};
			if(!$("#allcheck").is(":checked")){
				$('#total').text("상품가격(총 0개) :       0원");
				$('#delcost').text("배송비 :           0원");
				$('#allfee').text("총금액 : 0 원");
			}	
	});
});

</script>

	</body>
</html>