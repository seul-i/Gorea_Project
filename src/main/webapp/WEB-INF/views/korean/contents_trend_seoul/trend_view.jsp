<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<c:set var="seq" value="${param.go_seoul_seq}" />
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
                <div class="post-title">${to.go_seoul_subject}</div>
                <div class="post-info">
                    <div class="post-info-right">
                        <span class="post-info-item">작성일: ${to.go_seoul_wdate}</span>
                        <span class="post-info-item">조회수: ${to.go_seoul_hit}</span>
                    </div>
                </div>
                <div class="post-content">
                    <div class="content-img">
                        <img src="../../upload/${to.firstImageUrl}" alt="">
                    </div>
                    <div class="content-text">
                        <span>${to.go_seoul_content}</span>
                    </div>
                    
                    <div class="content-info">
                        <div class="phone-number">
                            <span class="label">전화번호</span>
                            <span class="mark">:</span>
                            <span class="value">${to.tel}</span>
                        </div>
                        <div class="address">
                            <span class="label">주소</span>
                            <span class="mark">:</span>
                            <span class="value">${to.address}</span>
                        </div>
                        <div class="amenity">
                            <span class="label">편의시설</span>
                            <span class="mark">:</span>
                            <span class="value">${to.facilities}</span>
                        </div>
                        <div class="transport-info">
                            <span class="label">교통 정보</span>
                            <span class="mark">:</span>
                            <span class="value">${to.traffic_info}</span>
                        </div>
                    </div>
                </div>  
                
                <div id="map" data-address="${to.address}"></div>
                
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
                    <div class="sub-comment">
                        <div class="comment">
                            <div class="comment-header">
                                <div class="comment-author">김철수</div>
                            </div>
                            <div class="comment-body">대댓글 내용입니다.</div>
                            <div class="comment-actions">
                                <span class="comment-timestamp">2023-01-02 16:15 <a href="#">답변쓰기</a></span>
                                <div>
                                    <a href="#">수정</a>
                                    <a href="#">삭제</a>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="sub-comment">
                        <div class="comment">
                            <div class="comment-header">
                                <div class="comment-author">김철수</div>
                            </div>
                            <div class="comment-body">대댓글 내용입니다.</div>
                            <div class="comment-actions">
                                <span class="comment-timestamp">2023-01-02 16:15 <a href="#">답변쓰기</a></span>
                                <div>
                                    <a href="#">수정</a>
                                    <a href="#">삭제</a>
                                </div>
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
                    <input type="button" value="삭제" class="btn" style="cursor: pointer;" onclick="location.href='trend_delete_ok.do?go_seoul_seq=${seq}'" />
                    <input type="button" value="수정" class="btn" style="cursor: pointer;" onclick="location.href='trend_modify.do?go_seoul_seq=${seq}'" />
                    <button class="btn" onclick="location.href='trend_seoul.do'">목록</button>
                </div>
            </div>
        </section>
    </main>
    <jsp:include page="/WEB-INF/views/korean/includes/footer.jsp"></jsp:include>
</body>
</html>
