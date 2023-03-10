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
.modal{ 
  position:absolute; width:100%; height:100%; background: rgba(0,0,0,0.8); top:0; left:0; display:none;
}
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
	<form name="data" method="post" id="writeForm"
			onsubmit="return writeCheck()" action="${cPath}/guest/insertGuest.do" >
			<input type="hidden" name="guest_no" value="${guest.guest_no}" />
			<h3>Guestbook</h3>
						<input type="text" class="form-control" 
						name="guest_name" id="guest_name" placeholder="name">
						<input type="password" class="form-control"
						name="guest_pw" id="guest_pw" placeholder="password">
						 <textarea class="form-control" aria-label="With textarea" placeholder="여러분의 소중한 방명록을 작성해주세요"
						 name="guest_content" id="guest_content"></textarea>
		<input type="submit" value="작성" class="btnWrite btn btn-primary" />
		<input type="reset" value="취소" class="btnWrite btn btn-secondary" />
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
							<input type="button"
								class="btnDelete btn btn-danger" id="btnDelete"
								name="${guest.guest_no }" alt="${guest.guest_pw }"
								value="삭제">
				</td>
			</tr>	
		</c:forEach>
	</tbody>
</table>


	 
<!--  부트 스트랩 모달 창 기능 자바스크립트 링크
<script
	src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"
	integrity="sha384-oBqDVmMz9ATKxIep9tiCxS/Z9fNfEXiDAYTujMAeBAsjFuCZSmKbSSUnQlmh/jp3"
	crossorigin="anonymous"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js"
	integrity="sha384-mQ93GR66B00ZXjt0YO5KlohRA5SY2XofN4zfuZxLkoj1gXtW8ANNCe9d5Y3eG5eD"
	crossorigin="anonymous"></script> -->

<!-- 제이쿼리 모달 -->
<div class="modal">
		<input type="hidden" name="delCheck" value="${guest.guest_no}">
		  <div class="modal_content" 
		       title="방명록삭제">
		       방명록을 삭제하려면 비밀번호를 입력하세요 : <br>
		    <input type="password" class="form-control"
				name="pwChk" id="pwChk" placeholder="password">
			</div>
			<div class="modal-footer">
				<input type="button" class="modal_delete btn btn-danger" value="삭제">
				<input type="button" class="modal_cancel btn btn-secondary" value="취소">
			</div>
</div>


<!-- 제이쿼리 --> 
<script
   src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
   
 <script>
//글작성 이전 유효성 검사
function writeCheck(){
	
	  if($("#guest_name").val() == "") {
		   alert("이름을 입력해주세요");
		   $("#guest_name").focus();
		   return false;
	  } 
	  if($("#guest_pw").val() == "") {
		   alert("비밀번호를 입력해주세요");
		   $("#guest_pw").focus();
		   return false;
	  } 
	  if($("#guest_content").val() == "") {
		   alert("내용을 입력해주세요");
		   $("#guest_content").focus();
		   return false;
	  }
	  }
</script>

<!-- 삭제부분 -->
<script>

$(function() {
	
	console.log('제이쿼리')
	
	// 리스트에서 삭제 버튼을 누르면		
  $(".btnDelete").click(function(){
	  	console.log('클릭이벤트 발생');
		
		del_guestNum = $(this).attr('name');
		del_guestPW = $(this).attr('alt');
		
		console.log(del_guestNum);
		console.log(del_guestPW);
		
    $(".modal").fadeIn();
    
  });
  
	// 모달에서 삭제하기
  var del_guestNum, del_guestPW ;
  $(".modal_delete").click(function() {
	
	  // 비밀번호 확인 후 삭제
	  if( $('#pwChk').val() == del_guestPW) {
			location.href=
	            "delGuest.do?guest_no="+
	            del_guestNum+"&guest_pw="+del_guestPW;
		} else {
			alert("비밀번호가 맞지 않습니다.");
			return;
		};
	  
  });
  
  // 모달창 닫기
  $(".modal_cancel").click(function(){
    $(".modal").fadeOut();
  });
  
	/*
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
	*/
});
</script>

</body>
</html>