<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Q&A reply</title>
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
	
</head>
<body class="sb-nav-fixed">
	<jsp:include page="/WEB-INF/views/main/header.jsp"></jsp:include>
	<jsp:include page="/WEB-INF/views/main/sidebar_board.jsp"></jsp:include>
	
	<form class="container mt-3" action="<c:url value='/qna/reply' />" method="POST" enctype="multipart/form-data"> 
		<input type="hidden" name="qnaRoot" value="${vo.qnaRoot }" />
		<input type="hidden" name="qnaStep" value="${vo.qnaStep }" />
		<input type="hidden" name="qnaIndent" value="${vo.qnaIndent }" />
		
	<input class="form-control form-control-lg" placeholder="제목" type="text" name="qnaTitle"
		aria-label=".form-control-lg example" />
		
		<br>
		
	<textarea rows="50" cols="50" name="qnaContent" style="resize: none;"></textarea>
	<script>CKEDITOR.replace('qnaContent', {height:400, filebrowserUploadUrl:'${pageContext.request.contextPath}/qna/fileupload'});</script>
		
		<br>
		
		<div class="mb-3">
			<input class="form-control" type="file" name="uploadfile" />
		</div>
	
	<button type="submit" class="w-btn w-btn-green" style="float: right;">답변하기</button>
	</form>

</body>
</html>