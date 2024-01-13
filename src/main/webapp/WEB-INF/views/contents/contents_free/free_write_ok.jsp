<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:set var="flag" value="${requestScope.flag}" />

<script type='text/javascript'>
    <c:choose>
        <c:when test="${flag == 0}">
            alert('글쓰기 성공');
            location.href='freeboard.do';
        </c:when>
        <c:when test="${flag == 1}">
            alert('글쓰기 실패');
            history.back();
        </c:when>
    </c:choose>
</script>