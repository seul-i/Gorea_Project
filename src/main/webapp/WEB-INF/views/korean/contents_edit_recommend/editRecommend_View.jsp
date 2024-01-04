<%@page import="com.gorea.dto_board.Gorea_EditRecommend_BoardTO"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<c:set var="paging" value="${requestScope.paging}" />

<!DOCTYPE html>
<%
    request.setCharacterEncoding("utf-8");
    String seq = request.getParameter("editrecoSeq");
    
    Gorea_EditRecommend_BoardTO to = (Gorea_EditRecommend_BoardTO)request.getAttribute("to");
    
    String subject = to.getEditrecoSubject();
    String subtitle = to.getEditrecoSubtitle();
    String hit = to.getEditrecoHit(); 
    String content = to.getEditrecoContent();
    String wdate = to.getEditrecoWdate();
    String uid = to.getUid();
    String filename = to.getFilename();
    
%>

<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>게시판 뷰</title>
    <link rel="stylesheet" type="text/css" href="/css/view/style.css">
    <link rel="stylesheet" type="text/css" href="/css/view/view.css">
    <script src="https://kit.fontawesome.com/42d55d598f.js" crossorigin="anonymous"></script>
</head>
<body>
    
        <jsp:include page="/WEB-INF/views/korean/includes/header.jsp"></jsp:include>
    
	<div class="location">
		<i class="fa-solid fa-house"></i> <span class="ar">></span> 추천 <span class="ar">></span> <span> <a href="./editRecommend_list.do">에디터
				추천 장소</a>
		</span>
	</div>
    <section class="infor-element">
        
        <div class="infor-title">
            <p class="h4">에디터 추천 장소</p>
            
            <h3 class="h3 textcenter"><%= subject %></h3> 

            <div class="post-element">
                <span>제작일 : <%= wdate %></span> <span>조회수 : <%= hit %></span>
            </div>

            <div class="text-area">
                <img class="blog-image"><%= content %>
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
        <div class="post-actions" style="text-align: right; margin-top: 10px;">
            <input type="button" value="삭제" class="btn" style="cursor: pointer;" onclick="location.href='editRecommend_delete_ok.do?editrecoSeq=<%=seq %>'" />
            <input type="button" value="수정" class="btn" style="cursor: pointer;" onclick="location.href='editRecommend_modify.do?editrecoSeq=<%=seq %>'" />
            <input type="button" value="목록" class="btn" style="cursor: pointer;" onclick="location.href='editRecommend_list.do'" />
        </div>
        
        
    </div>
                               
    </section>

</body>
</html>
