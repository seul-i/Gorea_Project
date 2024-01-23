<%@ page import="com.gorea.dto_board.Gorea_EditTip_BoardTO"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<c:set var="language" value="${language}" />
<c:set var="seq" value="${param.edittipSeq}" />
<c:set var="to" value="${requestScope.to}" />

<!-- Login 시에 Security context 에서 가져오는 유저 정보-->
<c:set var="role"
   value="${SPRING_SECURITY_CONTEXT.authentication.principal.gorea_UserTO.userRole}" />
   
<c:set var="userSeq" value="${SPRING_SECURITY_CONTEXT.authentication.principal.gorea_UserTO.userSeq}" />

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>게시판 뷰</title>
    <link rel="stylesheet" type="text/css" href="/css/editor/view.css">
    <link rel="stylesheet" type="text/css" href="/css/editor/comment.css">
    <script src="https://kit.fontawesome.com/42d55d598f.js" crossorigin="anonymous"></script>
    <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.min.js"></script>

    <!-- ============================= 댓글 리스트 ============================= -->
    <script>
    function updateCommentList() {
        $.ajax({
            type: 'GET',
            url: "/korean/edittip_list/" + $("#edittipSeq").val(),
            success: function (response) {
                var replyContainer = $("#replyContainer");
                replyContainer.empty();

                for (var i = 0; i < response.length; i++) {
                    var edittipCmtContent = response[i];

                    var html = '<div class="post-comment" id="edittipCmtContent_' + edittipCmtContent.edittipCmtSeq + '">';
                    html += '<div class="comment-list">';
                    html += '<div class="flex">';
                    html += '<div class="user">';
                    html += '<div class="user-image"><img src="' + getUserImage(edittipCmtContent.userNation) + '" alt=""></div>';
                    html += '<div class="user-meta">';
                    html += '<div class="name">' + edittipCmtContent.userNickname + '</div>';
                    html += '<div class="day">' + edittipCmtContent.edittipCmtWdate + '</div>';
                    html += '<div class="original-comment">' + edittipCmtContent.edittipCmtContent + '</div>';
                    html += '</div>';
                    html += '</div>';

                    var loginUserSeq = "${SPRING_SECURITY_CONTEXT.authentication.principal.gorea_UserTO.userSeq}";

                    if (loginUserSeq == edittipCmtContent.userSeq) {
                        // 수정, 삭제 버튼은 댓글 작성자와 로그인한 사용자가 동일한 경우에만 표시
                        html += '<div class="comment-buttons">';
                        html += '<button class="modify" data-reply="' + edittipCmtContent.edittipCmtSeq + '" data-user-seq="' + edittipCmtContent.userSeq + '">수정</button>';
                        html += '<button class="delete" data-reply="' + edittipCmtContent.edittipCmtSeq + '" data-user-seq="' + edittipCmtContent.userSeq + '">삭제</button>';
                        html += '</div>';
                    }

                    html += '</div>';
               
                    // 수정 폼
                    html += '<div class="replyModify-form" id="replyModifyForm_' + edittipCmtContent.edittipCmtSeq + '" style="display:none;">';
                    html += '<input type="hidden" name="edittipCmtSeq" value="' + edittipCmtContent.edittipCmtSeq + '">';
                    html += '<div class="original-comment" style="text-align: left;">' + edittipCmtContent.edittipCmtContent + '</div>'; // 기존 댓글 내용 표시
                    html += '<textarea style="resize: none;" id="replyModifyComment_' + edittipCmtContent.edittipCmtSeq + '" style=" border: 1px solid #ccc; ">' + edittipCmtContent.edittipCmtContent + '</textarea>';
                    html += '<button class="save" data-reply="' + edittipCmtContent.edittipCmtSeq + '">저장</button>';
                    html += '</div>';

                    html += '</div>'; // 추가된 부분
                    
                    replyContainer.append(html);
                }

                $('.modify').on('click', function () {
                    var edittipCmtSeq = $(this).data("reply");
                    var replyElement = $("#edittipCmtContent_" + edittipCmtSeq);
                    var replyUserSeq = $(this).data("user-seq");
                    var loginUserSeq = "${SPRING_SECURITY_CONTEXT.authentication.principal.gorea_UserTO.userSeq}";

                    if (replyUserSeq == loginUserSeq) {
                        // 기존 댓글 정보를 가져옴
                        var edittipCmtContent = replyElement.find(".original-comment").text().trim();

                        // 수정 폼 표시
                        replyElement.find(".comment-buttons").hide(); // 수정, 삭제 버튼 감춤
                        replyElement.find(".original-comment").hide();
                        replyElement.find(".replyModify-form").show();

                        // 저장 버튼 클릭 이벤트 처리
                        $("#replyModifyForm_" + edittipCmtSeq + " .save").off("click").on("click", function () {
                            var edittipCmtSeq = $(this).data("reply");
                            var edittipCmtContent = $("#replyModifyComment_" + edittipCmtSeq).val();
                            saveReply(edittipCmtSeq, edittipCmtContent);
                            
                         // 수정 폼 숨기고 수정, 삭제 버튼 다시 표시
                            replyElement.find(".comment-buttons").show();
                            replyElement.find(".original-comment").show();
                            replyElement.find(".replyModify-form").hide();
                        });
                    } else {
                        alert("댓글을 작성한 사용자만이 수정할 수 있습니다.");
                    }
                });
            },
            error: function (error) {
                console.error("Ajax 요청 실패:", error);
                alert("Error fetching comments");
                console.log("Exiting updateCommentList function due to error");
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



        // ============================= 리뷰 작성 =============================
        $(document).ready(function () {
            $("#submitReplyBtn").click(function () {
                var edittipCmtContentValue = $("#edittipCmtContent").val().trim();
                if (!edittipCmtContentValue) {
                    alert("댓글 내용을 입력하세요.");
                    return;
                }

                $.ajax({
                    type: 'POST',
                    url: "/korean/edittip_reply_Ok",
                    data: {
                        edittipSeq: $("#edittipSeq").val(),
                        edittipCmtContent: edittipCmtContentValue,
                        userSeq: "${SPRING_SECURITY_CONTEXT.authentication.principal.gorea_UserTO.userSeq}"
                    },
                    success: function (response) {
                        alert("작성 성공");
                        $("#edittipCmtContent").val("");
                        updateCommentList();
                    },
                    error: function (xhr, status, error) {
                        console.error("AJAX 오류: " + status + ", " + error);
                        console.log(xhr.responseText);
                        alert("댓글 서버 전송 실패");
                    }
                });
            });
        });

        // ============================= 리뷰 수정 =============================
        function saveReply(edittipCmtSeq, edittipCmtContent) {
           // 수정할 때 댓글 내용이 비어있는지 체크
            if (!edittipCmtContent.trim()) {
                alert("댓글 내용을 입력하세요.");
                return;
            }
            
            $.ajax({
                type: 'POST',
                url: "/korean/edittip_modify_Ok",
                data: {
                    edittipCmtSeq: edittipCmtSeq,
                    edittipCmtContent: edittipCmtContent
                },
                success: function (response) {
                    alert("댓글 수정 성공");
                    updateCommentList();
                },
                error: function (xhr, textStatus, errorThrown) {
                    console.error("Error updating comment:", errorThrown);
                    console.log(xhr.responseText);
                }
            });
        }

        // ============================= 리뷰 삭제 =============================
        $(document).on("click", ".delete", function (event) {
            event.preventDefault();
            var edittipCmtSeq = $(this).data("reply");
            var replyUserSeq = $(this).data("user-seq");
            var loginUserSeq = "${SPRING_SECURITY_CONTEXT.authentication.principal.gorea_UserTO.userSeq}";

            if (replyUserSeq != loginUserSeq) {
                alert("본인이 작성한 댓글만 삭제할 수 있습니다.");
                return;
            }

            $.ajax({
                type: 'post',
                url: "/korean/edittip_delete/" + edittipCmtSeq,
                success: function (response) {
                    if (response > 0) {
                        updateCommentList();
                        alert('댓글 삭제 성공');
                    } else {
                        console.error("error");
                        alert('댓글 삭제 실패');
                    }
                },
                error: function () {
                    console.error("error");
                    alert("서버와 통신 중 오류 발생");
                }
            });
        });

        $(document).ready(function () {
            updateCommentList();
        });

        $(window).on('beforeunload', function () {
            updateCommentList();
        });
    </script>

</head>
<body>
<jsp:include page="/WEB-INF/views/includes/header${language}.jsp"></jsp:include>

<div class="location">
    <i class="fa-solid fa-house"></i> <span class="ar">></span> 추천 <span class="ar">></span> <span> <a href="./edittip_list.do">에디터 꿀팁</a>
    </span>
</div>
<section class="infor-element">
    <div class="infor-title">
            <p class="h4">에디터 꿀팁</p>
            
            <h3 class="h3 textcenter">${eto.edittipSubject}</h3> 

            <div class="post-element">
                <span>제작일 : ${eto.edittipWdate}</span> <span>조회수 : ${eto.edittipHit}</span>
            </div>

            <div class="text-area">
                <img class="blog-image">${eto.edittipContent}
            </div>
        <form id="replyForm" method="post">
            <input type="hidden" id="edittipSeq" value="${param.edittipSeq}" />
            <input type="hidden" name="userSeq" value="${userSeq}">
            <div class="reply-form">
                <div class="comment-container">
                    <textarea style="resize: none;" id="edittipCmtContent" placeholder="댓글을 입력하세요"></textarea>
                    <button type="button" class="submitReplyBtn" id="submitReplyBtn">등록</button>
                </div>
            </div>
        </form>
        <div class="reply-section">
            <div id="replyContainer"></div>
        </div>
         
       <c:choose>
      <c:when test="${role eq 'ROLE_ADMIN'}">
            <div style="text-align: right; margin-top: 10px;">
                <button class="btn1" type="button"
                    onclick="location.href='editTip_delete_ok.do?edittipSeq=${seq}'">
                    삭제</button>
                <button class="btn1" type="button"
                    onclick="location.href='editTip_modify.do?edittipSeq=${seq}'">
                    수정</button>
                <button class="btn1" type="button"
                    onclick="location.href='editTip_list.do'">목록</button>
            </div>
        </c:when>
        </c:choose>
        
    </div>
</section>
</body>
</html>