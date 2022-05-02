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
			<td>${m.memberNickname }</td>
			<td>${m.memberRegDay }</td>
			<td>${m.memberAuth }</td>
			<td>${m.memberLevel}</td>
			<td><a href="javascript:void(0);" class="btn btn-danger" onclick="deleteConfirm();">삭제</a></td>
	
		</tr>
		<script type="text/javascript">
		function deleteConfirm(){
		if(!confirm("정말 삭제하시겠습니까??")){
			return false;
		}else{
			location.href="<c:url value='/admin/member/delete?memberSeq='/>"+${m.memberSeq};
			
		}
	}
</script>
		</c:forEach>
		</tbody>
	</table>
</div>


	<nav class="dataTable-pagination">
	  <ul class="dataTable-pagination-list">
	    <c:if test="${pageMaker.prev}">
	    	<li><a href="list${pageMaker.makeQuery(pageMaker.startPage - 1)}">이전</a></li>
	    </c:if> 
	
	    <c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="idx">
	    	<li><a href="list${pageMaker.makeQuery(idx)}">${idx}</a></li>
	    </c:forEach>
	
	    <c:if test="${pageMaker.next && pageMaker.endPage > 0}">
	    	<li><a href="list${pageMaker.makeQuery(pageMaker.endPage + 1)}">></a></li>
	    </c:if> 
	  </ul>
	</nav>



	<br> <a href="<c:url value='/admin/logout'/> ">로그아웃 하기</a><br>   
	<br> <a href="<c:url value='/admin/question/list'/> ">질문 추가/승인</a><br>
	<br> <a href="<c:url value='/admin/board/list'/> ">게시물 보기</a><br>   	



</body>
</html>