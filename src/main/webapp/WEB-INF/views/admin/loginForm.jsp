<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>LoginForm</title>
</head>
<body>
	<jsp:include page="/WEB-INF/views/admin/main/adminHeader.jsp"></jsp:include>

		<form:form commandName = "AdminLoginCommand">
			<p>
				<label>
					이메일 입력
					<form:input path="adminId"/>
					<form:errors path="adminId"/>
				</label>
			</p>
			<p>
				<label>
					비밀번호 입력
					<form:password path="adminPassword"/>
					<form:errors path="adminPassword"/>
				</label>
			</p>
		<input type="submit" value="로그인하기">
		</form:form>
</body>
</html>