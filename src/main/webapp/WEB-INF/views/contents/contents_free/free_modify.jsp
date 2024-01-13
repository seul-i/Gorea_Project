<%@page import="com.gorea.dto_board.Gorea_Notice_BoardTO"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page session="false"%>
<!DOCTYPE html>
<c:set var="language" value="${language}" />
<html>
<head>
<title>GO!rea</title>
<link rel="stylesheet" type="text/css" href="/css/freeboard/modify.css">
<script src="https://cdn.ckeditor.com/4.22.1/full-all/ckeditor.js"></script>
</head>
<body>
	<div class="containers">
		<h2>게시글 수정</h2>
		<form action="./freeboard_modify_ok.do" method="post" name="mfrm"
			enctype="multipart/form-data" class="form-horizontal">
			<c:set var="to" value="${requestScope.to}" />
			<input type="hidden" name="freeSeq" value="${param.freeSeq}" /> 
			<input type="hidden" name="cpage" value="${cpage}" /> 
			<input type="hidden" name="searchType" value="${searchType}" /> 
			<input type="hidden"name="searchKeyword" value="${searchKeyword}" />
			<div class="form-group">
				<input type="text" class="form-control" value="${to.freeTitle}"
					name="freeTitle" style="height: 50px" />
			</div>
			<div class="form-group">
				<textarea class="form-control" id="freeContent" name="freeContent">${to.freeContent}</textarea>
			</div>

			<div class="btn_wrap">
				<button type="submit" class="btn btn-primary" id="mbtn">저장하기</button>
			</div>
		</form>
	</div>
	<script type="text/javascript">
        window.onload = function() {
            CKEDITOR.replace('freeContent', {
                filebrowserUploadUrl: '/free/imageUpload',
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
            var title = document.mfrm.freeTitle.value.trim();
            var content = CKEDITOR.instances.freeContent.getData().trim();
            
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