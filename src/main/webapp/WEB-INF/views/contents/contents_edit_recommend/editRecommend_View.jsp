<%@ page import="com.gorea.dto_board.Gorea_EditRecommend_BoardTO"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<c:set var="language" value="${language}" />
<c:set var="seq" value="${param.editrecoSeq}" />
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>게시판 뷰</title>
    <link rel="stylesheet" type="text/css" href="/css/editor/view.css">
    <script src="https://kit.fontawesome.com/42d55d598f.js" crossorigin="anonymous"></script>
</head>
<body>
    <jsp:include page="/WEB-INF/views/includes/header${language}.jsp"></jsp:include>

	<div class="location">
		<i class="fa-solid fa-house"></i> <span class="ar">></span> 추천 <span class="ar">></span> <span>
			<a href="./editRecommend_list.do">에디터 추천 장소</a>
		</span>
	</div>
    <section class="infor-element">
        
        <div class="infor-title">
            <p class="h4">에디터 추천 장소</p>
            
            <h3 class="h3 textcenter">${to.editrecoSubject}</h3> 

            <div class="post-element">
                <span>제작일 : ${to.editrecoWdate}</span> <span>조회수 : ${to.editrecoHit}</span>
            </div>

            <div class="text-area">
                <img class="blog-image">${to.editrecoContent}
            </div>

            <div class="comment-section">
            <div class="comments-count">추천 5개 댓글 3개</div>
            <div class="comment">
                <div class="comment-header">
                    <div class="comment-author">이영희</div>
                </div>
                <div class="comment-body"></div>
                <div class="comment-actions">
                    <span class="comment-timestamp">2023-01-02 16:15</span>
                    <div>
                        <a href="#">수정</a>
                        <a href="#">삭제</a>
                    </div>
                </div>
            </div>
        </div>
        <div class="comment-form">
            <textarea style="resize: none;" placeholder="댓글을 입력하세요"></textarea>
        </div>
        <div class="comment-form-btn">
            <button class="btn">댓글 작성</button>
        </div>
        <div style="text-align: right; margin-right:25px; margin-top: 10px;">
            <button class="w-btn-outline w-btn-blue-outline" type="button" onclick="location.href='editRecommend_delete_ok.do?editrecoSeq=${seq}'"> 삭제 </button>
            <button class="w-btn-outline w-btn-blue-outline" type="button" onclick="location.href='editRecommend_modify.do?editrecoSeq=${seq}'"> 수정 </button>
            <button class="w-btn-outline w-btn-blue-outline" type="button" onclick="location.href='editRecommend_list.do'"> 목록 </button>
        </div>
    </div>
                               
    </section>
</body>
</html>
