<%@ page import="com.gorea.dto_board.Gorea_EditTip_BoardTO"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<c:set var="seq" value="${param.edittipSeq}" />
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>게시판 뷰</title>
    <link rel="stylesheet" type="text/css" href="/css/editor/style.css">
    <link rel="stylesheet" type="text/css" href="/css/editor/view.css">
    <script src="https://kit.fontawesome.com/42d55d598f.js" crossorigin="anonymous"></script>
</head>
<body>
    

	<div class="location">
		 추천 <span class="ar">></span> <span>
			<a href="./editTip_list.do">에디터 추천 장소</a>
		</span>
	</div>
    <section class="infor-element">
        
        <div class="infor-title">
            <p class="h4">에디터 추천 장소</p>
            
            <h3 class="h3 textcenter">${eto.edittipSubject}</h3> 

            <div class="post-element">
                <span>제작일 : ${eto.edittipWdate}</span> <span>조회수 : ${eto.edittipHit}</span>
            </div>

            <div class="text-area">
                <img class="blog-image">${eto.edittipContent}
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
            <button class="w-btn-outline w-btn-blue-outline" type="button" onclick="location.href='editTip_delete_ok.do?edittipSeq=${seq}'"> 삭제 </button>
            <button class="w-btn-outline w-btn-blue-outline" type="button" onclick="location.href='editTip_modify.do?edittipSeq=${seq}'"> 수정 </button>
            <button class="w-btn-outline w-btn-blue-outline" type="button" onclick="location.href='editTip_list.do'"> 목록 </button>
        </div>
    </div>
                               
    </section>
</body>
</html>
