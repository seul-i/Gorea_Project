<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	body{
		font-family:"montserrat",sans-serif;
		overflow: hidden;
	}
	
	.container_error{
		width: 100%;
		height: 70vh;
		position : relative;
		text-align: center;
		color: #343434;

	}

	.container_error h1{
		font-size: 160px;
		margin: 0;
		font-weight: 900;
		letter-spacing: 20px;
		background: url(/img/main/gang.jpg) center no-repeat;
		-webkit-text-fill-color: transparent;
		-webkit-background-clip: text;
	}
	
	.container_error h4{
		font-size: 25px;
		margin-bottom: 30px;
	}
	
	.container_error a{
		text-decoration: none;
		background: #007DC3;
		color: #fff;
		padding: 12px 24px;
		display: inline-block;
		border-radius: 25px;
		font-size: 14px;
	}
	
	footer{
		display:none;
	}
	
</style>
</head>
<body>
<jsp:include page="/WEB-INF/views/korean/includes/header.jsp"></jsp:include>
<div class="container_error">
	<br/>
	<h1>ERROR</h1>
	<h4>해당 페이지를 찾을수 없거나, 잘못된 요청의 접근 입니다</h4>
	<h4>The record for finding the page is an invalid request for access.</h4>
	<h4>このページが見つからないか、間違ったリクエストへのアクセスです</h4>
	<h4>无法找到此页面或访问错误请求 。</h4>
	<a href="/intro.do">Go IntroPage</a>
	<a href="javascript:history.back();">Go BackPage</a>
</div>
<jsp:include page="/WEB-INF/views/korean/includes/footer.jsp"></jsp:include>
</body>
</html>