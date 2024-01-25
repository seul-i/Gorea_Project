<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>GO!REA ADMIN</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <link rel="stylesheet" type="text/css" href="/css/admin/admin.css">
    <link rel="stylesheet" type="text/css" href="/css/notice/view.css">
    <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.min.js"></script>
	<script type="text/javascript" src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
    <script type="text/javascript">
		$( document ).ready( function() {
			const userSeq = '${userSeq}';
			
			// 댓글 작성 버튼
			$( '#replyWrite' ).on( 'click', function() {
				const replyContent = $('#replyContent').val().trim();

		        if (replyContent === "") {
		            showAlert('emptyContent');
		            return false;
		        }
				
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
				const modifyContent = $('#modifyContent'+cseq).val().trim();
				
				if (modifyContent === "") {
		            showAlert('emptyContent');
		            return false;
		        }
				
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
				const rereplyContent = $(this).closest('.comment').find('#rereplyContent'+grp).val();
				
				if (rereplyContent === "") {
		            showAlert('emptyContent');
		            return false;
		        }
				
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
						//console.log("${language}");
						
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
									html +=     '<div>';
									html +=         '<button class="btn reply-action-btn" id="replyModify">댓글 수정</button>';
									html +=         '<button class="btn reply-action-btn" id="replyDelete">댓글 삭제</button>';
									html +=     '</div>';
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
				url: '/${language}/gorea_reply_write_ok.do',
				type: 'post',
				data: {
					pseq: $( '#pseq' ).val(),
					replyContent: $( '#replyContent' ).val(),
					goreaboardNo: $( '#goreaboardNo' ).val(),
					userSeq: userSeq
				},
				success: function(response){
					if( '${language}' === 'korean' ){
						alert("작성 성공!!");
						$('#replyContent').val('');
					} else {
						alert("Success!!");
						$('#replyContent').val('');
					}
					
					readServer();
				},
				error: function(){
					if( '${language}' === 'korean' ){
						alert("작성 실패");
					} else {
						alert( "Failed" );
					}
				}
			});
		};
		
		const reWriteOkServer = function( grp, replyContent, userSeq ) {
			$.ajax({
				url: '/${language}/gorea_rereply_write_ok.do',
				type: 'post',
				data:{
					pseq: $( '#pseq' ).val(),
					replyContent: $( '#rereplyContent' + grp ).val(),
					goreaboardNo: $( '#goreaboardNo' ).val(),
					grp: grp,
					userSeq: userSeq
				},
				success: function(response){
					if( '${language}' === 'korean' ){
						alert("작성 성공!!");
						$('#replyContent'+grp).val('대댓글을 입력하세요');
					} else {
						alert("Success!!");
						$('#replyContent'+grp).val('대댓글을 입력하세요');
					}
					
					readServer();
				},
				error: function() {
					if( '${language}' === 'korean' ){
						alert("작성 실패");
					} else {
						alert( "Failed" );
					}
				}
			});
		}
		
		const deleteOkServer = function( cseq, grp ) {
			$.ajax({
				url: '/${language}/gorea_reply_delete_ok.do',
				type: 'post',
				data:{
					pseq: $('#pseq').val(),
					goreaboardNo: $( '#goreaboardNo' ).val(),
					cseq : cseq,
					grp : grp
				},
				success: function(response) {
					if( '${language}' === 'korean' ){
						alert( "삭제 성공" );
					} else {
						alert( "Delete Complete!!" );
					}
					
					readServer();
				},
				error: function(){
					console.log( "error" );
				}
			});
		}
		
		const modifyOkServer = function( cseq ){
			$.ajax({
				url: '/${language}/gorea_reply_modify_ok.do',
				type: 'post',
				data:{
					pseq: $( '#pseq' ).val(),
					goreaboardNo: $( '#goreaboardNo' ).val(),
					cseq: cseq,
					replyContent: $( '#modifyContent' + cseq ).val()
				},
				success: function(response){
					if( '${language}' === 'korean' ){
						alert( "수정 성공" );
					} else {
						alert( "Modify Success!!" );
					}
					
					readServer();
				},
				error: function(){
					console.log( "error" );
				}
			});
		}
		
		const reDeleteOkServer = function( cseq ){
			$.ajax({
				url: '/${language}/gorea_rereply_delete_ok.do',
				type: 'post',
				data:{
					pseq: $( '#pseq' ).val(),
					goreaboardNo: $( '#goreaboardNo' ).val(),
					cseq: cseq
				},
				success: function( response ){
					if( '${language}' === 'korean' ){
						alert( "삭제 성공" );
					} else {
						alert( "Delete Success!!" );
					}
					readServer();
				},
				error: function(){
					console.log( "error" );
				}
			});
		}
		
		const showAlert = function (type) {
			const language = '${language}';
			
			// 내용 없을 때 언어별 알림 처리
			const getKoreanMessage = function (type) {
		       switch (type) {
		           case 'emptyContent':
		               return '댓글 내용을 입력하세요.';
		           // 다른 한국어 메시지들 추가 가능
		           default:
		               return '기본 한국어 메시지';
			        }
			    };
		
		   	const getEnglishMessage = function (type) {
		       switch (type) {
		           case 'emptyContent':
		               return 'Please enter the comment content.';
		           // 다른 영어 메시지들 추가 가능
		           default:
		               return 'Default English message';
			       }
			   };
		
		   const getJapaneseMessage = function (type) {
		       switch (type) {
		           case 'emptyContent':
		               return 'コメント内容を入力してください。';
		           // 다른 일본어 메시지들 추가 가능
		           default:
		               return 'デフォルトの日本語メッセージ';
			        }
			    };
		
		    const getChineseMessage = function (type) {
		        switch (type) {
	     	       case 'emptyContent':
		 	          return '请输入评论内容。';
		           // 다른 중국어 메시지들 추가 가능
		           default:
		               return '默认中文消息';
			       }
			    };
			
	        switch (language) {
	            case 'korean':
	                alert(getKoreanMessage(type));
	                break;
	            case 'english':
	                alert(getEnglishMessage(type));
	                break;
	            case 'japanese':
	                alert(getJapaneseMessage(type));
	                break;
	            case 'chinese':
	                alert(getChineseMessage(type));
	                break;
	            default:
	                alert('Default alert message');
	        }
	    };
	</script>
</head>
<body>
    <aside>
        <button class="close-sidebar-btn" onclick="toggleSidebar()">X</button>
        <div class="logo">GO!REA</div>
        <ul>
			<li class="tooltip"><a href="#"><i
					class="fas fa-tachometer-alt"></i> <span class="menu-item-text">대시보드</span></a>
			</li>
			<li class="tooltip"><a href="#"><i class="fas fa-home"></i>
					<span class="menu-item-text">메인 관리</span></a></li>
			<li class="tooltip"><a href="javascript:void(0);"
				onclick="toggleSubmenu('data-management-submenu')"
				data-target="data-management-submenu"> <i
					class="fas fa-database"></i> <span class="menu-item-text">데이터
						관리</span><span class="submenu-indicator">∨</span>
			</a>
				<ul id="data-management-submenu" class="submenu">
					<li><a href="#">Best5</a></li>
					<li><a href="adminuserRecom.do">유저추천</a></li>
					<li><a href="adminfreeboard.do">자유게시판</a></li>
					<li><a href="adminEditReco.do">에디터 추천 장소</a></li>
					<li><a href="admineditTip.do">에디터 꿀팁</a></li>
					<li><a href="adminTrendseoul.do">트렌드 서울</a></li>
					<li><a href="adminnotice.do">공지사항</a></li>
				</ul></li>
			<li class="tooltip"><a href="javascript:void(0);"
				onclick="toggleSubmenu('member-management-submenu')"
				data-target="member-management-submenu"> <i class="fas fa-users"></i>
					<span class="menu-item-text">회원 관리</span><span
					class="submenu-indicator">∨</span>
			</a>
				<ul id="member-management-submenu" class="submenu">
					<li><a href="adminUserList.do">회원 목록 확인</a></li>
					<li><a href="#">회원 비밀번호 변경</a></li>
					<li><a href="#">회원 탈퇴</a></li>
				</ul></li>
			<li class="tooltip"><a href="adminqna.do"><i class="fas fa-envelope"></i>
					<span class="menu-item-text">문의 관리</span></a></li>
			<li class="tooltip"><a href="#"><i class="fas fa-chart-bar"></i>
					<span class="menu-item-text">통계 관리</span></a></li>
		</ul>
        <footer class="sidebar-footer">
            <a href="#"></a>
            <a href="#"></a>
        </footer>
    </aside>
    <main>
        <div class="logo-space">
            <span class="admin-title">관리자 페이지</span>
            <button class="logout-btn">Main</button>
        </div>
        <button class="toggle-sidebar-btn" onclick="toggleSidebar()">
            <i class="fas fa-bars"></i> 
        </button>
        
        <div class="containers">
	        <div class="post-title"><c:out value="${to.userRecomTitle }"/></div>
	        <div class="post-info">
			    <div class="post-info-left">
			        <span class="post-info-item">작성자: <c:out value="${to.userNickname}"/></span>
			    </div>
			    <div class="post-info-right">
			        <span class="post-info-item">작성일: <c:out value = "${to.userRecompostDate }" /></span>
			        <span class="post-info-item">조회수: <c:out value = "${to.userRecomHit }" /></span>
			    </div>
	        </div>
	        <div class="post-content">
	            <c:out value = "${to.userRecomContent }" escapeXml="false" />
	        </div>
	        <div class="comments-count" style="display : flex;"></div>
	        
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
	        
	        <c:url var="deleteUrl" value="/admin/adminuserRecom_delete_ok.do">
	            <c:param name="userRecomSeq" value="${ param.seq }" />
	            <c:if test="${not empty param.cpage}"><c:param name="cpage" value="${param.cpage}" /></c:if>
	            <c:if test="${not empty param.searchType}"><c:param name="searchType" value="${param.searchType}" /></c:if>
	            <c:if test="${not empty param.searchKeyword}"><c:param name="searchKeyword" value="${param.searchKeyword}" /></c:if>
	        </c:url>
	
	        <c:url var="modifyUrl" value="/admin/adminuserRecom_modify.do">
	            <c:param name="userRecomSeq" value="${ param.seq }" />
	            <c:if test="${not empty param.cpage}"><c:param name="cpage" value="${ param.cpage }" /></c:if>
	            <c:if test="${not empty param.searchType}"><c:param name="searchType" value="${param.searchType}" /></c:if>
	            <c:if test="${not empty param.searchKeyword}"><c:param name="searchKeyword" value="${param.searchKeyword}" /></c:if>
	        </c:url>
	
	        <c:url var="listUrl" value="/admin/adminuserRecom.do">
	            <c:if test="${not empty param.cpage}"><c:param name="cpage" value="${param.cpage}" /></c:if>
	            <c:if test="${not empty param.searchType}"><c:param name="searchType" value="${param.searchType}" /></c:if>
	            <c:if test="${not empty param.searchKeyword}"><c:param name="searchKeyword" value="${param.searchKeyword}" /></c:if>
	        </c:url>
	        
	        <div class="post-actions">
	            <div class="left-buttons">
			        <c:if test="${not empty prevPost}">
			            <input type="button" value="이전글" class="btn" onclick="location.href='/admin/adminuserRecom_view.do?seq=${prevPost.freeSeq}&cpage=${param.cpage}&searchType=${param.searchType}&searchKeyword=${fn:escapeXml(param.searchKeyword)}'" />
			        </c:if>
			        <c:if test="${not empty nextPost}">
			            <input type="button" value="다음글" class="btn" onclick="location.href='adminuserRecom_view.do?seq=${nextPost.freeSeq}&cpage=${param.cpage}&searchType=${param.searchType}&searchKeyword=${fn:escapeXml(param.searchKeyword)}'" />
			        </c:if>
	    		</div>
	            <div class="right-buttons">
	                <input type="button" value="삭제" class="btn" onclick="confirmDelete('${deleteUrl}')" />
	                <input type="button" value="수정" class="btn" onclick="location.href='${modifyUrl}'" />
	                <input type="button" value="목록" class="btn" onclick="location.href='${listUrl}'" />
	            </div>
	        </div>
      	</div>
        
        <script>
            function confirmDelete(deleteUrl) {
                if (confirm("글을 삭제하시겠습니까?")) {
                    location.href = deleteUrl;
                }
            }
        </script>
    </main>
    <script type="text/javascript" src="../../js/admin.js"></script>
</body>
</html>