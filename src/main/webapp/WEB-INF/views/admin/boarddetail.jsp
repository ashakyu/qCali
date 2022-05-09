<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<style>
a:link {
  color : black;
  text-decoration: none;
}
a:visited {
  color : grey;
  text-decoration: none;
}
a:hover {
  color : red;
  text-decoration: underline;
}
a:active {
  color : green;
  text-decoration: none;
}
.box {
  width: 1300px;
  padding-top: 3%;
  padding-left: 15%;
}
.board_title {
	font-weight : 700;
	font-size : 25pt;
	margin : 10pt;
}
.board_info_box {
	color : #6B6B6B;
	margin : 10pt;
}
.board_tag {
	color : #6B6B6B;
	font-size : 9pt;
	margin : 10pt;
	padding-bottom : 10pt;
}
</style>

<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/simple-datatables@latest/dist/style.css" rel="stylesheet" />
<script src="https://use.fontawesome.com/releases/v6.1.0/js/all.js" crossorigin="anonymous"></script>
<link href="<c:url value='/resources/static/css/styles.css'/> "
	rel="stylesheet" type="text/css">

<title>QCali :: 게시물 보기</title>

</head>
<body class="sb-nav-fixed">
	<jsp:include page="/WEB-INF/views/admin/main/adminHeader.jsp"></jsp:include>
	
	<div style="backgroud-color: #d3d3d3;">
	<div class="container">
		<div class="box">
			<table class="table table-sm caption-top">
				<caption>게시물 보기       |   </caption>
			</table>
			<p class="board_title">${boards.boardTitle }</p>
			<p class="board_info_box" style=" position: relative;  display: inline-block;">${boards.boardRegDay }   by</p><div class="dropdown" style=" position: relative;  display: inline-block;">
				<a href="" class="dropdown-toggle" type="button" id="dropdownMenuButton1" data-bs-toggle="dropdown" aria-expanded="false">${boards.memberNickname }</a>
					  <ul class="dropdown-menu" aria-labelledby="dropdownMenuButton1">
					    <li><a class="dropdown-item" href="${pageContext.request.contextPath }/diary/list/${boards.memberSeq}">Diary 보기</a></li>
					    <li><a class="dropdown-item" href="${pageContext.request.contextPath }/board/memberArticle?memberSeq=${boards.memberSeq}">쓴 글 보기 </a></li>
					  </ul>
					</div>
			<p class="board_tag">조회수 : <c:out value="${boards.boardCount }"/>,  좋아요 : <c:out value="${boards.boardLike }"/>
			<hr>
			<h5 class="text-muted">질문 : ${boards. questionContent}</h5>
			<p>${boards.boardContent }</p>		
		</div>

	<br>
	
		<div style="float: right;">

		<button type="button"  class="btn btn-outline-danger" onClick="deleteConfirm();">글 삭제</button>
		</div>
	</div>
		<script>
			function deleteConfirm(){
				if(!confirm("정말 삭제하시겠습니까?")){
				return false;
				}
				else{
				location.href="<c:url value='/admin/board/delete?boardSeq='/>"+${boards.boardSeq};
				}
			}
			</script>
		</div>
</body>
</html>