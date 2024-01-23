<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="seq" value="${param.noticeSeq}" />
<c:set var="to" value="${requestScope.to}" />
<c:set var="language" value="${language}" />
<c:set var="role"
	value="${SPRING_SECURITY_CONTEXT.authentication.principal.gorea_UserTO.userRole}" />
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>GO!rea</title>
    <link rel="stylesheet" type="text/css" href="/css/notice/view.css">
</head>
<body>
	<jsp:include page="/WEB-INF/views/includes/header${language}.jsp"></jsp:include>
    <div class="containers">
        <div class="post-title"><c:out value="${to.noticeTitle}" /></div>
        <div class="post-info">
            <div class="post-info-left">
                <span class="post-info-item">작성자: 관리자</span>
            </div>
            <div class="post-info-right">
                <span class="post-info-item">작성일: <c:out value="${to.noticepostDate}"  escapeXml="false"/></span>
                <span class="post-info-item">조회수: <c:out value="${to.noticeHit}" escapeXml="false"/></span>
            </div>
        </div>
        <div class="post-content">
            <c:out value="${to.noticeContent}" escapeXml="false" />
        </div>
        <c:url var="deleteUrl" value="/${language}/notice_delete_ok.do">
            <c:param name="noticeSeq" value="${seq}" />
            <c:if test="${not empty param.cpage}"><c:param name="cpage" value="${param.cpage}" /></c:if>
            <c:if test="${not empty param.searchType}"><c:param name="searchType" value="${param.searchType}" /></c:if>
            <c:if test="${not empty param.searchKeyword}"><c:param name="searchKeyword" value="${param.searchKeyword}" /></c:if>
        </c:url>

        <c:url var="modifyUrl" value="/${language}/notice_modify.do">
            <c:param name="noticeSeq" value="${seq}" />
            <c:if test="${not empty param.cpage}"><c:param name="cpage" value="${param.cpage}" /></c:if>
            <c:if test="${not empty param.searchType}"><c:param name="searchType" value="${param.searchType}" /></c:if>
            <c:if test="${not empty param.searchKeyword}"><c:param name="searchKeyword" value="${param.searchKeyword}" /></c:if>
        </c:url>

        <c:url var="listUrl" value="/${language}/notice.do">
            <c:if test="${not empty param.cpage}"><c:param name="cpage" value="${param.cpage}" /></c:if>
            <c:if test="${not empty param.searchType}"><c:param name="searchType" value="${param.searchType}" /></c:if>
            <c:if test="${not empty param.searchKeyword}"><c:param name="searchKeyword" value="${param.searchKeyword}" /></c:if>
        </c:url>

       <div class="post-actions">
    <!-- 이전글, 다음글 버튼 그룹 -->
    <div class="left-buttons">
        <c:if test="${not empty prevPost}">
            <input type="button" value="이전글" class="btn" onclick="location.href='notice_view.do?noticeSeq=${prevPost.noticeSeq}&cpage=${param.cpage}&searchType=${param.searchType}&searchKeyword=${fn:escapeXml(param.searchKeyword)}'" />
        </c:if>
        <c:if test="${not empty nextPost}">
            <input type="button" value="다음글" class="btn" onclick="location.href='notice_view.do?noticeSeq=${nextPost.noticeSeq}&cpage=${param.cpage}&searchType=${param.searchType}&searchKeyword=${fn:escapeXml(param.searchKeyword)}'" />
        </c:if>
    </div>

    <!-- 삭제, 수정, 목록 버튼 그룹 -->
    <div class="right-buttons">
    <c:choose>
	<c:when test="${role eq 'ROLE_ADMIN'}">
        <input type="button" value="삭제" class="btn" onclick="confirmDelete('${deleteUrl}')" />
        <input type="button" value="수정" class="btn" onclick="location.href='${modifyUrl}'" />
        </c:when>
        </c:choose>
        <input type="button" value="목록" class="btn" onclick="location.href='${listUrl}'" />
    </div>
</div>
    </div>
    <script>
    function confirmDelete(deleteUrl) {
        if (confirm("글을 삭제하시겠습니까?")) {
            location.href = deleteUrl;
        }
    }
</script>
<jsp:include page="/WEB-INF/views/includes/footer.jsp"></jsp:include>
</body>
</html>
