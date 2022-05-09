<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<style>
body {
	background-color: #f5f5f5;
	margin: 0 auto;
	padding: 0;
}

.list {
	color: #555;
	font-size: 15px;
	padding: 0 !important;

	font-family: courier, monospace;
	border: 1px solid #dedede;
}

.list li {
	list-style: none;
	border-bottom: 1px dotted #ccc;
	text-indent: 25px;
	height: auto;
	padding: 10px;
	text-transform: none;
}

.list li:hover {
	background-color: #f0f0f0;
	-webkit-transition: all 0.2s;
	-moz-transition: all 0.2s;
	-ms-transition: all 0.2s;
	-o-transition: all 0.2s;
}

.lines {
	border-left: 1px solid #ffaa9f;
	border-right: 1px solid #ffaa9f;
	width: 2px;
	float: left;
	height: 250px;
	margin-left: 40px;
}

h4 {
	color: #add8e6;
	font-size: 20px;
	letter-spacing: -2px;
	text-align: center;
}
</style>


<title>MemberPopup</title>
</head>
<body>
	<h4>${info.memberNickname }님의 정보 <br><br><a href="${pageContext.request.contextPath }/diary/list/${info.memberSeq}" target = "_blank">
		<svg xmlns="http://www.w3.org/2000/svg" width="25" height="25" fill="currentColor" class="bi bi-journal-richtext" viewBox="0 0 16 16">
	  <path d="M7.5 3.75a.75.75 0 1 1-1.5 0 .75.75 0 0 1 1.5 0zm-.861 1.542 1.33.886 1.854-1.855a.25.25 0 0 1 .289-.047L11 4.75V7a.5.5 0 0 1-.5.5h-5A.5.5 0 0 1 5 7v-.5s1.54-1.274 1.639-1.208zM5 9.5a.5.5 0 0 1 .5-.5h5a.5.5 0 0 1 0 1h-5a.5.5 0 0 1-.5-.5zm0 2a.5.5 0 0 1 .5-.5h2a.5.5 0 0 1 0 1h-2a.5.5 0 0 1-.5-.5z"/>
  	<path d="M3 0h10a2 2 0 0 1 2 2v12a2 2 0 0 1-2 2H3a2 2 0 0 1-2-2v-1h1v1a1 1 0 0 0 1 1h10a1 1 0 0 0 1-1V2a1 1 0 0 0-1-1H3a1 1 0 0 0-1 1v1H1V2a2 2 0 0 1 2-2z"/>
  	<path d="M1 5v-.5a.5.5 0 0 1 1 0V5h.5a.5.5 0 0 1 0 1h-2a.5.5 0 0 1 0-1H1zm0 3v-.5a.5.5 0 0 1 1 0V8h.5a.5.5 0 0 1 0 1h-2a.5.5 0 0 1 0-1H1zm0 3v-.5a.5.5 0 0 1 1 0v.5h.5a.5.5 0 0 1 0 1h-2a.5.5 0 0 1 0-1H1z"/>
	</svg></a></h4>
	
<div class="lines"></div>	
		<ul class="list">

			<li>Id  ${info.memberId }</li>
			<li>닉네임  ${info.memberNickname }</li>
			<li>가입일   ${info.memberRegDay }</li>
			<li>생일   ${info.memberBirthDay }</li>
			<li>Level  ${info.memberLevel }</li>
			
			
		</ul>
		
	
	

</body>
</html>