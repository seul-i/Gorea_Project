<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- <%
	request.setCharacterEncoding("utf-8");
	int flag = (Integer)request.getAttribute("flag");

	out.println( "<script type='text/javascript'>" );
	if( flag == 0 ) {
		out.println( "alert( '글쓰기 성공' );" );
		out.println( "location.href='/korean/userRecom.do';" );
	} else if( flag == 1 ) {
		out.println( "alert( '글쓰기 실패' );" );
		out.println( "history.back();" );
	}
	out.println( "</script>" );
%> --%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:set var="flag" value="${requestScope.flag}" />

<script type='text/javascript'>
    <c:choose>
        <c:when test="${flag == 0}">
            alert('글쓰기 성공');
            location.href='userRecom.do';
        </c:when>
        <c:when test="${flag == 1}">
            alert('글쓰기 실패');
            history.back();
        </c:when>
    </c:choose>
</script>