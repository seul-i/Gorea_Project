<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<c:set var="seq" value="${ param.userRecomSeq }" />
<c:set var="to" value="${ requestScope.to }" />
<c:set var="language" value="${language}" />
<c:set var="userSeq" value="${SPRING_SECURITY_CONTEXT.authentication.principal.gorea_UserTO.userSeq}" />
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
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
				const cseq = $(this).closest('.comment').find('#cseq').val();
				const grp = $(this).closest('.comment').find('#grp').val();
        		console.log("cseq는 : " + cseq );
        		console.log( "grp는 : " + grp );
        		
        		console.log( "pseq는 : " + $('#pseq').val() );
        		
        		deleteOkServer( cseq, grp );
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
				const cseq = $(this).closest('.comment').find('#cseq').val();
				
				console.log( "cseq는 : " + cseq );
				
				console.log( "rereplyWriteForm" + cseq );
				
				$( '#rereplyWriteForm' + cseq ).show();
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
				const grp = $(this).closest('.comment').find('#grp').val();
				
				console.log( "대댓글 cseq는 : " + cseq );
				console.log( "대댓글 grp는 : " + grp );
				console.log( "대댓글 pseq는 : " + $('#pseq').val() );
				
				reDeleteOkServer( cseq );
			});
			
			readServer();
		});
		
		
		// 함수 ---------------------------------------------------------------------------------------
		 
		const readServer = function( cseq , userNickname, replyContent, replypostDate, grp, grpl, userSeq ) {
			$.ajax({
				url: '/korean/gorea_replyList.do',
				type: 'get',
				data : {
					pseq : $('#pseq').val(),
					goreaboardNo : $('#goreaboardNo').val(),
					cseq : cseq,
					userNickname : userNickname,
					replyContent : replyContent,
					replypostDate : replypostDate,
					grp : grp,
					grpl : grpl,
					userSeq : userSeq
				},
				dataType: 'json',
				success: function( data ) {
					for( var i = 0; i<data.length; i++ ){
						console.log( "pseq : " + data[i].pseq );
						console.log( "goreaNo : " + data[i].goreaboardNo );
						console.log( "cseq : " + data[i].cseq );
						console.log( "Nick : " + data[i].userNickname );
						console.log( "replyContent : " + data[i].replyContent );
						console.log( "grp : " + data[i].grp );
						console.log( "grpl : " + data[i].grpl );
						console.log( "userSeq : " + data[i].userSeq );
					}
					
					$( '.comment-section' ).empty();
					let html = '';
					
					$.each( data, function ( index, item ){

						html += '<div class="comment">';
						html += '<input type="hidden" id="cseq" value="' + item.cseq + '" />';
						html += '<input type="hidden" id="grp" value="' + item.grp + '" />';
						html += '<input type="hidden" id="grpl value="' + item.grpl +'"/>';
						
						var loginUserSeq = "${SPRING_SECURITY_CONTEXT.authentication.principal.gorea_UserTO.userSeq}";
						
						if( item.grpl == 0 ){ // 모댓글일 때
								html += '<div class="comment-header">';
								html += '	<div class="comment-author">' + item.userNickname + '</div>';
								html += '</div>';
								html += '<div class="comment-body">' + item.replyContent + '</div>';
								html += '<div class="comment-actions">';
								html += 	'<span class="comment-timestamp">' + item.replypostDate ;

								if (loginUserSeq == item.userSeq) {
									html += '<button id="rereplyWrite">답변쓰기</button></span>';
									html +=     '<div>';
						            html +=         '<button id="replyModify">댓글 수정</button>';
						            html +=         '<button id="replyDelete">댓글 삭제</button>';
						            html +=     '</div>';
								}
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
					            
					            if (loginUserSeq == item.userSeq) {
						            html +=            '<div>';
						            html +=                '<button id="replyModify">수정</button>';
						            html +=                '<button id="rereplyDelete">삭제</button>';
						            html +=            '</div>';
					            }
						            
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
				url: '/korean/gorea_replyWriteOk.do',
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
				url: '/korean/gorea_rereply_Wtire_Ok.do',
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
					$('#replyContent'+grp).val('대댓글을 입력하세요');
					
					readServer();
				},
				error: function() {
					console.log( 'error' );
					alert( '작성 실패' );
				}
			});
		}
		
		const deleteOkServer = function( cseq, grp ) {
			$.ajax({
				url: '/korean/gorea_replyDeleteOk.do',
				type: 'post',
				data:{
					pseq: $('#pseq').val(),
					goreaboardNo: $( '#goreaboardNo' ).val(),
					cseq : cseq,
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
				url: '/korean/gorea_replyModifyOk.do',
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
				url: '/korean/gorea_rereply_Delete_Ok.do',
				type: 'post',
				data:{
					pseq: $( '#pseq' ).val(),
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
	<jsp:include page="/WEB-INF/views/includes/header${language}.jsp"></jsp:include>
    <div class="containers">
        <div class="post-title"><c:out value="${to.userRecomTitle }"/></div>
        <div class="post-info">
            <div class="post-info-left">
                <span class="post-info-item">작성자: <c:out value="${to.userNickname}"/></span><!-- user랑 join해서 nick 받아오기 -->
                <!-- <span class="post-info-item">국적: 내국인</span> -->
            </div>
            <div class="post-info-right">
                <span class="post-info-item">작성일: <c:out value = "${to.userRecompostDate }" /></span>
                <span class="post-info-item">조회수: <c:out value = "${to.userRecomHit }" /></span>
            </div>
        </div>
        <div class="post-content">
            <c:out value = "${to.userRecomContent }" escapeXml="false" />
        </div>
        <!-- 댓글 수 추천 수 공간 -->
        <div class="comments-count" style="display : flex;"><div>추천 5개</div>&nbsp&nbsp<div id="replyCount"></div></div>
        <div class="comment-section" id="comment">
     
        </div>
        <div class="comment-form">
            <textarea id="replyContent" style="resize: none;" placeholder="댓글을 입력하세요"></textarea>
            <button class="btn" id="replyWrite">댓글 작성</button>
        </div>
        
        <input type="hidden" id="goreaboardNo" value="${to.userRecomboardNo}" />
        <input type="hidden" id="pseq" value="${to.userRecomSeq}" />
        
        <div class="post-actions" style="text-align: right; margin-top: 10px;">
	        <div class="left-buttons">
	        </div>
	        <div class="right-buttons">
	        	<input type="button" value="목록" class="btn" style="cursor: pointer;" onclick="location.href='/korean/userRecomList.do'" />
	            <input type="button" value="수정" class="btn" style="cursor: pointer;" onclick="location.href='userRecomModify.do?seq=${to.userRecomSeq}'" />
	            <input type="button" value="삭제" class="btn" style="cursor: pointer;" onclick="location.href='userRecomDeleteOk.do?seq=${to.userRecomSeq}'" />
	        </div>
    	</div>
    </div>
<script>
	//function increaseLikes(freeSeq) {
    	//fetch('/increaseLikes?freeSeq=' + freeSeq, { method: 'POST' })
        	//.then(response => response.text())
        	//.then(likes => {
            	// 추천 수를 페이지에 표시
            	//document.getElementById('like-count').innerText = likes;
        	//});
	//}

	//function confirmDelete(deleteUrl) {
    	//if (confirm("글을 삭제하시겠습니까?")) {
        	//location.href = deleteUrl;
    	//}
	//}
</script>
<jsp:include page="/WEB-INF/views/includes/footer.jsp"></jsp:include>
</body>
</html>
