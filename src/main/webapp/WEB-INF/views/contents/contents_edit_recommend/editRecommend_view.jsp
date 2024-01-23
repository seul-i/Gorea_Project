<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.gorea.dto_board.Gorea_EditRecommend_BoardTO"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>


<c:set var="language" value="${language}" />
<c:set var="seq" value="${param.editrecoSeq}" />
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
    <script type="text/javascript">
    
    let language='${language}';
    
    function updateCommentList() {
        $.ajax({
            type: 'GET',
            url: "/korean/edit_list/" + $("#editrecoSeq").val(),
            success: function (response) {
                var replyContainer = $("#replyContainer");
                replyContainer.empty();

                for (var i = 0; i < response.length; i++) {
                    var editrecoCmtContent = response[i];

                    var html = '<div class="post-comment" id="editrecoCmtContent_' + editrecoCmtContent.editrecoCmtSeq + '">';
                    html += '<div class="comment-list">';
                    html += '<div class="flex">';
                    html += '<div class="user">';
                    html += '<div class="user-image"><img src="' + getUserImage(editrecoCmtContent.userNation) + '" alt=""></div>';
                    html += '<div class="user-meta">';
                    html += '<div class="name">' + editrecoCmtContent.userNickname + '</div>';
                    html += '<div class="day">' + editrecoCmtContent.editrecoCmtWdate + '</div>';
                    html += '<div class="original-comment">' + editrecoCmtContent.editrecoCmtContent + '</div>';
                    html += '</div>';
                    html += '</div>';

                    var loginUserSeq = "${SPRING_SECURITY_CONTEXT.authentication.principal.gorea_UserTO.userSeq}";

                    if (loginUserSeq == editrecoCmtContent.userSeq) {
                        // 수정, 삭제 버튼은 댓글 작성자와 로그인한 사용자가 동일한 경우에만 표시
                        html += '<div class="comment-buttons">';
                        
                        if(language === 'korean'){
                     html += '<button class="modify" data-reply="' + editrecoCmtContent.editrecoCmtSeq + '" data-user-seq="' + editrecoCmtContent.userSeq + '">수정</button>';
                     html += '<button class="delete" data-reply="' + editrecoCmtContent.editrecoCmtSeq + '" data-user-seq="' + editrecoCmtContent.userSeq + '">삭제</button>';
                        }else if(language === 'english'){
                     html += '<button class="modify" data-reply="' + editrecoCmtContent.editrecoCmtSeq + '" data-user-seq="' + editrecoCmtContent.userSeq + '">modify</button>';
                     html += '<button class="delete" data-reply="' + editrecoCmtContent.editrecoCmtSeq + '" data-user-seq="' + editrecoCmtContent.userSeq + '">delete</button>';
                        }else if(language === 'japanese'){
                     html += '<button class="modify" data-reply="' + editrecoCmtContent.editrecoCmtSeq + '" data-user-seq="' + editrecoCmtContent.userSeq + '">修正する</button>';
                     html += '<button class="delete" data-reply="' + editrecoCmtContent.editrecoCmtSeq + '" data-user-seq="' + editrecoCmtContent.userSeq + '">消去</button>';
                        }else if(language === 'chinese'){
                     html += '<button class="modify" data-reply="' + editrecoCmtContent.editrecoCmtSeq + '" data-user-seq="' + editrecoCmtContent.userSeq + '">调整</button>';
                     html += '<button class="delete" data-reply="' + editrecoCmtContent.editrecoCmtSeq + '" data-user-seq="' + editrecoCmtContent.userSeq + '">删除</button>';
                        }else{
                     html += '<button class="modify" data-reply="' + editrecoCmtContent.editrecoCmtSeq + '" data-user-seq="' + editrecoCmtContent.userSeq + '">수정</button>';
                     html += '<button class="delete" data-reply="' + editrecoCmtContent.editrecoCmtSeq + '" data-user-seq="' + editrecoCmtContent.userSeq + '">삭제</button>';
                        }
                        html += '</div>';
                    }

                    html += '</div>';

                    // 수정 폼
                    html += '<div class="replyModify-form" id="replyModifyForm_' + editrecoCmtContent.editrecoCmtSeq + '" style="display:none;">';
                    html += '<input type="hidden" name="editrecoCmtSeq" value="' + editrecoCmtContent.editrecoCmtSeq + '">';
                    html += '<div class="original-comment" style="text-align: left;">' + editrecoCmtContent.editrecoCmtContent + '</div>'; // 기존 댓글 내용 표시
                    html += '<textarea style="resize: none;" id="replyModifyComment_' + editrecoCmtContent.editrecoCmtSeq + '" style=" border: 1px solid #ccc; ">' + editrecoCmtContent.editrecoCmtContent + '</textarea>';
                    html += '<button class="save" data-reply="' + editrecoCmtContent.editrecoCmtSeq + '">저장</button>';
                    html += '</div>';

                    html += '</div>'; // 추가된 부분

                    replyContainer.append(html);
                }

                $('.modify').on('click', function () {
                    var editrecoCmtSeq = $(this).data("reply");
                    var replyElement = $("#editrecoCmtContent_" + editrecoCmtSeq);
                    var replyUserSeq = $(this).data("user-seq");
                    var loginUserSeq = "${SPRING_SECURITY_CONTEXT.authentication.principal.gorea_UserTO.userSeq}";

                    if (replyUserSeq == loginUserSeq) {
                        // 기존 댓글 정보를 가져옴
                        var editrecoCmtContent = replyElement.find(".original-comment").text().trim();

                        // 수정 폼 표시
                        replyElement.find(".comment-buttons").hide(); // 수정, 삭제 버튼 감춤
                        replyElement.find(".original-comment").hide();
                        replyElement.find(".replyModify-form").show();

                        // 저장 버튼 클릭 이벤트 처리
                        $("#replyModifyForm_" + editrecoCmtSeq + " .save").off("click").on("click", function () {
                            var editrecoCmtSeq = $(this).data("reply");
                            var editrecoCmtContent = $("#replyModifyComment_" + editrecoCmtSeq).val();
                            saveReply(editrecoCmtSeq, editrecoCmtContent);

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
                return "/img/comment/nation-wr.png";
        }
    }

        // ============================= 댓글 작성 =============================
        $(document).ready(function () {
            $("#submitReplyBtn").click(function () {
                var editrecoCmtContentValue = $("#editrecoCmtContent").val().trim();
                if (!editrecoCmtContentValue) {
                    alert("댓글 내용을 입력하세요.");
                    return;
                }

                $.ajax({
                    type: 'POST',
                    url: "/korean/edit_reply_Ok",
                    data: {
                        editrecoSeq: $("#editrecoSeq").val(),
                        editrecoCmtContent: editrecoCmtContentValue,
                        userSeq: "${SPRING_SECURITY_CONTEXT.authentication.principal.gorea_UserTO.userSeq}"
                    },
                    success: function (response) {
                        alert("작성 성공");
                        $("#editrecoCmtContent").val("");
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
        function saveReply(editrecoCmtSeq, editrecoCmtContent) {
           // 수정할 때 댓글 내용이 비어있는지 체크
            if (!editrecoCmtContent.trim()) {
                alert("댓글 내용을 입력하세요.");
                return;
            }
            
            $.ajax({
                type: 'POST',
                url: "/korean/edit_modify_Ok",
                data: {
                    editrecoCmtSeq: editrecoCmtSeq,
                    editrecoCmtContent: editrecoCmtContent
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
            var editrecoCmtSeq = $(this).data("reply");
            var replyUserSeq = $(this).data("user-seq");
            var loginUserSeq = "${SPRING_SECURITY_CONTEXT.authentication.principal.gorea_UserTO.userSeq}";

            if (replyUserSeq != loginUserSeq) {
                alert("본인이 작성한 댓글만 삭제할 수 있습니다.");
                return;
            }

            $.ajax({
                type: 'post',
                url: "/korean/edit_delete/" + editrecoCmtSeq,
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
      <i class="fa-solid fa-house"></i>
      <span class="ar">></span>
      <c:choose>
         <c:when test="${language eq 'korean'}">
         
            추천 <span class="ar">></span> 
             <span> 
                <a href="./editRecommend_list.do">에디터 추천 장소</a>
             </span>
          
         </c:when>
         <c:when test="${language eq 'english'}">
         
            recommend <span class="ar">></span> 
             <span> 
                <a href="./editRecommend_list.do">Editor's Recommended Places</a>
             </span>
         
         </c:when>
         <c:when test="${language eq 'japanese'}">
         
            おすすめ <span class="ar">></span> 
             <span> 
                <a href="./editRecommend_list.do">エディターおすすめの場所</a>
             </span>
         
         </c:when>
         <c:when test="${language eq 'chinese'}">
         
            
            建议 <span class="ar">></span> 
             <span> 
                <a href="./editRecommend_list.do">编辑推荐的地方</a>
             </span>
         
         </c:when>
         <c:otherwise>제목</c:otherwise>
      </c:choose>
   </div>
   
   <section class="infor-element">
       <div class="infor-title">
         <c:choose>
            <c:when test="${language eq 'korean'}">
            
               <p class="h4">에디터 추천 장소</p>
                 <h3 class="h3 textcenter">${to.editrecoSubject}</h3>
                 <div class="post-element">
                     <span>작성일 : ${to.editrecoWdate}</span> <span>조회수 : ${to.editrecoHit}</span>
                 </div>
                 
            </c:when>
            <c:when test="${language eq 'english'}">
            
               <p class="h4">Editor's Recommended Places</p>
                 <h3 class="h3 textcenter">${to.editrecoSubject}</h3>
                 <div class="post-element">
                     <span>Date Created : ${to.editrecoWdate}</span> <span>views : ${to.editrecoHit}</span>
                 </div>
            
            </c:when>
            <c:when test="${language eq 'japanese'}">
               
               <p class="h4">エディターおすすめの場所</p>
                 <h3 class="h3 textcenter">${to.editrecoSubject}</h3>
                 <div class="post-element">
                     <span>作成日 : ${to.editrecoWdate}</span> <span>ヒット : ${to.editrecoHit}</span>
                 </div>
            
            </c:when>
            <c:when test="${language eq 'chinese'}">
            
               <p class="h4">编辑推荐的地方</p>
                 <h3 class="h3 textcenter">${to.editrecoSubject}</h3>
                 <div class="post-element">
                     <span>创建日期 : ${to.editrecoWdate}</span> <span>意见 : ${to.editrecoHit}</span>
                 </div>
            
            </c:when>
            <c:otherwise>제목</c:otherwise>
         </c:choose>

           <div class="text-area">
                 ${fn:replace(to.editrecoContent, '&nbsp;', ' ')}
           </div>
           
           <form id="replyForm" method="post">
               <input type="hidden" id="editrecoSeq" value="${param.editrecoSeq}" />
               <input type="hidden" name="userSeq" value="${userSeq}">
               <div class="reply-form">
               
                  <c:choose>
                  <c:when test="${language eq 'korean'}">
                  
                  <div class="comment-container">
                          <textarea style="resize: none;" id="editrecoCmtContent" placeholder="댓글을 입력하세요"></textarea>
                          <button type="button" class="submitReplyBtn" id="submitReplyBtn">등록</button>
                      </div>
                   
                  </c:when>
                  <c:when test="${language eq 'english'}">
                  
                  <div class="comment-container">
                          <textarea style="resize: none;" id="editrecoCmtContent" placeholder="Please enter your comment"></textarea>
                          <button type="button" class="submitReplyBtn" id="submitReplyBtn">write</button>
                      </div>
                  
                  </c:when>
                  <c:when test="${language eq 'japanese'}">
                  
                  <div class="comment-container">
                          <textarea style="resize: none;" id="editrecoCmtContent" placeholder="コメントを入力してください"></textarea>
                          <button type="button" class="submitReplyBtn" id="submitReplyBtn">書く</button>
                      </div>
                  
                  </c:when>
                  <c:when test="${language eq 'chinese'}">            
                     
                  <div class="comment-container">
                          <textarea style="resize: none;" id="editrecoCmtContent" placeholder="请输入您的评论"></textarea>
                          <button type="button" class="submitReplyBtn" id="submitReplyBtn">写</button>
                      </div>
                  
                  </c:when>
                  <c:otherwise>제목</c:otherwise>
               </c:choose>
               </div>
           </form>
           
           <!-- 댓글 영역 -->
           <div class="reply-section">
               <div id="replyContainer"></div>
           </div>
           <c:choose>
            <c:when test="${role eq 'ROLE_USER'}">
               <div style="text-align: right; margin-top: 10px;">
                  <button class="btn1" type="button"
                  onclick="location.href='editRecommend_list.do'">
                     <c:choose>
                         <c:when test="${language eq 'korean'}">목록</c:when>
                         <c:when test="${language eq 'english'}">List</c:when>
                         <c:when test="${language eq 'japanese'}">リスト</c:when>
                         <c:when test="${language eq 'chinese'}">列表</c:when>
                        </c:choose>
                  </button>
               </div>
            </c:when>
         </c:choose>
            
         <c:choose>
            <c:when test="${role eq 'ROLE_ADMIN'}">
                  <div style="text-align: right; margin-top: 10px;">
                      <button class="btn1" type="button"
                          onclick="location.href='editRecommend_delete_ok.do?editrecoSeq=${seq}'">
                          삭제</button>
                      <button class="btn1" type="button"
                          onclick="location.href='editRecommend_modify.do?editrecoSeq=${seq}'">
                          수정</button>
                      <button class="btn1" type="button"
                          onclick="location.href='editRecommend_list.do'">목록</button>
                  </div>
            </c:when>
         </c:choose>
           
       </div>
   </section>

   <jsp:include page="/WEB-INF/views/includes/footer.jsp"></jsp:include>

</body>
</html>