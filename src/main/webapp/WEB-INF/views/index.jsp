<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
<title>QCali :: 마음을 건들이다</title>
<script src="https://use.fontawesome.com/releases/v6.1.0/js/all.js" crossorigin="anonymous"></script>
<link rel="preconnect" href="https://fonts.gstatic.com" />
<link href="https://fonts.googleapis.com/css2?family=Tinos:ital,wght@0,400;0,700;1,400;1,700&amp;display=swap" rel="stylesheet" />
<link href="https://fonts.googleapis.com/css2?family=DM+Sans:ital,wght@0,400;0,500;0,700;1,400;1,500;1,700&amp;display=swap" rel="stylesheet" />
        <!-- Core theme CSS (includes Bootstrap)-->
<link href="<c:url value='/resources/static/css/indexstyles.css'/>" rel="stylesheet" />
</head>
<body>

	<video class="bg-video" playsinline="playsinline" autoplay="autoplay" muted="muted" loop="loop"><source src="<c:url value='resources/static/video/odengcute.mp4'/>" type="video/mp4" /></video>
	      <div class="masthead">
	      
            <div class="masthead-content text-white">
            	      <a href="${pageContext.request.contextPath }/admin/login">관리자 계정</a>               
            
                <div class="container-fluid px-5 px-lg-0">
                    <h1 class="fst-italic lh-2 mb-2">Once a day,<br>
                    Write<br>your daily Life..</h1>
						<p class="mb-5"> <strong>QCali</strong>는 Question의 Calendar의 합성어입니다.<br>당신으의 마음을 편히 털어 놓을 수 있습니다.<br> 하루에 한 번 일상의 소중함을 기록하세요!</p>

                            </div>
                        <div class="container">
                        
                        <c:if test="${memberLogin == null }">
                        
                        
                         <button class="btn btn-primary" id="submitButton" type="submit" style="float: right; padding-right:10;"
                            onclick="location.href='${pageContext.request.contextPath}/member/insert'">시작하기</button>
                    
                         <button class="btn btn-primary" id="submitButton" type="submit" style="float: right; padding-left: 10;"
                            onclick="location.href='${pageContext.request.contextPath}/member/login'">Login</button>
                         </c:if>
                         
                       <c:if test="${memberLogin != null }">
                         <button class="btn btn-primary" id="submitButton" type="submit" style="float: right; padding-right:10;"
                            onclick="location.href='${pageContext.request.contextPath}/board/todayArticle'">오늘 올라온 글 보기</button>
                    
                         <button class="btn btn-primary" id="submitButton" type="submit" style="float: right; padding-left: 10;"
                            onclick="location.href='${pageContext.request.contextPath}/member/logout'">Logout</button>
                         </c:if>
                       
                         </div>
                     
                      
                      </div>
                     
                </div>
       
       
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
        <script src="<c:url value='/resources/static/js/indexscripts.js'/>"></script>
        <script src="https://cdn.startbootstrap.com/sb-forms-latest.js"></script>
                                         
</body>
</html>