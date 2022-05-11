<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>QCali :: Admin Main</title>
</head>
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
<link href="https://cdn.jsdelivr.net/npm/simple-datatables@latest/dist/style.css" rel="stylesheet" />
<script src="https://use.fontawesome.com/releases/v6.1.0/js/all.js" crossorigin="anonymous"></script>
	

<body>
	<jsp:include page="/WEB-INF/views/admin/main/adminHeader.jsp"></jsp:include>
 	
 
<body class = "sb-nav-fixed">
	<div class="container mt-5">
	<!-- today 올라온 글 -->
	
	<h4 class="mt-3">Today 게시물</h4>
		<table id = "datatablesSimple" class="table table-sm table-border m-3">
		<thead class="table-light">
		<tr>
			<th>번호</th>
			<th>제목</th>
			<th>닉네임</th>
			<th>조회수</th>
			<th>좋아요</th>
		</tr>
		</thead>
		<c:if test="${boardTotal == 0}">
			<td colspan="5">오늘 올라온 글이 없습니다.</td>
		</c:if>
		<c:if test="${boardTotal > 0  }">
			<c:forEach var="list" items="${list }">
				<tr>
					<td>${list.rn }</td>
					<td><a href="${pageContext.request.contextPath}/admin/board/detail/${list.boardSeq}">${list.boardTitle }</a></td>
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
					   				<li><a class="dropdown-item" href="#" onClick="popUpInfo(${list.memberSeq});">회원 정보 보기</a></li>								
					   			</ul>
							</div>
						</td>
					</c:if>
					<td>${list.boardCount }</td>
					<td>${list.boardLike }</td>
				</tr>
			</c:forEach>
		</c:if>
			</table>
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
	<div class="dataTable-container mt-3">
	<svg xmlns="http://www.w3.org/2000/svg" width="40" height="40" style="padding-bottom : 11px;" fill="currentColor" class="bi bi-caret-right-fill" viewBox="0 0 16 16">
  <path d="m12.14 8.753-5.482 4.796c-.646.566-1.658.106-1.658-.753V3.204a1 1 0 0 1 1.659-.753l5.48 4.796a1 1 0 0 1 0 1.506z"/>
	</svg>
	
	<h4 style="display : inline-block;">게시물 랭킹</h4>
		
		<table id = "datatablesSimple" class="table table-sm m-3">
		<thead class="table-light">
		<tr>
			<th>순위</th>
			<th>ID</th>
			<th>닉네임</th>
			<th>작성 수</th>
		</tr>
		</thead>
		
		<tbody>
			<c:forEach var ="r" items="${rank }">
				<tr>
					<td>${r.rank }위</td>
					<td>${r.memberId }</td>
					<c:if test="${empty r.memberSeq }">
					<!-- on delete set null로 회원이 null로 바뀔 경우 -->
					<td>탈퇴회원</td>
				</c:if>
				
				<c:if test="${!empty r.memberSeq }">
					<!-- 회원의 닉네임이 있을 경우 -->
				<td><div class="dropdown">
					<a href="" class="dropdown-toggle" type="button" id="dropdownMenuButton1" data-bs-toggle="dropdown" aria-expanded="false">${r.memberNickname}</a>
						<ul class="dropdown-menu" aria-labelledby="dropdownMenuButton1">
							<li><a class="dropdown-item" href="${pageContext.request.contextPath }/board/memberArticle?memberSeq=${r.memberSeq}">게시물 보기</a></li>
							<li><a class="dropdown-item" href="${pageContext.request.contextPath }/diary/list/${r.memberSeq}">Diary 보기</a></li>
			   				<li><a class="dropdown-item" href="#" onClick="popUpInfo(${r.memberSeq});">회원 정보 보기</a></li>								
			   			</ul>
					</div>
				</td>
				</c:if>					
					<td>${r.count }개</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	</div>

	<svg xmlns="http://www.w3.org/2000/svg" width="40" height="40" style="padding-bottom : 11px;" fill="currentColor" class="bi bi-caret-right-fill" viewBox="0 0 16 16">
  <path d="m12.14 8.753-5.482 4.796c-.646.566-1.658.106-1.658-.753V3.204a1 1 0 0 1 1.659-.753l5.48 4.796a1 1 0 0 1 0 1.506z"/>
	</svg>
	
	<h4 style="display : inline-block;">댓글 수 랭킹</h4>
	<div class="dataTable-container">
		<table id = "datatablesSimple" class="table table-sm m-3">
		<thead class="table-light">
		<tr>
			<th>순위</th>
			<th>ID</th>
			<th>닉네임</th>
			<th>작성 수</th>
		</tr>
		</thead>
		<tbody>
			<c:forEach var ="r" items="${reply }">
				<tr>
					<td>${r.rank }위</td>
					<td>${r.memberId }</td>
					<c:if test="${empty r.memberSeq }">
					<!-- on delete set null로 회원이 null로 바뀔 경우 -->
					<td>탈퇴회원</td>
				</c:if>
				
				<c:if test="${!empty r.memberSeq }">
					<!-- 회원의 닉네임이 있을 경우 -->
				<td><div class="dropdown">
					<a href="" class="dropdown-toggle" type="button" id="dropdownMenuButton1" data-bs-toggle="dropdown" aria-expanded="false">${r.memberNickname}</a>
						<ul class="dropdown-menu" aria-labelledby="dropdownMenuButton1">
							<li><a class="dropdown-item" href="${pageContext.request.contextPath }/board/memberArticle?memberSeq=${r.memberSeq}">게시물 보기</a></li>
							<li><a class="dropdown-item" href="${pageContext.request.contextPath }/diary/list/${r.memberSeq}">Diary 보기</a></li>
			   				<li><a class="dropdown-item" href="#" onClick="popUpInfo(${r.memberSeq});">회원 정보 보기</a></li>								
			   			</ul>
					</div>
				</td>
				</c:if>
				<td>${r.count }개</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	</div>
	<svg xmlns="http://www.w3.org/2000/svg" width="40" height="40" style="padding-bottom : 11px;" fill="currentColor" class="bi bi-caret-right-fill" viewBox="0 0 16 16">
  <path d="m12.14 8.753-5.482 4.796c-.646.566-1.658.106-1.658-.753V3.204a1 1 0 0 1 1.659-.753l5.48 4.796a1 1 0 0 1 0 1.506z"/>
	</svg>
	
	<h4 style="display : inline-block;">일기 수  랭킹</h4>
	<div class="dataTable-container">
		<table id = "datatablesSimple" class="table table-sm m-3">
		<thead class="table-light">
		<tr>
			<th>순위</th>
			<th>ID</th>
			<th>닉네임</th>
			<th>작성 수</th>
		</tr>
		</thead>
		<tbody>
			<c:forEach var ="r" items="${diary }">
				<tr>
					<td>${r.rank }위</td>
					<td>${r.memberId }</td>
					<c:if test="${empty r.memberSeq }">
					<!-- on delete set null로 회원이 null로 바뀔 경우 -->
					<td>탈퇴회원</td>
				</c:if>
				
				<c:if test="${!empty r.memberSeq }">
					<!-- 회원의 닉네임이 있을 경우 -->
				<td><div class="dropdown">
					<a href="" class="dropdown-toggle" type="button" id="dropdownMenuButton1" data-bs-toggle="dropdown" aria-expanded="false">${r.memberNickname}</a>
						<ul class="dropdown-menu" aria-labelledby="dropdownMenuButton1">
							<li><a class="dropdown-item" href="${pageContext.request.contextPath }/board/memberArticle?memberSeq=${r.memberSeq}">게시물 보기</a></li>
							<li><a class="dropdown-item" href="${pageContext.request.contextPath }/diary/list/${r.memberSeq}">Diary 보기</a></li>
			   				<li><a class="dropdown-item" href="#" onClick="popUpInfo(${r.memberSeq});">회원 정보 보기</a></li>								
			   			</ul>
					</div>
				</td>
				</c:if>					<td>${r.count }개</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	</div>
	
	</div>
						<script type="text/javascript">
								function popUpInfo(seq){
									let url = "${pageContext.request.contextPath}/member/popup?memberSeq="+seq;
									let name = "Member 정보";
									let specs = "height=350, width= 300, status = no, location= no, top=100, left=100";
									window.open(url, name, specs);}
								</script>
</body>
</html>