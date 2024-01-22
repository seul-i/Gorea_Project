<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<c:set var="seq" value="${param.qnaSeq}" />
<c:set var="to" value="${requestScope.to}" />
<c:set var="language" value="${language}" />
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>GO!rea</title>
    <link rel="stylesheet" type="text/css" href="/css/qna/view.css">
</head>
<body>
    <div class="containers">
        <div class="post-title"><c:out value="${to.qnaTitle}" /></div>
        <div class="post-info">
            <div class="post-info-left">
                <span class="post-info-item">작성자: 관리자</span>
            </div>
            <div class="post-info-right">
                <span class="post-info-item">작성일: <c:out value="${to.qnapostDate}"  escapeXml="false"/></span>
            </div>
        </div>
        <div class="post-content">
            <c:out value="${to.qnaContent}" escapeXml="false" />
        </div>
        <div class="comment-section">
            <div class="comments-count">댓글 3개</div>
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
            <!-- 여기에 추가 댓글 및 대댓글이 들어갑니다 -->
        </div>
        <div class="comment-form">
            <textarea placeholder="댓글을 입력하세요"></textarea>
            <button class="btn">댓글 작성</button>
        </div>
        <div class="post-actions">
            <input type="button" value="삭제" class="btn" style="cursor: pointer;" onclick="location.href='qna_delete_ok.do?qnaSeq=${seq}'" />
            <input type="button" value="수정" class="btn" style="cursor: pointer;" onclick="location.href='qna_modify.do?qnaSeq=${seq}'" />
            <input type="button" value="목록" class="btn" style="cursor: pointer;" onclick="location.href='qna.do'" />
        </div>
    </div>
</body>
</html>
