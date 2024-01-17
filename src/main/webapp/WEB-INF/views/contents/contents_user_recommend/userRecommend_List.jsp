<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="com.gorea.dto_board.Gorea_Recommend_BoardTO"%>
<%@ page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<c:set var="language" value="${language}" />
<c:set var="paging" value="${paging}" />
<c:set var="boardList" value="${paging.boardList}" />
<c:set var="lists" value="${requestScope.lists}" />

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>유저추천</title>
    <link rel="stylesheet" type="text/css" href="/css/userRecommend/board.css">
    <link rel="stylesheet" type="text/css" href="/css/header/header.css">
	<link rel="stylesheet" type="text/css" href="/css/footer/footer.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.css"/>
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    <style>
        * {
            margin: 0;
            padding: 0;
        }

        html {
            font-size: 10px;
        }

        .main {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100%;
            font-family: Arial, sans-serif; /* 폰트 스타일을 원하는 대로 설정할 수 있습니다 */
            margin-top : 30px;
        }

        ul, li {
            list-style: none;
        }

        a {
            text-decoration: none;
            color: inherit;
        }

        .board_wrap {
        	height: 100%;
            width: 1000px;
        }

        .board_title {
            margin-bottom: 30px;
            text-align: center;
        }

        .board_title strong {
            font-size: 3rem;
        }

        .board_title p {
            margin-top: 5px;
            font-size: 1.3rem;
        }

        .bt_wrap {
            margin-top: 30px;
            text-align: center;
            font-size: 0;
        }

        .bt_wrap a {
            display: inline-block;
            min-width: 80px;
            margin-left: 10px;
            padding: 10px;
            border: 1px solid #000;
            border-radius: 2px;
            font-size: 1.3rem;
        }

        .bt_wrap a:first-child {
            margin-left: 0;
        }

        .bt_wrap a.on {
            background: #000;
            color: #fff;
        }

        .board_list {
            width: 100%;
            border-top: 2px solid #000;
        }

        .board_list > div {
            border-bottom: 1px solid #ddd;
            font-size: 0;
        }

        .board_list > div.top {
            border-bottom: 1px solid #999;
        }

        .board_list > div:last-child {
            border-bottom: 1px solid #000;
        }

        .board_list > div > div {
            display: inline-block;
            padding: 15px 0;
            text-align: center;
            font-size: 1.3rem;
        }

        .board_list > div.top > div {
            font-weight: 600;
        }

        .board_list .num {
            width: 10%;
        }

        .board_list .title {
            width: 60%;
            text-align: left;
        }

        .board_list .top .title {
            text-align: center;
        }

        .board_list .writer {
            width: 10%;
        }

        .board_list .date {
            width: 10%;
        }

        .board_list .count {
            width: 10%;
        }

        .board_page {
            margin-top: 30px;
            text-align: center;
            font-size: 0;
        }

        .board_page a {
            display: inline-block;
            width: 32px;
            height: 32px;
            box-sizing: border-box;
            vertical-align: middle;
            border: 1px solid #ddd;
            border-left: 0;
            line-height: 100%;
        }

        .board_page a.bt {
            padding-top: 10px;
            font-size: 1.2rem;
            letter-spacing: -1px;
        }

        .board_page a.num {
            padding-top: 9px;
            font-size: 1.4rem;
        }

        .board_page a.num.on {
            border-color: #000;
            background: #000;
            color: #fff;
        }

        .board_page a:first-child {
            border-left: 1px solid #ddd;
        }

        @media (max-width: 1000px) {
            .board_wrap {
                width: 80%;
                min-width: 320px;
                padding: 0 30px;
                box-sizing: border-box;
            }

            .board_list .num,
            .board_list .writer {
                display: none;
            }

            .board_list .date {
                width: 30%;
            }

            .board_list .title {
                text-indent: 10px;
            }

            .board_list .top .title {
                text-indent: 0;
            }

            .board_page a {
                width: 26px;
                height: 26px;
            }

            .board_page a.bt {
                padding-top: 7px;
            }
            
            .board_page a.num {
                padding-top: 6px;
            }
	
			.board_title strong {
		    	font-size: 1.8rem;
			}
			
			.pagination {
			    display: flex;
			    justify-content: center;
			    align-items: center;
			    margin-top: 10px; /* 원하는 간격으로 조절 */
			}
			
			.pagination-item {
			    /* 현재 스타일을 유지하면서 필요한 경우 추가 스타일을 정의합니다. */
			    margin: 0 5px; /* 페이지 번호 간격을 조절할 수 있습니다. */
			}
        }
    </style>
    
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

	<div class="main">
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
	                    <div class="count">조회</div>
	                </div>
	                <!-- list 부분 -->
	                <c:if test="${not empty lists}">
	                <c:forEach var="to" items="${lists}">
	                    <div>
	                        <div class='num'><c:out value="${to.userRecomSeq}" /></div>
	                        <div class='title'><a href='/${language}/userRecomView.do?seq=<c:out value="${to.userRecomSeq}" />'><c:out value="${to.userRecomTitle}" /></a></div>
	                        <div class='writer'><c:out value="${to.userNickname}" /></div>
	                        <div class='date'><c:out value="${to.userRecompostDate}" /></div>
	                        <div class='count'><c:out value="${to.userRecomHit}" /></div>
	                    </div>
	                </c:forEach>
	                </c:if>
	            </div>
	            
	        <div class="pagination">
			<!-- 처음 페이지 버튼 -->
			<c:choose>
				<c:when test="${paging.cpage == 1}">
					<span class="pagination-item disabled">&lt;&lt;</span>
				</c:when>
				<c:otherwise>
					<a href="/${language}/userRecomList.do?cpage=1"
						class="pagination-item">&lt;&lt;</a>
				</c:otherwise>
			</c:choose>
	
			<!-- 이전 페이지 버튼 -->
			<c:choose>
				<c:when test="${paging.cpage == 1}">
					<span class="pagination-item disabled">&lt;</span>
				</c:when>
				<c:otherwise>
					<a href="/${language}/userRecomList.do?cpage=${paging.cpage - 1}"
						class="pagination-item">&lt;</a>
				</c:otherwise>
			</c:choose>
	
			<!-- 페이지 번호 -->
			<c:choose>
				<c:when test="${paging.totalPage <= 5}">
					<!-- 페이지 개수가 5 이하인 경우 -->
					<c:forEach var="i" begin="${1}" end="${paging.totalPage}"
						varStatus="loop">
						<c:choose>
							<c:when test="${i == paging.cpage}">
								<span class="pagination-item active">${i}</span>
							</c:when>
							<c:otherwise>
								<a href="/${language}/userRecomList.do?cpage=${i}"
									class="pagination-item">${i}</a>
							</c:otherwise>
						</c:choose>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<!-- 페이지 개수가 5 초과인 경우 -->
					<c:forEach var="i" begin="${paging.firstPage}"
						end="${paging.lastPage}" varStatus="loop">
						<c:choose>
							<c:when test="${i == paging.cpage}">
								<span class="pagination-item active">${i}</span>
							</c:when>
							<c:otherwise>
								<a href="/${language}/userRecomList.do?cpage=${i}"
									class="pagination-item">${i}</a>
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
					<a href="$/${language}/userRecomList.do?cpage=${paging.totalPage}"
						class="pagination-item">&gt;&gt;</a>
				</c:otherwise>
			</c:choose>
			</div>
	            
	        </div>
	        <div class="btn_area">
	            <div class="align_right">
	                <input type="button" value="쓰기" class="btn_write btn_txt01" style="cursor: pointer;" onclick="location.href='./userRecomWrite.do'" />
	            </div>
	        </div>
	    </div>
    </div>
    
    <jsp:include page="/WEB-INF/views/includes/footer.jsp"></jsp:include>
    
</body>
</html>
