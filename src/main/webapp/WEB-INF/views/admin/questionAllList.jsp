<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>총 질문 리스트</title>
</head>
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
</style>
<link href="https://cdn.jsdelivr.net/npm/simple-datatables@latest/dist/style.css" rel="stylesheet" />
<script src="https://use.fontawesome.com/releases/v6.1.0/js/all.js" crossorigin="anonymous"></script>
<link href="<c:url value='/resources/static/css/styles.css'/> "
	rel="stylesheet" type="text/css">
</head>

<body class="sb-nav-fixed">
	<jsp:include page="/WEB-INF/views/admin/main/adminHeader.jsp"></jsp:include>
	
	<div class="container mt-5">
	<h2 class="m-3">질문 목록</h2>
	<div class="dataTable-container">
	<h5 style="float: right;">총 질문 수  : ${questionTotal }개</h5>
	<table id = "datatablesSimple" class="dataTable-table">
		<thead>
		<tr>
			<th class="text-center">NO</th>
			<th>질문 내용</th>
			<th>작성자</th>
			<th>삭제</th>
		</tr>
		</thead>
		
		<tbody>
		<c:forEach var="q" items="${questions }">
			<tr>
				<td class="text-center">${q.no}</td>
				<td>${q.questionContent }</td>
				<c:choose>
					<c:when test="${empty q.memberSeq}">
						<td>탈퇴한 회원</td>
					</c:when>
					<c:when test="${q.memberSeq == -1 }">
						<td>관리자</td>
					</c:when>
					<c:otherwise>
						<td>${q.memberNickname }</td>
					</c:otherwise>
				</c:choose>
			<td class="text-center"><button type="button" class="btn btn-danger" onClick="deleteConfirm(${q.questionSeq});">삭제</button></td>
				</tr>
		<script>
		function deleteConfirm(seq){
			if(!confirm("정말 거부하시겠습니까?")){
				return false;
			}else{
				location.href="${pageContext.request.contextPath}/admin/question/delete?questionSeq="+seq;
			}
		}	
		</script>	
		</c:forEach>
		</tbody>
	</table>
	
	<nav aria-label="Page navigation example">
		<ul class="pagination justify-content-center">
	    <c:if test="${pageMaker.prev}">
	    	<li class="page-item"><a class="page-link" href="questionAll${pageMaker.makeQuery(pageMaker.startPage - 1)}">이전</a></li>
	    </c:if> 
	
	    <c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="idx">
	    	<li class="page-item"><a class="page-link" href="questionAll${pageMaker.makeQuery(idx)}">${idx}</a></li>
	    </c:forEach>
	
	    <c:if test="${pageMaker.next && pageMaker.endPage > 0}">
	    	<li class="page-item"><a class="page-link" href="questionAll${pageMaker.makeQuery(pageMaker.endPage + 1)}">></a></li>
	    </c:if>  
	  </ul>
	</nav>

	</div>
	</div> 	
</body>
</html>