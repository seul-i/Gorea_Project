<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.File" %>
<%
	request.setCharacterEncoding("utf-8");
	
	int flag = (Integer)request.getAttribute("flag");
	
	out.println("<script type='text/javascript'>");
	if(flag == 0){
		// 정상
		out.println("alert('글 삭제 성공');");
		out.println("location.href = 'userRecomList.do';");
	} else if(flag == 1) {
		// 에러
		out.println("alert('글 삭제 실패.');");
		out.println("history.back();");
	}
		out.println("</script>");
%>