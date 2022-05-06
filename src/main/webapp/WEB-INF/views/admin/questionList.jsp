<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
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

<title>QCali :: 질문</title>
	<script>
	function nullCheck(){
		if(questionAdd.questionContent.value==""){
			alert("질문을 입력해주세요.");
			questionAdd.questionContent.focus();
			return false;
		}
	}
	</script>
</head>
<body class="sb-nav-fixed">
	<jsp:include page="/WEB-INF/views/admin/main/adminHeader.jsp"></jsp:include>
	<div class="container mt-5">
	<a style="float: right;" href="${pageContext.request.contextPath}/admin/questionAll"> &lt; 질문 목록 보기   &gt; </a>
	
	<h2>질문 추가하기</h2>
	<form:form action="${pageContext.request.contextPath}/admin/question/questionAdd" name ="questionAdd" commandName="questionRegistCommand" onsubmit="return nullCheck()">
		<form:input path="questionContent"
		class="form-control form-control-lg" type="text" placeholder="추가할 질문을 입력해주세요." aria-label=".form-control-lg example"/>
		<form:errors path="questionContent"/>		
		
		<button type="submit" class="btn btn-primary m-2 position-relative" style="float: right;">
			질문 추가
		</button>
	</form:form>
	<br><br><br>
	<div class="dataTable-container">
		<h2>질문 승인 대기 </h2>
	<table id = "datatablesSimple" class="dataTable-table">
		<thead>
		<tr>
			<th>번호</th>
			<th>질문 내용</th>
			<th>작성자</th>
			<th class="text-center">질문 승인/거절</th>
		</tr>
		</thead>
		<c:if test="${empty questions }">
			<tr>
			<td colspan="4">승인 대기 중인 질문이 없습니다.</td>
		</c:if>
		<tbody>
		<c:forEach var="q" items="${questions }">
			<tr>
				<td>${q.no}</td>
				<td>${q.questionContent }</td>
					<!-- memberNickname이 null일 수 있다. -->
				<c:choose>
					<c:when test="${q.memberSeq == -1 }">
						<td>관리자</td>
					</c:when>
					<c:when test="${!empty q.memberNickname}">
						<td>${q.memberNickname }</td>
					</c:when>
					<c:otherwise>
						<td>탈퇴한 회원</td>
					</c:otherwise>
				</c:choose>
				
				<td class="text-center">
				<button type="button" class="btn btn-danger" onClick="deleteConfirm();">거부</button>
				<button type="button" class="btn btn-primary" onClick="approveConfirm();">승인</button>
				</td>
			</tr>
		<script>
		function deleteConfirm(){
			if(!confirm("정말 거부하시겠습니까?")){
				return false;
			}else{
				location.href="<c:url value='/admin/question/delete?questionSeq='/>"+${q.questionSeq};
			}
		}
		
		function approveConfirm(){
			if(!confirm("정말 승인하시겠습니까?")){
				return false;
			}else{
				location.href="<c:url value='/admin/question/approve?questionSeq='/>"+${q.questionSeq};
			}
		}
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