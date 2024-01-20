<%@page import="org.json.JSONObject"%>
<%@page import="org.json.JSONArray"%>
<%@page import="com.gorea.dto_reply.Gorea_ReplyTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="utf-8"%>
<%
	List<Gorea_ReplyTO> datas = (List)request.getAttribute( "lists" );

	JSONArray arr = new JSONArray();
	for( Gorea_ReplyTO rto : datas ){
		String pseq = rto.getPseq();
		String goreaboardNo = rto.getGoreaboardNo();
		String cseq = rto.getCseq();
		String userSeq = rto.getUserSeq();
		String userNickname = rto.getUserNickname();
		String replyContent = rto.getReplyContent();
		String replypostDate = rto.getReplypostDate();
		int wgap = rto.getWgap();
		
		int grp = rto.getGrp();
		int grpl = rto.getGrpl();
		
		JSONObject obj = new JSONObject();
		obj.put( "pseq", pseq );
		obj.put( "goreaboardNo", goreaboardNo );
		obj.put( "cseq", cseq );
		obj.put( "userSeq", userSeq );
		obj.put( "userNickname", userNickname );
		obj.put( "replyContent", replyContent );
		obj.put( "replypostDate",replypostDate );
		obj.put( "wgap", wgap );
		obj.put( "grp", grp );
		obj.put( "grpl", grpl );
		
		arr.put( obj );
	}
	
	out.println( arr );
%>