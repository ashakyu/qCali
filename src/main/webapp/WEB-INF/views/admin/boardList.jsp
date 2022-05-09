<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>QCali :: 게시판 관리</title>
<style>
a:link {
  color : black;
  text-decoration: none;
}
a:visited {
  color : black;
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
</style>
</head>
<link href="https://cdn.jsdelivr.net/npm/simple-datatables@latest/dist/style.css" rel="stylesheet" />
<script src="https://use.fontawesome.com/releases/v6.1.0/js/all.js" crossorigin="anonymous"></script>

<!-- <link -->
<!-- 	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" -->
<!-- 	rel="stylesheet" -->
<!-- 	integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" -->
<!-- 	crossorigin="anonymous"> -->

	
<link href="<c:url value='/resources/static/css/styles.css'/> "
	rel="stylesheet" type="text/css">
	
<body class = "sb-nav-fixed">
	<jsp:include page="/WEB-INF/views/admin/main/adminHeader.jsp"></jsp:include>

	<div class="container mt-5">
	<h2 class="m-3">일문일답</h2>
	<h5 style="float: right;">총 게시물 수 : ${boardTotal }개</h5>
	
	<div class="dataTable-container">
	<table id = "datatablesSimple" class="dataTable-table">
		<thead>
		<tr>
			<th>NO</th>
			<th>제목</th>
			<th>닉네임</th>
			<th>작성일</th>
			<th>조회수</th>
			<th>좋아요</th>
		</tr>
		</thead>
		<tfoot>
		<tr>
			<th>NO</th>
			<th>제목</th>
			<th>닉네임</th>
			<th>작성일</th>
			<th>조회수</th>
			<th>좋아요</th>
		</tr>		
		</tfoot>
		
		<tbody>
		<c:forEach var="b" items="${boards}">
		<tr>
			<td>${b.rn }</td>
			<td><a href="<c:url value='/admin/board/detail/${b.boardSeq }' /> "> ${b.boardTitle }</a></td>
				<c:if test="${empty b.memberSeq }">
					<!-- on delete set null로 회원이 null로 바뀔 경우 -->
					<td>탈퇴회원</td>
				</c:if>
				
				<c:if test="${!empty b.memberSeq }">
					<!-- 회원의 닉네임이 있을 경우 -->
				<td><div class="dropdown">
					<a href="" class="dropdown-toggle" type="button" id="dropdownMenuButton1" data-bs-toggle="dropdown" aria-expanded="false">${b.memberNickname}</a>
						<ul class="dropdown-menu" aria-labelledby="dropdownMenuButton1">
							<li><a class="dropdown-item" href="${pageContext.request.contextPath }/board/memberArticle?memberSeq=${b.memberSeq}">게시물 보기</a></li>
							<li><a class="dropdown-item" href="${pageContext.request.contextPath }/diary/list/${b.memberSeq}">Diary 보기</a></li>
			   				<li><a class="dropdown-item" href="#" onClick="popUpInfo();">회원 정보 보기</a></li>								
			   			</ul>
					</div>
				</td>
				</c:if>
			<td>${b.boardRegDay }</td>
			<td>${b.boardCount }</td>
			<td>${b.boardLike }</td>
		</tr>
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
		</c:forEach>

		</tbody>
	</table>
	</div>
		
	
	<nav aria-label="Page navigation example">
		<ul class="pagination justify-content-center">
	    <c:if test="${pageMaker.prev}">
	    	<li class="page-item"><a class="page-link" href="list${pageMaker.makeQuery(pageMaker.startPage - 1)}">이전</a></li>
	    </c:if> 
	
	    <c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="idx">
	    	<li class="page-item"><a class="page-link" href="list${pageMaker.makeQuery(idx)}">${idx}</a></li>
	    </c:forEach>
	
	    <c:if test="${pageMaker.next && pageMaker.endPage > 0}">
	    	<li class="page-item"><a class="page-link" href="list${pageMaker.makeQuery(pageMaker.endPage + 1)}">></a></li>
	    </c:if>  
	  </ul>
	</nav>

	</div>
</body>
</html>