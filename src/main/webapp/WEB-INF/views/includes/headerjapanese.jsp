<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!-- Login 시에 Security context 에서 가져오는 유저 정보-->
<c:set var="role" value="${SPRING_SECURITY_CONTEXT.authentication.principal.gorea_UserTO.userRole}"/>
<c:set var="nickname" value="${SPRING_SECURITY_CONTEXT.authentication.principal.gorea_UserTO.userNickname}"/>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8" />
    	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
    	<!-- 1. 폰트어썸 CDN / 2. jQuery -->
    	<script src="https://kit.fontawesome.com/52f65b6106.js" crossorigin="anonymous"></script>
    	<script src="//code.jquery.com/jquery-1.12.4.min.js"></script>
    	
    	<link rel="stylesheet" type="text/css" href="/css/header/header.css" />
		<link rel="stylesheet" type="text/css" href="/css/footer/footer.css">

		<script type="text/javascript">
		
			window.onload = function () {
	        	document.querySelector(".searchBtn").onclick = function () {
	        		
					var searchInput = document.tsfrm.querySelector(".search");
	
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
			<div class="nav1">
	        	<div class="logo">
	          		<a href="/japanese/main.do"></a>
				</div>
	
			<div class="info-div">
				<form action="japanese/total_search.do" method="post" name="tsfrm" style="margin: 0px">
					<ul>
						<!-- 검색 박스 -->
						<li class="search-box">
							<input type="text" class="search" required placeholder="Search" value=""/>
	                		<span class="search-boxSpan"></span>
	              		</li>
	              		
	              		<!-- 검색 버튼, 폰트어썸 아이콘 사용 -->
	             		<li class="search-button">
	                		<a class="searchBtn">
	                			<i class="fa-solid fa-magnifying-glass" style="font-size: 22px"></i>
	                		</a>
						</li>
						
						<!-- 날씨 -->
						<li class="weather">
	                		<a href="#">
	                			<img src="/img/header/sunny.png" alt="" />
	                		</a>
						</li>
	
						<!-- 언어 선택 -->
						<li>
							<select name="languages" id="lang" onchange="changeLanguage(this)">
								<option value="#">日本語</option>
								<option value="/korean/">한국어</option>
								<option value="/english/">English</option>
								<option value="/chinese/">汉语</option>
							</select>
						</li>
						
						<li>
	 						<c:if test="${empty SPRING_SECURITY_CONTEXT}">
								<a href="/japanese/login.do">Login</a>
							</c:if>
							
							<c:if test="${not empty SPRING_SECURITY_CONTEXT}">
								<c:choose>
									<c:when test="${role eq 'ROLE_USER'}">
										<div class="dropdown">
											<a href="#" class="mypage-toggle" data-nickname="${nickname}">${nickname}</a>
	                        					<div class="dropdown-options">
	                          						<a href="/user/japanese/mypage.do">マイページ</a>
	                          						<a href="/logout.do" class="logout">ログアウト</a>
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
					<li><a href="#">僕らのソウル</a>
						<ul class="dropdown-list">
							<li><a href="/japanese/BestTop5.do">Best TOP5</a></li>
	                        <li><a href="#">旅行者のおすすめ</a></li>
	                        <li><a href="/japanese/freeboard.do">フリー掲示板</a></li>
	                    </ul>
					</li>
				
					<li><a href="#">エディター推薦</a>
						<ul class="dropdown-list">
							<li><a href="/japanese/editRecommend_list.do">エディタ推薦場所</a></li>
	                        <li><a href="#">エディターのおすすめのコツ</a></li>
	                    </ul>
					</li>
				
				 	<li><a href="/japanese/trend_seoul.do">トレンドソウル</a></li>
                
					<li><a href="#">旅行 情報</a>
						<ul class="dropdown-list">
							<li><a href="#">天気 情報</a></li>
	                        <li><a href="#">交通 情報</a></li>
	                        <li><a href="#">為替 情報</a></li>
	                        <li><a href="#">防疫 情報</a></li>
	                    </ul>
					</li>
				
					<li><a href="#">旅行者 支援</a>
						<ul class="dropdown-list">
							<li><a href="#">サイト 紹介</a></li>
							<li><a href="/japanese/qna_write.do">問い合わせ</a></li>
							<li><a href="/japanese/notice.do">お知らせ</a></li>
	                    </ul>
					</li>
				</ul>
			</div>

			<ul class="nav-links">
				<li>
					<input type="text" placeholder="Search" style="height: 25px; width: 300px"/>
					<i class="fa-solid fa-magnifying-glass" style="font-size: 20px"></i>
				</li>
				
		        <li><a href="#">僕らのソウル</a>
		        <li><a href="#">エディター推薦</a></li>
		        <li><a href="#">トレンドソウル</a></li>
		        <li><a href="#">旅行 情報</a></li>
		        <li><a href="#">旅行者 支援</a></li>
			</ul>
	    </div>
	    
		<script type="text/javascript" src="/js/header/header.js"></script>
	</body>
</html>
