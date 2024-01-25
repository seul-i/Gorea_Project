<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.File" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<c:set var="flag" value="${requestScope.flag}" />
<c:set var="cpage" value="${param.cpage}" />
<c:set var="searchType" value="${param.searchType}" />
<c:set var="qnaSeq" value="${param.qnaSeq}" />
<c:set var="searchKeyword" value="${fn:escapeXml(param.searchKeyword)}" />

<!-- URL 기본 구조 설정 및 쿼리 문자열 생성 -->
<c:url var="finalUrl" value="adminqna.do">
    <c:param name="qnaSeq" value="${qnaSeq}" />
    <c:param name="cpage" value="${cpage}" />
    <c:param name="searchType" value="${searchType}" />
    <c:param name="searchKeyword" value="${searchKeyword}" />
</c:url>

<!-- flag 값에 따라 조건부 리다이렉트 -->
<c:choose>
    <c:when test="${flag == 0}">
        <!-- 글 수정 성공 시 리다이렉트 -->
        <script type="text/javascript">
            window.location.href = "${finalUrl}";
</script>
</c:when>
<c:otherwise>
<!-- 글 수정 실패 시 다른 처리 -->
<!-- <c:redirect url="errorPage.jsp" /> -->
</c:otherwise>
</c:choose>