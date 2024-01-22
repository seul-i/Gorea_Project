<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:set var="flag" value="${requestScope.flag}" />

<script type="text/javascript">
    <c:choose>
        <c:when test="${flag eq 0}">
            alert('글 삭제 성공');
            location.href = 'editRecommend_list.do';
        </c:when>
        <c:when test="${flag eq 1}">
            alert('글 삭제 실패.');
            history.back();
        </c:when>
    </c:choose>
</script>
