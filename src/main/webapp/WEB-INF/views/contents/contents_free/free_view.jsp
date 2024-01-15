<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<c:set var="seq" value="${param.freeSeq}" />
<c:set var="to" value="${requestScope.to}" />
<c:set var="language" value="${language}" />
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>GO!rea</title>
    <link rel="stylesheet" type="text/css" href="/css/freeboard/view.css">
</head>
<body>
	<jsp:include page="/WEB-INF/views/includes/header${language}.jsp"></jsp:include>
    <div class="containers">
        <div class="post-title"><c:out value="${to.freeTitle}" /></div>
        <div class="post-info">
            <div class="post-info-left">
                <span class="post-info-item">작성자: 아무개</span>
            </div>
            <div class="post-info-right">
                <span class="post-info-item">작성일: <c:out value="${to.freepostDate}"/></span>
                <span class="post-info-item">조회수: <c:out value="${to.freeHit}"/></span>
            </div>
        </div>
        <div class="post-content">
            <c:out value="${to.freeContent}" escapeXml="false" />
        </div>
        <!-- 추천 버튼과 추천 수 -->
		<button onclick="increaseLikes('${seq}')">추천</button>
        <div class="comment-section">
            <div class="comments-count">추천 <span id="like-count">${to.freeRecomcount}</span>개 댓글 3개</div>
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
        <c:url var="deleteUrl" value="/${language}/freeboard_delete_ok.do">
            <c:param name="freeSeq" value="${seq}" />
            <c:if test="${not empty param.cpage}"><c:param name="cpage" value="${param.cpage}" /></c:if>
            <c:if test="${not empty param.searchType}"><c:param name="searchType" value="${param.searchType}" /></c:if>
            <c:if test="${not empty param.searchKeyword}"><c:param name="searchKeyword" value="${param.searchKeyword}" /></c:if>
        </c:url>

        <c:url var="modifyUrl" value="/${language}/freeboard_modify.do">
            <c:param name="freeSeq" value="${seq}" />
            <c:if test="${not empty param.cpage}"><c:param name="cpage" value="${param.cpage}" /></c:if>
            <c:if test="${not empty param.searchType}"><c:param name="searchType" value="${param.searchType}" /></c:if>
            <c:if test="${not empty param.searchKeyword}"><c:param name="searchKeyword" value="${param.searchKeyword}" /></c:if>
        </c:url>

        <c:url var="listUrl" value="/${language}/freeboard.do">
            <c:if test="${not empty param.cpage}"><c:param name="cpage" value="${param.cpage}" /></c:if>
            <c:if test="${not empty param.searchType}"><c:param name="searchType" value="${param.searchType}" /></c:if>
            <c:if test="${not empty param.searchKeyword}"><c:param name="searchKeyword" value="${param.searchKeyword}" /></c:if>
        </c:url>

       <div class="post-actions">
    <!-- 이전글, 다음글 버튼 그룹 -->
    <div class="left-buttons">
        <c:if test="${not empty prevPost}">
            <input type="button" value="이전글" class="btn" onclick="location.href='freeboard_view.do?freeSeq=${prevPost.freeSeq}&cpage=${param.cpage}&searchType=${param.searchType}&searchKeyword=${fn:escapeXml(param.searchKeyword)}'" />
        </c:if>
        <c:if test="${not empty nextPost}">
            <input type="button" value="다음글" class="btn" onclick="location.href='freeboard_view.do?freeSeq=${nextPost.freeSeq}&cpage=${param.cpage}&searchType=${param.searchType}&searchKeyword=${fn:escapeXml(param.searchKeyword)}'" />
        </c:if>
    </div>

    <!-- 삭제, 수정, 목록 버튼 그룹 -->
    <div class="right-buttons">
        <input type="button" value="삭제" class="btn" onclick="confirmDelete('${deleteUrl}')" />
        <input type="button" value="수정" class="btn" onclick="location.href='${modifyUrl}'" />
        <input type="button" value="목록" class="btn" onclick="location.href='${listUrl}'" />
    </div>
</div>
    </div>
    <script>
function increaseLikes(freeSeq) {
    fetch('/increaseLikes?freeSeq=' + freeSeq, { method: 'POST' })
        .then(response => response.text())
        .then(likes => {
            // 추천 수를 페이지에 표시
            document.getElementById('like-count').innerText = likes;
        });
}

function confirmDelete(deleteUrl) {
    if (confirm("글을 삭제하시겠습니까?")) {
        location.href = deleteUrl;
    }
}
</script>
<jsp:include page="/WEB-INF/views/includes/footer.jsp"></jsp:include>
</body>
</html>
