<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GO!REA ADMIN</title>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
<link rel="stylesheet" type="text/css" href="/css/admin/admin.css">
<link rel="stylesheet" type="text/css" href="/css/qna/view.css">
<link rel="stylesheet" type="text/css" href="/css/qna/comment.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>
	function updateCommentList() {
		$
				.ajax({
					type : 'GET',
					url : "/korean/qnAReplylist/" + $("#qnaSeq").val(),
					success : function(response) {
						var replyContainer = $("#replyContainer");
						replyContainer.empty();

						for (var i = 0; i < response.length; i++) {
							var qnaCmtContent = response[i];

							var html = '<div class="post-comment" id="qnaCmtContent' + qnaCmtContent.qnaCmtSeq + '">';
							html += '<div class="comment-list">';
							html += '<div class="flex">';
							html += '<div class="user">';
							html += '<div class="user-image"><img src="'
									+ getUserImage(qnaCmtContent.userNation)
									+ '" alt=""></div>';
							html += '<div class="user-meta">';
							html += '<div class="name">'
									+ qnaCmtContent.userNickname + '</div>';
							html += '<div class="day">'
									+ qnaCmtContent.qnaCmtWdate + '</div>';
							html += '</div>';
							html += '</div>';

							var loginUserSeq = "${SPRING_SECURITY_CONTEXT.authentication.principal.gorea_UserTO.userSeq}";

							if (loginUserSeq == qnaCmtContent.userSeq) {
								// 수정, 삭제 버튼은 댓글 작성자와 로그인한 사용자가 동일한 경우에만 표시
								html += '<div>';
								html += '<button class="modify" data-reply="' + qnaCmtContent.qnaCmtSeq + '" data-user-seq="' + qnaCmtContent.userSeq + '">수정</button>';
								html += '<button class="delete" data-reply="' + qnaCmtContent.qnaCmtSeq + '" data-user-seq="' + qnaCmtContent.userSeq + '">삭제</button>';
								html += '</div>';
							}

							html += '</div>';

							if (qnaCmtContent.isEditing) {
								// 수정 중인 경우, 수정 폼 표시
								html += '<div class="replyModify-form" id="replyModifyForm_' + qnaCmtContent.qnaCmtSeq + '">';
								html += '<input type="hidden" name="qnaCmtSeq" value="' + qnaCmtContent.qnaCmtSeq + '">';
								html += '<div class="comment-container">';
								html += '<div class="original-comment">'
										+ qnaCmtContent.qnaCmtContent
										+ '</div>'; // 기존 댓글 내용 표시
								html += '<textarea style="resize: none;" id="replyModifyComment_' + qnaCmtContent.qnaCmtSeq + '" placeholder="댓글 내용">'
										+ qnaCmtContent.qnaCmtContent
										+ '</textarea>';
								html += '<button class="save" data-reply="' + qnaCmtContent.qnaCmtSeq + '">저장</button>';
								html += '</div>';
								html += '</div>';
							} else {
								// 수정 중이 아닌 경우, 댓글 내용 표시
								html += '<div class="comment">'
										+ qnaCmtContent.qnaCmtContent
										+ '</div>';
							}

							html += '</div>';
							html += '</div>';

							replyContainer.append(html);
						}

						$(document)
								.on(
										'click',
										'.modify',
										function() {
											var qnaCmtSeq = $(this).data(
													"reply");
											var replyElement = $("#qnaCmtContent"
													+ qnaCmtSeq);
											var modifyButton = $(this); // 현재 클릭된 수정 버튼
											var deleteButton = replyElement
													.find(".delete"); // 삭제 버튼 선택

											// 수정 및 삭제 버튼 숨기기
											modifyButton.hide();
											deleteButton.hide();

											var qnaCmtContent = replyElement
													.find(".comment").text()
													.trim();

											var editFormHtml = '<div class="replyModify-form" id="replyModifyForm_' + qnaCmtSeq + '">'
													+ '<textarea style="resize: none;" id="replyModifyComment_' + qnaCmtSeq + '" placeholder="댓글 내용">'
													+ qnaCmtContent
													+ '</textarea>'
													+ '<button class="submitReplyBtn" data-reply="' + qnaCmtSeq + '">저장</button>'
													+ '</div>';

											replyElement.find(".comment")
													.replaceWith(editFormHtml);

											// '닫기' 버튼 추가 (수정 및 삭제 버튼과 동일한 스타일 적용)
											modifyButton
													.after('<button class="closeEdit modify delete" data-reply="' + qnaCmtSeq + '">닫기</button>');

											// 저장 버튼 클릭 이벤트 처리
											$(
													"#replyModifyForm_"
															+ qnaCmtSeq
															+ " .submitReplyBtn")
													.off("click")
													.on(
															"click",
															function() {
																var updatedContent = $(
																		"#replyModifyComment_"
																				+ qnaCmtSeq)
																		.val();
																saveReply(
																		qnaCmtSeq,
																		updatedContent);
																// 수정, 삭제 버튼 다시 표시
																modifyButton
																		.show();
																deleteButton
																		.show();
																$(
																		".closeEdit[data-reply='"
																				+ qnaCmtSeq
																				+ "']")
																		.remove();
															});

											// 닫기 버튼 클릭 이벤트 처리
											$(
													".closeEdit[data-reply='"
															+ qnaCmtSeq + "']")
													.off("click")
													.on(
															"click",
															function(event) {
																event
																		.stopPropagation(); // 이벤트 버블링 방지
																$(this)
																		.remove();
																modifyButton
																		.show();
																deleteButton
																		.show();
																var originalCommentHtml = '<div class="comment">'
																		+ qnaCmtContent
																		+ '</div>';
																replyElement
																		.find(
																				".replyModify-form")
																		.replaceWith(
																				originalCommentHtml);
															});
										});
					},
					error : function(error) {
						console.error("Ajax 요청 실패:", error);
						alert("Error fetching comments");
						console
								.log("Exiting updateCommentList function due to error");
					}
				});
	}

	// 국가에 따라 다른 이미지 반환
	function getUserImage(userNation) {
		console.log("userNation:", userNation);
		switch (userNation) {
		case "대한민국":
			return "/img/comment/nation-kr.png";
		case "미국":
			return "/img/comment/nation-en.png";
		case "중국":
			return "/img/comment/nation-chn.png";
		case "일본":
			return "/img/comment/nation-jp.png";
		default:
			return "/img/comment/default.png";
		}
	}

	$(document)
			.ready(
					function() {
						$("#submitReplyBtn")
								.off("click")
								.on(
										"click",
										function() {
											var qnaCmtContentValue = $(
													"#qnaCmtContent").val()
													.trim();
											if (!qnaCmtContentValue) {
												alert("댓글 내용을 입력하세요.");
												return;
											}

											$
													.ajax({
														type : 'POST',
														url : "/korean/qnareply_write",
														contentType : 'application/json', // JSON 형식으로 데이터 전송
														data : JSON
																.stringify({
																	qnaSeq : $(
																			"#qnaSeq")
																			.val(),
																	qnaCmtContent : qnaCmtContentValue,
																	userSeq : "${SPRING_SECURITY_CONTEXT.authentication.principal.gorea_UserTO.userSeq}"
																}),
														success : function(
																response) {
															alert("작성 성공");
															$("#qnaCmtContent")
																	.val("");
															updateCommentList();
														},
														error : function(xhr,
																status, error) {
															console
																	.error("AJAX 오류: "
																			+ status
																			+ ", "
																			+ error);
															console
																	.log(xhr.responseText);
															alert("댓글 서버 전송 실패");
														}
													});
										});
					});

	// ============================= 리뷰 수정 =============================
	function saveReply(qnaCmtSeq, qnaCmtContent) {
		console.log("saveReply called with", qnaCmtSeq, qnaCmtContent); // 로그 추가

		if (!qnaCmtContent.trim()) {
			alert("댓글 내용을 입력하세요.");
			return;
		}

		$.ajax({
			type : 'POST',
			url : "/korean/qnareplmodifyok", // 경로 확인
			contentType : 'application/json',
			data : JSON.stringify({
				qnaCmtSeq : qnaCmtSeq, // 키 이름 확인 필요
				qnaCmtContent : qnaCmtContent
			// 키 이름 확인 필요
			}),
			success : function(response) {
				alert("댓글 수정 성공");
				updateCommentList();
			},
			error : function(xhr, textStatus, errorThrown) {
				console.error("Error updating comment:", errorThrown);
				alert("댓글 수정 실패: " + xhr.responseText);
			}
		});
	}

	$(document)
			.on(
					"click",
					".delete",
					function(event) {
						event.preventDefault();
						var qnaCmtSeq = $(this).data("reply");
						var replyUserSeq = $(this).data("user-seq");
						var loginUserSeq = "${SPRING_SECURITY_CONTEXT.authentication.principal.gorea_UserTO.userSeq}";

						if (replyUserSeq != loginUserSeq) {
							alert("본인이 작성한 댓글만 삭제할 수 있습니다.");
							return;
						}

						$.ajax({
							type : 'POST',
							url : "/korean/qnadelete/" + qnaCmtSeq,
							success : function(response) {
								if (response > 0) {
									updateCommentList();
									alert('댓글 삭제 성공');
								} else {
									console.error("error");
									alert('댓글 삭제 실패');
								}
							},
							error : function() {
								console.error("error");
								alert("서버와 통신 중 오류 발생");
							}
						});
					});

	$(document).ready(function() {
		updateCommentList();
	});

	$(window).on('beforeunload', function() {
		updateCommentList();
	});
</script>
</head>
<body>
	<aside>
		<button class="close-sidebar-btn" onclick="toggleSidebar()">X</button>
		<div class="logo">GO!REA</div>
		<ul>
            <li class="tooltip">
                <a href="#"><i class="fas fa-tachometer-alt"></i> <span class="menu-item-text">대시보드</span></a>
            </li>
            <li class="tooltip">
                <a href="#"><i class="fas fa-home"></i> <span class="menu-item-text">메인 관리</span></a>
            </li>
            <li class="tooltip">
                <a href="javascript:void(0);" onclick="toggleSubmenu('data-management-submenu')" data-target="data-management-submenu">
                    <i class="fas fa-database"></i> <span class="menu-item-text">데이터 관리</span><span class="submenu-indicator">∨</span>
                </a>
                <ul id="data-management-submenu" class="submenu">
                    <li><a href="#">Best5</a></li>
                    <li><a href="adminuserRecom.do">장소추천</a></li>
                    <li><a href="adminfreeboard.do">자유게시판</a></li>
                    <li><a href="adminEditReco.do">에디터 추천 장소</a></li>
                    <li><a href="admineditTip.do">에디터 꿀팁</a></li>
                    <li><a href="adminTrendseoul.do">트렌드 서울</a></li>
                    <li><a href="adminnotice.do">공지사항</a></li>
                </ul>
            </li>
            <li class="tooltip">
                <a href="javascript:void(0);" onclick="toggleSubmenu('member-management-submenu')" data-target="member-management-submenu">
                    <i class="fas fa-users"></i> <span class="menu-item-text">회원 관리</span><span class="submenu-indicator">∨</span>
                </a>
                <ul id="member-management-submenu" class="submenu">
                    <li><a href="adminUserList.do">회원 목록 확인</a></li>
                    <!-- 
                    <li><a href="#">회원 비밀번호 변경</a></li>
                    <li><a href="#">회원 탈퇴</a></li>  -->
                </ul>
            </li>
            <li class="tooltip">
                <a href="adminqna.do"><i class="fas fa-envelope"></i> <span class="menu-item-text">문의 관리</span></a>
            </li>
            <li class="tooltip">
                <a href="#"><i class="fas fa-chart-bar"></i> <span class="menu-item-text">통계 관리</span></a>
            </li>
        </ul>
		<footer class="sidebar-footer">
			<a href="#"></a> <a href="#"></a>
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

		<!-- qna 보기 내용 -->
		<c:set var="seq" value="${param.qnaSeq}" />
		<c:set var="to" value="${requestScope.to}" />
		<c:set var="role"
			value="${SPRING_SECURITY_CONTEXT.authentication.principal.gorea_UserTO.userRole}" />

		<div class="containers">
	<div class="tith2">
            <h1>QnA</h1>
        </div>
		<div class="post-title">
			[<c:out value="${to.qnaCategory}" escapeXml="false" />]
			<c:out value="${to.qnaTitle}" />
		</div>
		<div class="post-info">
			<div class="post-info-left">
				<span class="post-info-item">작성자:${to.userNickname}</span>
				<span class="post-info-item">작성일: <c:out
						value="${to.qnapostDate}" escapeXml="false" /></span>
			</div>
		</div>
		<div class="post-content">
			<c:out value="${to.qnaContent}" escapeXml="false" />
		</div>
		<div class="comment-section">
			<div class="comments-count"></div>
			<form id="replyForm" method="post">
				<input type="hidden" id="qnaSeq" value="${param.qnaSeq}" /> <input
					type="hidden" name="userSeq" value="${userSeq}">
				<div class="reply-form">

					<c:choose>
						<c:when test="${role eq 'ROLE_ADMIN'}">
							<div class="comment-container">
								<textarea style="resize: none;" id="qnaCmtContent"
									placeholder="댓글을 입력하세요"></textarea>
								<button type="button" class="submitReplyBtn" id="submitReplyBtn">등록</button>
							</div>
						</c:when>
					</c:choose>

				</div>
			</form>
			<div class="reply-section">
				<div id="replyContainer"></div>
			</div>
			<div class="post-actions align-right">
					<c:choose>
						<c:when test="${role eq 'ROLE_ADMIN' or userSeq eq to.userSeq}">
							<input type="button" value="삭제" class="btn"
								style="cursor: pointer;"
								onclick="location.href='adminqna_delete_ok.do?qnaSeq=${seq}'" />
							<input type="button" value="수정" class="btn"
								style="cursor: pointer;"
								onclick="location.href='adminqna_modify.do?qnaSeq=${seq}'" />
						</c:when>
					</c:choose>
					<input type="button" value="목록" class="btn"
						style="cursor: pointer;" onclick="location.href='adminqna.do'" />
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
