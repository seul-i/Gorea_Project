<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<c:set var="language" value="${language}" />
<c:set var="userSeq" value="${SPRING_SECURITY_CONTEXT.authentication.principal.gorea_UserTO.userSeq}"/>
<html>
<head>
    <title>Go!rea</title>
    <link rel="stylesheet" type="text/css" href="/css/userRecommend/write.css">
    <script src="https://cdn.ckeditor.com/4.22.1/full-all/ckeditor.js"></script>
</head>
<body>
	<jsp:include page="/WEB-INF/views/includes/header${language}.jsp"></jsp:include>
    <div class="containers">
    	<c:choose>
    		<c:when test="${language eq 'korean' }">
		        <h2>게시글 작성</h2>
		        <form class="form-horizontal" name="wfrm" method="post" action="/${language}/userRecom_write_ok.do">
		        	<input type="hidden" name="userSeq" value="${userSeq}"/>
		            <div class="form-group">
		                <input type="text" class="form-control" id="title" name="title" style="height: 50px" placeholder="제목을 입력해 주세요."/>
		            </div>
		            <div class="form-group">
		                <textarea class="form-control" id="content" name="content" placeholder="내용을 입력해 주세요."></textarea>
		            </div>
		
		            <div class="btn_wrap">
		                <button type="submit" id="wbtn" class="btn btn-primary">저장하기</button>
		                <input type="button" value="목록" class="btn btn-primary" style="cursor: pointer;" onclick="location.href='userRecom.do'" />
		            </div>
		        </form>
        	</c:when>
        	<c:when test="${language eq 'english' }">
		        <h2>Write a post</h2>
		        <form class="form-horizontal" name="wfrm" method="post" action="/${language}/userRecom_write_ok.do">
		        	<input type="hidden" name="userSeq" value="${userSeq}"/>
		            <div class="form-group">
		                <input type="text" class="form-control" id="title" name="title" style="height: 50px" placeholder="Please write title"/>
		            </div>
		            <div class="form-group">
		                <textarea class="form-control" id="content" name="content" placeholder="Please write content"></textarea>
		            </div>
		
		            <div class="btn_wrap">
		                <button type="submit" id="wbtn" class="btn btn-primary">Save</button>
		                <input type="button" value="List" class="btn btn-primary" style="cursor: pointer;" onclick="location.href='userRecom.do'" />
		            </div>
		        </form>
        	</c:when>
        	<c:when test="${language eq 'japanese' }">
		        <h2>投稿を書く</h2>
		        <form class="form-horizontal" name="wfrm" method="post" action="/${language}/userRecom_write_ok.do">
		        	<input type="hidden" name="userSeq" value="${userSeq}"/>
		            <div class="form-group">
		                <input type="text" class="form-control" id="title" name="title" style="height: 50px" placeholder="タイトルを入力してください."/>
		            </div>
		            <div class="form-group">
		                <textarea class="form-control" id="content" name="content" placeholder="コンテンツを入力してください."></textarea>
		            </div>
		
		            <div class="btn_wrap">
		                <button type="submit" id="wbtn" class="btn btn-primary">保存</button>
		                <input type="button" value="リスト" class="btn btn-primary" style="cursor: pointer;" onclick="location.href='userRecom.do'" />
		            </div>
		        </form>
        	</c:when>
        	<c:when test="${language eq 'chinese' }">
		        <h2>写一篇文章</h2>
		        <form class="form-horizontal" name="wfrm" method="post" action="/${language}/userRecom_write_ok.do">
		        	<input type="hidden" name="userSeq" value="${userSeq}"/>
		            <div class="form-group">
		                <input type="text" class="form-control" id="title" name="title" style="height: 50px" placeholder="请输入主题."/>
		            </div>
		            <div class="form-group">
		                <textarea class="form-control" id="content" name="content" placeholder="请输入您的详细信息."></textarea>
		            </div>
		
		            <div class="btn_wrap">
		                <button type="submit" id="wbtn" class="btn btn-primary">节省</button>
		                <input type="button" value="列表" class="btn btn-primary" style="cursor: pointer;" onclick="location.href='userRecom.do'" />
		            </div>
		        </form>
        	</c:when>
        </c:choose>
    </div>

    <script type="text/javascript">
        window.onload = function() {
            CKEDITOR.replace('content', {
                filebrowserUploadUrl: '/UserRecom/imageUpload',
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
    <!-- <script type="text/javascript">
        // 폼 제출 시에 제목과 내용이 입력되었는지 확인
        document.getElementById('wbtn').onclick = function() {
            var title = document.wfrm.title.value.trim();
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
    </script> -->
    <script type="text/javascript">
    // 폼 제출 시에 제목과 내용이 입력되었는지 확인
    document.getElementById('wbtn').onclick = function() {
        var title = document.wfrm.title.value.trim();
        var content = CKEDITOR.instances.content.getData().trim();
        
        if (title === "") {
            showAlert(getLanguageAlert('title'));
            return false;
        }
        if (content === "") {
            showAlert(getLanguageAlert('content'));
            return false;
        }
    };

    // 언어에 따른 alert 메시지 반환 함수
    function getLanguageAlert(type) {
        var language = "${language}"; // JSP의 변수를 가져와 사용
        switch (language) {
            case 'korean':
                return (type === 'title') ? '제목을 입력하셔야 합니다.' : '내용을 입력하셔야 합니다.';
            case 'english':
                return (type === 'title') ? 'Please enter the title.' : 'Please enter the content.';
            case 'japanese':
                return (type === 'title') ? 'タイトルを入力してください.' : 'コンテンツを入力してください.';
            case 'chinese':
                return (type === 'title') ? '请输入主题.' : '请输入您的详细信息.';
            default:
                return 'Default alert message';
        }
    }

    // alert 메시지 보여주는 함수
    function showAlert(message) {
        alert(message);
    }
    </script>
    <jsp:include page="/WEB-INF/views/includes/footer.jsp"></jsp:include>
</body>
</html>