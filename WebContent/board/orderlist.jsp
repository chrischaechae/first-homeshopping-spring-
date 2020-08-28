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
	margin: 0px auto;
}
img{
	width: 50px;
	height: 50px;
}
table{
	width: 900px;
	border: 1px solid gray;
	border-collapse: collapse;
	text-align: center;
	vertical-align: middle;
}
 th,tr,td{
 	border: 1px solid gray;
 }
 #search{
 	position: relative;
 	margin-bottom: 10px;
 }
</style>
</head>
<body>
<div id="container">
<jsp:include page="/board/menu.jsp"/>
<h1 id="title">최근주문내역</h1>
<form action="orderlist.do" method="GET" onsubmit="return searchCheck()">
	<div id="search">
		<select name="keyField">
					<option value="ordering_date">날짜</option>
					<option value="pro_name">상품정보</option>
					<option value="ordering_status">상태</option>
		</select> 
			<input type="text" size="16" name="keyWord">

			<input type="hidden" name="client_id" value="${sessionScope.login.client_id}">
			<input type="submit" id="search" value="검색">
	<span>주문내역(${count } 건)</span>		
	</div>
</form>		
	<table>
		<thead>
			<tr>
				<th style="width: 100px;">날짜</th>
				<th style="width: 500px;">상품정보</th>
				<th style="width: 150px;">상태</th>
				<th>확인신청</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach var="bean" items="${list}" varStatus="status">
		
			<tr>
				<td class="confirm">${bean.ordering_confirm }</td>
				<td>${bean.ordering_date }</td>
				<td><img src="http://localhost:8098/admin/upload/${bean.pro_img }">상품명 : ${bean.pro_name } / 사이즈 : ${bean.choice_size } / 색 : ${bean.choice_color }
					<div>결제:${bean.ordering_payment }/요청사항:${bean.ordering_request }/${bean.ordering_price }원  / ${bean.ordering_num }개</div>
				</td>
				<td>${bean.ordering_status }</td>
				
   					 <c:if test="${bean.ordering_status=='배송완료' && bean.ordering_confirm==0}">
					<td><button id="confirm${bean.ordering_no }" value="${bean.ordering_no }">수취확인</button>
						<button id="refund${bean.ordering_no }" value="${bean.ordering_no }">환불신청</button>
					</td>
					</c:if>
					 <c:if test="${bean.ordering_status=='배송완료' && bean.ordering_confirm==1}">
					<td>수취확인</td>
					</c:if>
					<c:if test="${bean.ordering_status!='배송완료'}">
     				<td></td>
    				</c:if>
			</tr>
		</c:forEach>
		</tbody>
	
	</table>
	 <table align="center" style="border:0px;">
		<c:if test="${count>0}">
			<tr>
				<td align="center">${pagingHtml}</td>
			</tr>
		</c:if>
	</table>
</div>
<script type="text/javascript">

history.replaceState({},null,location.pathname);
$(document).ready(function(){
	

	
var abc="${sessionScope.login.client_id}";
	
	if(abc==null || abc==""){
		location.href="login.do";
	}
	
	$('.confirm').hide();
	$("[id^='confirm']").click(function(){
		var status=$(this).val();
		alert(status);
		$.ajax({
			url:'confirmstatus.do',
			type:'POST',
			async: false,
			data:{ordering_status:status},
			success:function(data){
				 alert("수취확인되었습니다.");
			},
			error:function(){
				
			}
		}); 
		$(this).attr('disabled', true);
	});
	
	$("[id^='refund']").click(function(){
		var no=$(this).val();
		$.ajax({
			url:'refundstatus.do',
			type:'POST',
			async: false,
			data:{ordering_no:no},
			success:function(data){
				 alert("환불신청되었습니다.");
			},
			error:function(){
				
			}
		}); 
		$(this).attr('disabled', true);
	});
	
});
</script>

	</body>
</html>