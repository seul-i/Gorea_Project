<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!-- Login 시에 Security context 에서 가져오는 유저 정보-->
<c:set var="role"
	value="${SPRING_SECURITY_CONTEXT.authentication.principal.gorea_UserTO.userRole}" />
<c:set var="nickname"
	value="${SPRING_SECURITY_CONTEXT.authentication.principal.gorea_UserTO.userNickname}" />

<c:set var="maxLength" value="6" />
<c:set var="userSeq" value="${SPRING_SECURITY_CONTEXT.authentication.principal.gorea_UserTO.userSeq}" />

<%-- 닉네임의 길이가 maxLength 이상이면 일부만 표시하고 뒤에 "..."을 붙임 --%>
<c:choose>
    <c:when test="${fn:length(nickname) > maxLength}">
        <c:set var="shortenedNickname" value="${fn:substring(nickname, 0, maxLength)}..." />
    </c:when>
    <c:otherwise>
        <c:set var="shortenedNickname" value="${nickname}" />
    </c:otherwise>
</c:choose>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<!-- 1. 폰트어썸 CDN / 2. jQuery -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<!-- header / footer CSS -->
<link rel="stylesheet" type="text/css" href="/css/header/header.css" />
<link rel="stylesheet" type="text/css" href="/css/footer/footer.css">

<!-- 폰트 cdn -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Gowun+Dodum&family=Noto+Sans+KR&family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">

	<script type="text/javascript">
			
			function changeLanguage(selectElement) {
		        // 현재 주소 가져오기
		        const viewUrl = window.location.href;
		        
		        console.log(viewUrl);

		        // 현재 주소에서 마지막 부분 추출
		        const parts = viewUrl.split("/");
		        const lastPart = parts[parts.length - 1];

		        // 선택된 언어 값 가져오기
		        const selectedLanguage = selectElement.value;

		        // 새로운 URL 생성
		        const newUrl = selectedLanguage + lastPart;

		        // 새 URL로 이동
		        window.location.href = newUrl;
			}
	        
		</script>
</head>

<body>
	<div class="header-nav">
		<div class="header-nav1">
			<div class="header_logo">
				<a href="/korean/main.do"></a>
			</div>

			<div class="headerInfo-div">
				<form action="/korean/totalsearch.do" method="get" name="tsfrm">
					<ul>
						<!-- 검색 박스 -->
						<li class="search-box">
							<input type="text" class="headerSearch-box"
							name="keyword" required placeholder="Search" /> 
						</li>

						<!-- 검색 버튼, 폰트어썸 아이콘 사용 -->
						<li class="search-button">
							<button type="submit" class="searchBtn">
								<i class="fa-solid fa-magnifying-glass"></i>
							</button>
						</li>

						<!-- 날씨 -->
						<li class="header-weather"><a href="#"> <img
								src="/img/header/sunny.png" alt="" />
						</a></li>

						<!-- 언어 선택 -->
						<li>
							<select name="languages" id="lang" onchange="changeLanguage(this)">
								<option value="#" selected>한국어</option>
								<option value="/english/">English</option>
								<option value="/japanese/">日本語</option>
								<option value="/chinese/">汉语</option>
							</select>
						</li>

						<li class="header-login">
							<c:if test="${empty SPRING_SECURITY_CONTEXT}">
								<a href="/korean/login.do">Login</a>
							</c:if> 
							
							<c:if test="${not empty SPRING_SECURITY_CONTEXT}">
								<c:choose>
								
									<c:when test="${role eq 'ROLE_USER'}">
										<div class="headerDropdown">
											<a href="#" class="mypage-toggle" data-nickname="${shortenedNickname}">${shortenedNickname}</a>
											<div class="headerDropdown-options">
												<a href="/korean/userMypage.do?userSeq=${userSeq }">마이페이지</a>  
												<a href="/logoutKr.do" class="logout">로그아웃</a>
											</div>
										</div>
									</c:when>

									<c:when test="${role eq 'ROLE_ADMIN'}">
										<div class="headerDropdown">
											<a href="#" class="mypage-toggle" data-nickname="${role }">ADMIN</a>
											<div class="headerDropdown-options">
												<a href="/admin/adminpage.do">관리자 페이지</a> 
												<a href="/logoutKr.do" class="logout">로그아웃</a>
											</div>
										</div>
									</c:when>

									<c:otherwise>
									</c:otherwise>
									
								</c:choose>
							</c:if>
						</li>
						
						<li class="search-togleBtn">
							<a href="/korean/totalsearch.do">
								<i class="fa-solid fa-magnifying-glass"></i>
							</a>
						</li>

						<li class="navbar_toggleBtn">
							<div class="header-menuBtn">
								<div class="line1"></div>
								<div class="line2"></div>
								<div class="line3"></div>
							</div>
						</li>
					</ul>
				</form>
			</div>
		</div>

		<div class="header-nav2">
			<ul class="header-nav2List">
				<li><a href="#">우리들의 서울</a>
					<ul class="header-dropdownList">
						<li><a href="/korean/bestTop5.do">Best TOP5</a></li>
						<li><a href="/korean/userRecom.do">여행자 추천</a></li>
						<li><a href="/korean/freeboard.do">자유게시판</a></li>
					</ul></li>

				<li><a href="#">에디터 추천</a>
					<ul class="header-dropdownList">
						<li><a href="/korean/editRecommend_list.do">에디터 추천장소</a></li>
						<li><a href="/korean/editTip_list.do">에디터 추천꿀팁</a></li>
					</ul></li>

				<li><a href="/korean/trend_seoul.do">트렌드 서울</a></li>

				<li><a href="#">여행 정보</a>
					<ul class="header-dropdownList">
						<li><a href="#">날씨 정보</a></li>
						<li><a href="#">교통 정보</a></li>
						<li><a href="#">환율 정보</a></li>
						<li><a href="#">방역 정보</a></li>
					</ul></li>

				<li><a href="#">여행자 지원</a>
					<ul class="header-dropdownList">
						<li><a href="#">사이트 소개</a></li>
						<li><a href="/korean/qna_write.do">QnA</a></li>
						<li><a href="/korean/notice.do">공지사항</a></li>
					</ul></li>
			</ul>
		</div>

		
		<div class="nav-links">		
			<ul>
				<li>
					<c:if test="${empty SPRING_SECURITY_CONTEXT}">
						<h1><a href="/korean/login.do" class="header-Gologin">Login & SIGN UP</a></h1>
						<h4>welcome vist Go!rea</h4><br/>
						
						<select name="languages" id="lang2" onchange="changeLanguage(this)" style="margin-right:20px">
							<option value="#" selected>한국어</option>
							<option value="/english/">English</option>
							<option value="/japanese/">日本語</option>
							<option value="/chinese/">汉语</option>
						</select>
					</c:if> 
								
					<c:if test="${not empty SPRING_SECURITY_CONTEXT}">
						<c:choose>
							<c:when test="${role eq 'ROLE_USER'}">
								<h3 class="nav-id" data-nickname="${nickname}">환영합니다 '<span>${nickname}</span>' 님</h3>
								
								<div class="nav-idIfno">
									<a href="/korean/userMypage.do" style="font-size:15px; margin-right:20px">마이 페이지</a>
									<a href="/logoutKr.do" class="logout" style="font-size:15px">로그아웃</a>
									
									<select name="languages" id="lang2" onchange="changeLanguage(this)" style="margin-right:20px">
										<option value="#" selected>한국어</option>
										<option value="/english/">English</option>
										<option value="/japanese/">日本語</option>
										<option value="/chinese/">汉语</option>
									</select>
									
									<img src="/img/header/sunny.png" alt="" />
									
								</div>
							</c:when>
		
							<c:when test="${role eq 'ROLE_ADMIN'}">
								<a href="#" class="mypage-toggle" data-nickname="${role }">ADMIN</a>
									<div class="nav-idIfno">
										<a href="/admin/adminpage.do" style="font-size:15px; margin-right:20px">관리자 페이지</a> 
										<a href="/logoutKr.do" class="logout" style="font-size:15px">로그아웃</a>
										
										<select name="languages" id="lang2" onchange="changeLanguage(this)" style="margin-right:20px">
											<option value="#" selected>한국어</option>
											<option value="/english/">English</option>
											<option value="/japanese/">日本語</option>
											<option value="/chinese/">汉语</option>
										</select>
									</div>
							</c:when>
	
							<c:otherwise>
							</c:otherwise>
										
						</c:choose>
					</c:if>		
				</li>
				
				<li class="nav-line"><hr/></li>
				
				<li>
					<p>[ 우리들의 서울 ]</p>
					<div class="nav-IndexInput">
						<a href="/korean/bestTop5.do">Best TOP5</a>&nbsp;&nbsp;&nbsp;&nbsp;
						<a href="/korean/userRecom.do">여행자 추천</a>&nbsp;&nbsp;&nbsp;&nbsp;
						<a href="/korean/freeboard.do">자유게시판</a>
					</div>
				</li>
				<li>
					<p>[ 에디터 추천 ]</p>
					<div class="nav-IndexInput">
						<a href="/korean/editRecommend_list.do">에디터 추천장소</a>&nbsp;&nbsp;&nbsp;&nbsp;
						<a href="/korean/editTip_list.do">에디터 추천꿀팁</a>
					</div>
				</li>
				<li>
					<p>[ 트렌드 서울 ]</p>
					<div class="nav-IndexInput">
						<a href="/korean/trend_seoul.do">트렌드 서울</a>
					</div>
				</li>
				<li>
					<p>[ 여행 정보 ]</p>
					<div class="nav-IndexInput">
						<a href="#">날씨 정보</a>&nbsp;&nbsp;&nbsp;&nbsp;
						<a href="#">교통 정보</a>&nbsp;&nbsp;&nbsp;&nbsp;
						<a href="#">환율 정보</a>&nbsp;&nbsp;&nbsp;&nbsp;
						<a href="#">방역 정보</a>
					</div>
				</li>
				<li>
					<p>[ 여행자 지원 ]</p>
					<div class="nav-IndexInput">
						<a href="#">사이트 소개</a>&nbsp;&nbsp;&nbsp;&nbsp;
						<a href="/korean/qna_write.do">QnA</a>&nbsp;&nbsp;&nbsp;&nbsp;
						<a href="/korean/notice.do">공지사항</a>
					</div>
				</li>
				<li>
					<div class="nav-footer">
						<img src="">
					</div>
				</li>
			</ul>
		</div>
	</div>

	<script type="text/javascript" src="../../js/header.js"></script>
</body>
</html>
