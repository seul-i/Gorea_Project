<%@ page import="com.gorea.dto_board.Gorea_EditRecommend_BoardTO"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<!DOCTYPE html>
<c:set var="to" value="${requestScope.to}" />
<c:set var="seq" value="${param.editrecoSeq}" />
<c:set var="language" value="${language}" />
<html>
<head>
<title>GO!rea</title>
<link rel="stylesheet" type="text/css" href="/css/editor/write.css">
<script src="https://cdn.ckeditor.com/4.22.1/full-all/ckeditor.js"></script>
<script type="text/javascript">
	window.onload = function() {
		document.getElementById("mbtn").onclick = function() {
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
	<jsp:include page="/WEB-INF/views/includes/header${language}.jsp"></jsp:include>
	<div class="containers">
	<div class="tith2">
		<h2>에디터 추천 장소 수정</h2>
		</div>
		<form action="./editRecommend_modify_ok.do" method="post" name="mfrm"
			enctype="multipart/form-data" class="form-horizontal">
			<input type="hidden" name="editrecoSeq" value="${seq}" />
			<div class="form-group">
			<div class="stits">
                    <p>제목</p>
                </div>
				<input type="text" class="form-control"
					value="${to.editrecoSubject}" name="editrecoSubject"
					style="height: 40px" />
					 </div>
					 <div class="form-group">
			<div class="stits">
                    <p>부제목</p>
                </div>
					 <input type="text" class="form-control"
					value="${to.editrecoSubtitle}" name="editrecoSubtitle"
					style="height: 40px" />
					</div>
			<div class="form-group">
				<textarea class="form-control" id="content" name="editrecoContent">${to.editrecoContent}</textarea>
			</div>
	</div>
	<div class="btn_wrap">
				<button type="submit" class="btn btn-primary">저장하기</button>
			</div>
		</form>
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
	<jsp:include page="/WEB-INF/views/includes/footer.jsp"></jsp:include>
</body>
</html>
