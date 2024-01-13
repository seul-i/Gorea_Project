<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.File" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%
    request.setCharacterEncoding("utf-8");
    int flag = (Integer)request.getAttribute("flag");
%>

<script type="text/javascript">
    <c:choose>
        <c:when test="${flag == 0}">
            // 정상
            alert('글 수정 성공');
            location.href = 'editTip_list.do';
        </c:when>
        <c:when test="${flag == 1}">
            // 에러
            alert('글 수정 실패.');
            history.back();
        </c:when>
    </c:choose>
</script>
