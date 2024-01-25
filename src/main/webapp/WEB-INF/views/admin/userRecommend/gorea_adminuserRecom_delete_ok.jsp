<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.File" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:set var="flag" value="${requestScope.flag}" />
<c:set var="cpage" value="${param.cpage}" />
<c:set var="searchType" value="${param.searchType}" />
<c:set var="searchKeyword" value="${param.searchKeyword}" />

<!-- URL 기본 구조 설정 -->
<c:set var="redirectUrl" value="adminuserRecom.do" />

<!-- URL에 추가할 쿼리 문자열 생성 -->
<c:set var="queryParams" value="" />
<c:if test="${not empty cpage}">
    <c:set var="queryParams" value="${queryParams}${empty queryParams ? '' : '&'}cpage=${cpage}" />
</c:if>
<c:if test="${not empty searchType}">
    <c:set var="queryParams" value="${queryParams}${empty queryParams ? '' : '&'}searchType=${searchType}" />
</c:if>
<c:if test="${not empty searchKeyword}">
    <c:set var="queryParams" value="${queryParams}${empty queryParams ? '' : '&'}searchKeyword=${searchKeyword}" />
</c:if>

<!-- 최종 URL 생성 -->
<c:set var="finalUrl" value="${redirectUrl}${not empty queryParams ? '?' : ''}${queryParams}" />

<script type='text/javascript'>
    var flag = <c:out value="${flag}" />;
    var redirectUrl = <c:out value="${finalUrl}" />;

    if (flag === 0) {
        alert('글 삭제 성공');
        location.href = redirectUrl;
    } else if (flag === 1) {
        alert('글 삭제 실패');
        history.back();
    }
</script>

<!-- 삭제 후 noticeboard.do로 리다이렉트 -->
<c:redirect url="${finalUrl}" />