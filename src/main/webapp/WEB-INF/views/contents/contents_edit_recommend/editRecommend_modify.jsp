<%@ page import="com.gorea.dto_board.Gorea_EditRecommend_BoardTO"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<c:set var="to" value="${requestScope.to}" />
<c:set var="seq" value="${param.editrecoSeq}" />
<html>
<head>
    <title>게시글 수정</title>
    <link rel="stylesheet" type="text/css" href="/css/editor/write.css">
    <script src="https://cdn.ckeditor.com/4.22.1/full-all/ckeditor.js"></script>
    <script type="text/javascript">
        window.onload = function () {
            document.getElementById("mbtn").onclick = function () {
                if (document.mfrm.subject.value.trim() == "") {
                    alert("제목을 입력하셔야 합니다.");
                    return false;
                }
                if (document.mfrm.content.value.trim() == "") {
                    alert("내용을 입력하셔야 합니다.");
                    return false;
                }
                document.mfrm.submit();
            };
        };
    </script>
</head>
<body>
<div class="container">
    <h2>게시글 수정</h2>
    <form action="./editRecommend_modify_ok.do" method="post" name="mfrm" enctype="multipart/form-data"
          class="form-horizontal">
        <input type="hidden" name="editrecoSeq" value="${seq}"/>
        <div class="form-group">
            <input type="text" class="form-control" value="${to.editrecoSubject}" name="editrecoSubject"
                   style="height: 50px"/>
            <input type="text" class="form-control" value="${to.editrecoSubtitle}" name="editrecoSubtitle"
                   style="height: 50px"/>
        </div>
        <div class="form-group">
            <textarea class="form-control" id="content" name="editrecoContent">${to.editrecoContent}</textarea>
        </div>

        <div class="btn_wrap">
            <button type="submit" class="btn btn-primary">저장하기</button>
        </div>
    </form>
</div>
<script type="text/javascript">
    window.onload = function () {
        CKEDITOR.replace('editrecoContent', {
            filebrowserUploadUrl: '/editRecommend/imageUpload',
            height: 500,
            toolbar: [
                {name: 'clipboard', items: ['Undo', 'Redo']},
                {name: 'styles', items: ['Font', 'FontSize']},
                {name: 'basicstyles', items: ['Bold', 'Italic', 'Underline', 'Strike', 'RemoveFormat', 'CopyFormatting']},
                {name: 'colors', items: ['TextColor', 'BGColor']},
                {name: 'align', items: ['JustifyLeft', 'JustifyCenter', 'JustifyRight']},
                {name: 'links', items: ['Link', 'Unlink']},
                {name: 'paragraph', items: ['NumberedList', 'BulletedList', '-', 'Blockquote']},
                {name: 'insert', items: ['Image']},
                {name: 'tools', items: ['Maximize']},
                {name: 'editing', items: ['Scayt']}
            ]
        });
    };
</script>
</body>
</html>
