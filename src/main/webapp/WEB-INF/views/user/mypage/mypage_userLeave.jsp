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
	<link rel="stylesheet" type="text/css" href="/css/mypage/userLeave.css">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.css"/>
</head>
<body>
<jsp:include page="/WEB-INF/views/includes/header${language}.jsp"></jsp:include>
	<c:if test="${not empty SPRING_SECURITY_CONTEXT}">
		<!-- 시큐리티 컨텍스트에서 사용자 정보를 가져옴 -->
		<c:set var="userSeq" value="${SPRING_SECURITY_CONTEXT.authentication.principal.gorea_UserTO.userSeq}" />
		<c:set var="userid" value="${SPRING_SECURITY_CONTEXT.authentication.principal.gorea_UserTO.username}" />
		<c:set var="nickname" value="${SPRING_SECURITY_CONTEXT.authentication.principal.gorea_UserTO.userNickname}" />
		
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
	               <a href="qnaList.do?userSeq=${userSeq }" class="mypagebtn active qna">1:1 문의내역</a>
	               <a href="userLeave.do?userSeq=${userSeq }" class="mypagebtn active bye">회원탈퇴</a>
	           </div>
	       </div>
	   </div>
			
		<section class="mypage-section">
	       	 	<div class="mypage-container">
	            	<div class="menu-title">
	                	<b>회원탈퇴</b>
	            	</div>
	            	<div class="caution-comment">
	            		<div class="commnet-header">
	            			<span>탈퇴 안내</span>
	            		</div>
	            		<div class="commnet-body">
	            			<p class="comment">회원탈퇴를 신청하기 전에 안내 사항을 확인해 주세요.</p>
	            			<p class="comment">회원탈퇴를 신청 시 해당 아이디는 즉시 탈퇴처리되며 회원정보는 모두 삭제됩니다</p>
	            			<p class="comment">이후 해당 아이디는 영구적으로 사용이 중지되므로 해당 아이디로는 재가입이 불가능합니다.</p>
	            			<p class="comment">회원탈퇴 신청하시기 전에 신중히 생각하시기 바랍니다.
	            		</div>
	            	</div>
	            	
	            	<form name="info_form" method="post">
	            		<input type="hidden" value="${userSeq }">
	              	  <div class="info_write">
                  	 	<div class="form-group">
                   	    	<div class="title">
	                    	        <label for="userid">회원탈퇴 계정</label>
                    	    </div>
	                        <div class="input">
	                            <input type="text" id="userid" name="userid" value="${userid}" readonly>
	                        </div>
	                    </div>
	                    <div class="form-group">
                   	    	<div class="title">
	                    	        <label for="password">비밀번호</label>
                    	    </div>
	                        <div class="input">
	                            <input type="password" id="password" name="password" value="">
	                        </div>
	                    </div>
	                </div>
	
	                <div class="userInfo_btn">
	                    <a href="/${language}/main.do" class="userInfoBtn">메인이동</a>
	                    <input type="submit" class="userInfoBtn" value="회원탈퇴하기">
	                </div>
	            </form>
	        </div>
	    </section>   
	   	</div>
	</c:if>
   <jsp:include page="/WEB-INF/views/includes/footer.jsp"></jsp:include> 
</body>
</html>