<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.File" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:set var="flag" value="${requestScope.flag}" />
<c:set var="cpage" value="${param.cpage}" />
<c:set var="searchType" value="${param.searchType}" />
<c:set var="searchKeyword" value="${param.searchKeyword}" />
<c:set var="freeSeq" value="${param.freeSeq}" />

<!-- URL 기본 구조 설정 -->
<c:set var="redirectUrl" value="freeboard_view.do" />

<!-- URL에 추가할 쿼리 문자열 생성 -->
<c:set var="queryParams" value="" />
<c:if test="${not empty cpage}">
    <c:set var="queryParams" value="${queryParams}&cpage=${cpage}" />
</c:if>
<c:if test="${not empty searchType}">
    <c:set var="queryParams" value="${queryParams}&searchType=${searchType}" />
</c:if>
<c:if test="${not empty searchKeyword}">
    <c:set var="queryParams" value="${queryParams}&searchKeyword=${searchKeyword}" />
</c:if>

<!-- 최종 URL 생성 -->
<c:set var="finalUrl" value="${redirectUrl}?freeSeq=${freeSeq}${queryParams}" />

<!-- flag 값에 따라 조건부 리다이렉트 -->
<c:choose>
    <c:when test="${flag == 0}">
        <!-- 글 수정 성공 시 리다이렉트 -->
        <c:redirect url="${finalUrl}" />
    </c:when>
    <c:otherwise>
        <!-- 글 수정 실패 시 다른 처리 (예: 에러 페이지로 리다이렉트) -->
        <!-- <c:redirect url="errorPage.jsp" /> -->
    </c:otherwise>
</c:choose>
