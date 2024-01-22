<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page session="false"%>
<!DOCTYPE html>
<c:set var="language" value="${language}" />
<c:set var="userSeq" value="${SPRING_SECURITY_CONTEXT.authentication.principal.gorea_UserTO.userSeq}" />
<html>
<head>
<title>GO!rea</title>
<link rel="stylesheet" type="text/css" href="/css/userRecommend/modify.css">
<script src="https://cdn.ckeditor.com/4.22.1/full-all/ckeditor.js"></script>
</head>
<body>
	<jsp:include page="/WEB-INF/views/includes/header${language}.jsp"></jsp:include>
    <div class="containers">
        <h2>게시글 수정</h2>
        <form action="/korean/userRecom_modify_ok.do" method="post" name="mfrm" enctype="multipart/form-data" class="form-horizontal">
	        <c:set var="to" value="${requestScope.to}" />
	        <input type="hidden" name="seq" value="${param.seq}" /> 
			<input type="hidden" name="cpage" value="${cpage}" /> 
			<input type="hidden" name="searchType" value="${searchType}" /> 
			<input type="hidden"name="searchKeyword" value="${searchKeyword}" />
			<input type="hidden" name="userSeq" value="${userSeq}"/>
	        <div class="form-group">
	            <input type="text" class="form-control" value="${to.userRecomTitle }" name="title" style="height: 50px" />
	        </div>
	        <div class="form-group">
	            <textarea class="form-control" id="content" name="content">${to.userRecomContent }</textarea>
	        </div>
	
	        <div class="btn_wrap">
	        	<button type="submit" class="btn btn-primary" id="mbtn">저장하기</button>
	           	<input type="button" value="목록" class="btn" style="cursor: pointer;" onclick="location.href='userRecom.do'" />
	           	<input type="button" value="취소" class="btn" style="cursor: pointer;" onclick="location.href='userRecom_view.do?seq=${param.seq}'" />
	        </div>
    	</form>
    </div>
    <script type="text/javascript">
        window.onload = function() {
            CKEDITOR.replace('content', {
                filebrowserUploadUrl: 'imageUpload',
                height: 500,
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
            var title = document.mfrm.title.value.trim();
            var content = CKEDITOR.instances.content.getData().trim();
            
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