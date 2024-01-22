<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="language" value="${language}" />
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Go!rea</title>
	<link rel="stylesheet" type="text/css" href="/css/mypage/mypageHeader.css">
	<link rel="stylesheet" type="text/css" href="/css/mypage/userInfo.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.css"/>
    
</head>
<body>
<jsp:include page="/WEB-INF/views/includes/header${language}.jsp"></jsp:include>
	<c:if test="${not empty SPRING_SECURITY_CONTEXT}">
		<!-- 시큐리티 컨텍스트에서 사용자 정보를 가져옴 -->
		<c:set var="userSeq" value="${SPRING_SECURITY_CONTEXT.authentication.principal.gorea_UserTO.userSeq}" />
		<c:set var="userid" value="${SPRING_SECURITY_CONTEXT.authentication.principal.gorea_UserTO.username}" />
		<c:set var="firstname" value="${SPRING_SECURITY_CONTEXT.authentication.principal.gorea_UserTO.userFirstname}" />
		<c:set var="lastname" value="${SPRING_SECURITY_CONTEXT.authentication.principal.gorea_UserTO.userLastname}" />
		<c:set var="nickname" value="${SPRING_SECURITY_CONTEXT.authentication.principal.gorea_UserTO.userNickname}" />
		<c:set var="mail" value="${SPRING_SECURITY_CONTEXT.authentication.principal.gorea_UserTO.userMail}" />
		<c:set var="country" value="${SPRING_SECURITY_CONTEXT.authentication.principal.gorea_UserTO.userNation}" />
		
    	<div class="main">
    		<div class="commonBanner" id="comBanner">
		        <img src="/img/banner/Top5Banner.jpg" alt="banner">
		        <div class="commonBanner-text">
		            <h1>마이페이지</h1>
		        </div>
		    </div>


 	   <div class="menuContainer">
	       <div class="menuinner">
	           <div class="mypage-menuBtn">
	               <a href="mypage.do" class="mypagebtn active userInfo">회원정보</a>
	               <a href="boardList.do?userSeq=${userSeq}" class="mypagebtn active boardList">게시글 관리</a>
	               <a href="replyList.do?userSeq=${userSeq}" class="mypagebtn active replyList">댓글 관리</a>
	               <a href="#" class="mypagebtn active likeList">즐겨찾기</a>
	               <a href="qnaList.do?userSeq=${userSeq}" class="mypagebtn active qna">1:1 문의내역</a>
	               <a href="userLeave.do?userSeq=${userSeq}" class="mypagebtn active bye">회원탈퇴</a>
	           </div>
	       </div>
	   </div>
			
		<section class="mypage-section">
	       	 	<div class="mypage-container">
	            	<div class="menu-title">
	                	<b>
            		 		<c:choose>
	                            <c:when test="${language eq 'korean'}">회원정보수정</c:when>
	                            <c:when test="${language eq 'english'}">Modify Member Information</c:when>
	                            <c:when test="${language eq 'japanese'}">会員情報の修正</c:when>
	                            <c:when test="${language eq 'chinese'}">修改会员信息</c:when>
                        </c:choose>
						</b>
	            	</div>
	            	<form name="info_form" method="post">
	              	  <div class="info_write">
                  	 	<div class="form-group">
                   	    	<div class="title">
	                    	        <label for="userid">아이디</label>
                    	    </div>
	                        <div class="input">
	                            <input type="text" id="userid" naem="userid" value="${userid}" readonly>
	                        </div>
	                    </div>
	                    <div class="form-group">
	                        <div class="title">
	                            <label for="password">비밀번호</label>
	                        </div>
	                        <div class="input">
	                            <input type="password" id="password" naem="password" value="" readonly>
	                        </div>
	                    </div>
	                    <div class="form-group">
	                        <div class="title">
	                            <label for="confirm_password">비밀번호 확인</label>
	                        </div>
	                        <div class="input">
	                            <input type="password" id="confirm_password" naem="confirm_password" value="" readonly>
	                        </div>
	                    </div>
	                    <div class="form-group">
	                        <div class="title">
	                            <label for="lastname">lastname</label>
	                        </div>
	                        <div class="input">
	                            <input type="text" id="lastname" naem="lastname" value="${lastname }" readonly>
	                        </div>
	                    </div>
	                    <div class="form-group">
	                        <div class="title">
	                            <label for="firstname">firstname</label>
	                        </div>
	                        <div class="input">
	                            <input type="text" id="firstname" naem="firstnmae" value="${firstname }" readonly>
	                        </div> 
	                    </div>
	                    <div class="form-group">
	                        <div class="title">
	                            <label for="nickname">닉네임</label>
	                        </div>
	                        <div class="input">
	                            <input type="text" id="nickname" naem="nickname" value="${nickname }" readonly>
	                        </div> 
	                    </div>
	                    <div class="form-group">
	                        <div class="title">
	                            <label for="email">이메일 주소:</label>
	                        </div>
	                        <div class="input">
	                            <input type="email" id="email" name="email" value="${mail }" readonly>
	                        </div>  
	                    </div>    
	                    <div class="form-group">
	                        <div class="title">
	                            <label for="email">국적</label>
	                        </div>
	                        <div class="input">
	                            <select id="country" name="country">
						            <option value="kr" ${country eq '대한민국' ? 'selected' : ''}>대한민국</option>
						            <option value="us" ${country eq '미국' ? 'selected' : ''}>미국</option>
						            <option value="jp" ${country eq '일본' ? 'selected' : ''}>일본</option>
						            <option value="cn" ${country eq '중국' ? 'selected' : ''}>중국</option>
						        </select>
	                        </div>  
	                    </div> 
	                </div>
	
	                <div class="userInfo_btn">
	                    <input type="submit" class="userInfoBtn" value="취소">
	                    <input type="submit" class="userInfoBtn" value="수정 완료">
	                </div>
	            </form>
	        </div>
	    </section>   
	   	</div>
	</c:if>
   <jsp:include page="/WEB-INF/views/includes/footer.jsp"></jsp:include> 
</body>
</html>