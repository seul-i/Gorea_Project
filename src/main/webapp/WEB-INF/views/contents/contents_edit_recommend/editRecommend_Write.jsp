<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Date"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="userSeq" value="${SPRING_SECURITY_CONTEXT.authentication.principal.gorea_UserTO.userSeq}" />
<!DOCTYPE html>
<html>
<head>
<title>게시글 작성</title>
<link rel="stylesheet" type="text/css" href="/css/editor/write.css">
<script src="https://cdn.ckeditor.com/4.22.1/full-all/ckeditor.js"></script>
</head>
<body>
	<div class="container">
		<h2>게시글 작성</h2>
		<form class="form-horizontal" method="post"
			action="./editRecommend_write_ok.do" enctype="multipart/form-data">
			<input type="hidden" name="userSeq" value="${userSeq}">
			<div class="form-group">
				<input type="text" class="form-control" name="editrecoSubject"
					style="height: 50px" placeholder="제목을 입력해 주세요." /> <input
					type="text" class="form-control" name="editrecoSubtitle"
					style="height: 50px" placeholder="부제목을 입력해 주세요." />
			</div>
			<div class="form-group">
				<textarea class="form-control" id="content" name="editrecoContent"
					placeholder="내용을 입력해 주세요."></textarea>
			</div>


			<div class="btn_wrap">
				<button type="submit" class="btn btn-primary">저장하기</button>
			</div>
		</form>
	</div>

	<script type="text/javascript">
		window.onload = function() {
			CKEDITOR.replace('editrecoContent', {
				filebrowserUploadUrl : '/editRecommend/imageUpload',
				height : 500,
				toolbar : [
						{
							name : 'clipboard',
							items : [ 'Undo', 'Redo' ]
						},
						{
							name : 'styles',
							items : [ 'Font', 'FontSize' ]
						},
						{
							name : 'basicstyles',
							items : [ 'Bold', 'Italic', 'Underline', 'Strike',
									'RemoveFormat', 'CopyFormatting' ]
						},
						{
							name : 'colors',
							items : [ 'TextColor', 'BGColor' ]
						},
						{
							name : 'align',
							items : [ 'JustifyLeft', 'JustifyCenter',
									'JustifyRight' ]
						},
						{
							name : 'links',
							items : [ 'Link', 'Unlink' ]
						},
						{
							name : 'paragraph',
							items : [ 'NumberedList', 'BulletedList', '-',
									'Blockquote' ]
						}, {
							name : 'insert',
							items : [ 'Image' ]
						}, {
							name : 'tools',
							items : [ 'Maximize' ]
						}, {
							name : 'editing',
							items : [ 'Scayt' ]
						} ]
			});
		};
	</script>
</body>
</html>
