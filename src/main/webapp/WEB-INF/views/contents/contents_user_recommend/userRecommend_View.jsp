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
    <title>GO!rea</title>
    <link rel="stylesheet" type="text/css" href="/css/userRecommend/view.css">
    <script src="https://kit.fontawesome.com/42d55d598f.js" crossorigin="anonymous"></script>
    <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.min.js"></script>
	<script type="text/javascript" src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
	<script type="text/javascript">
		$( document ).ready( function() {
			const userSeq = '${userSeq}';
			
			// 댓글 작성 버튼
			$( '#replyWrite' ).on( 'click', function() {
				
				writeOkServer( userSeq );
			});
			
			// 댓글 삭제 버튼
			$(document).on('click', '#replyDelete', function () {
				const cseq = $(this).closest('.comment').find('#cseq').val();
				const grp = $(this).closest('.comment').find('#grp').val();
        		
        		deleteOkServer( cseq, grp );
    		});
			
			
			// 댓글 수정 버튼
			$(document).on('click', '#replyModify', function(){
				const cseq = $(this).closest('.comment').find('#cseq').val();
				
			    $('.reply-action-btn').hide();
				
				$('#modifyForm' + cseq ).show();
			});
			
			
			// 수정 확인 버튼
			$(document).on( 'click', '#replyModifyOk', function(){
				const cseq = $(this).closest('.comment').find('#cseq').val();
				
				modifyOkServer( cseq );
			});
			
			
			// 수정 취소 버튼
			$(document).on( 'click', '#replyModifyCancel', function(){
				const cseq = $(this).closest('.comment').find('#cseq').val();
				
			    $('.reply-action-btn').show();
				
				$('#modifyForm' + cseq ).hide();
			});
			
			
			// 대댓글 작성 폼 버튼
			$(document).on( 'click', '#rereplyWrite', function() {
				const cseq = $(this).closest('.comment').find('#cseq').val();
				
				$('.reply-action-btn').hide();

				$( '#rereplyWriteForm' + cseq ).show();
			});
			
			
			// 대댓글 쓰기 버튼
			$(document).on( 'click', '#rereplyWriteBtn', function(){
				const grp = $(this).closest('.comment').find('#grp').val();
				const replyContent = $(this).closest('.comment').find('#rereplyContent'+grp).val();
				
				reWriteOkServer( grp, replyContent, userSeq );
			});
			
			// 대댓글 작성 취소 버튼
			$(document).on( 'click', '#rereplyCancelBtn', function(){
				const grp = $(this).closest('.comment').find('#grp').val();
				
				$('.reply-action-btn').show();
				
				$( '#rereplyWriteForm' + grp ).hide();
			});
			
			// 대댓글 삭제 버튼
			$(document).on( 'click', '#rereplyDelete', function(){
				const cseq = $(this).closest('.comment').find('#cseq').val();
				const grp = $(this).closest('.comment').find('#grp').val();
				
				reDeleteOkServer( cseq );
			});
			
			readServer();
		});
		
		
		// 함수 ---------------------------------------------------------------------------------------
		 
		const readServer = function( cseq , userNickname, replyContent, replypostDate, grp, grpl, userSeq ) {
			$.ajax({
				url: '/korean/gorea_reply.do',
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
					
					$( '.comment-section' ).empty();
					let html = '';
					
					$.each( data, function ( index, item ){

						html += '<input type="hidden" id="cseq" value="' + item.cseq + '" />';
						html += '<input type="hidden" id="grp" value="' + item.grp + '" />';
						html += '<input type="hidden" id="grpl value="' + item.grpl +'"/>';
						
						html += '<div class="comment" style="display:flex; justify-content: space-between; width: 100%;">';
						
						var loginUserSeq = "${SPRING_SECURITY_CONTEXT.authentication.principal.gorea_UserTO.userSeq}";
						
						if( item.grpl == 0 ){ // 모댓글일 때
								html += '<div class="comment-header">';
								html += '	<div class="comment-author">' + item.userNickname + '</div>';
								html += '</div>';
								html += '<div class="comment-body">' + item.replyContent + '</div>';
								html += '<div class="comment-actions">';
								html += 	'<span class="comment-timestamp">' + item.replypostDate ;

								html += '<input type="hidden" name="userSeq" value="${userSeq}"/>';
								
								html += '<input type="hidden" id="cseq" value="' + item.cseq + '" />';
								html += '<input type="hidden" id="grp" value="' + item.grp + '" />';
								
								 if (!loginUserSeq) {
							            html += '<button class="btn reply-action-btn" id="rereplyWrite" style="display:none;">답변쓰기</button></span>';
							        } else {
							            html += '<button class="btn reply-action-btn" id="rereplyWrite">답변쓰기</button></span>';
								
										if (loginUserSeq == item.userSeq) {
											html +=     '<div>';
								            html +=         '<button class="btn reply-action-btn" id="replyModify">댓글 수정</button>';
								            html +=         '<button class="btn reply-action-btn" id="replyDelete">댓글 삭제</button>';
								            html +=     '</div>';
										}
							        }
					            html += '</div>';
					            
					            //form과 공간 만들기
					            
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
					            html += 		'<button class="btn" id="replyModifyOk">확인</button>';
					            html += 		'<button class="btn" id="replyModifyCancel">취소</button>';
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
					        	   html += '<input type="hidden" id="cseq" value="' + item.cseq + '" />';
						           html +=            '<div>';
						           html +=                '<button class="btn reply-action-btn" id="replyModify">수정</button>';
						           html +=                '<button class="btn reply-action-btn" id="rereplyDelete">삭제</button>';
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
					            html += 		'<button class="btn" id="replyModifyOk">확인</button>';
					            html += 		'<button class="btn" id="replyModifyCancel">취소</button>';
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
		
		const writeOkServer = function( userSeq ){
			$.ajax({
				url: '/korean/gorea_reply_write_ok.do',
				type: 'post',
				data: {
					pseq: $( '#pseq' ).val(),
					replyContent: $( '#replyContent' ).val(),
					goreaboardNo: $( '#goreaboardNo' ).val(),
					userSeq: userSeq
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
		
		const reWriteOkServer = function( grp, replyContent, userSeq ) {
			$.ajax({
				url: '/korean/gorea_rereply_wtire_ok.do',
				type: 'post',
				data:{
					pseq: $( '#pseq' ).val(),
					replyContent: $( '#rereplyContent' + grp ).val(),
					goreaboardNo: $( '#goreaboardNo' ).val(),
					grp: grp,
					userSeq: userSeq
				},
				success: function(response){
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
				url: '/korean/gorea_reply_delete_ok.do',
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
				url: '/korean/gorea_reply_modify_ok.do',
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
				url: '/korean/gorea_rereply_delete_ok.do',
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
        <%-- <button onclick="increaseLikesUserRecommend('${seq}')">추천</button> --%>
        <div class="comments-count" style="display : flex;">
        	<%-- <div>추천</div><span id="like-count">${to.userRecomcount }</span>&nbsp;&nbsp;<div id="replyCount"></div> --%>
        </div>
        
        <c:choose>
        	<c:when test="${not empty userSeq }">
        		<input type="hidden" id="goreaboardNo" value="${to.userRecomboardNo}" />
        		<input type="hidden" id="pseq" value="${to.userRecomSeq}" />
        		<input type="hidden" name="userSeq" value="${userSeq}"/>
		        <div class="comment-form" style="display: flex;">
		            <textarea id="replyContent" style="resize: none;" placeholder="댓글을 입력하세요"></textarea>
		            <button class="btn" id="replyWrite">댓글 작성</button>
		        </div>
	        </c:when>
        </c:choose>
        
        <div class="comment-section" id="comment"></div>
        
        <c:url var="deleteUrl" value="/${language}/userRecom_delete_ok.do">
            <c:param name="userRecomSeq" value="${ seq }" />
            <c:if test="${not empty param.cpage}"><c:param name="cpage" value="${param.cpage}" /></c:if>
            <c:if test="${not empty param.searchType}"><c:param name="searchType" value="${param.searchType}" /></c:if>
            <c:if test="${not empty param.searchKeyword}"><c:param name="searchKeyword" value="${param.searchKeyword}" /></c:if>
        </c:url>

        <c:url var="modifyUrl" value="/${language}/userRecom_modify.do">
            <c:param name="userRecomSeq" value="${ seq }" />
            <c:if test="${not empty param.cpage}"><c:param name="cpage" value="${ param.cpage }" /></c:if>
            <c:if test="${not empty param.searchType}"><c:param name="searchType" value="${param.searchType}" /></c:if>
            <c:if test="${not empty param.searchKeyword}"><c:param name="searchKeyword" value="${param.searchKeyword}" /></c:if>
        </c:url>

        <c:url var="listUrl" value="/${language}/userRecom.do">
            <c:if test="${not empty param.cpage}"><c:param name="cpage" value="${param.cpage}" /></c:if>
            <c:if test="${not empty param.searchType}"><c:param name="searchType" value="${param.searchType}" /></c:if>
            <c:if test="${not empty param.searchKeyword}"><c:param name="searchKeyword" value="${param.searchKeyword}" /></c:if>
        </c:url>
        
        
        <div class="post-actions">
	        <div class="left-buttons">
	        	<c:if test="${not empty prevPost}">
		            <input type="button" value="이전글" class="btn" onclick="location.href='userRecom_view.do?seq=${prevPost.userRecomSeq}&cpage=${param.cpage}&searchType=${param.searchType}&searchKeyword=${fn:escapeXml(param.searchKeyword)}'" />
		        </c:if>
		        <c:if test="${not empty nextPost}">
		            <input type="button" value="다음글" class="btn" onclick="location.href='userRecom_view.do?seq=${nextPost.userRecomSeq}&cpage=${param.cpage}&searchType=${param.searchType}&searchKeyword=${fn:escapeXml(param.searchKeyword)}'" />
		        </c:if>
	        </div>
	        <div class="right-buttons">
	        	<input type="button" value="목록" class="btn" onclick="location.href='${listUrl}'" />
	            <c:if test="${userSeq eq to.userSeq}">
		            <!-- userSeq와 게시글 작성자의 userSeq가 일치하는 경우에만 수정 및 삭제 버튼 표시 -->
		            <input type="button" value="수정" class="btn" onclick="location.href='${modifyUrl}'" />
		            <input type="button" value="삭제" class="btn" onclick="confirmDelete('${deleteUrl}')" />
        		</c:if>
	        </div>
    	</div>
    	
    </div>
<script>
	function increaseLikesUserRecommend(userRecomSeq) {
    	fetch('/increaseLikesUserRecommend?userRecomSeq=' + userRecomSeq, { method: 'POST' })
        	.then(response => response.text())
        	.then(likes => {
            	// 추천 수를 페이지에 표시
            	document.getElementById('like-count').innerText = likes;
        	});
	}
	
	function confirmDelete(deleteUrl) {
	    if (confirm("글을 삭제하시겠습니까?")) {
	        location.href = deleteUrl;
	    }
	}
</script>
<jsp:include page="/WEB-INF/views/includes/footer.jsp"></jsp:include>
</body>
</html>
