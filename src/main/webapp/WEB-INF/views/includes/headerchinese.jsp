<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!-- Login 시에 Security context 에서 가져오는 유저 정보-->
<c:set var="role"
	value="${SPRING_SECURITY_CONTEXT.authentication.principal.gorea_UserTO.userRole}" />
<c:set var="nickname"
	value="${SPRING_SECURITY_CONTEXT.authentication.principal.gorea_UserTO.userNickname}" />

<c:set var="userSeq" value="${SPRING_SECURITY_CONTEXT.authentication.principal.gorea_UserTO.userSeq}" />
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
		
			window.onload = function () {
	        	document.querySelector(".searchBtn").onclick = function () {
	        		
					var searchInput = document.tsfrm.querySelector(".headerSearch-box");
	
					if (!searchInput || searchInput.value.trim() === "") {
						alert("您需要输入搜索词.");
						return;
					}
					
				document.tsfrm.submit();
				};
				
			};
			
			
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
				<a href="/chinese/main.do"></a>
			</div>

			<div class="headerInfo-div">
				<form action="/chinese/totalsearch.do" method="get" name="tsfrm">
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
								<option value="#">汉语</option>
								<option value="/korean/">한국어</option>
								<option value="/english/">English</option>
								<option value="/japanese/">日本語</option>
							</select>
						</li>

						<li class="header-login">
							<c:if test="${empty SPRING_SECURITY_CONTEXT}">
								<a href="/chinese/login.do">登录</a>
							</c:if> 
							
							<c:if test="${not empty SPRING_SECURITY_CONTEXT}">
								<c:choose>
								
									<c:when test="${role eq 'ROLE_USER'}">
										<div class="headerDropdown">
											<a href="#" class="mypage-toggle" data-nickname="${nickname}">${nickname}</a>
											<div class="headerDropdown-options">
												<a href="/chinese/userMypage.do?userSeq=${userSeq }">我的页面</a> <a
													href="/logoutChn.do" class="logout">登出</a>
											</div>
										</div>
									</c:when>

									<c:when test="${role eq 'ROLE_ADMIN'}">
										<div class="headerDropdown">
											<a href="#" class="mypage-toggle" data-nickname="${role }">ADMIN</a>
											<div class="headerDropdown-options">
												<a href="/admin/adminpage.do">관리자 페이지</a> <a
													href="/logoutChn.do" class="logout">로그아웃</a>
											</div>
										</div>
									</c:when>

									<c:otherwise>
									</c:otherwise>
									
								</c:choose>
							</c:if>
						</li>
						
						<li class="search-togleBtn">
							<a href="/chinese/totalsearch.do">
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
				<li><a href="#">我们的首尔</a>
					<ul class="header-dropdownList">
						<li><a href="/chinese/bestTop5.do">Best TOP5</a></li>
						<li><a href="/chinese/userRecom.do">旅行推荐</a></li>
						<li><a href="/chinese/freeboard.do">自由留言板</a></li>
					</ul></li>

				<li><a href="#">编辑推荐</a>
					<ul class="header-dropdownList">
						<li><a href="/chinese/editRecommend_list.do">编辑推荐场所</a></li>
						<li><a href="/chinese/editTip_list.do">编辑推荐秘诀</a></li>
					</ul></li>

				<li><a href="/chinese/trend_seoul.do">首尔潮流</a></li>

				<li><a href="#">旅游 信息</a>
					<ul class="header-dropdownList">
						<li><a href="#">天气 信息</a></li>
						<li><a href="#">交通 信息</a></li>
						<li><a href="#">汇率 信息</a></li>
						<li><a href="#">防疫 信息</a></li>
					</ul></li>

				<li><a href="#">旅游 援助</a>
					<ul class="header-dropdownList">
						<li><a href="#">网站 介绍</a></li>
						<li><a href="/chinese/qna_write.do">QnA</a></li>
						<li><a href="/chinese/notice.do">公告事项</a></li>
					</ul></li>
			</ul>
		</div>

		
		<div class="nav-links">		
			<ul>
				<li>
					<c:if test="${empty SPRING_SECURITY_CONTEXT}">
						<h1><a href="/chinese/login.do" class="header-Gologin">登录 & 报名</a></h1>
						<h4>欢迎访问 Go!rea</h4><br/>
						
						<select name="languages" id="lang2" onchange="changeLanguage(this)" style="margin-right:20px">
							<option value="#">汉语</option>
							<option value="/korean/">한국어</option>
							<option value="/english/">English</option>
							<option value="/japanese/">日本語</option>
						</select>
					</c:if> 
								
					<c:if test="${not empty SPRING_SECURITY_CONTEXT}">
						<c:choose>
							<c:when test="${role eq 'ROLE_USER'}">
								<h3 class="nav-id" data-nickname="${nickname}">欢迎访问 '<span>${nickname}</span>'</h3>
								
								<div class="nav-idIfno">
									<a href="/chinese/userMypage.do" style="font-size:15px; margin-right:20px">我的页面</a>
									<a href="/logoutChn.do" class="logout" style="font-size:15px">登出</a>
									
									<select name="languages" id="lang2" onchange="changeLanguage(this)" style="margin-right:20px">
										<option value="#">汉语</option>
										<option value="/korean/">한국어</option>
										<option value="/english/">English</option>
										<option value="/japanese/">日本語</option>
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
					<p>[ 我们的首尔 ]</p>
					<div class="nav-IndexInput">
						<a href="/chinese/bestTop5.do">Best TOP5</a>&nbsp;&nbsp;&nbsp;&nbsp;
						<a href="/chinese/userRecom.do">旅行推荐</a>&nbsp;&nbsp;&nbsp;&nbsp;
						<a href="/chinese/freeboard.do">自由留言板</a>
					</div>
				</li>
				<li>
					<p>[ 编辑推荐 ]</p>
					<div class="nav-IndexInput">
						<a href="/chinese/editRecommend_list.do">编辑推荐场所</a>&nbsp;&nbsp;&nbsp;&nbsp;
						<a href="/chinese/editTip_list.do">编辑推荐秘诀</a>
					</div>
				</li>
				<li>
					<p>[ 首尔潮流 ]</p>
					<div class="nav-IndexInput">
						<a href="/chinese/trend_seoul.do">首尔潮流</a>
					</div>
				</li>
				<li>
					<p>[ 旅游 信息 ]</p>
					<div class="nav-IndexInput">
						<a href="#">天气 信息</a>&nbsp;&nbsp;&nbsp;&nbsp;
						<a href="#">交通 信息</a>&nbsp;&nbsp;&nbsp;&nbsp;
						<a href="#">汇率 信息</a>&nbsp;&nbsp;&nbsp;&nbsp;
						<a href="#">防疫 信息</a>
					</div>
				</li>
				<li>
					<p>[ 旅游 援助 ]</p>
					<div class="nav-IndexInput">
						<a href="#">网站 介绍</a>&nbsp;&nbsp;&nbsp;&nbsp;
						<a href="/chinese/qna_write.do">QnA</a>&nbsp;&nbsp;&nbsp;&nbsp;
						<a href="/chinese/notice.do">公告事项</a>
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

	<script type="text/javascript" src="/js/header/header.js"></script>
</body>
</html>
