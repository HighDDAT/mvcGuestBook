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
				
					<!--<input type=button value="삭제1"  class="btn btn-danger"
						onClick="fn_remove_article('${cPath}/guest/delGuest.do', ${guest.guest_no})">
							
					  <input type="button" value="삭제1" class="btn btn-danger"
                   		 onclick="location.href = 'delGuest.do?guest_no=${guest.guest_no}'">-->
						
					 <!-- -->
					 <input type="button" class="btnDelete btn btn-outline-danger"
					 	name="${guest.guest_no}" alt="${guest.guest_pw}"
					 	value="삭제">
					
					<!--  
					<div class="del btn btn-danger">
						<input type="hidden" class="no" value="${guest.guest_no}">
						삭제
						</div> -->
						
				</td>
			</tr>	
		</c:forEach>
	</tbody>
</table>


<!--Modal -->

	<!-- <div class="modal fade" id="exampleModal" tabindex="-1"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h1 class="modal-title fs-5" id="exampleModalLabel">${guest.guest_no}번째 방명록 삭제</h1>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				
				<form action="${cPath}/guest/delGuest.do" method="post">
				
					<div class="modal-body">
					<input type="hidden" name="guest_no" value='${ param.guest_no }'>
						<div class="mb-3">
						    <label for="exampleInputPassword1" class="form-label">비밀번호를 입력하세요</label>
						    <input type="password" class="form-control" id="guest_pw" name="guest_pw">
	  					</div>
					</div>
				
					<div class="modal-footer">
						<input type="button" id="btnDeleteGo" class="btn btn-default" 
						value="메시지 삭제하기" alt="" style="font-size:10px">
                  <input type="button" class="btn btn-default" data-dismiss="modal" 
                  		value="닫기" style="font-size:10px">
					</div>
				</form>
				
			</div>
		</div>
	</div> -->
<!--
   <script type="text/javascript" >
     
	 function fn_remove_article(url,guest_no){
		 var form = document.createElement("form");
		 
		 form.setAttribute("method", "post");
		 form.setAttribute("action", url);
		 
	     var guest_noInput = document.createElement("input");
	     guest_noInput.setAttribute("type","hidden");
	     guest_noInput.setAttribute("name","guest_no");
	     guest_noInput.setAttribute("value", guest_no);
		 
	     form.appendChild(guest_noInput);
	     document.body.appendChild(form);
	     form.submit();
	 }
	

	
	$(function() {
		console.log('제이쿼리 연결')
		
		$(".btnDelete").click(function() {
			
			console.log('click')
			
			del_guestNum = $(this).attr('name'); // 게시글번호
			del_guestPw = $(this).attr('alt'); // 비밀번호
			
			
			
		})
			
	})
		
		/*
	 $(".btnDelete").click(function(){
         // 삭제 게시글의 실제 비밀번호를 js 변수 
         del_guestNum = $(this).attr('name'); // PK
         del_guestPw = $(this).attr('alt');  // 비밀번호
         var del_messageId, del_password ;
         
         $('#btnDeleteGo').click(function (){
            // 삭제하기 위해 입력한 비밀번호  $('#password').val() 
            if( $('#guest_pw').val() != del_guestPw){
               alert(' 비밀번호 틀림!!!');
               return;
            }
            //비밀번호가 맞으면 
            location.href=
               "delGuest.do?guest_no="+
               		del_guestNum+"&guest_pw="+del_guestPw;
         });
         */

 </script>
  -->
<!-- 제이쿼리 -->  
<script
   src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
 
 <!-- 부트스트랩 -->  
 <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
	 integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" 
	 crossorigin="anonymous"></script>
	 
<script
	src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"
	integrity="sha384-oBqDVmMz9ATKxIep9tiCxS/Z9fNfEXiDAYTujMAeBAsjFuCZSmKbSSUnQlmh/jp3"
	crossorigin="anonymous"></script>

<!-- 삭제 관련 모달 스크립트 -->	
<script>
$(function() {
	console.log('제이쿼리 연결')
	
	// btnDelete 누르면 값 받아와서 변수 만들고 모달창 띄우기
	$(".btnDelete").click(function(){
        // 삭제 게시글의 실제 비밀번호를 js 변수 
        del_password = $(this).attr('alt');  // 비밀번호
        del_messageId = $(this).attr('name'); // PK
        
        // 모달창 띄우는 함수 : modal()
          $("#myModal").modal({backdrop: "static"});
          $("#myModal").on('shown.bs.modal', function () {
             $('#password').focus();
          });
	      });
	     
	     $('#myModal > div').css({
	        "width":"400px"
	        ,"top":'150px'
	        ,"margin":'0 auto'
	     });
		
})
</script>   
</body>
</html>