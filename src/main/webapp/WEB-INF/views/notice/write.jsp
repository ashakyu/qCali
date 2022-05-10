<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<title>공지 사항 글 쓰기</title>
<!-- jQuery -->
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<!-- bootstrap css -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<script type="text/javascript" src="<c:url value="/resources"/>/static/js/ckeditor/ckeditor.js"></script>

<link href="<c:url value='/resources/static/css/button.css'/> "
	rel="stylesheet" type="text/css">
</head>
<body>
	<jsp:include page="/WEB-INF/views/main/header.jsp"></jsp:include>
	<jsp:include page="/WEB-INF/views/main/sidebar_board.jsp"></jsp:include>
	
	<div class="container"">
	<table class="table table-sm caption-top">
		<caption>공지사항    |  글쓰기</caption>
	</table>

	<form action="<c:url value='/notice/write' /> " method="post" name="writeForm" onsubmit="return nullCheck()">
			<div class="form-group">
      			<label for="noticeTitle" class="form-label mt-4">제목</label>
      			<input type="text" class="form-control" name="noticeTitle" id="noticeTitle" size="30" maxlength="50"/>
    		</div>
			
			<div class="form-group">
      			<label for="noticeContent" class="form-label mt-4">내용</label>
      			<textarea class="form-control" name="noticeContent" id="noticeContent"></textarea>
    		</div>
    		
    		<div class="form-group">
      			<label for="formFile" class="form-label mt-4"></label>
      			<input class="form-control" type="file" name="formFile" id="formFile">
      			<script>CKEDITOR.replace('noticeContent', {
      				height:400,
      				filebrowserUploadUrl:'${pageContext.request.contextPath}/notice/fileupload'});</script>
    		</div><br>
			
			<div style="margin-top:2%; padding-left:20%; float:right;">
  				<button type="submit" class="w-btn w-btn-green">등록하기</button>
  				<input type="button" value="돌아가기" class="w-btn w-btn-green" onclick="location.href='<c:url value="/notice/list"/>'">
			</div>
	</form>
	<script>
		function nullCheck() {
			if (writeForm.noticeTitle.value == "") {
				alert("제목을 입력해주세요.");
				writeForm.noticeTitle.focus();
					return false;
			} else if (writeForm.noticeContent.value == "") {
				alert("내용을 입력해주세요.");
				writeForm.noticeContent.focus();
					return false;
			}
		}
	</script>
	</div>
  </body>
</html>