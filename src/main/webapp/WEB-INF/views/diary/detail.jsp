<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%> 

<!DOCTYPE html>
<html>
<head>

<link href="<c:url value='/resources/static/css/button.css'/> "
	rel="stylesheet" type="text/css">
	
<style>
.box {
   width: 1300px;
   padding-top: 3%;
   padding-left: 15%;
}
.board_title {
   font-weight: 700;
   font-size: 25pt;
   margin: 10pt;
}
.board_info_box {
   color: #6B6B6B;
   margin: 10pt;
}
.board_tag {
   color: #6B6B6B;
   font-size: 9pt;
   margin: 10pt;
   padding-bottom: 10pt;
}
</style>
<meta charset="UTF-8">
<title>QCali :: ${diaryList.diaryTitle}</title>
<!-- Option 1: Bootstrap Bundle with Popper -->

<!-- jQuery -->
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<!-- bootstrap css -->

<link href="<c:url value='/resources/static/css/dropdown.css'/> " rel="stylesheet" type="text/css">
</head>
<body>
<jsp:include page="/WEB-INF/views/main/header.jsp"></jsp:include>
<jsp:include page="/WEB-INF/views/main/sidebar_board.jsp"></jsp:include>

<div class="container mt-3">
	<div class="box">	
		<c:if test="${ empty diaryList}">
			<h3>없는 일기입니다.</h3>
		</c:if>
		<c:if test="${ !empty diaryList}">
		 <table class="table table-sm caption-top">
            <caption>${diaryList.memberNickname} 의 일기장</caption>
         </table>
		
		 <div>
	         <p class="board_title">${diaryList.diaryTitle}</p>
	         <p class="board_info_box" style=" position: relative;  display: inline-block;">${diaryList.diaryRegday}</p>
	         <div style=" position: relative;  display: inline-block;">
		         <p class="board_info_box" style=" position: relative;  display: inline-block;">by
		            <c:if test="${empty diaryList.memberNickname}">
		                  	탈퇴 회원
		            </c:if>
		            <c:if test="${!empty diaryList.memberNickname}">
		            <div class="dropdown" style=" position: relative;  display: inline-block;">
					<a href="" class="dropdown-toggle" type="button" id="dropdownMenuButton1" data-bs-toggle="dropdown" aria-expanded="false">${diaryList.memberNickname}</a>
						<ul class="dropdown-menu" aria-labelledby="dropdownMenuButton1">
							<li><a class="dropdown-item" href="${pageContext.request.contextPath }/board/memberArticle?memberSeq=${diaryList.memberSeq}">게시물 보기</a></li>
							<li><a class="dropdown-item" href="${pageContext.request.contextPath }/diary/list/${diaryList.memberSeq}">Diary 보기</a></li>
			   				<li><a class="dropdown-item" href="#" onClick="popUpInfo();">회원 정보 보기</a></li>								
						</ul>
					</div>
		            </c:if>
	         </div>
         </div>
         					<script type="text/javascript">
						function popUpInfo(){
							var popupX = (document.body.offsetWidth / 2) - (200 / 2);
							// 만들 팝업창 좌우 크기의 1/2 만큼 보정값으로 빼주었음

							var popupY= (document.body.offsetHeight / 2) - (300 / 2);
							// 만들 팝업창 상하 크기의 1/2 만큼 보정값으로 빼주었음


							let url = "${pageContext.request.contextPath}/member/popup?memberSeq=${b.memberSeq}";
							let name = "Member 정보";
				            let option = "width = 350, height = 300, top = 100, left = 200, location = no"
							window.open(url, name,  'status=no, height=300, width=200, left='+ popupX + ', top='+ popupY);}
						</script>	
         
		 <p class="board_tag">조회수 : ${diaryList.diaryCount}, 좋아요 : ${diaryList.diaryLike}</p>
         <hr>       
	     <p style="text-align: center;">
			 <c:if test="${!empty diaryList.diaryImg }"> <!-- 이미지 있으면 -->	
				<img src="/diaryImg${diaryList.diaryImg }" width="400">
				<hr>
			 </c:if>		 
		 </p>		
         <p>${diaryList.diaryContent}</p>
         
          <div style="text-align: right;">
			<a class="text-dark heart" style="text-decoration-line: none;">
				<img id="heart" src="" height="35px">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			</a>
		</div>	
		</c:if> 
    
     </div>
 <div style="margin-top: 2%; padding-left: 20%; float: right;">
        
	         <c:if test="${myArticle == true}">
	            <button type="button" class="w-btn w-btn-gray"
	               onclick="location.href='<c:url value="/diary/edit/${diaryList.diarySeq}"/>'">일기 수정</button>
	            <button type="button" class="w-btn w-btn-gray"
	               onClick="delete_button();">일기 삭제</button>
	            <c:if test="${!empty diaryList.diaryImg }">
	               <button type="button" class="w-btn w-btn-gray"
	               onClick="deleteImg_button();">이미지 삭제</button>     
	            </c:if>    
	         </c:if>
	         <button type="button" class="w-btn w-btn-gray"
	               onclick="location.href='<c:url value="/diary/list/${diaryList.memberSeq}"/>'">일기장 가기</button>
       	</div>      			
</div>	
	<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
	<script>
		$(document).ready(function() {
			var heartval = ${diaryHeart};
			if (heartval > 0) {
				console.log(heartval);
			    $("#heart").prop("src", '<c:url value="/resources"/>'+"/static/images/heart-fill.svg");
				$(".heart").prop('name', heartval)
			} else {
				console.log(heartval);
				$("#heart").prop("src", '<c:url value="/resources"/>'+"/static/images/heart.svg");
				$(".heart").prop('name', heartval)
			}
			$(".heart").on("click", function() {
				var that = $(".heart");
				console.log(that.prop('name'));
				var sendData = {
					'diarySeq' : '${diarySeq}',
					'diaryHeart' : that.prop('name'),
				};
				$.ajax({
					url : '<c:url value="/diary/heart"/>',
					type : 'POST',
					data : JSON.stringify(sendData),
					contentType: 'application/json',
					success : function(data) {
						that.prop('name', data);
						console.log("success:" + that.prop('name', data));
						if (data == 1) {
							 $('#heart').prop("src",'<c:url value="/resources"/>'+"/static/images/heart-fill.svg");
						} else {
							 $('#heart').prop("src",'<c:url value="/resources"/>'+"/static/images/heart.svg");
						}
					}
				});
			});
		});
	</script>

	<script type="text/javascript">
		function delete_button() {
			if (!confirm("정말 삭제하시겠습니까??")) { //아니오
				return false;			
			} else { //예
				return location.href="<c:url value='/diary/delete?diarySeq='/>"+${diaryList.diarySeq};
			}
		}
		
		function deleteImg_button() {
			if (!confirm("정말 삭제하시겠습니까??")) { //아니오
				return false;			
			} else { //예
				return location.href="<c:url value='/diary/deleteImg?diarySeq='/>"+${diaryList.diarySeq};
			}
		}
	</script>
</body>
</html>