<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>

<link href="<c:url value='/resources/static/css/button.css'/> "
	rel="stylesheet" type="text/css">
<meta charset="UTF-8">
<title>공지 사항 리스트</title>
<!-- jQuery -->
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<!-- bootstrap css -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
</head>
<body >
	<jsp:include page="/WEB-INF/views/main/header.jsp"></jsp:include>
	<jsp:include page="/WEB-INF/views/main/sidebar_board.jsp"></jsp:include>
	
	<div class="container mt-5">
		<table class="table table-hover">
		<caption>공지사항    |  게시물  총 ${boardTotal} 개</caption>
		<thead class="table-light">
			<tr>
				<th class="col-sm-3">작성 번호</th>
				<th class="col-sm-5">제목</th>
				<th class="col-sm-4">작성 날짜</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var ="notice" items="${notice}" varStatus="loop">
			<tr>
				<th>${notice.noticeSeq}</th>
				<td><a href="<c:url value="/notice/read/${notice.noticeSeq}"/>">${notice.noticeTitle}</a></td>
				<td>${notice.noticeRegDay}</td>
			</tr>
			</c:forEach>
		</tbody>
		</table>
		<div class="d-grid gap-2 d-md-block" style="float:right">
			<c:if test="${adminAuthInfoCommand != null }">
			<input type="button" value="글쓰기" class="w-btn w-btn-green" onclick="location.href='<c:url value="/notice/write"/>'">
			</c:if>
			<input type="button" value="돌아가기" class="w-btn w-btn-green" onclick="location.href='<c:url value="/board/list"/>'">  	
		</div>

		<nav aria-label="Page navigation example">
			<ul class="pagination justify-content-center">

				<c:if test="${pageMaker.prev }">
					<li class="page-item disabled"><a class="page-link"
						href="list${pageMaker.makeQuery(pageMaker.startPage - 1) }">이전</a></li>
				</c:if>

				<c:forEach var="currentPage" begin="${pageMaker.startPage }"
					end="${pageMaker.endPage }">
					<li class="page-item"
						<c:out value="${pageMaker.cri.page == currentPage ? 'class=active' : ''}"/>><a
						class="page-link" href="list${pageMaker.makeQuery(currentPage) }">${currentPage }</a></li>
				</c:forEach>

				<c:if test="${pageMaker.next && pageMaker.endPage > 0 }">
					<li class="page-item"><a class="page-link"
						href="list${pageMaker.makeQuery(pageMaker.endPage + 1) }">다음</a></li>
				</c:if>
			</ul>
		</nav>
	</div>
	</div>
  </body>
</html>