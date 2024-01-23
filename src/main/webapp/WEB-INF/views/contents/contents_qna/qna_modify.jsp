<%@page import="com.gorea.dto_board.Gorea_Notice_BoardTO"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page session="false" %>
<c:set var="language" value="${language}" />
<!DOCTYPE html>
<html>
<head>
    <title>GO!rea</title>
    <link rel="stylesheet" type="text/css" href="/css/qna/modify.css">
    <script src="https://cdn.ckeditor.com/4.22.1/full-all/ckeditor.js"></script>
</head>
<body>
	<jsp:include page="/WEB-INF/views/includes/header${language}.jsp"></jsp:include>
	<div class="location">
      <i class="fa-solid fa-house"></i>
      <span class="ar">></span>
      <c:choose>
         <c:when test="${language eq 'korean'}">
         <span> 
                여행자 지원 >
             </span>
             <span> 
                QnA
             </span>
         </c:when>
         <c:when test="${language eq 'english'}">
             <span> 
                여행자 지원 >
             </span>
             <span> 
                QnA
             </span>
         </c:when>
         <c:when test="${language eq 'japanese'}">
             <span> 
                여행자 지원 >
             </span>
             <span> 
                QnA
             </span>
         </c:when>
         <c:when test="${language eq 'chinese'}">
             <span> 
                여행자 지원 >
             </span>
             <span> 
                QnA
             </span>
         </c:when>
         <c:otherwise>제목</c:otherwise>
      </c:choose>
   </div>
    <div class="containers">
    <div class="tith2">
            <h2>QnA</h2> <!-- 제목을 중앙 정렬 -->
            <!-- 폼과 나머지 내용 -->
        </div>
        <form action="./qna_modify_ok.do" method="post" name="mfrm" enctype="multipart/form-data" class="form-horizontal">
            <c:set var="to" value="${requestScope.to}" />
            <input type="hidden" name="qnaSeq" value="${param.qnaSeq}"/>
            <c:choose>
            <c:when test="${language eq 'korean'}">
            
               <div>
                    <div class="form-group">
                         <div class="stits">
                             <p>문의유형</p>
                         </div>
                <select class="form-control" name="qnaCategory" style="border: 1px solid #ccc">
                    <option value="컨텐츠">컨텐츠</option>
                    <option value="회원">회원</option>
                    <option value="사이트이용">사이트이용</option>
                    <option value="게시판">게시판</option>
                    <option value="기타">기타</option>
                </select>
            </div>
            <div class="form-group">
            <div class="stits">
                    <p>제목</p>
                </div>
                <input type="text" class="form-control" value="${to.qnaTitle}" name="qnaTitle" style="height: 40px" />
            </div>
            <div class="form-group">
                <textarea class="form-control" id="qnaContent" name="qnaContent">${to.qnaContent}</textarea>
            </div>

            <div class="btn_wrap">
                <button type="submit" class="btn btn-primary" id="mbtn">수정하기</button>
            </div>
            </div>
            </c:when>
            
            <c:when test="${language eq 'english'}">
            
               <div>
                    <div class="form-group">
                         <div class="stits">
                             <p>Inquiry type</p>
                         </div>
                <select class="form-control" name="qnaCategory" style="border: 1px solid #ccc">
                    <option value="컨텐츠">Content</option>
                    <option value="회원">Member</option>
                    <option value="사이트이용">Site Usage</option>
                    <option value="게시판">Board</option>
                    <option value="기타">Other</option>
                </select>
            </div>
            <div class="form-group">
            <div class="stits">
                    <p>Title</p>
                </div>
                <input type="text" class="form-control" value="${to.qnaTitle}" name="qnaTitle" style="height: 40px" />
            </div>
            <div class="form-group">
                <textarea class="form-control" id="qnaContent" name="qnaContent">${to.qnaContent}</textarea>
            </div>

            <div class="btn_wrap">
                <button type="submit" class="btn btn-primary" id="mbtn">Modify</button>
            </div>
            </div>
            </c:when>
            
            <c:when test="${language eq 'japanese'}">
            
               <div>
                    <div class="form-group">
                         <div class="stits" style="width:150px;">
                             <p>お問い合わせ種類</p>
                         </div>
                <select class="form-control" name="qnaCategory" style="border: 1px solid #ccc">
                    <option value="컨텐츠">コンテンツ</option>
                    <option value="회원">メンバー</option>
                    <option value="사이트이용">サイト利用</option>
                    <option value="게시판">フォーラム</option>
                    <option value="기타">その他</option>
                </select>
            </div>
            <div class="form-group">
            <div class="stits">
                    <p>タイトル</p>
                </div>
                <input type="text" class="form-control" value="${to.qnaTitle}" name="qnaTitle" style="height: 40px" />
            </div>
            <div class="form-group">
                <textarea class="form-control" id="qnaContent" name="qnaContent">${to.qnaContent}</textarea>
            </div>

            <div class="btn_wrap">
                <button type="submit" class="btn btn-primary" id="mbtn">文の修正</button>
            </div>
            </div>
            </c:when>
            
            <c:when test="${language eq 'chinese'}">
            
               <div>
                    <div class="form-group">
                         <div class="stits">
                             <p>询价类型</p>
                         </div>
                <select class="form-control" name="qnaCategory" style="border: 1px solid #ccc">
                    <option value="컨텐츠">内容</option>
                    <option value="회원">会员</option>
                    <option value="사이트이용">网站使用</option>
                    <option value="게시판">论坛</option>
                    <option value="기타">其他</option>
                </select>
            </div>
            <div class="form-group">
            <div class="stits">
                    <p>修改文章</p>
                </div>
                <input type="text" class="form-control" value="${to.qnaTitle}" name="qnaTitle" style="height: 40px" />
            </div>
            <div class="form-group">
                <textarea class="form-control" id="qnaContent" name="qnaContent">${to.qnaContent}</textarea>
            </div>

            <div class="btn_wrap">
                <button type="submit" class="btn btn-primary" id="mbtn">文の修正</button>
            </div>
            </div>
            </c:when>
            </c:choose>
        </form>
    </div>
    <script type="text/javascript">
        window.onload = function() {
            CKEDITOR.replace('qnaContent', {
                filebrowserUploadUrl: '/qna/imageUpload',
                height: 700,
                toolbar: [
                    { name: 'clipboard', items: [ 'Undo', 'Redo' ] },
                    { name: 'styles', items: ['Font', 'FontSize' ] },
                    { name: 'basicstyles', items: [ 'Bold', 'Italic', 'Underline', 'Strike', 'RemoveFormat', 'CopyFormatting' ] },
                    { name: 'colors', items: [ 'TextColor', 'BGColor' ] },
                    { name: 'align', items: [ 'JustifyLeft', 'JustifyCenter', 'JustifyRight' ] },
                    { name: 'links', items: [ 'Link', 'Unlink' ] },
                    { name: 'paragraph', items: [ 'NumberedList', 'BulletedList', '-', 'Blockquote' ] },
                    { name: 'insert', items: [ 'Image' ] },
                    { name: 'tools', items: [ 'Maximize' ] },
                    { name: 'editing', items: [ 'Scayt' ] }
                ]
            });
        };
    </script>
    <script type="text/javascript">
        document.getElementById('mbtn').onclick = function() {
            var title = document.mfrm.qnaTitle.value.trim();
            var content = CKEDITOR.instances.qnaContent.getData().trim();
            
            if (title === "") {
                alert('제목을 입력하셔야 합니다.');
                return false;
            }
            if (content === "") {
                alert('내용을 입력하셔야 합니다.');
                return false;
            }
        };
    </script>
    <jsp:include page="/WEB-INF/views/includes/footer.jsp"></jsp:include>
</body>
</html>