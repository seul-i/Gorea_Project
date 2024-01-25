<%@ page import="com.gorea.dto_board.Gorea_Notice_BoardTO"%>
<%@ page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="language" value="${language}" />
<c:set var="paging" value="${paging}" />
<c:set var="notice" value="${paging.notice}" />
<c:set var="role"
	value="${SPRING_SECURITY_CONTEXT.authentication.principal.gorea_UserTO.userRole}" />
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Go!rea</title>
<link rel="stylesheet" type="text/css" href="/css/notice/list.css">
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script>
    	
    // 이전 페이지로 이동하는 함수
    function goToPreviousPage() {
        var currentPage = ${paging.cpage};

        // 현재 페이지가 1페이지인 경우에는 동작하지 않도록 체크
        if (currentPage > 1) {
            // 이동할 URL 생성
            var url = "/${language}/notice.do?cpage=" + (currentPage - 1);

            // 실제로 페이지 이동
            window.location.href = url;
        }
    }
    
    </script>
</head>
<body>
	<jsp:include page="/WEB-INF/views/includes/header${language}.jsp"></jsp:include>
	
	<div class="commonBanner" id="comBanner">
        <img src="/img/banner/noticeBanner.jpg" alt="banner">
        <div class="commonBanner-text">
            <h1>
            <c:choose>
                <c:when test="${language eq 'korean'}">공지사항</c:when>
                <c:when test="${language eq 'english'}">announcement</c:when>
                <c:when test="${language eq 'japanese'}">お知らせ</c:when>
                <c:when test="${language eq 'chinese'}">公告</c:when>
            </c:choose>
            </h1>
        </div>
    </div>
    
    <div class="location">
		<i class="fa-solid fa-house"></i> <span class="ar">></span>
		<c:choose>
			<c:when test="${language eq 'korean'}">
         
	            여행자 지원 <span class="ar">></span>
				<span> <a href="./bestTop5.do.do">공지사항</a>
				</span>

			</c:when>
			<c:when test="${language eq 'english'}">
         
	            Traveler Assistance <span class="ar">></span>
				<span> <a href="./bestTop5.do.do">announcement</a>
				</span>

			</c:when>
			<c:when test="${language eq 'japanese'}">
         
	            旅行者サポート <span class="ar">></span>
				<span> <a href="./bestTop5.do.do">お知らせ</a>
				</span>

			</c:when>
			<c:when test="${language eq 'chinese'}">
         
            
	            旅客协助 <span class="ar">></span>
				<span> <a href="./bestTop5.do.do">公告</a>
				</span>

			</c:when>

			<c:otherwise>제목</c:otherwise>
		</c:choose>
	</div>
	
	<div class="board_wrap">
		<div class="board_title">
		<strong>
		<c:choose>
                <c:when test="${language eq 'korean'}">공지사항</c:when>
                <c:when test="${language eq 'english'}">announcement</c:when>
                <c:when test="${language eq 'japanese'}">お知らせ</c:when>
                <c:when test="${language eq 'chinese'}">公告</c:when>
        </c:choose>
        </strong>
		</div>
		<div class="board_list_wrap">
			<div class="board_list">
				<div class="top">
				
				<c:choose>
		                <c:when test="${language eq 'korean'}">
		                
		                <div class="num">번호</div>
						<div class="title">제목</div>
						<div class="writer">글쓴이</div>
						<div class="date">작성일</div>
						<div class="count">조회</div>
		                
		                </c:when>
		                
		                <c:when test="${language eq 'english'}">
		                
		                <div class="num">Number</div>
						<div class="title">Title</div>
						<div class="writer">Author</div>
						<div class="date">Date of Writing</div>
						<div class="count">Comment</div>
		                
		                </c:when>
		                
		                
		                <c:when test="${language eq 'japanese'}">
		                
		                <div class="num">番号</div>
						<div class="title">タイトル</div>
						<div class="writer">著者</div>
						<div class="date">投稿日</div>
						<div class="count">コメント</div>
		                
		                </c:when>
		                
		                <c:when test="${language eq 'chinese'}">
		                
		                <div class="num">编号 </div>
						<div class="title">标题</div>
						<div class="writer">作者</div>
						<div class="date">创作日期 </div>
						<div class="count">评论</div>
		                
		                </c:when>
		        </c:choose>
				
				</div>

				<c:if test="${empty lists}">
					<div style="text-align: center; padding: 20px; font-size: 18px;">
						등록된 게시글이 없습니다.</div>
				</c:if>
				<c:if test="${not empty lists}">
					<c:forEach items="${lists}" var="to">
						<div>
							<div class='num'>${to.noticeSeq}</div>
							<div class='title'>
								<a href='./notice_view.do?noticeSeq=${to.noticeSeq}<c:if test="${not empty param.cpage}">&cpage=${param.cpage}</c:if><c:if test="${not empty param.searchType}">&searchType=${param.searchType}</c:if><c:if test="${not empty param.searchKeyword}">&searchKeyword=${param.searchKeyword}</c:if>'>
									${to.noticeTitle} </a>
							</div>
							<div class='writer'>관리자</div>
							<div class='date'>${to.noticepostDate}</div>
							<div class='count'>${to.noticeHit}</div>
						</div>
					</c:forEach>
				</c:if>
			</div>
			<div class="bottom-container">
				<div class="pagination-container">
					<div class="pagination">
						<!-- 처음 페이지 버튼 -->
						<c:if test="${paging.cpage > 1}">
							<a
								href="/${language}/notice.do?cpage=1<c:if test="${not empty param.searchType and not empty param.searchKeyword}">&searchType=${param.searchType}&searchKeyword=${param.searchKeyword}</c:if>"
								class="pagination-item">&lt;&lt;</a>
							<a
								href="/${language}/notice.do?cpage=${paging.cpage - 1}<c:if test="${not empty param.searchType and not empty param.searchKeyword}">&searchType=${param.searchType}&searchKeyword=${param.searchKeyword}</c:if>"
								class="pagination-item">&lt;</a>
						</c:if>
						<c:if test="${paging.cpage == 1}">
							<span class="pagination-item disabled">&lt;&lt;</span>
							<span class="pagination-item disabled">&lt;</span>
						</c:if>

						<!-- 페이지 번호 -->
						<c:forEach var="i" begin="${paging.firstPage}"
							end="${paging.lastPage}" varStatus="loop">
							<c:choose>
								<c:when test="${i == paging.cpage}">
									<span class="pagination-item active">${i}</span>
								</c:when>
								<c:otherwise>
									<a
										href="/${language}/notice.do?cpage=${i}<c:if test="${not empty param.searchType and not empty param.searchKeyword}">&searchType=${param.searchType}&searchKeyword=${param.searchKeyword}</c:if>"
										class="pagination-item">${i}</a>
								</c:otherwise>
							</c:choose>
						</c:forEach>

						<!-- 다음 페이지 버튼 -->
						<c:if test="${paging.cpage < paging.totalPage}">
							<a
								href="/${language}/notice.do?cpage=${paging.cpage + 1}<c:if test="${not empty param.searchType and not empty param.searchKeyword}">&searchType=${param.searchType}&searchKeyword=${param.searchKeyword}</c:if>"
								class="pagination-item">&gt;</a>
							<a
								href="/${language}/notice.do?cpage=${paging.totalPage}<c:if test="${not empty param.searchType and not empty param.searchKeyword}">&searchType=${param.searchType}&searchKeyword=${param.searchKeyword}</c:if>"
								class="pagination-item">&gt;&gt;</a>
						</c:if>
						<c:if test="${paging.cpage == paging.totalPage}">
							<span class="pagination-item disabled">&gt;</span>
							<span class="pagination-item disabled">&gt;&gt;</span>
						</c:if>
					</div>
				</div>
			</div>
			
			<div class="writeBtnBox">
				<c:choose>
					<c:when test="${role eq 'ROLE_ADMIN'}">
						<div class="write_button_container">
							<a href="notice_write.do" class="write_button">글쓰기</a>
						</div>
					</c:when>
				</c:choose>
			</div>

			<div class="search_container">
				<form action="notice.do" method="get">
					<select name="searchType">
						<option value="title">제목</option>
						<option value="titleContent">제목 + 내용</option>
					</select> <input type="text" name="searchKeyword" placeholder="검색어 입력">
					<input type="submit" value="검색">
				</form>
			</div>
		</div>
	</div>
	<jsp:include page="/WEB-INF/views/includes/footer.jsp"></jsp:include>
</body>
</html>
