<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>QCali :: 유저 관리</title>
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
	<h2 class="m-3">Users</h2>
	<h5 style="float: right;">사용자 수 : ${boardTotal }명</h5>
	
	<div class="dataTable-container">
	<table id = "datatablesSimple" class="dataTable-table">
		<thead>
		<tr>
			<th>아이디</th>
			<th>닉네임</th>
			<th>가입 날짜</th>
			<th>인증T/F</th>
			<th>레벨</th>
		</tr>
		</thead>
		
		<tfoot>
		<tr>
			<th>아이디</th>
			<th>닉네임</th>
			<th>가입 날짜</th>
			<th>인증T/F</th>
			<th>레벨</th>
		</tr>
		</tfoot>
		
		<tbody>
		<c:forEach var="m" items="${members }">
		<tr>
			<td>${m.memberId}</td>
			<td><div class="dropdown">
				<a href="" class="dropdown-toggle" type="button" id="dropdownMenuButton1" data-bs-toggle="dropdown" aria-expanded="false">
					${m.memberNickname }</a>
					  <ul class="dropdown-menu" aria-labelledby="dropdownMenuButton1">
					    <li><a class="dropdown-item" href="${pageContext.request.contextPath }/diary/list/${m.memberSeq}">Diary 보기</a></li>
					    <li><a class="dropdown-item" href="${pageContext.request.contextPath }/board/memberArticle?memberSeq=${m.memberSeq}">쓴 글 보기 </a></li>
					  </ul>
					</div></td>
			<td>${m.memberRegDay }</td>
			<td>${m.memberAuth }</td>
			<td>${m.memberLevel}</td>
			<td class="text-center"><button type="button" class="btn btn-danger" onclick="deleteConfirm(${m.memberSeq});">삭제</button></td>
		</tr>
		<script type="text/javascript">
		function deleteConfirm(seq){
		if(!confirm("정말 삭제하시겠습니까??")){
			return false;
		}else{
			location.href="${pageContext.request.contextPath}/admin/member/delete?memberSeq="+seq;
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