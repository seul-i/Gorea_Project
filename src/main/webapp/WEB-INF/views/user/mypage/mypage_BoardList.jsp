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
    
    
    // ========================= 게시판 선택 =============================
    // 페이지 로딩 시 실행되는 함수
    window.onload = function () {
        // 선택된 게시판 값 가져오기
        var selectedBoard = document.getElementById("boardType").value;

        // TODO: 서버에 선택된 게시판에 대한 데이터 요청 및 처리
        // AJAX를 사용하여 서버에 요청하고, 응답을 받아서 화면을 업데이트하는 코드 작성
    }

    // 게시판 변경 시 실행되는 함수
    document.getElementById("boardType").addEventListener("change", function () {
        // 선택된 게시판 값 가져오기
        var selectedBoard = this.value;

        // TODO: 서버에 선택된 게시판에 대한 데이터 요청 및 처리
        // AJAX를 사용하여 서버에 요청하고, 응답을 받아서 화면을 업데이트하는 코드 작성
    });
    
    </script>
    
</head>
<body>
<jsp:include page="/WEB-INF/views/includes/header${language}.jsp"></jsp:include>
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
                <b>게시글 관리</b>
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
                        <th class="col-num">대상 게시판</th>
                        <th class="col-title">제목</th>
                        <th class="col-writer">글쓴이</th>
                        <th class="col-date">작성일</th>
                        <th class="col-count">조회수</th>
                    </thead>
                    
                    <c:choose>
                        <c:when test="${not empty lists}">
                            <c:forEach var="board" items="${lists}">
                                <tbody>
                                 <tr class="boardList">
                                    <td>${board.boardType }</td>
                                    <td>
                                        <c:choose>
											<c:when test="${board.boardType eq '자유게시판'}">
                                            <a href="/${language}/freeboard_view.do?freeSeq=${board.id}">${board.title}</a>
                                            </c:when>
                                            <c:when test="${board.boardType eq '에디터 추천'}">
                                                <a href="/${language}/editRecommend_view.do?editrecoSeq=${board.id}">${board.title}</a>
                                            </c:when>
                                        </c:choose>
                                        <!-- 여행자 추천, BestTop5 부분 추가 & 에디터 추천 x -->
                                    </td>
                                    <td>${board.userNickname }</td>
                                    <td>${board.postDate }</td>
                                    <td>${board.hit }</td>
                                 </tr>
                                </tbody>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <tbody>
                                <tr>
                                    <td colspan="5">등록된 게시물이 없습니다.</td>
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