
<%@page import="com.gorea.dto_board.Gorea_Recommend_BoardTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
	Gorea_Recommend_BoardTO to = (Gorea_Recommend_BoardTO)request.getAttribute( "to" );

	String seq = to.getUserRecomSeq();
	String userSeq = to.getUserSeq();
	String goreaboardNo = to.getUserRecomboardNo();
	String title = to.getUserRecomTitle();
	String content = to.getUserRecomContent();
	String wdate = to.getUserRecompostDate();
	String hit = to.getUserRecomHit();
	String comment = to.getUserRecomCmt();
	
	String userNickname = to.getUserNickname();
	
	int wgap = to.getWgap();
%>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>게시판 뷰</title>
    <link rel="stylesheet" type="text/css" href="/css/userRecommend/view.css">
    <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.min.js"></script>
	<script type="text/javascript" src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
	<script type="text/javascript">
		$( document ).ready( function() {
			// 댓글 작성 버튼
			$( '#replyWrite' ).on( 'click', function() {
				console.log( "pseq는 : " + $('#pseq').val() );
				console.log( "goreaboardNo는 : " + $('#goreaboardNo').val() );
				
				writeOkServer();
			});
			
			// 댓글 삭제 버튼
			$(document).on('click', '#replyDelete', function () {
				const grp = $(this).closest('.comment').find('#grp').val();
				
        		console.log("grp는 : " + grp );
        		
        		deleteOkServer( grp );
    		});
			
			// 댓글 수정 버튼
			$(document).on('click', '#replyModify', function(){
				const cseq = $(this).closest('.comment').find('#cseq').val();
				
				console.log( "cseq는 : " + cseq );
				
				$('#modifyForm' + cseq ).show();
			});
			
			// 수정 확인 버튼
			$(document).on( 'click', '#replyModifyOk', function(){
				const cseq = $(this).closest('.comment').find('#cseq').val();
				
				console.log( "cseq는 : " + cseq );
				
				modifyOkServer( cseq );
			});
			
			// 수정 취소 버튼
			$(document).on( 'click', '#replyModifyCancel', function(){
				const cseq = $(this).closest('.comment').find('#cseq').val();
				
				console.log( "cseq는 : " + cseq );
				
				$('#modifyForm' + cseq ).hide();
			});
			
			// 대댓글 작성 폼 버튼
			$(document).on( 'click', '#rereplyWrite', function() {
				const grp = $(this).closest('.comment').find('#grp').val();
				
				console.log( "grp는 : " + grp );
				
				console.log( "rereplyWriteForm" + grp );
				
				$( '#rereplyWriteForm' + grp ).show();
			});
			
			// 대댓글 쓰기 버튼
			$(document).on( 'click', '#rereplyWriteBtn', function(){
				const grp = $(this).closest('.comment').find('#grp').val();
				const replyContent = $(this).closest('.comment').find('#rereplyContent'+grp).val();
				
				console.log( "쓰기 grp는 : " + grp);
				console.log( "쓰기 content는 : " + replyContent );
				
				reWriteOkServer( grp, replyContent );
			});
			
			// 대댓글 작성 취소 버튼
			$(document).on( 'click', '#rereplyCancelBtn', function(){
				const grp = $(this).closest('.comment').find('#grp').val();
				
				console.log( "취소 grp는 : " + grp );
				
				$( '#rereplyWriteForm' + grp ).hide();
			});
			
			// 대댓글 삭제 버튼
			$(document).on( 'click', '#rereplyDelete', function(){
				const cseq = $(this).closest('.comment').find('#cseq').val();
				
				console.log( "대댓글 cseq는 : " + cseq );
				
				reDeleteOkServer( cseq );
			});
			
			readServer();
		});
		
		
		// 함수 ---------------------------------------------------------------------------------------
		const readServer = function( cseq , userNickname, replyContent, replypostDate, grp, grpl ) {
			$.ajax({
				url: '/gorea_replyList.do',
				type: 'get',
				data : {
					pseq : $('#pseq').val(),
					goreaboardNo : $('#goreaboardNo').val(),
					cseq : cseq,
					userNickname : userNickname,
					replyContent : replyContent,
					replypostDate : replypostDate,
					grp : grp,
					grpl : grpl
				},
				dataType: 'json',
				success: function( data ) {
					$( '.comment-section' ).empty();
					let html = '';
					html += '<div class="comments-count">추천 5개 댓글 3개</div>';
					
					$.each( data, function ( index, item ){
						//console.log( index + " : " + item.content );
			            //console.log( "grp는 : " + item.grp );
						//console.log( "grpl은 : " + item.grpl );
						html += '<div class="comment">';
						html += '<input type="hidden" id="cseq" value="' + item.cseq + '" />';
						html += '<input type="hidden" id="grp" value="' + item.grp + '" />';
						html += '<input type="hidden" id="grpl value="' + item.grpl +'"/>';
						if( item.replyContent == ""){ // 삭제된 댓글일 때
							html += "<div>";
							html += "	(삭제된 댓글입니당)";
							html += "</div>"
			            }else{
							if( item.grpl == 0 ){ // 모댓글일 때
								html += '<div class="comment-header">';
								html += '	<div class="comment-author">' + item.userNickname + '</div>';
								html += '</div>';
								html += '<div class="comment-body">' + item.replyContent + '</div>';
								html += '<div class="comment-actions">';
								html += 	'<span class="comment-timestamp">' + item.replypostDate + ' <button id="rereplyWrite">답변쓰기</button></span>';
					            html +=     '<div>';
					            html +=         '<button id="replyModify">댓글 수정</button>';
					            html +=         '<button id="replyDelete">댓글 삭제</button>';
					            html +=     '</div>';
					            html += '</div>';
					            
					            html += '<br>';
					            html += '<div id="rereplyWriteForm' + item.grp + '" style="display : none;">';
					            html += 	'<div class="reply-body' + item.grp + '">';
					            html += 		'<textarea id="rereplyContent' + item.grp + '" style="resize:none; flex: 1; padding: 10px; border-radius: 4px; border: 1px solid #ccc; min-height: 60px; width: 80%;" placeholder="대댓글을 입력하세요"></textarea>';
					            html += 	'</div>';
					            html += 	'<div class="comment-form-btn">';
					            html += 		'<button class="btn" id="rereplyWriteBtn">대댓글 작성</button>';
					            html += 		'<button class="btn" id="rereplyCancelBtn">작성 취소</button>';
					        	html += 	'</div>';
					            html += '</div>';
					            
					            html += '<div id="modifyForm' + item.cseq + '" style="display : none;">';
					            html += 	'<div class="comment-body' + item.cseq + '">';
					            html += 		'<br />'
					            html +=			'<textarea id="modifyContent' + item.cseq + '" style="resize: none; flex: 1; padding: 10px; border-radius: 4px; border: 1px solid #ccc; min-height: 60px; width: 80%;" placeholder="' + item.replyContent + '"></textarea>';
					            html += 	'</div>';
					            html += 	'<div>';
					            html += 		'<button id="replyModifyOk">확인</button>';
					            html += 		'<button id="replyModifyCancel">취소</button>';
					            html += 	'</div>';
					            html += '<hr>';
					            html += '</div>';
					            
							} else {
								html += '<div class="sub-comment">';
					            html +=    '<div class="comment' + item.cseq + '">';
					            html +=        '<div class="comment-header">';
					            html +=            '<div class="comment-author">' + item.userNickname + '</div>'
					            html +=        '</div>';
					            html +=        '<div class="comment-body">' + item.replyContent + '</div>';
					            html +=        '<div class="comment-actions">';
					            html +=            '<span class="comment-timestamp">' + item.replypostDate + '</span>';
					            html +=            '<div>';
					            html +=                '<button id="replyModify">수정</button>';
					            html +=                '<button id="rereplyDelete">삭제</button>';
					            html +=            '</div>';
					            html +=        '</div>';
					            html +=    '</div>';
					            html += '</div>';
					            html += '<div id="modifyForm' + item.cseq + '" style="display : none;">';
					            html += 	'<div class="comment-body' + item.cseq + '">';
					            html += 		'<br />'
					            html +=			'<textarea id="modifyContent' + item.cseq + '" style="resize: none; flex: 1; padding: 10px; border-radius: 4px; border: 1px solid #ccc; min-height: 60px; width: 80%;" placeholder="' + item.replyContent + '"></textarea>';
					            html += 	'</div>';
					            html += 	'<div>';
					            html += 		'<button id="replyModifyOk">확인</button>';
					            html += 		'<button id="replyModifyCancel">취소</button>';
					            html += 	'</div>';
					            html += '<hr>';
					            html += '</div>';
							}
			            }
			            html += '</div>';
					});
					$( '.comment-section' ).append( html );
				},
				error: function() {
					console.log( "error" );
				}
			});
		};
		
		const writeOkServer = function(){
			$.ajax({
				url: './gorea_replyWriteOk.do',
				type: 'post',
				data: {
					pseq: $( '#pseq' ).val(),
					replyContent: $( '#replyContent' ).val(),
					goreaboardNo: $( '#goreaboardNo' ).val()
				},
				success: function(response){
					alert("작성 성공");
					$('#replyContent').val('');
					
					readServer();
				},
				error: function(){
					console.log( 'error' );
					alert("작성 실패");
				}
			});
		};
		
		const reWriteOkServer = function( grp, replyContent ) {
			$.ajax({
				url: '/gorea_rereply_Wtire_Ok.do',
				type: 'post',
				data:{
					pseq: $( '#pseq' ).val(),
					replyContent: $( '#rereplyContent' + grp ).val(),
					goreaboardNo: $( '#goreaboardNo' ).val(),
					grp: grp
				},
				success: function(response){
					console.log( replyContent );
					console.log( $( '#grp' ).val() );
					
					alert("작성 성공");
					$('#replyContent').val('대댓글을 입력하세요');
					
					readServer();
				},
				error: function() {
					console.log( 'error' );
					alert( '작성 실패' );
				}
			});
		}
		
		const deleteOkServer = function( grp ) {
			$.ajax({
				url: './gorea_replyDeleteOk.do',
				type: 'post',
				data:{
					pseq: $('#pseq').val(),
					goreaboardNo: $( '#goreaboardNo' ).val(),
					grp : grp
				},
				success: function(response) {
					alert( "삭제 성공" );
					readServer();
				},
				error: function(){
					console.log( "error" );
				}
			});
		}
		
		const modifyOkServer = function( cseq ){
			$.ajax({
				url: './gorea_replyModifyOk.do',
				type: 'post',
				data:{
					pseq: $( '#pseq' ).val(),
					goreaboardNo: $( '#goreaboardNo' ).val(),
					cseq: cseq,
					replyContent: $( '#modifyContent' + cseq ).val()
				},
				success: function(response){
					alert( "수정 성공" );
					readServer();
				},
				error: function(){
					console.log( "error" );
				}
			});
		}
		
		const reDeleteOkServer = function( cseq ){
			$.ajax({
				url: './gorea_rereply_Delete_Ok.do',
				type: 'post',
				data:{
					goreaboardNo: $( '#goreaboardNo' ).val(),
					cseq: cseq
				},
				success: function( response ){
					alert( "삭제 성공" );
					readServer();
				},
				error: function(){
					console.log( "error" );
				}
			});
		}
	</script>
</head>
<body>
    <div class="container">
        <div class="post-title"><%=title %></div>
        <div class="post-info">
            <div class="post-info-left">
                <span class="post-info-item">작성자: <%=userNickname %></span><!-- user랑 join해서 nick 받아오기 -->
                <span class="post-info-item">국적: 내국인</span><!--  -->
            </div>
            <div class="post-info-right">
                <span class="post-info-item">작성일: <%=wdate %></span>
                <span class="post-info-item">조회수: <%=hit %></span>
            </div>
        </div>
        <div class="post-content">
            <%=content %>
        </div>
        <div class="comment-section" id="comment">
     
        </div>
        <div class="comment-form">
            <textarea id="replyContent" style="resize: none;" placeholder="댓글을 입력하세요"></textarea>
        </div>
        <div class="comment-form-btn">
            <button class="btn" id="replyWrite">댓글 작성</button>
        </div>
        <input type="hidden" id="goreaboardNo" value=<%=goreaboardNo %> />
        <input type="hidden" id="pseq" value=<%=seq %> />
        <div class="post-actions" style="text-align: right; margin-top: 10px;">
        	<input type="button" value="목록" class="btn" style="cursor: pointer;" onclick="location.href='userRecomList.do'" />
            
            <input type="button" value="수정" class="btn" style="cursor: pointer;" onclick="location.href='userRecomModify.do?seq=<%=seq %>'" />
            <input type="button" value="삭제" class="btn" style="cursor: pointer;" onclick="location.href='userRecomDeleteOk.do?seq=<%=seq %>'" />
        </div>
    </div>
</body>
</html>
