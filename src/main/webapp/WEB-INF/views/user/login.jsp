<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="language" value="${language}" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Go!rea Login Page</title>
<script src="https://kit.fontawesome.com/52f65b6106.js" crossorigin="anonymous"></script>
<!-- 부트 스트랩 -->
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
	integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T"
	crossorigin="anonymous">
<link rel="stylesheet" type="text/css" href="/css/login/login.css">
<link href="https://fonts.googleapis.com/css2?family=Gowun+Dodum&family=Noto+Sans+KR&family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">

</head>
<body>
	
	<c:if test="${!empty loginFailMsg }">
		<script type="text/javascript">
			const msg = "${loginFailMsg}";
		</script>
	</c:if>

	<section class="login">
		<div class="login_box">
			<div class="left">
				<c:choose>
				
					<c:when test="${language eq 'korean' || loginFailKr eq '한국'}">
						<div class="top_link">
							<a href="/korean/main.do"> 
								<i class="fa-regular fa-circle-right fa-rotate-180 fa-lg"></i>
								<span class="goMain">Main Page</span>
							</a>
							
						</div>
						<div class="contact">
						
							<form action="/loginProcKr" method="post">
							
								<img src="/img/login/gorea_logo.png" class="login_logo">
									<input type="text" name="username" value="" placeholder="ID">
									<input type="password" name="password" value="" placeholder="PASSWORD">
							
								<div class="checkbox_container">
									
									<!-- 쿠키 유지 -->
									<label for="continue_login">로그인 유지하기 
										<input type="checkbox" id="continue_login" name="remember-me">
									</label>
									
									<!-- 로그인 버튼 -->
									<button class="submit login_btn" type="submit">SIGN IN</button>
								</div>
								
								<div class="bot_link">
									<a href="/korean/join.do">SIGN UP</a>
								</div>
							
								<span style="color: red; text-align: center; display: block;" readonly>
									${loginFailMsg}
								</span>
								
								<div class="bot_link2">
									<span class="findid"> 
										아이디나 비밀번호를 잊었을 때는, 
										<a class="bot_link" href="#">여기</a>를 눌러주세요.
									</span>
								</div>
							</form>
						</div>
					</c:when>
					    		
					<c:when test="${language eq 'english' || loginFailEn eq '미국'}">
						<div class="top_link">
							<a href="/english/main.do"> 
								<i class="fa-regular fa-circle-right fa-rotate-180 fa-lg"></i>
								<span class="goMain">Main Page</span>
							</a>
						</div>
				
						<div class="contact">
						
					    <form action="/loginProcEn" method="post">
							
								<img src="/img/login/gorea_logo.png" class="login_logo">
									<input type="text" name="username" value="" placeholder="ID">
									<input type="password" name="password" value="" placeholder="PASSWORD">
							
								<div class="checkbox_container">
									
									<!-- 쿠키 유지 -->
									<label for="continue_login">Remember Me 
										<input type="checkbox" id="continue_login" name="remember-me">
									</label>
									
									<!-- 로그인 버튼 -->
									<button class="submit login_btn" type="submit">SIGN IN</button>
								</div>
								
								<div class="bot_link">
									<a href="/english/join.do">SIGN UP</a>
								</div>
							
								<span style="color: red; text-align: center; display: block;" readonly>
									${loginFailMsg}
								</span>
								
								<div class="bot_link2">
									<span class="findid"> 
										If you have forgotten your ID or password, <br/>
										please <a class="bot_link" href="#">click</a> here
									</span>
								</div>
							</form>
						</div>
					</c:when>
					    		
					<c:when test="${language eq 'japanese' || loginFailJp eq '일본'}">
						<div class="top_link">
							<a href="/japanese/main.do"> 
								<i class="fa-regular fa-circle-right fa-rotate-180 fa-lg"></i>
								<span class="goMain">Main Page</span>
							</a>
						</div>
				
						<div class="contact">
							<form action="/loginProcJp" method="post">
							
								<img src="/img/login/gorea_logo.png" class="login_logo">
									<input type="text" name="username" value="" placeholder="ID">
									<input type="password" name="password" value="" placeholder="PASSWORD">
							
								<div class="checkbox_container">
									
									<!-- 쿠키 유지 -->
									<label for="continue_login">ログインを維持
										<input type="checkbox" id="continue_login" name="remember-me">
									</label>
									
									<!-- 로그인 버튼 -->
									<button class="submit login_btn" type="submit">ログイン</button>
								</div>
								
								<div class="bot_link">
									<a href="/japanese/join.do">サインアップ</a>
								</div>
							
								<span style="color: red; text-align: center; display: block;" readonly>
									${loginFailMsg}
								</span>
								
								<div class="bot_link2">
									<span class="findid"> 
										IDまたはパスワードをお忘れの方は
										<a class="bot_link" href="#">こちら</a>
										クリックしてください.
									</span>
								</div>
							</form>
						</div>
					</c:when>
					    		
					<c:when test="${language eq 'chinese' || loginFailChn eq '중국'}">
						<div class="top_link">
							<a href="/chinese/main.do"> 
								<i class="fa-regular fa-circle-right fa-rotate-180 fa-lg"></i>
								<span class="goMain">Main Page</span>
							</a>
						</div>
				
						<div class="contact">
							<form action="/loginProcChn" method="post">
							
								<img src="/img/login/gorea_logo.png" class="login_logo">
									<input type="text" name="username" value="" placeholder="ID">
									<input type="password" name="password" value="" placeholder="PASSWORD">
							
								<div class="checkbox_container">
									
									<!-- 쿠키 유지 -->
									<label for="continue_login">保持登录状态
										<input type="checkbox" id="continue_login" name="remember-me">
									</label>
									
									<!-- 로그인 버튼 -->
									<button class="submit login_btn" type="submit">登录</button>
								</div>
								
								<div class="bot_link">
									<a href="/chinese/join.do">成为会员</a>
								</div>
							
								<span style="color: red; text-align: center; display: block;" readonly>
									${loginFailMsg}
								</span>
								
								<div class="bot_link2">
									<span class="findid"> 
										当您忘记 ID 或密码时,请点击
										<a class="bot_link" href="#">这里</a>
									</span>
								</div>
							</form>
						</div>
					</c:when>
			</c:choose>
			
			<div class="center-button">
				<a href=" /oauth2/authorization/google" class="image-button"></a>
			</div>
				
			</div>
			
			<div class="right">
				<div class="right-inductor"></div>
			</div>

		</div>
	</section>
</body>

</html>