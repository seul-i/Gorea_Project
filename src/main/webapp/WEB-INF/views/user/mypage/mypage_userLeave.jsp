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
		        	<c:choose>
		                  <c:when test="${language eq 'korean'}"><h1>마이페이지</h1></c:when>
		                  <c:when test="${language eq 'english'}"><h1>MyPage</h1></c:when>
		                  <c:when test="${language eq 'japanese'}"><h1>マイページ</h1></c:when>
		                  <c:when test="${language eq 'chinese'}"><h1>我的页面</h1></c:when>
		          	</c:choose>
		    	</div>
		    </div>

	 	  <div class="menuContainer">
		    <div class="menuinner">
		        <div class="mypage-menuBtn">
		            <a href="userMypage.do" class="mypagebtn active userInfo">
		                <c:choose>
		                    <c:when test="${language eq 'korean'}">회원정보</c:when>
		                    <c:when test="${language eq 'english'}">User Information</c:when>
		                    <c:when test="${language eq 'japanese'}">ユーザー情報</c:when>
		                    <c:when test="${language eq 'chinese'}">用户信息</c:when>
		                </c:choose>
		            </a>
		            <a href="userBoardList.do?userSeq=${userSeq}" class="mypagebtn active boardList">
		                <c:choose>
		                    <c:when test="${language eq 'korean'}">게시글 관리</c:when>
		                    <c:when test="${language eq 'english'}">Posts Management</c:when>
		                    <c:when test="${language eq 'japanese'}">投稿の管理</c:when>
		                    <c:when test="${language eq 'chinese'}">管理职位</c:when>
		                </c:choose>
		            </a>
		            <a href="userReplyList.do?userSeq=${userSeq}" class="mypagebtn active replyList">
		                <c:choose>
		                    <c:when test="${language eq 'korean'}">댓글 관리</c:when>
		                    <c:when test="${language eq 'english'}">Reply Management</c:when>
		                    <c:when test="${language eq 'japanese'}">返信の管理</c:when>
		                    <c:when test="${language eq 'chinese'}">管理回复</c:when>
		                </c:choose>
		            </a>
		            <a href="#" class="mypagebtn active likeList">
		                <c:choose>
		                    <c:when test="${language eq 'korean'}">즐겨찾기</c:when>
		                    <c:when test="${language eq 'english'}">Favorites</c:when>
		                    <c:when test="${language eq 'japanese'}">お気に入りの</c:when>
		                    <c:when test="${language eq 'chinese'}">收藏夹</c:when>
		                </c:choose>
		            </a>
		            <a href="userQnaList.do?userSeq=${userSeq}" class="mypagebtn active qna">
		                <c:choose>
		                    <c:when test="${language eq 'korean'}">1:1 문의내역</c:when>
		                    <c:when test="${language eq 'english'}">1:1 Inquiries</c:when>
		                    <c:when test="${language eq 'japanese'}">1:1 お問い合わせ</c:when>
		                    <c:when test="${language eq 'chinese'}">1:1 咨询</c:when>
		                </c:choose>
		            </a>
		            <a href="userDropAccount.do?userSeq=${userSeq}" class="mypagebtn active bye">
		                 <c:choose>
		                    <c:when test="${language eq 'korean'}">회원탈퇴</c:when>
		                    <c:when test="${language eq 'english'}">Drop Account</c:when>
		                    <c:when test="${language eq 'japanese'}">アカウントを削除する</c:when>
		                    <c:when test="${language eq 'chinese'}">删除帐户</c:when>
		                </c:choose>
		            </a>
		        </div>
		    </div>
		</div>
			
		<section class="mypage-section">
		    <div class="mypage-container">
		        <div class="menu-title">
		            <b>
		                <c:choose>
		                    <c:when test="${language eq 'korean'}">회원탈퇴</c:when>
		                    <c:when test="${language eq 'english'}">Drop Account</c:when>
		                    <c:when test="${language eq 'japanese'}">アカウントを削除する</c:when>
		                    <c:when test="${language eq 'chinese'}">删除帐户</c:when>
		                </c:choose>
		            </b>
		        </div>
		        <div class="caution-comment">
		            <div class="commnet-header">
		                <span>
		                    <c:choose>
		                        <c:when test="${language eq 'korean'}">탈퇴 안내</c:when>
		                        <c:when test="${language eq 'english'}">Withdrawal Guide</c:when>
		                        <c:when test="${language eq 'japanese'}">退会案内</c:when>
		                        <c:when test="${language eq 'chinese'}">退出 通知</c:when>
		                    </c:choose>
		                </span>
		            </div>
		            <div class="commnet-body">
		                <p class="comment">
		                    <c:choose>
		                        <c:when test="${language eq 'korean'}">회원탈퇴를 신청하기 전에 안내 사항을 확인해 주세요.</c:when>
		                        <c:when test="${language eq 'english'}">Before Applying For withdrawal, Please Check The Guidance.</c:when>
		                        <c:when test="${language eq 'japanese'}">退会申請をする前に案内事項を確認してください。</c:when>
		                        <c:when test="${language eq 'chinese'}">在申请退出之前，请查看指南。</c:when>
		                    </c:choose>
		                </p>
		                <p class="comment">
		                    <c:choose>
		                        <c:when test="${language eq 'korean'}">회원탈퇴를 신청 시 해당 아이디는 즉시 탈퇴처리되며 회원정보는 모두 삭제됩니다.</c:when>
		                        <c:when test="${language eq 'english'}">When applying for withdrawal, the corresponding ID will be immediately terminated, and all member information will be deleted.</c:when>
		                        <c:when test="${language eq 'japanese'}">退会申請をすると、該当のIDはすぐに解約され、会員情報はすべて削除されます。</c:when>
		                        <c:when test="${language eq 'chinese'}">申请退出后，相应的ID将立即终止，所有会员信息将被删除</c:when>
		                    </c:choose>
		                </p>
		                <p class="comment">
		                    <c:choose>
		                        <c:when test="${language eq 'korean'}">회원탈퇴 신청하시기 전에 신중히 생각하시기 바랍니다.</c:when>
		                        <c:when test="${language eq 'english'}">Please think carefully before applying for withdrawal.</c:when>
		                        <c:when test="${language eq 'japanese'}">退会申請をする前に慎重に考えてください。</c:when>
		                        <c:when test="${language eq 'chinese'}">在申请退出之前，请仔细考虑。</c:when>
		                    </c:choose>
		                </p>
		            </div>
		        </div>
		        <form name="info_form" method="post">
		            <input type="hidden" value="${userSeq}">
		            <div class="info_write">
		                <div class="form-group">
		                    <div class="title">
		                        <label for="userid">
		                            <c:choose>
		                                <c:when test="${language eq 'korean'}">회원탈퇴 계정</c:when>
		                                <c:when test="${language eq 'english'}">Drop Account ID</c:when>
		                                <c:when test="${language eq 'japanese'}">アカウントを削除 ID</c:when>
		                                <c:when test="${language eq 'chinese'}">删除帐户 ID</c:when>
		                            </c:choose>
		                        </label>
		                    </div>
		                    <div class="input">
		                        <input type="text" id="userid" name="userid" value="${userid}" readonly>
		                    </div>
		                </div>
		                <div class="form-group">
		                    <div class="title">
		                        <label for="password">
		                            <c:choose>
		                                <c:when test="${language eq 'korean'}">비밀번호</c:when>
		                                <c:when test="${language eq 'english'}">Password</c:when>
		                                <c:when test="${language eq 'japanese'}">パスワード</c:when>
		                                <c:when test="${language eq 'chinese'}">密码</c:when>
		                            </c:choose>
		                        </label>
		                    </div>
		                    <div class="input">
		                        <input type="password" id="password" name="password" value="">
		                    </div>
		                </div>
		            </div>
		            <div class="userInfo_btn">
		                <a href="/${language}/main.do" class="userInfoBtn">
		                    <c:choose>
		                        <c:when test="${language eq 'korean'}">메인이동</c:when>
		                        <c:when test="${language eq 'english'}">Go to Main</c:when>
		                        <c:when test="${language eq 'japanese'}">メインに移動</c:when>
		                        <c:when test="${language eq 'chinese'}">转到主页</c:when>
		                    </c:choose>
		                </a>
	                	<c:choose>
						    <c:when test="${language eq 'korean'}">
						        <input type="submit" class="userInfoBtn" value="회원탈퇴하기">
						    </c:when>
						    <c:when test="${language eq 'english'}">
						        <input type="submit" class="userInfoBtn" value="Drop Accout">
						    </c:when>
						    <c:when test="${language eq 'japanese'}">
						        <input type="submit" class="userInfoBtn" value="会員脱退する">
						    </c:when>
						    <c:when test="${language eq 'chinese'}">
						        <input type="submit" class="userInfoBtn" value="退出会员">
						    </c:when>
						</c:choose>
					</div>
		        </form>
		    </div>
		</section>
   
	   	</div>
	</c:if>
   <jsp:include page="/WEB-INF/views/includes/footer.jsp"></jsp:include> 
</body>
</html>