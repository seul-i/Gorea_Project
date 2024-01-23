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
	                    	    <c:choose>
		                            <c:when test="${language eq 'korean'}"><label for="userid">아이디</label></c:when>
		                            <c:when test="${language eq 'english'}"><label for="userid">ID</label></c:when>
		                            <c:when test="${language eq 'japanese'}"><label for="userid">ID</label></c:when>
		                            <c:when test="${language eq 'chinese'}"><label for="userid">ID</label></c:when>
                       			</c:choose>
                    	    </div>
	                        <div class="input">
	                            <input type="text" id="userid" name="userid" value="${userid}" readonly>
	                        </div>
	                    </div>
	                    <div class="form-group">
	                        <div class="title">
	                        	<c:choose>
		                            <c:when test="${language eq 'korean'}"><label for="password">비밀번호</label></c:when>
		                            <c:when test="${language eq 'english'}"><label for="password">password</label></c:when>
		                            <c:when test="${language eq 'japanese'}"><label for="password">パスワード</label></c:when>
		                            <c:when test="${language eq 'chinese'}"><label for="password">密码</label></c:when>
                       			</c:choose>
	                        </div>
	                        <div class="input">
	                            <input type="password" id="password" name="password" value="" readonly>
	                        </div>
	                    </div>
	                    <div class="form-group">
	                        <div class="title">
	                        	<c:choose>
		                            <c:when test="${language eq 'korean'}"><label for="confirm_password">비밀번호 확인</label></c:when>
		                            <c:when test="${language eq 'english'}"><label for="confirm_password">Confirm_Password</label></c:when>
		                            <c:when test="${language eq 'japanese'}"><label for="confirm_password">パスワードを認証する</label></c:when>
		                            <c:when test="${language eq 'chinese'}"><label for="confirm_password">确认密码</label></c:when>
                       			</c:choose>
	                        </div>
	                        <div class="input">
	                            <input type="password" id="confirm_password" name="confirm_password" value="" readonly>
	                        </div>
	                    </div>
	                    <div class="form-group">
	                        <div class="title">
	                        	<c:choose>
		                            <c:when test="${language eq 'korean'}"><label for="lastname">lastname</label></c:when>
		                            <c:when test="${language eq 'english'}"><label for="lastname">lastname</label></c:when>
		                            <c:when test="${language eq 'japanese'}"><label for="lastname">lastname</label></c:when>
		                            <c:when test="${language eq 'chinese'}"><label for="lastname">lastname</label></c:when>
                       			</c:choose>
	                        </div>
	                        <div class="input">
	                            <input type="text" id="lastname" name="lastname" value="${lastname }" readonly>
	                        </div>
	                    </div>
	                    <div class="form-group">
	                        <div class="title">
	                        	<c:choose>
		                            <c:when test="${language eq 'korean'}"><label for="firstname">firstname</label></c:when>
		                            <c:when test="${language eq 'english'}"><label for="firstname">firstname</label></c:when>
		                            <c:when test="${language eq 'japanese'}"><label for="firstname">firstname</label></c:when>
		                            <c:when test="${language eq 'chinese'}"><label for="firstname">firstname</label></c:when>
                       			</c:choose>
	                        </div>
	                        <div class="input">
	                            <input type="text" id="firstname" name="firstnmae" value="${firstname }" readonly>
	                        </div> 
	                    </div>
	                    <div class="form-group">
	                        <div class="title">
	                       		 <c:choose>
		                            <c:when test="${language eq 'korean'}"><label for="nickname">닉네임</label></c:when>
		                            <c:when test="${language eq 'english'}"><label for="nickname">nickname</label></c:when>
		                            <c:when test="${language eq 'japanese'}"><label for="nickname">ニックネーム</label></c:when>
		                            <c:when test="${language eq 'chinese'}"><label for="nickname">昵称</label></c:when>
                       			</c:choose>
	                        </div>
	                        <div class="input">
	                            <input type="text" id="nickname" name="nickname" value="${nickname }" readonly>
	                        </div> 
	                    </div>
	                    <div class="form-group">
	                        <div class="title">
	                        	 <c:choose>
		                            <c:when test="${language eq 'korean'}"><label for="email">이메일 주소</label></c:when>
		                            <c:when test="${language eq 'english'}"><label for="email">Email Address</label></c:when>
		                            <c:when test="${language eq 'japanese'}"><label for="email">電子メールアドレス</label></c:when>
		                            <c:when test="${language eq 'chinese'}"><label for="email">电子邮件地址</label></c:when>
                       			</c:choose>
	                        </div>
	                        <div class="input">
	                            <input type="email" id="email" name="email" value="${mail }" readonly>
	                        </div>  
	                    </div>    
	                    <div class="form-group">
						    <div class="title">
						        <label for="country">
						            <c:choose>
						                <c:when test="${language eq 'korean'}">국적</c:when>
						                <c:when test="${language eq 'english'}">Nationality</c:when>
						                <c:when test="${language eq 'japanese'}">国籍</c:when>
						                <c:when test="${language eq 'chinese'}">国籍</c:when>
						            </c:choose>
						        </label>
						    </div>
						    <div class="input">
						        <select id="country" name="country">
						            <option value="kr" ${country eq '대한민국' ? 'selected' : ''}>
						                <c:choose>
						                    <c:when test="${language eq 'korean'}">대한민국</c:when>
						                    <c:when test="${language eq 'english'}">South Korea</c:when>
						                    <c:when test="${language eq 'japanese'}">韓国</c:when>
						                    <c:when test="${language eq 'chinese'}">韩国</c:when>
						                </c:choose>
						            </option>
						            <option value="us" ${country eq '미국' ? 'selected' : ''}>
						                <c:choose>
						                    <c:when test="${language eq 'korean'}">미국</c:when>
						                    <c:when test="${language eq 'english'}">United States</c:when>
						                    <c:when test="${language eq 'japanese'}">アメリカ</c:when>
						                    <c:when test="${language eq 'chinese'}">美国</c:when>
						                </c:choose>
						            </option>
						            <option value="jp" ${country eq '일본' ? 'selected' : ''}>
						                <c:choose>
						                    <c:when test="${language eq 'korean'}">일본</c:when>
						                    <c:when test="${language eq 'english'}">Japan</c:when>
						                    <c:when test="${language eq 'japanese'}">日本</c:when>
						                    <c:when test="${language eq 'chinese'}">日本</c:when>
						                </c:choose>
						            </option>
						            <option value="cn" ${country eq '중국' ? 'selected' : ''}>
						                <c:choose>
						                    <c:when test="${language eq 'korean'}">중국</c:when>
						                    <c:when test="${language eq 'english'}">China</c:when>
						                    <c:when test="${language eq 'japanese'}">中国</c:when>
						                    <c:when test="${language eq 'chinese'}">中国</c:when>
						                </c:choose>
						            </option>
						        </select>
						    </div>
						</div>
	                </div>
	
	                <div class="userInfo_btn">
					    <input type="submit" class="userInfoBtn" value="<c:choose><c:when test='${language eq "korean"}'>취소</c:when><c:when test='${language eq "english"}'>Cancel</c:when><c:when test='${language eq "japanese"}'>キャンセル</c:when><c:when test='${language eq "chinese"}'>取消</c:when></c:choose>">
					    <input type="submit" class="userInfoBtn" value="<c:choose><c:when test='${language eq "korean"}'>수정 완료</c:when><c:when test='${language eq "english"}'>Complete Modification</c:when><c:when test='${language eq "japanese"}'>完全な修正</c:when><c:when test='${language eq "chinese"}'>完成修改</c:when></c:choose>">
					</div>

	            </form>
	        </div>
	    </section>   
	   	</div>
	</c:if>
   <jsp:include page="/WEB-INF/views/includes/footer.jsp"></jsp:include> 
</body>
</html>