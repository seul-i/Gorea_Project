<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<!-- 1. 폰트어썸 CDN / 2. jQuery -->
<script src="https://kit.fontawesome.com/52f65b6106.js" crossorigin="anonymous"></script>
<script src="//code.jquery.com/jquery-1.12.4.min.js"></script>
<link rel="stylesheet" type="text/css" href="/css/header/header.css">


<script type="text/javascript">
	window.onload = function() {
	    document.querySelector('.searchBtn').onclick = function() {
	        var searchInput = document.tsfrm.querySelector('.search');
	
	        if (!searchInput || searchInput.value.trim() === '') {
	            alert('검색어를 입력 하셔야 합니다.');
	            return;
	        }
	        document.tsfrm.submit();
	    };
	};
</script>

</head>
<body>

<c:set var="role" value="${SPRING_SECURITY_CONTEXT.authentication.principal.gorea_UserTO.go_user_role}" />
<c:set var="nickname" value="${SPRING_SECURITY_CONTEXT.authentication.principal.gorea_UserTO.go_user_nickname}" />

	<div class="header-nav">
		<div class="nav1">
			<div class="logo">
				<a href="/english/main.do"></a>
			</div>
			
			<div class="info-div">
				<form action="korean/total_search.do" method="post" name="tsfrm" style="margin:0px;">
					<ul>
	                	<li class ="search-box">
	                	<input type="text" class="search" required placeholder="Search">
	    				<span class="search-boxSpan"></span></li>
	    				<li class ="search-button">
	                	<a class="searchBtn"><i class="fa-solid fa-magnifying-glass" style="font-size: 22px;"></i></a>
	                	</li>
	                	
	                	
	                	<li class ="weather"><a href="#"><img src="/img/header/sunny.png" alt=""></a></li>
	                	<li>
	                		<select name="languages" id="lang" onchange="location.href=this.value">
	                			<option value="#">English</option>
	                			<option value="/korean/main.do">Korean</option>
	   							<option value="/japanese/main.do">Japanese</option>
	    						<option value="/chinese/main.do">Chinese</option>
	                		</select>
	                	</li>
	                	<li>
		                	<c:if test="${empty SPRING_SECURITY_CONTEXT}">
		                		<a href="#">Login</a>
		                	</c:if>
	                	
		                	<c:if test="${not empty SPRING_SECURITY_CONTEXT}">
								<c:choose>
						            <c:when test="${role eq 'ROLE_USER'}">
						            	
						            	<div class="dropdown">
										  <a href="#" class="mypage-toggle" data-nickname="${nickname}">${nickname}</a>
										  <div class="dropdown-options">
										    <a href="/user/korean/mypage.do">MyPage</a>
										    <a href="/logout.do" class="logout">Logout</a>
										  </div>
										</div>
						            </c:when>
						            <c:when test="${role eq 'ROLE_ADMIN'}">
						                <div class="dropdown">
										  <a href="#" class="mypage-toggle" data-nickname="${role }">ADMIN</a>
										  <div class="dropdown-options">
										    <a href="/admin/adminpage.do">관리자 페이지</a>
										    <a href="/logout.do" class="logout">로그아웃</a>
										  </div>
										</div>
						            </c:when>
						            <c:otherwise>
						                <!-- 다른 역할에 해당하는 경우 -->
						            </c:otherwise>
						        </c:choose>
						    </c:if>
	                	</li>
	                	
	                	<li class="navbar_toggleBtn">
	                		<div class="menuBtn">
		                		<div class="line1"></div>
		        				<div class="line2"></div>
		        				<div class="line3"></div>
	        				</div>
	                	</li>
	                	
	            	</ul>
            	</form>
			</div>
		</div>

		<div class="nav2">
			<ul class="nav-list">
				<li><a href="#">Our Seoul</a>
					<ul class="dropdown-list">
						<li><a href="#">Best TOP5</a></li>
                        <li><a href="#">Visitor pick</a></li>
                        <li><a href="#">Free Board</a></li>
                    </ul>
				</li>
				
				<li><a href="#">Editor</a>
					<ul class="dropdown-list">
						<li><a href="#">Editor pick</a></li>
                        <li><a href="#">Editor tip</a></li>
                    </ul>
				</li>
				
				 <li><a href="#">Trend Seoul</a></li>
                
				<li><a href="#">Travel Info</a>
					<ul class="dropdown-list">
						<li><a href="#">Weather Info</a></li>
                        <li><a href="#">Traffic info</a></li>
                        <li><a href="#">Exchange rate</a></li>
                        <li><a href="#">Quarantine info</a></li>
                    </ul>
				</li>
				
				<li><a href="#">Traveler support</a>
					<ul class="dropdown-list">
						<li><a href="#">Site Introduction</a></li>
						<li><a href="#">To contact</a></li>
						<li><a href="#">Notice</a></li>
                    </ul>
				</li>
			</ul>
		</div>
	
		<ul class="nav-links">
			<li>
			  <input type="text" placeholder="Search" style="height:25px; width:300px;">
			  <i class="fa-solid fa-magnifying-glass" style="font-size: 20px;"></i>
			</li>
	        <li><a href="#">Our Seoul</a>
	        <li><a href="#">Editor</a></li>
	        <li><a href="#">Trend Seoul</a></li>
	        <li><a href="#">Travel Info</a></li>
	        <li><a href="#">Traveler support</a></li>
		</ul>
		
	</div>
	<script type="text/javascript" src="/js/header/header.js"></script>
	
</body>
</html>