<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="paging" value="${paging}" />
<c:set var="freeboard" value="${paging.freeboard}" />

<c:set var="userSeq" value="${SPRING_SECURITY_CONTEXT.authentication.principal.gorea_UserTO.userSeq}" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Go!rea</title>
<link rel="stylesheet" type="text/css" href="/css/mypage/mypageHeader.css">
<link rel="stylesheet" type="text/css" href="/css/mypage/board.css">
 <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.css"/>
    <script>
    	
    // 이전 페이지로 이동하는 함수
    function goToPreviousPage() {
        var currentPage = ${paging.cpage};

        // 현재 페이지가 1페이지인 경우에는 동작하지 않도록 체크
        if (currentPage > 1) {
            // 이동할 URL 생성
            var url = "/${language}/boardList.do?cpage=" + (currentPage - 1);

            // 실제로 페이지 이동
            window.location.href = url;
        }
    }
    </script>
    
</head>
<body>
<jsp:include page="/WEB-INF/views/includes/header${language}.jsp"></jsp:include>
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
	                    <c:when test="${language eq 'korean'}">게시글 관리</c:when>
	                    <c:when test="${language eq 'english'}">Posts Management</c:when>
	                    <c:when test="${language eq 'japanese'}">投稿の管理</c:when>
	                    <c:when test="${language eq 'chinese'}">管理职位</c:when>
	            	</c:choose>
                </b>
            </div>

<!-- 
             <div class="board-select">
                <select id="boardType" name="boardType">
                	<option value="free">전체게시판</option>
                    <option value="free">자유게시판</option>
                    <option value="recommend">여행자 추천 게시판</option>
                    <option value="best">Best Top5 게시판</option>
                </select>
            </div>  -->
             <div class="board-wrap">
			    <table class="board-list">
			        <thead>
			            <th class="col-num">
			                <c:choose>
			                    <c:when test="${language eq 'korean'}">대상 게시판</c:when>
			                    <c:when test="${language eq 'english'}">Target Board</c:when>
			                    <c:when test="${language eq 'japanese'}">対象掲示板</c:when>
			                    <c:when test="${language eq 'chinese'}">目标留言板</c:when>
			                </c:choose>
			            </th>
			            <th class="col-title">
			                <c:choose>
			                    <c:when test="${language eq 'korean'}">제목</c:when>
			                    <c:when test="${language eq 'english'}">Title</c:when>
			                    <c:when test="${language eq 'japanese'}">タイトル</c:when>
			                    <c:when test="${language eq 'chinese'}">标题</c:when>
			                </c:choose>
			            </th>
			            <th class="col-writer">
			                <c:choose>
			                    <c:when test="${language eq 'korean'}">글쓴이</c:when>
			                    <c:when test="${language eq 'english'}">Writer</c:when>
			                    <c:when test="${language eq 'japanese'}">作成者</c:when>
			                    <c:when test="${language eq 'chinese'}">作者</c:when>
			                </c:choose>
			            </th>
			            <th class="col-date">
			                <c:choose>
			                    <c:when test="${language eq 'korean'}">작성일</c:when>
			                    <c:when test="${language eq 'english'}">Date</c:when>
			                    <c:when test="${language eq 'japanese'}">投稿日</c:when>
			                    <c:when test="${language eq 'chinese'}">创建日期</c:when>
			                </c:choose>
			            </th>
			            <th class="col-count">
			                <c:choose>
			                    <c:when test="${language eq 'korean'}">조회수</c:when>
			                    <c:when test="${language eq 'english'}">Views</c:when>
			                    <c:when test="${language eq 'japanese'}">閲覧数</c:when>
			                    <c:when test="${language eq 'chinese'}">浏览量</c:when>
			                </c:choose>
			            </th>
			        </thead>
			
					<!-- 여행자 추천, BestTop5 부분 추가 & 에디터 추천 x -->
			        <c:choose>
			            <c:when test="${not empty lists}">
						    <c:forEach var="board" items="${lists}">
						        <tbody>
						            <tr class="boardList">
						                <td>
						                    <c:choose>
						                        <c:when test="${board.boardType eq '자유게시판'}">
						                            <c:choose>
						                                <c:when test="${language eq 'korean'}">자유게시판</c:when>
						                                <c:when test="${language eq 'english'}">Free Board</c:when>
						                                <c:when test="${language eq 'japanese'}">フリーボード</c:when>
						                                <c:when test="${language eq 'chinese'}">自由板</c:when>
						                            </c:choose>
						                        </c:when>
						                        <c:when test="${board.boardType eq '에디터 추천'}">
						                            <c:choose>
						                                <c:when test="${language eq 'korean'}">에디터 추천</c:when>
						                                <c:when test="${language eq 'english'}">Editor's Recommend</c:when>
						                                <c:when test="${language eq 'japanese'}">編集者のおすすめ</c:when>
						                                <c:when test="${language eq 'chinese'}">编辑推荐</c:when>
						                            </c:choose>
						                        </c:when>
						                    </c:choose>
						                </td>
						                <td>
					                    <c:choose>
					                        <c:when test="${board.boardType eq '자유게시판'}">
					                            <a href="/${language}/freeboard_view.do?freeSeq=${board.id}">${board.title}</a>
					                        </c:when>
					                        <c:when test="${board.boardType eq '에디터 추천'}">
					                            <a href="/${language}/editRecommend_view.do?editrecoSeq=${board.id}">${board.title}</a>
					                        </c:when>
					                    </c:choose>
						                </td>
						                <td>${board.userNickname}</td>
						                <td>${board.postDate}</td>
						                <td>${board.hit}</td>
						            </tr>
						        </tbody>
						    </c:forEach>
						</c:when>
			            <c:otherwise>
			                <tbody>
			                    <tr>
			                        <td colspan="5">
			                            <c:choose>
			                                <c:when test="${language eq 'korean'}">등록된 게시물이 없습니다.</c:when>
			                                <c:when test="${language eq 'english'}">No registered posts.</c:when>
			                                <c:when test="${language eq 'japanese'}">登録された投稿はありません。</c:when>
			                                <c:when test="${language eq 'chinese'}">没有注册的帖子。</c:when>
			                            </c:choose>
			                        </td>
			                    </tr>
			                </tbody>
			            </c:otherwise>
			        </c:choose>
			    </table>
			</div>

                 <div class="bottom-container">
					    <div class="pagination-container">
					        <div class="pagination">
					        <!-- 처음 페이지 버튼 -->
					        <c:if test="${paging.cpage > 1}">
					            <a href="/user/${language}/boardList.do?userSeq=${userSeq }cpage=1" class="pagination-item">&lt;&lt;</a>
					            <a href="/user/${language}/boardList.do?userSeq=${userSeq }&cpage=${paging.cpage - 1}" class="pagination-item">&lt;</a>
					        </c:if>
					        <c:if test="${paging.cpage == 1}">
					            <span class="pagination-item disabled">&lt;&lt;</span>
					            <span class="pagination-item disabled">&lt;</span>
					        </c:if>
					
					        <!-- 페이지 번호 -->
							<c:forEach var="i" begin="${paging.firstPage}" end="${paging.lastPage}" varStatus="loop">
							    <c:choose>
							        <c:when test="${i == paging.cpage}">
							            <span class="pagination-item active">${i}</span>
							        </c:when>
							        <c:otherwise>
							            <a href="/user/${language}/boardList.do?userSeq=${userSeq}&cpage=${i}" class="pagination-item">${i}</a>
							        </c:otherwise>
							    </c:choose>
							</c:forEach>

					
					        <!-- 다음 페이지 버튼 -->
					        <c:if test="${paging.cpage < paging.totalPage}">
					            <a href="/user/${language}/boardList.do?userSeq=${userSeq}&cpage=${paging.cpage + 1}" class="pagination-item">&gt;</a>
					            <a href="/user/${language}/boardList.do?userSeq=${userSeq}&cpage=${paging.totalPage}" class="pagination-item">&gt;&gt;</a>
					        </c:if>
					        <c:if test="${paging.cpage == paging.totalPage}">
					            <span class="pagination-item disabled">&gt;</span>
					            <span class="pagination-item disabled">&gt;&gt;</span>
					        </c:if>
					    </div>
					    </div>
					</div>
               	</div>
		</div>
    </section> 
    <jsp:include page="/WEB-INF/views/includes/footer.jsp"></jsp:include> 
</body>
</html>