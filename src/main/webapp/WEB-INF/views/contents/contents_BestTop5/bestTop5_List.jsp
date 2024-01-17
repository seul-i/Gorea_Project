<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<c:set var="language" value="${language}" />

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<title>Gorea_BestTop5</title>
		
		<link rel="preconnect" href="https://fonts.googleapis.com">
		<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
		<link href="https://fonts.googleapis.com/css2?family=Inter:wght@200&family=Noto+Sans+KR:wght@200;500;600&display=swap" rel="stylesheet">
		
		<style>
		
			@import url('https://fonts.googleapis.com/css2?family=Inter:wght@200&family=Noto+Sans+KR:wght@200;500;600&display=swap');
			
		    .top5Box {
		        width: 80%;
		        height: 350px;
		        margin: 30px;
		        background-color: #FFFAFA;
		        box-shadow: 0 0.5rem 1.5rem rgba(0, 0, 0, .1);
		        border-radius: 5px;
		    }
		    .title-box{
				display: flex;
		    	width: 100%;
		    	height: 50px;
			    justify-content: space-between;
			    align-items: center;
		    }
		    
		    .title-box h3{
				margin-left: 25px;
				margin-top: 40px;
				font-family: 'Inter', sans-serif;
		    }
		    
		    .title-box h5{
				margin-right: 25px;
				margin-top: 40px;
				font-family: 'Inter', sans-serif;
		    }
		    
		    .top5list-content{
		    	display: flex;
		    	height: 300px;
		    }
		    
		    .top5list-left {
		    	display: flex;
		        width: 60px;
		        height: 300px;
		        color: black;
		        align-items: center;
		    }
		    
		    .top5Seq{
		    	width: 20px;
		    	display: flex;
				justify-content : center;
				margin-left:25px;
		    }
		    
		    .vertical-line {
		    	width: 40px;
				height: 70%;
				float: right;
				border-right: 0.5px solid #dee2e6;
			}
		    
		    .top5list-center{
		    	display: flex;
				width: 80%;
				align-items: center;
		    	justify-content : center;
		    }
		    
		    .top5img{
		    	display: flex;
		    	width: 200px;
		    	height: 200px;
		    	background-color: black;
		    	margin: 10px;
		    }
		    
		    .top5img img{
				width: 100%;
				height: 100%;
				object-fit: cover;
				
		    }
		    
		</style>
	
	</head>
<body>
	<jsp:include page="/WEB-INF/views/includes/header${language}.jsp"></jsp:include>
	
		<a href="/${language}/bestTop5_write.do">글쓰기</a><br/>
		
			<div class="top5Box">
			
				<div class="title-box">
					<h3>김아무개의 추천 장소</h3>
					<h5>작성날짜 / 조회수</h5>
				</div>
				
				<div class="top5list-content">
			    	<div class="top5list-left">
			    	
			    		<div class="top5Seq">
			    		1
			    		</div>
			    		<div class="vertical-line">
			    		</div>
			    	</div>
			    	
			    	<div class="top5list-center">
			    		<div class="top5img">
				    		<img src="/img/intro/img1.jpg" alt="">
				    	</div>
				    	<div class="top5img">
				    		<img src="/img/intro/img1.jpg" alt="">
				    	</div>
				    	<div class="top5img">
				    		<img src="/img/intro/img1.jpg" alt="">
				    	</div>
				    	<div class="top5img">
				    		<img src="/img/intro/img1.jpg" alt="">
				    	</div>
				    	<div class="top5img">
				    		<img src="/img/intro/img1.jpg" alt="">
				    	</div>
					</div>
			    </div>
			    
			    <div id="screenright">
			    
			    </div>
			</div>
			<div>
<%-- 			<c:forEach var="top5Data" items="${boardList}"> --%>
<!--     			<div style="border: 1px solid #ccc; margin-bottom: 10px; padding: 10px;"> -->
<%-- 			        <p>Top5Seq: ${top5Data.top5Seq}</p> --%>
<%-- 			        <p>UserSeq: ${top5Data.userSeq}</p> --%>
<%-- 			        <p>SeoulSeq: ${top5Data.seoulSeq}</p> --%>
<%-- 			        <p>SeoulCategoryNo: ${top5Data.seoulcategoryNo}</p> --%>
<%-- 			        <p>SeoulTitle: ${top5Data.seoulTitle}</p> --%>
<%-- 			        <p>SeoulLoc: ${top5Data.seoulLoc}</p> --%>
<%-- 			        <p>SeoulLocGu: ${top5Data.seoulLocGu}</p> --%>
<%-- 			        <p>Top5Comment: ${top5Data.top5Comment}</p> --%>
<%-- 			        <p>Top5Hit: ${top5Data.top5Hit}</p> --%>
<%-- 			        <p>Top5PostDate: ${top5Data.top5postDate}</p> --%>
<!-- 			    </div> -->
<%-- 			</c:forEach> --%>
			</div>
	<jsp:include page="/WEB-INF/views/includes/footer.jsp"></jsp:include>
</body>
</html>