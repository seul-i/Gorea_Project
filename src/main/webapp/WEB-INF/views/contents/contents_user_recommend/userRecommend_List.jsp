<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="com.gorea.dto_board.Gorea_Recommend_BoardTO"%>
<%@ page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<c:set var="language" value="${language}" />
<c:set var="paging" value="${paging}" />
<c:set var="boardList1" value="${paging.boardList1}" />
<c:set var="lists" value="${requestScope.lists}" />

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Go!rea</title>
    <link rel="stylesheet" type="text/css" href="/css/userRecommend/list.css">
    <link rel="stylesheet" type="text/css" href="/css/header/header.css">
	<link rel="stylesheet" type="text/css" href="/css/footer/footer.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.css"/>
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    <script>
	    // 이전 페이지로 이동하는 함수
	    function goToPreviousPage() {
	        var currentPage = ${paging.cpage};
	
	        // 현재 페이지가 1페이지인 경우에는 동작하지 않도록 체크
	        if (currentPage > 1) {
	            // 이동할 URL 생성
	            var url = "/${language}/userRecomList.do?cpage=" + (currentPage - 1);
	
	            // 실제로 페이지 이동
	            window.location.href = url;
	        }
	    }
    </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/includes/header${language}.jsp"></jsp:include>
	<div class="board_wrap">
		<div class="board_title">
	        <strong>유저추천</strong>
	    </div>
	    <div class="board_list_wrap">
	        <div class="board_list">
	            <div class="top">
	                <div class="num">번호</div>
	                <div class="title">제목</div>
	                <div class="writer">글쓴이</div>
	                <div class="date">작성일</div>
	                <div class="recommend">추천수</div>
	                <div class="count">조회</div>
	            </div>
	            
	            <!-- list 부분 -->
	            <c:if test="${empty lists}">
                    <div style="text-align: center; padding: 20px; font-size: 18px;">
                        등록된 게시글이 없습니다.
                    </div>
                </c:if>
                
	            <c:if test="${not empty lists}">
	              	<c:forEach var="to" items="${lists}">
	                    <div>
	                        <div class='num'>${to.userRecomSeq}</div>
	                        <div class='title'><a href='/${language}/userRecomView.do?seq=<c:out value="${to.userRecomSeq}" />'><c:out value="${to.userRecomTitle}" /></a></div>
	                        <div class='writer'>${to.userNickname}</div>
	                        <div class='date'>${to.userRecompostDate}</div>
	                        <div class='recommend'>${to.userRecomcount }</div>
	                        <div class='count'><c:out value="${to.userRecomHit}" /></div>
	                    </div>
	                </c:forEach>
	            </c:if>
	            
	          </div>
	      	<div class="bottom-container">   
	        	<div class="pagination">
				<!-- 처음 페이지 버튼 -->
					<c:choose>
						<c:when test="${paging.cpage == 1}">
							<span class="pagination-item disabled">&lt;&lt;</span>
						</c:when>
						<c:otherwise>
							<a href="/${language}/userRecomList.do?cpage=1" class="pagination-item">&lt;&lt;</a>
						</c:otherwise>
					</c:choose>
	
				<!-- 이전 페이지 버튼 -->
					<c:choose>
						<c:when test="${paging.cpage == 1}">
							<span class="pagination-item disabled">&lt;</span>
						</c:when>
						<c:otherwise>
							<a href="/${language}/userRecomList.do?cpage=${paging.cpage - 1}" class="pagination-item">&lt;</a>
						</c:otherwise>
					</c:choose>
		
					<!-- 페이지 번호 -->
					<c:choose>
						<c:when test="${paging.totalPage <= 5}">
							<!-- 페이지 개수가 5 이하인 경우 -->
							<c:forEach var="i" begin="${1}" end="${paging.totalPage}" varStatus="loop">
								<c:choose>
									<c:when test="${i == paging.cpage}">
										<span class="pagination-item active">${i}</span>
									</c:when>
									<c:otherwise>
										<a href="/${language}/userRecomList.do?cpage=${i}" class="pagination-item">${i}</a>
									</c:otherwise>
								</c:choose>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<!-- 페이지 개수가 5 초과인 경우 -->
							<c:forEach var="i" begin="${paging.firstPage}" end="${paging.lastPage}" varStatus="loop">
								<c:choose>
									<c:when test="${i == paging.cpage}">
										<span class="pagination-item active">${i}</span>
									</c:when>
									<c:otherwise>
										<a href="/${language}/userRecomList.do?cpage=${i}" class="pagination-item">${i}</a>
									</c:otherwise>
								</c:choose>
							</c:forEach>
						</c:otherwise>
					</c:choose>
	
					<!-- 다음 페이지 버튼 -->
					<c:choose>
						<c:when test="${paging.cpage == paging.totalPage}">
							<span class="pagination-item disabled">&gt;</span>
						</c:when>
						<c:otherwise>
							<a href="$/${language}/userRecomList.do?cpage=${paging.cpage + 1}"
								class="pagination-item">&gt;</a>
						</c:otherwise>
					</c:choose>
		
					<!-- 마지막 페이지 버튼 -->
					<c:choose>
						<c:when test="${paging.cpage == paging.totalPage}">
							<span class="pagination-item disabled">&gt;&gt;</span>
						</c:when>
						<c:otherwise>
							<a href="$/${language}/userRecomList.do?cpage=${paging.totalPage}" class="pagination-item">&gt;&gt;</a>
						</c:otherwise>
					</c:choose>
				</div>		           
	        </div>
	        <!-- 쓰기 버튼 -->
	        <br />
	        <div class="write_button_container">
		        <a href="userRecomWrite.do" class="write_button">글쓰기</a>
		    </div>
		    <div class="search_container">
           		<form action="userRecomList.do" method="get">
    				<select name="searchType">
        				<option value="title">제목</option>
        				<option value="titleContent">제목 + 내용</option>
    				</select>
    			<input type="text" name="searchKeyword" placeholder="검색어 입력">
    			<input type="submit" value="검색">
				</form>
        	</div>
	    </div>
    </div>
    <jsp:include page="/WEB-INF/views/includes/footer.jsp"></jsp:include>
    
</body>
</html>
