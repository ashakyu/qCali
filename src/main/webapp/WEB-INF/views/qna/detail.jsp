<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="<c:url value='/resources/static/css/dropdown.css'/> "
	rel="stylesheet" type="text/css">
<style>
table {
	width: 50%;
	float:right;
}
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
<title>QCali :: 문의사항 </title>
</head>
<body class="sb-nav-fixed">
<header>
	<jsp:include page="/WEB-INF/views/main/header.jsp"></jsp:include>
	<jsp:include page="/WEB-INF/views/main/sidebar_board.jsp"></jsp:include>
</header>

	
	<div class="container mt-3">
		<h2>Q&A 문의 내용</h2>
	<br>
	
	<div class="shadow-none p-3 mb-5 bg-light rounded" style="border: 1px solid lightgrey;">
		<c:if test="${vo.qnaIndent == 0 }">
		<h4 class="fw-bolder">문의 제목 : ${vo.qnaTitle }</h4>
		</c:if>
		<c:if test="${vo.qnaIndent == 1 }">
		<h4 class="fw-bolder">답변 제목 : ${vo.qnaTitle }</h4>
		</c:if>
	</div>
		
	
	<table class="table" width="200px">
		<thead>
		<tr>
			<th>작성자</th>
			<c:if test="${! empty vo.qnaWriter  }">
				<td>${vo.qnaWriter }</td>
			</c:if>
			<c:if test="${empty vo.qnaWriter }">
				<c:if test="${!empty vo.memberNickname }">
				<td><div class="dropdown">
					<a href="" class="dropdown-toggle" type="button" id="dropdownMenuButton1" data-bs-toggle="dropdown" aria-expanded="false">${vo.memberNickname}</a>
						<ul class="dropdown-menu" aria-labelledby="dropdownMenuButton1">
							<li><a class="dropdown-item" href="${pageContext.request.contextPath }/board/memberArticle?memberSeq=${vo.memberSeq}">게시물 보기</a></li>
							<li><a class="dropdown-item" href="${pageContext.request.contextPath }/diary/list/${vo.memberSeq}">Diary 보기</a></li>
			   				<li><a class="dropdown-item" href="#" onClick="popUpInfo();">회원 정보 보기</a></li>								
			   			</ul>
					</div>
				</td>

				<script type="text/javascript">
					function popUpInfo(){
						let url = "${pageContext.request.contextPath}/member/popup?memberSeq=${vo.memberSeq}";
						let name = "Member 정보";
						let specs = "height=350, width= 300, status = no, location= no";
						window.open(url, name, specs);}
				</script>
						
				</c:if>
				<c:if test="${empty vo.memberSeq}">
					<td>탈퇴한 회원</td>
				</c:if>
			</c:if>

			<th>작성일자</th>
			<td>${vo.qnaRegDay }</td>

			<th>조회수</th>
			<td>${vo.qnaReadcnt }</td>
		</tr>
	</table>

	
	<div class="shadow-none p-3 mb-5 bg-light rounded" style="border:1px solid lightgrey;">
		${vo.qnaContent }	
	</div>
	
	<div class="input-group" style="width: auto;">
			<span class="input-group-text">첨부 파일</span>
		<c:if test="${!empty vo.qnaFileName }">
			<a class="form-control" href="<c:url value='/qna/download?qnaSeq=${vo.qnaSeq}'/>">
			${vo.qnaFileName } </a>
		</c:if>	
	</div>			
	
	<br>
	<c:if test="${!empty admin }">
		<c:if test="${ vo.qnaIndent == 0}">
			<button type="button" class="btn btn-dark m-1" style="float:right;"
			onClick="location.href='${pageContext.request.contextPath}/qna/reply?qnaSeq=${vo.qnaSeq }'">답글쓰기 
			</button>
		</c:if>

		<button type="button" class ="btn btn-outline-dark m-1" 
		onclick="deleteConfirm();"style="float:right;">글 삭제</button>

		<button type="button" class="btn btn-outline-dark m-1" style="float:right;"
		onclick="location.href='${pageContext.request.contextPath}/qna/modify?qnaSeq=${vo.qnaSeq }'">글 수정</button>

	</c:if>

	<c:if test="${!empty member }">
		<button type="button" class ="btn btn-dark m-1" 
		onclick="deleteConfirm();"style="float:right;">글 삭제</button>
		<button type="button" class="btn btn-outline-dark m-1" style="float:right;"
		onclick="location.href='${pageContext.request.contextPath}/qna/modify?qnaSeq=${vo.qnaSeq }'">글 수정</button>
	</c:if>
	</div>
	
<script>
	function deleteConfirm(){
		if(!confirm("정말 삭제하시겠습니까?")){
			return false;
		}
		else{
			location.href="<c:url value='/qna/delete?qnaSeq='/>"+${vo.qnaSeq};
		}
	}
</script>

<jsp:include page="/WEB-INF/views/main/footer.jsp"></jsp:include>

</body>
</html>