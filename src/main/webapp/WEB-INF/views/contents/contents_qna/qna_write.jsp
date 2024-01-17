<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<c:set var="language" value="${language}" />
<html>
<head>
    <title>GO!rea</title>
    <link rel="stylesheet" type="text/css" href="/css/qna/write.css">
    <script src="https://cdn.ckeditor.com/4.22.1/full-all/ckeditor.js"></script>
</head>
<body>
    <div class="containers">
        <h2>공지사항 작성</h2>
        <!-- 서버 측 메시지 표시 -->
        <c:if test="${not empty successMessage}">
            <div class="success-message">${successMessage}</div>
        </c:if>
        <c:if test="${not empty errorMessage}">
            <div class="error-message">${errorMessage}</div>
        </c:if>
        <form class="form-horizontal" name="wfrm" method="post" action="./qna_write_ok.do">
            <div class="form-group">
                <input type="text" class="form-control" name="qnaTitle" style="height: 50px" placeholder="제목을 입력해 주세요."/>
            </div>
            <div class="form-group">
                <textarea class="form-control" id="qnaContent" name="qnaContent" placeholder="내용을 입력해 주세요."></textarea>
            </div>
            <div class="btn_wrap">
                <button type="submit" id="wbtn" class="btn btn-primary">저장하기</button>
            </div>
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
        // 폼 제출 시에 제목과 내용이 입력되었는지 확인
        document.getElementById('wbtn').onclick = function() {
            var title = document.wfrm.qnaTitle.value.trim();
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
</body>
</html>