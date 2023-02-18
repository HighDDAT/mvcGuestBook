<%@page import="java.io.PrintWriter"%>
<%@page import="guestBook.dto.GuestDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	isELIgnored="false" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:set var="cPath" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>방명록</title>
<style>
.area_namePw input {
	width: 30%;
	display: inline-block;
}
.area_reply {

	background-color : #FAFAFA;
	
	border-top : 3px solid #EFEFEF;
	border-bottom : 3px solid #EFEFEF;
}
</style>
<!-- 부트스트랩 css -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet"
	integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65"
	crossorigin="anonymous">
</head>
<body>

	<form name="frmGuest" method="post"
			action="${cPath}/guest/insertGuest.do" >
			<input type="hidden" name="guest_no" value="${guest.guest_no}" />
		<div class="form">
			<h3>Guestbook</h3>
			<div class="area_reply">
				<div class="area_namePw">
					<div class="mb-4">
						<input type="text" class="form-control" 
						name="guest_name" id="guest_name" placeholder="name">
						<input type="password" class="form-control"
						name="guest_pw" id="guest_pw" placeholder="password">
					</div>
				</div>
				<div class="area_text">	
					<div class="mb-4">
						 <textarea class="form-control" aria-label="With textarea" placeholder="여러분의 소중한 방명록을 작성해주세요"
						 name="guest_content" id="guest_content"></textarea>
			  		</div>
			  	</div>	
			  	<div class="area_btn">	
					<div class="mb-4 form-check">
			  			<input type=submit class="btn btn-primary" value="작성" />
					</div>
				</div>
			</div>
			</div>
	</form>
<table class="table">
	<thead class="table-primary">
		<tr>
			<td>번호</td>
			<td>이름</td>
			<td>비밀번호</td>
			<td>내용</td>
			<td colspan="2">등록일자</td>
		</tr>
	</thead>
	<tbody>
		<c:forEach var="guest" items="${guestList}">
			<tr>
				<td>${guest.guest_no}</td>
				<td>${guest.guest_name}</td>
				<td>${guest.guest_pw}</td>
				<td>${guest.guest_content}</td>
				<td>${guest.append_date}</td>
				<td>
					<form name="delBooks" method="post" enctype="multipart/form-data"
						action="${cPath}/guest/delGuest.do">
						<input type="hidden" name="delCheck" value="${guest.guest_no}">
							<input type="button"
								class="btnDelete btn btn-primary" id="btnDelete"
								name="${guest.guest_no }" alt="${guest.guest_pw }"
								value="삭제">
					</form>		
				</td>
			</tr>	
		</c:forEach>
	</tbody>
</table>



<!-- 제이쿼리 -->  
<script
   src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
	 
<!--  부트 스트랩 모달 창 기능 자바스크립트 링크 -->
<script
	src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"
	integrity="sha384-oBqDVmMz9ATKxIep9tiCxS/Z9fNfEXiDAYTujMAeBAsjFuCZSmKbSSUnQlmh/jp3"
	crossorigin="anonymous"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js"
	integrity="sha384-mQ93GR66B00ZXjt0YO5KlohRA5SY2XofN4zfuZxLkoj1gXtW8ANNCe9d5Y3eG5eD"
	crossorigin="anonymous"></script>

<script>
$(function() {
	console.log('제이쿼리')
	
	$(".btnDelete").click(function() {
		console.log('클릭이벤트 발생');
		
		del_guestNum = $(this).attr('name');
		del_guestPW = $(this).attr('alt');
		
		console.log(del_guestNum);
		console.log(del_guestPW);
		
		
		pwCheck = prompt('비밀번호를 입력하세요');
		
		if(del_guestPW == pwCheck) {
			location.href=
	            "delGuest.do?guest_no="+
	            del_guestNum+"&guest_pw="+del_guestPW;
		} else if(pwCheck == null) {
        	return;
		} else {
			alert("비밀번호가 맞지 않습니다.");
		};
	});
});

</script>
</body>
</html>