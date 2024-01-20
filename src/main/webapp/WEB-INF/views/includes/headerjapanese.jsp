<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!-- Login 시에 Security context 에서 가져오는 유저 정보-->
<c:set var="role"
	value="${SPRING_SECURITY_CONTEXT.authentication.principal.gorea_UserTO.userRole}" />
<c:set var="nickname"
	value="${SPRING_SECURITY_CONTEXT.authentication.principal.gorea_UserTO.userNickname}" />

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
						alert("検索語を入力してください。");
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
				<a href="/japanese/main.do"></a>
			</div>

			<div class="headerInfo-div">
				<form action="/japanese/totalsearch.do" method="get" name="tsfrm">
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
								<option value="#">日本語</option>
								<option value="/korean/">한국어</option>
								<option value="/english/">English</option>
								<option value="/chinese/">汉语</option>
							</select>
						</li>

						<li class="header-login">
							<c:if test="${empty SPRING_SECURITY_CONTEXT}">
								<a href="/japanese/login.do">ログイン</a>
							</c:if> 
							
							<c:if test="${not empty SPRING_SECURITY_CONTEXT}">
								<c:choose>
								
									<c:when test="${role eq 'ROLE_USER'}">
										<div class="headerDropdown">
											<a href="#" class="mypage-toggle" data-nickname="${nickname}">${nickname}</a>
											<div class="headerDropdown-options">
												<a href="/user/japanese/mypage.do">マイページ</a>
	                          					<a href="/logout.do" class="logout">ログアウト</a>
											</div>
										</div>
									</c:when>

									<c:when test="${role eq 'ROLE_ADMIN'}">
										<div class="dropdown">
											<a href="#" class="mypage-toggle" data-nickname="${role }">ADMIN</a>
											<div class="headerDropdown-options">
												<a href="/admin/adminpage.do">관리자 페이지</a>
												<a href="/logout.do" class="logout">로그아웃</a>
											</div>
										</div>
									</c:when>

									<c:otherwise>
									</c:otherwise>
									
								</c:choose>
							</c:if>
						</li>
						
						<li class="search-togleBtn">
							<a href="/japanese/totalsearch.do">
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
				<li><a href="#">僕らのソウル</a>
					<ul class="header-dropdownList">
						<li><a href="/japanese/bestTop5.do">Best TOP5</a></li>
						<li><a href="/japanese/userRecomList.do">旅行者のおすすめ</a></li>
						<li><a href="/japanese/freeboard.do">フリー掲示板</a></li>
					</ul></li>

				<li><a href="#">エディター推薦</a>
					<ul class="header-dropdownList">
						<li><a href="/japanese/editRecommend_list.do">エディタ推薦場所</a></li>
						<li><a href="/japanese/editTip_list.do">エディターのおすすめのコツ</a></li>
					</ul></li>

				<li><a href="/japanese/trend_seoul.do">トレンドソウル</a></li>

				<li><a href="#">旅行 情報</a>
					<ul class="header-dropdownList">
						<li><a href="#">天気 情報</a></li>
						<li><a href="#">交通 情報</a></li>
						<li><a href="#">為替 情報</a></li>
						<li><a href="#">防疫 情報</a></li>
					</ul></li>

				<li><a href="#">旅行者 支援</a>
					<ul class="header-dropdownList">
						<li><a href="#">サイト 紹介</a></li>
						<li><a href="/japanese/qna_write.do">QnA</a></li>
						<li><a href="/japanese/notice.do">お知らせ</a></li>
					</ul></li>
			</ul>
		</div>

		
		<div class="nav-links">		
			<ul>
				<li>
					<c:if test="${empty SPRING_SECURITY_CONTEXT}">
						<h1><a href="/japanese/login.do" class="header-Gologin">ログイン ＆ サインアップ</a></h1>
						<h4>ようこそ、Go!rea</h4><br/>
						
						<select name="languages" id="lang2" onchange="changeLanguage(this)" style="margin-right:20px">
							<option value="#">日本語</option>
							<option value="/korean/">한국어</option>
							<option value="/english/">English</option>
							<option value="/chinese/">汉语</option>
						</select>
					</c:if> 
								
					<c:if test="${not empty SPRING_SECURITY_CONTEXT}">
						<c:choose>
							<c:when test="${role eq 'ROLE_USER'}">
								<h3 class="nav-id" data-nickname="${nickname}">いらっしゃいませ '<span>${nickname}</span>' さん</h3>
								
								<div class="nav-idIfno">
									<a href="/user/japanese/mypage.do" style="font-size:15px; margin-right:20px">マイページ</a>
									<a href="/logout.do" class="logout" style="font-size:15px">ログアウト</a>
									
									<select name="languages" id="lang2" onchange="changeLanguage(this)" style="margin-right:20px">
										<option value="#">日本語</option>
										<option value="/korean/">한국어</option>
										<option value="/english/">English</option>
										<option value="/chinese/">汉语</option>
									</select>
									
									<img src="/img/header/sunny.png" alt="" />
									
								</div>
							</c:when>
		
							<c:when test="${role eq 'ROLE_ADMIN'}">
								<a href="#" class="mypage-toggle" data-nickname="${role }">ADMIN</a>
									<div class="dropdown-options">
										<a href="/admin/adminpage.do">관리자 페이지</a> 
										<a href="/logout.do" class="logout">로그아웃</a>
									</div>
							</c:when>
	
							<c:otherwise>
							</c:otherwise>
										
						</c:choose>
					</c:if>		
				</li>
				
				<li class="nav-line"><hr/></li>
				
				<li>
					<p>[ 僕らのソウル ]</p>
					<div class="nav-IndexInput">
						<a href="/japanese/bestTop5.do">Best TOP5</a>&nbsp;&nbsp;&nbsp;&nbsp;
						<a href="/japanese/userRecomList.do">旅行者のおすすめ</a>&nbsp;&nbsp;&nbsp;&nbsp;
						<a href="/japanese/freeboard.do">フリー掲示板</a>
					</div>
				</li>
				<li>
					<p>[ エディター推薦 ]</p>
					<div class="nav-IndexInput">
						<a href="/japanese/editRecommend_list.do">エディタ推薦場所</a>&nbsp;&nbsp;&nbsp;&nbsp;
						<a href="/japanese/editTip_list.do">エディターのおすすめのコツ</a>
					</div>
				</li>
				<li>
					<p>[ トレンドソウル ]</p>
					<div class="nav-IndexInput">
						<a href="/japanese/trend_seoul.do">トレンドソウル</a>
					</div>
				</li>
				<li>
					<p>[ 旅行 情報 ]</p>
					<div class="nav-IndexInput">
						<a href="#">天気 情報</a>&nbsp;&nbsp;&nbsp;&nbsp;
						<a href="#">交通 情報</a>&nbsp;&nbsp;&nbsp;&nbsp;
						<a href="#">為替 情報</a>&nbsp;&nbsp;&nbsp;&nbsp;
						<a href="#">防疫 情報</a>
					</div>
				</li>
				<li>
					<p>[ 旅行者 支援 ]</p>
					<div class="nav-IndexInput">
						<a href="#">サイト 紹介</a>&nbsp;&nbsp;&nbsp;&nbsp;
						<a href="/japanese/qna_write.do">QnA</a>&nbsp;&nbsp;&nbsp;&nbsp;
						<a href="/japanese/notice.do">お知らせ</a>
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
