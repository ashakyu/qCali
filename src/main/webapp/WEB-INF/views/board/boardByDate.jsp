<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8" name="viewport"
	content="width=device-width, initial-scale=1">
<%--질문 출력 css --%>
<link href="<c:url value='/resources/static/css/question.css'/> "
	rel="stylesheet" type="text/css">
<link href="<c:url value='/resources/static/css/styles.css'/> " rel="stylesheet" type="text/css">
<title>QCali :: BoardList By Date</title>
</head>
<body>
	<jsp:include page="/WEB-INF/views/main/header.jsp"></jsp:include>
	<jsp:include page="/WEB-INF/views/main/sidebar_board.jsp"></jsp:include>

	<div class="container">

	<br>
	<h2>${date}일 게시글</h2>
	<br>

			<%-- 검색 bar --%>
			<div class="search row">
				<div class="col-xs-2 col-sm-2">
					<form action="<c:url value='/board/search'/>">

						<select name="searchOption" class="form-select form-select-sm"
							aria-label=".form-select-sm example">
							<option value="boardTitle">제목</option>
							<option value="memberNickname">닉네임</option>
						</select>
				</div>
				<div class="col-xs-10 col-sm-10">
					<div class="input-group">
						<input type="text" name="searchWord" placeholder="SEARCH"
							class="form-control" /> <span class="input-group-btn"> <input
							type="submit" value="검색" class="btn btn-default" />
						</span>
					</div>
					</form>
				</div>
			</div>

			<%--게시글 부븐 --%>

			<br>

			<figure>
				<a href="${pageContext.request.contextPath }/board/list">전체 목록
					최신순&nbsp;</a>
				<a href="${pageContext.request.contextPath }/board/todayArticle">&nbsp;
					오늘 올라온 글 보기</a>
			</figure>
			<figure class="text-end">

				<figcaption class="blockquote-footer">게시글 수 :
					${boardTotal }</figcaption>
			</figure>


			<table class="table table-hover">
				<thead>
					<tr>
						<th>NO</th>
						<th>TITLE</th>
						<th>작성자</th>
						<th>좋아요</th>
						<th>조회수</th>
					</tr>
				</thead>

				<c:if test="${ empty boardList}">
					<tr>
						<td colspan="7">게시판에 저장된 글이 없습니다.</td>
					</tr>
				</c:if>

				<c:if test="${ !empty boardList}">
					<c:forEach var="list" items="${boardList}">
						<tr>
							<td>${list.rn}</td>

							<td><a
								href="<c:url value='/board/detail?boardSeq=${list.boardSeq}'/>">${list.boardTitle}</a>

							</td>
							<c:if test="${empty list.memberSeq }"> <td>탈퇴 회원</td> </c:if> 
							<c:if test="${!empty list.memberSeq }">
								<td><div class="dropdown">
									<a href="" class="dropdown-toggle" type="button" id="dropdownMenuButton1" data-bs-toggle="dropdown" aria-expanded="false">${list.memberNickname}</a>
										<ul class="dropdown-menu" aria-labelledby="dropdownMenuButton1">
											<li><a class="dropdown-item" href="${pageContext.request.contextPath }/board/memberArticle?memberSeq=${list.memberSeq}">게시물 보기</a></li>
											<li><a class="dropdown-item" href="${pageContext.request.contextPath }/diary/list/${list.memberSeq}">Diary 보기</a></li>
							   				<li><a class="dropdown-item" href="#" onClick="popUpInfo();">회원 정보 보기</a></li>								
							   			</ul>
									</div>
								</td> </c:if>
							<td>${list.boardLike}</td>
							<td>${list.boardCount}</td>
						</tr>
						<script type="text/javascript">
							function popUpInfo(){
								let url = "${pageContext.request.contextPath}/member/popup?memberSeq=${list.memberSeq}";
								let name = "Member 정보";
								let specs = "height=350, width= 300, status = no, location= no, top=100, left=100";
								window.open(url, name, specs);
							}
						</script>
					</c:forEach>

				</c:if>
			</table>
			<nav aria-label="Page navigation example">
				<ul class="pagination justify-content-center">
					<c:if test="${pageMaker.prev}">
						<li class="page-item"><a class="page-link"
							href="listDay${pageMaker.makeQuery(pageMaker.startPage - 1)}&date=${date}">이전</a></li>
					</c:if>

					<c:forEach begin="${pageMaker.startPage}"
						end="${pageMaker.endPage}" var="idx">
						<li class="page-item"><a class="page-link"
							href="listDay${pageMaker.makeQuery(idx)}&date=${date}">${idx}</a></li>
					</c:forEach>

					<c:if test="${pageMaker.next && pageMaker.endPage > 0}">
						<li class="page-item"><a class="page-link"
							href="listDay${pageMaker.makeQuery(pageMaker.endPage + 1)}&date=${date}">다음</a></li>
					</c:if>
				</ul>
			</nav>

		</div>
<jsp:include page="/WEB-INF/views/main/footer.jsp"></jsp:include>

</body>
</html>