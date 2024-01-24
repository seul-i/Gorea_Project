<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:set var="language" value="${language}" />
<c:set var="googlemap" value="${googlemap}"/>
<c:set var="to" value="${requestScope.to}" />
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="robots" content="index, follow, max-image-preview:large, max-snippet:-1, max-video-preview:-1">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
   	<script src="http://ajax.aspnetcdn.com/ajax/jQuery/jquery-1.12.4.min.js"></script>
	
    <!-- 내가 변경한 css가 밑에있어야함 -->
    <link rel="stylesheet" type="text/css" href="/css/Top5/top5view.css">
    
    <script src="../../js/top5Map.js"></script>
    <script src="https://use.fontawesome.com/releases/v5.2.0/js/all.js"></script>
	<title>Gorea_BestTop5</title>

	<c:choose>
    	<c:when test="${language eq 'korean'}">
    		 <script src="https://maps.googleapis.com/maps/api/js?key=${googlemap}&libraries=places&callback=initMap&language=ko" defer></script>
    	</c:when>
	    <c:when test="${language eq 'english'}">
	        <script src="https://maps.googleapis.com/maps/api/js?key=${googlemap}&libraries=places&callback=initMap&language=en" defer></script>
	    </c:when>
	    <c:when test="${language eq 'japanese'}">
	        <script src="https://maps.googleapis.com/maps/api/js?key=${googlemap}&libraries=places&callback=initMap&language=ja" defer></script>
	    </c:when>
	    <c:when test="${language eq 'chinese'}">
	        <script src="https://maps.googleapis.com/maps/api/js?key=${googlemap}&libraries=places&callback=initMap&language=zh-CN" defer></script>
	    </c:when>
	</c:choose>

</head>

<body>
	<jsp:include page="/WEB-INF/views/includes/header${language}.jsp"></jsp:include>
	
		<div class="commonBanner" id="comBanner">
	        <img src="/img/banner/Top5Banner.jpg" alt="banner">
	        <div class="commonBanner-text">
	            <h2>'${to.userNickname}' 의 Best Top5</h2>
	        </div>
	    </div>
	    
	    <!-- contents ---------------------------------------------------------->
	    
		<div class="top5viewContainer">
					
			<div class="top5viewContent">
			
			<div>
				<span> ${to.top5postDate} </span>
			</div>
				<h2>- ${to.seoulTitle1} -</h2>
				<label> [ ${to.seoulLocGu1} ] ${to.mainCategory1} / ${to.subCategory1} </label>
				<div>
					<img src="${to.firstImageUrl1}" class="viewContentImg">
				</div>
				<div class="commentBox">
					<div id="comment" class="comment1">
						${to.top5Comment1}
					</div>
				</div>
				<div></div>
				<div class="mapSize" id="map" data-address="${to.seoulLoc1}"></div>
			<hr/>
				<h2>- ${to.seoulTitle2} -</h2>
				<label> [ ${to.seoulLocGu2} ] ${to.mainCategory2} / ${to.subCategory2} </label>
				<div>
					<img src="${to.firstImageUrl2}" class="viewContentImg">
				</div>
				<div class="commentBox">
					<div id="comment" class="comment1">
						${to.top5Comment2}
					</div>
				</div>
				<div class="mapSize" id="map2" data-address2="${to.seoulLoc2}"></div>
			<hr/>
				<h2>- ${to.seoulTitle3} -</h2>
				<label> [ ${to.seoulLocGu3} ] ${to.mainCategory3} / ${to.subCategory3} </label>
				<div>
					<img src="${to.firstImageUrl3}" class="viewContentImg">
				</div>
				<div class="commentBox">
					<div id="comment" class="comment1">
						${to.top5Comment3}
					</div>
				</div>
				<div class="mapSize" id="map3" data-address3="${to.seoulLoc3}"></div>
			<hr/>
				<h2>- ${to.seoulTitle4} -</h2>
				<label> [ ${to.seoulLocGu4} ] ${to.mainCategory4} / ${to.subCategory4} </label>
				<div>
					<img src="${to.firstImageUrl4}" class="viewContentImg">
				</div>
				<div class="commentBox">
					<div id="comment" class="comment1">
						${to.top5Comment4}
					</div>
				</div>
				<div class="mapSize" id="map4" data-address4="${to.seoulLoc4}"></div>	
			<hr/>
				<h2>- ${to.seoulTitle5} -</h2>
				<label> [ ${to.seoulLocGu5} ] ${to.mainCategory5} / ${to.subCategory5} </label>
				<div>
					<img src="${to.firstImageUrl5}" class="viewContentImg">
				</div>
				<div class="commentBox">
					<div id="comment" class="comment1">
						${to.top5Comment5}
					</div>
				</div>
				<div class="mapSize" id="map5" data-address5="${to.seoulLoc5}"></div>	
			</div>
			
		</div>
		
		<div class="best5CommentBox">
			<div class="best5Comment">
				<label>댓글수</label>
				<hr/>
				<div style="height:100px;"></div>
			</div>
		</div>
	<jsp:include page="/WEB-INF/views/includes/footer.jsp"></jsp:include>
	
</body>
</html>