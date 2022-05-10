<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>QCali :: Q&A 글쓰기</title>
<script type="text/javascript"
	src="<c:url value='/resources/'/>static/js/ckeditor/ckeditor.js"></script>
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
	<script>
	
		function nullCheck(){
			var title = document.writeForm.qnaTitle.value;
				var titletrim = title.trim();
			var content = 	CKEDITOR.instances.qnaContent.getData();
			var contenttrim = content.trim();
			if(titletrim == ""){
				alert("제목을 입력해주세요.");
				writeForm.qnaTitle.focus();
				return false;
			}else if(CKEDITOR.instances.qnaContent.getData() == '' || CKEDITOR.instances.qnaContent.getData().length == 0){
				alert("내용을 입력해주세요.");
				CKEDITOR.instances.qnaContent.focus();
				return false;
			}else if(contenttrim == ''){
				alert("내용을 입력해주세요.");
				CKEDITOR.instances.qnaContent.focus();
				return false;

			}
		}
	</script>
</head>
<body class="sb-nav-fixed">
	<jsp:include page="/WEB-INF/views/main/header.jsp"></jsp:include>
	<jsp:include page="/WEB-INF/views/main/sidebar_board.jsp"></jsp:include>

	<div class="container mt-3">
	<h2 class="m-3">문의하기</h2>

<!-- 파일 첨부 시 form 태그의 필요 속성 1. 반드시 method가 post 2. enctype을 지정 ▶ enctype='multipart/form-data' --> 
	<form class="container mt-3" action="<c:url value='/qna/write' />" method="POST" enctype="multipart/form-data"
	name ="writeForm" onsubmit="return nullCheck()" >
	
		<input class="form-control form-control-lg" placeholder="제목" type="text" name="qnaTitle" required
		aria-label=".form-control-lg example" />
	<br>
	<textarea rows="50" cols="50" name="qnaContent" style="resize: none;" required></textarea>
			<script>CKEDITOR.replace('qnaContent',{height: 400, filebrowserUploadUrl:'${pageContext.request.contextPath}/qna/fileupload'});</script>
		<br>
		<div class="mb-3">
			<input class="form-control" type="file" name="uploadfile" />
		</div>

	<button type="submit" class="btn btn-secondary" style="float: right;">문의하기</button>

</form>
</div>
</body>
</html>