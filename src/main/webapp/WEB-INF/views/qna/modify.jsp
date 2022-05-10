<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Q&A 수정</title>
<script type="text/javascript"
	src="<c:url value='/resources/static/js/ckeditor/ckeditor.js'/>"></script>
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
<link href="<c:url value='/resources/static/css/button.css'/> "
	rel="stylesheet" type="text/css">
<link href="https://cdn.jsdelivr.net/npm/simple-datatables@latest/dist/style.css" rel="stylesheet" />
<script src="https://use.fontawesome.com/releases/v6.1.0/js/all.js" crossorigin="anonymous"></script>
<link href="<c:url value='/resources/static/css/styles.css'/> "
	rel="stylesheet" type="text/css">

	<script>
		function nullCheck(){
			if(updateForm.qnaTitle.value==""){
				alert("제목을 입력해주세요.");
				updateForm.qnaTitle.focus();
				return false;
			}else if(updateForm.qnaContent.value==""){
				alert("내용을 입력해주세요.");
				updateForm.qnaContent.focus();
				return false;
			}
		}
	</script>

</head>
<body class="sb-nav-fixed">
<header>
	<jsp:include page="/WEB-INF/views/main/header.jsp"></jsp:include>
	<jsp:include page="/WEB-INF/views/main/sidebar_board.jsp"></jsp:include>
</header>
	<div class="container mt-3">
	<h2 class="m-3">문의하기</h2>
	
	<form class="container mt-3" action="${pageContext.request.contextPath }/qna/modify?qnaSeq=${vo.qnaSeq }" method="POST"
	 enctype="multipart/form-data" name="updateForm" onsubmit="return nullCheck()">
		<input type="hidden" name="qnaSeq" value=${vo.qnaSeq } />
		<input type="hidden" name="attach" />
		
		<input class="form-control form-control-lg" placeholder="제목" type="text" name="qnaTitle"
		aria-label=".form-control-lg example" value="${vo.qnaTitle }" />
		
		<br>
		
		<textarea rows="50" cols="50" name="qnaContent" style="resize: none;">${vo.qnaContent }</textarea>
		<script>CKEDITOR.replace('qnaContent', {height:400, filebrowserUploadUrl:'${pageContext.request.contextPath}/qna/fileupload'});</script>
		<br>
		
		<div class="mb-3">
			<input class="form-control" type="file" name="uploadfile" />
		</div>
		
		<button type="submit" class="w-btn w-btn-green" style="float: right;">수정하기</button>
		&nbsp;&nbsp;
		<button type="button" class="w-btn w-btn-green" style="float: right;"
		onclick="location.href='${pageContext.request.contextPath }/qna/detail?qnaSeq=${vo.qnaSeq }'">취소</button>
		
	</form>
	
	</div>
<jsp:include page="/WEB-INF/views/main/footer.jsp"></jsp:include>

</body>
</html>