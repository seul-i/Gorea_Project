<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<c:set var="seq" value="${param.seoulSeq}" />
<c:set var="to" value="${requestScope.to}" />

<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>게시판 뷰</title>
    <link rel="stylesheet" type="text/css" href="/css/trendseoul/view.css">
    <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyA_q0lUg_FtwRv09Y4bdwoxyXOwC0Fs3tA&libraries=places&callback=initMap" defer></script>
    
    <script src="/js/map/map.js"></script>
</head>
<body>
    <jsp:include page="/WEB-INF/views/korean/includes/header.jsp"></jsp:include>
    <main>
        <section>
            <div class="container">
            	<div class="category">${to.subCategory} </div>
                <div class="post-title">${to.seoulTitle}</div>
                <div class="post-info">
                    <div class="post-info-right">
                        <span class="post-info-item">작성일: ${to.seoulpostDate}</span>
                        <span class="post-info-item">조회수: ${to.seoulHit}</span>
                    </div>
                </div>
                <div class="post-content">
                    <div class="content-img">
                        <img src="../../upload/${to.firstImageUrl}" alt="">
                    </div>
                    <div class="content-text">
                        <span>${to.seoulContent}</span>
                    </div>
                    
                    <div class="content-info">
                        <div class="info">
                            <span class="label">주소</span>
                            <span class="mark">:</span>
                            <span class="value">${to.seoulLoc}</span>
                        </div>
                        <div class="info">
                            <span class="label">사이트</span>
                            <span class="mark">:</span>
                            <span class="value">
                                <c:if test="${not empty to.seoulSite}">
                                    <a href="${to.seoulSite}" target="_blank">홈페이지</a>
                                </c:if>
                                <c:if test="${empty to.seoulSite}">
                                    정보 없음
                                </c:if>
                            </span>
                        </div>
                        <div class="info">
                            <span class="label">이용시간</span>
                            <span class="mark">:</span>
                            <span class="value">${to.seoulusageTime}</span>
                        </div>
                        <div class="info">
                            <span class="label">이용요금</span>
                            <span class="mark">:</span>
                            <span class="value">${to.seoulusageFee}</span>
                        </div>
                        <div class="info">
                            <span class="label">교통정보</span>
                            <span class="mark">:</span>
                            <span class="value">${to.seoulTrafficinfo}</span>
                        </div>
                        <div class="info">
                            <span class="label">꼭 알아야할 것</span>
                            <span class="mark">:</span>
                            <span class="value">${to.seoulNotice}</span>
                        </div>
                    </div>
                </div>
                
                <div id="map" data-address="${to.seoulLoc}"></div>
                
                <div class="map"> </div>
                <div class="comment-section">
                    <div class="comments-count">추천 5개 댓글 3개</div>
                    <div class="comment">
                        <div class="comment-header">
                            <div class="comment-author">이영희</div>
                        </div>
                        <div class="comment-body">댓글 내용입니다.</div>
                        <div class="comment-actions">
                            <span class="comment-timestamp">2023-01-02 16:15 <a href="#">답변쓰기</a></span>
                            <div>
                                <a href="#">수정</a>
                                <a href="#">삭제</a>
                            </div>
                        </div>
                    </div>
                    <!-- 추가 댓글들 -->
                </div>
                <div class="comment-form">
                    <textarea style="resize: none;" placeholder="댓글을 입력하세요"></textarea>
                    <button class="btn">댓글 작성</button>
                </div>
                <div class="post-actions" style="text-align: right; margin-top: 10px;">
                    <input type="button" value="삭제" class="btn" style="cursor: pointer;" onclick="location.href='trend_delete_ok.do?seoulSeq=${seq}'" />
                    <input type="button" value="수정" class="btn" style="cursor: pointer;" onclick="location.href='trend_modify.do?seoulSeq=${seq}'" />
                     <input type="button" value="목록" class="btn" style="cursor: pointer;" onclick="location.href='trend_seoul.do'" />
                </div>
            </div>
        </section>
    </main>
</body>
</html>
