<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" name="viewport" content="width=device-width, initial-scale=1">
<title>QCali :: boardEditForm</title>

<!-- Bootstrap CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
	crossorigin="anonymous">
<!-- Option 1: Bootstrap Bundle with Popper -->
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
	crossorigin="anonymous"></script>
	

<script type="text/javascript"
	src="<c:url value="/resources"/>/static/js/ckeditor/ckeditor.js"></script>
</head>
<body>

	<jsp:include page="/WEB-INF/views/main/header.jsp"></jsp:include>
	<jsp:include page="/WEB-INF/views/main/sidebar_board.jsp"></jsp:include>
	<br><br>
	<article>

	<div class="container">
	
	<c:if test="${!empty memberLogin}">

	<form:form commandName="boardEditData">
		<div class="mb-3">
				<input name="boardTitle" value="${ articleInfo.boardTitle}" class="form-control"/> 
				<form:errors path="boardTitle" />
				</div>
				<br>
				<div class="mb-3">
	
				<textarea name="boardContent" id="boardContent" class="form-control"> ${ articleInfo.boardContent }</textarea>
						<script type="text/javascript">	
			CKEDITOR.replace('boardContent', {height:400},
			{filebrowserUploadUrl:'${pageContext.request.contextPath}/board/ckUpload'
			});
		</script>
				
				<form:errors path="boardContent" /></div>

		<div class="d-grid gap-2 d-md-flex justify-content-md-end">
		<input type="submit" value="수정하기" class="btn btn-default"/>
		</div>
	</form:form>

	</c:if>
</div>
</article>
<jsp:include page="/WEB-INF/views/main/footer.jsp"></jsp:include>
<c:if test="${empty memberLogin}">
		
		    <script>

	alert("로그인인 해주세요.");
	document.location.href="<c:url value='/main'/>";
</script>
		
		
		</c:if>
</body>
</html>