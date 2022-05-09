<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib  prefix="spring" uri="http://www.springframework.org/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" name="viewport" content="width=device-width, initial-scale=1">

<!-- <script src="https://use.fontawesome.com/releases/v6.1.0/js/all.js" crossorigin="anonymous"></script> -->
<link href="<c:url value='/resources/static/css/styles.css'/>" rel="stylesheet" type="text/css">
</head>
<title>QCali :: Q&A</title>
</head>
<body class="sb-nav-fixed">
	<jsp:include page="/WEB-INF/views/main/header.jsp"></jsp:include>
	<jsp:include page="/WEB-INF/views/main/sidebar_board.jsp"></jsp:include>

	
	<!-- 목록 -->
	
	<div class="container mt-3">	
	<table class ="table table-striped caption-top" >
		<caption>Q&A    |  ${boardTotal} 개</caption>
		<thead>
		<tr>
			<th>번호</th>
			<th>제목</th>
			<th>작성자</th>
			<th>날짜</th>

		</tr>
		</thead>
		<tbody>
		<c:if test="${boardtotal == 0 }">
			등록된 글이 없습니다.
		</c:if>
		<c:forEach items="${qnaList }" var="list">
		<tr>
			<td>${list.qnaNo }</td>
			<td>
				<c:forEach var="i" begin="1" end="${list.qnaIndent }">
					<c:choose>
					<c:when test="${i eq list.qnaIndent }">
						ㄴ[답변]:
					</c:when>
					<c:otherwise>
						&nbsp;&nbsp;
					</c:otherwise>		
					</c:choose>			
				</c:forEach>
				
				<c:choose>
					<c:when test="${list.qnaTitle eq 'none' }">
						삭제된 글입니다.
					</c:when>
					<c:otherwise>
						<a href="<c:url value='/qna/detail/${list.qnaSeq} '/> ">${list.qnaTitle }</a>
					</c:otherwise>
				</c:choose>
			</td>
			<!-- 관리자 일 경우 -->
			
			<c:if test="${!empty list.qnaWriter }">	
				<td>
					${list.qnaWriter }
				</td>
			</c:if>
			
			<c:if test="${empty list.qnaWriter }">
				<c:if test="${empty list.memberSeq }">
					<!-- on delete set null로 회원이 null로 바뀔 경우 -->
					<td>탈퇴회원</td>
				</c:if>
				
				<c:if test="${!empty list.memberSeq }">
					<!-- 회원의 닉네임이 있을 경우 -->
				<td><div class="dropdown">
					<a href="" class="dropdown-toggle" type="button" id="dropdownMenuButton1" data-bs-toggle="dropdown" aria-expanded="false">${list.memberNickname}</a>
						<ul class="dropdown-menu" aria-labelledby="dropdownMenuButton1">
							<li><a class="dropdown-item" href="${pageContext.request.contextPath }/board/memberArticle?memberSeq=${list.memberSeq}">게시물 보기</a></li>
							<li><a class="dropdown-item" href="${pageContext.request.contextPath }/diary/list/${list.memberSeq}">Diary 보기</a></li>
			   				<li><a class="dropdown-item" href="#" onClick="popUpInfo();">회원 정보 보기</a></li>								
			   			</ul>
					</div>
				</td>
				</c:if>
					<script type="text/javascript">
						function popUpInfo(){
							let url = "${pageContext.request.contextPath}/member/popup?memberSeq=${list.memberSeq}";
							let name = "Member 정보";
							let specs = "height=350, width= 300, status = no, location= no, top=100, left=100";
							window.open(url, name, specs);}
						</script>
			</c:if>
			
			<td>${list.qnaRegDay }</td>

			</tr>

		</c:forEach>
		</tbody>
	</table>
	<button type="button" class="btn btn-secondary" style="float: right;"
	onclick="location.href='${pageContext.request.contextPath}/qna/write'" >문의하기</button>
	
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
<jsp:include page="/WEB-INF/views/main/footer.jsp"></jsp:include>
</body>
</html>