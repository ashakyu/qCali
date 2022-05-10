<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">

<meta charset="UTF-8">

<style>
thead {
	display: table-header-group;
	vertical-align: middle;
	border-color: inherit;
	background: #e9ecef;
}
</style>

<title>QCali :: 일기장</title>
</head>
<body class = "sb-nav-fixed">
<jsp:include page="/WEB-INF/views/main/header.jsp"></jsp:include>
<jsp:include page="/WEB-INF/views/main/sidebar_board.jsp"></jsp:include>

<div class="container mt-5">
		<div class="row">
			<div class="col">
				<h3>${diaryNickname} 님의 일기장</h3>			
			</div>
			</div>
			<div class="col-2">		

			
		</div>

	<table class="table table-hover">
	<caption style="caption-side : top; text-align:right;">등록된 일기 수 : ${diaryTotal }개</caption>
	
		<thead>
		<tr>
			<th scope="col">글번호</th>
			<th scope="col">제목</th>
			<th scope="col">닉네임</th>
			<th scope="col">작성일</th>
			<th scope="col">좋아요</th>
			<th scope="col">조회수</th>
			<th scope="col">공개여부</th>
		</tr>
		</thead>
	
		<c:if test="${ empty diaryList}">
			<tr>
				<td colspan="7">게시판에 저장된 글이 없습니다.</td>
			</tr>
		</c:if>

		<c:if test="${ !empty diaryList}">
			<c:forEach var="list" items="${diaryList}">
				
				<tr>
					<td scope="row">${list.rn}</td>
						<c:if test="${memberLogin.memberSeq == testMemberSeq}" >
					<td><a href="<c:url value='/diary/detail?diarySeq=${list.diarySeq}'/>">${list.diaryTitle}</a>
					</td>
					<td>${list.memberNickname}</td>
					<td>${list.diaryRegday}</td>
					<td>${list.diaryLike}</td>
					<td>${list.diaryCount}</td>
					<c:if test="${list.diaryOpen eq 'T' }">
						<td>공개글</td>
					</c:if>
					<c:if test="${list.diaryOpen eq 'F' }">
						<td>비공개글</td>
					</c:if>
					
					</c:if>
					
					<c:if test="${memberLogin.memberSeq != testMemberSeq}" >
					<c:if test="${list.diaryOpen eq 'F' }" >
					<td colspan="6">비공개 글입니다.</td>
					</c:if>
					<c:if test="${list.diaryOpen eq 'T' }" >
						<td><a href="<c:url value='/diary/detail?diarySeq=${list.diarySeq}'/>">${list.diaryTitle}</a>
					</td>
					<td>
						<div class="dropdown">
						<a href="#" class="dropdown-toggle" type="button" id="dropdownMenuButton1" data-bs-toggle="dropdown" aria-expanded="false"> ${list.memberNickname}</a>
							<ul class="dropdown-menu" aria-labelledby="dropdownMenuButton1">
								<li><a class="dropdown-item" href="${pageContext.request.contextPath }/board/memberArticle?memberSeq=${list.memberSeq}">게시물 보기</a></li>
								<li><a class="dropdown-item" href="${pageContext.request.contextPath }/diary/list/${list.memberSeq}">Diary 보기</a></li>
								<li><a class="dropdown-item" href="#" onClick="popUpInfo();">회원 정보 보기</a></li>
							</ul>
						</div>
					</td>
					<td>${list.diaryRegday}</td>
					<td>${list.diaryLike}</td>
					<td>${list.diaryCount}</td>
					<td>${list.diaryOpen}</td>
					</c:if>
					</c:if>					
				</tr>
					<script type="text/javascript">
						function popUpInfo() {
							let url = "${pageContext.request.contextPath}/member/popup?memberSeq=${list.memberSeq}";
							let name = "Member 정보";	
							let popupX = (window.screen.width / 2) - (300 / 2);
							let popupY= (window.screen.height / 2) - (350 / 2);
							let specs = 'height=350, width= 300, toolbar=no, status=no, menubar=no, resizable=yes, location=no, left='+ popupX + ', top='+ popupY;
							window.open(url, name, specs);
						}
					</script>
				
			</c:forEach>
		</c:if>
	</table>
				<c:if test="${!empty memberLogin}">
				<c:set var ="memberLogin.memberSeq" value="${memberLogin.memberSeq}"/>
				<c:set var ="testMemberSeq" value="${testMemberSeq}"/>			
				<c:if test="${memberLogin.memberSeq == testMemberSeq}">
					<a href="<c:url value='/diary/write/${memberLogin.memberSeq}'/>"><button class="btn btn-outline-info" style="float:right;">일기쓰기</button></a>
				</c:if>
				<c:if test="${memberLogin.memberSeq != testMemberSeq}">
					<a href="<c:url value='/diary/list/${memberLogin.memberSeq}'/>"><button class="btn btn-outline-info" style="float:right;">내 일기장 가기</button></a>
				</c:if>
			</c:if>			
			<nav aria-label="Page navigation example">
				<ul class="pagination justify-content-center">
			    <c:if test="${pageMaker.prev}">
			    	<li class="page-item"><a class="page-link" href="${pageMaker.makeQuery(pageMaker.startPage - 1)}">이전</a></li>
			    </c:if> 
			
			    <c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="idx">
			    	<li class="page-item"><a class="page-link" href="${pageMaker.makeQuery(idx)}">${idx}</a></li>
			    </c:forEach>
			
			    <c:if test="${pageMaker.next && pageMaker.endPage > 0}">
			    	<li class="page-item"><a class="page-link" href="${pageMaker.makeQuery(pageMaker.endPage + 1)}">></a></li>
			    </c:if>  
			  </ul>
		</nav>
</div>
</body>
</html>
