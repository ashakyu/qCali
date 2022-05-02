<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" name="viewport" content="width=device-width, initial-scale=1">
<title>Insert title here</title>

<script type="text/javascript"
	src="<c:url value="/resources"/>/static/js/ckeditor/ckeditor.js"></script>
</head>
<body>
<jsp:include page="/WEB-INF/views/main/header.jsp"></jsp:include>
<jsp:include page="/WEB-INF/views/main/sidebar_board.jsp"></jsp:include>
<div class="container">
	<form:form commandName="boardEditData">
		<table border="1">
			<tr>
				<td>제목</td>
				<td><input name="boardTitle" value="${ articleInfo.boardTitle}"/> 
				<form:errors path="boardTitle" /></td>

			</tr>
			<tr>
				<td>내용</td>
				<td><textarea name="boardContent" id="boardContent"> ${ articleInfo.boardContent }</textarea>
						<script type="text/javascript">	
			CKEDITOR.replace('boardContent',
			{filebrowserUploadUrl:'${pageContext.request.contextPath}/board/ckUpload'
			});
		</script>
				
				<form:errors path="boardContent" /></td>

			</tr>
		</table>

		
		<input type="submit" value="수정하기" />
	</form:form>
</div>
</body>
</html>