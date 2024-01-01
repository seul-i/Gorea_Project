<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="robots" content="index, follow, max-image-preview:large, max-snippet:-1, max-video-preview:-1">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="/css/main/Main.css">
<title>Go!rea Main</title>

<script type="text/javascript" src="/js/main/jquery.min.js"></script>
<script type="text/javascript" src="/js/main/skel.min.js"></script>
<script type="text/javascript" src="/js/main/main.js"></script>
</head>

<body>
	
	<jsp:include page="/WEB-INF/views/english/includes/header.jsp"></jsp:include>
		
		<section class="banner half">
			<article>
				<img src="/img/main/DDP.jpg" width="1440" height="961">
					<div class="inner">
						<header>
<!-- 							<h4 style="font-weight:bold;">역사와 현대가 공존하는 문화와 쇼핑의 중심지</h4> -->
							<h2 style="font-weight:bold;">Dongdaemun</h2>
						</header>
					</div>
			</article>
			
			<article>
				<img src="/img/main/gangnam.jpg" width="1440" height="961">
					<div class="inner">
						<header>
							<h2 style="font-weight:bold;">Gangnam</h2>
							<!-- 작가 tawatchai07 출처 Freepik -->
						</header>
					</div>
			</article>
			
			<article>
				<img src="/img/main/sungsu.jpg" alt="" width="1440" height="962">
					<div class="inner">
						<header>
							<h2 style="font-weight:bold;">Seongsudong</h2>
						</header>
					</div>
			</article>
			
			<article>
				<img src="/img/main/gang.jpg" width="1440" height="961">
					<div class="inner">
						<header>
							<h2 style="font-weight:bold;">Gwangjang Market</h2>
						</header>
					</div>
			</article>
			
			<article>
				<img src="/img/main/nowon.jpg" width="1440" height="962">
					<div class="inner">
						<header>
							<h2 style="font-weight:bold;">Nowon</h2>
						</header>
					</div>
			</article>
		</section>
		
		<div class="test" style="border-bottom: 1px solid rgba(0,0,0,0.15); height: 600px;"> 
	
		</div>
		
		<jsp:include page="/WEB-INF/views/korean/includes/footer.jsp"></jsp:include>
</body>
</html>