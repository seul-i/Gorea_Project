<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<c:set var="language" value="${language}" />
<c:set var="userSeq" value="${SPRING_SECURITY_CONTEXT.authentication.principal.gorea_UserTO.userSeq}" />
<html>
<head>
    <title>GO!rea</title>
    <link rel="stylesheet" type="text/css" href="/css/qna/write.css">
    <script src="https://cdn.ckeditor.com/4.22.1/full-all/ckeditor.js"></script>
</head>
<body>
	<jsp:include page="/WEB-INF/views/includes/header${language}.jsp"></jsp:include>
    <div class="containers">
        <div class="tith2">
            <h2>QnA</h2> <!-- 제목을 중앙 정렬 -->
            <!-- 폼과 나머지 내용 -->
        </div>
        <!-- 서버 측 메시지 표시 -->
        <c:if test="${not empty successMessage}">
            <div class="success-message">${successMessage}</div>
        </c:if>
        
        <c:if test="${not empty errorMessage}">
            <div class="error-message">${errorMessage}</div>
        </c:if>
        
        <form class="form-horizontal" name="wfrm" method="post" action="./qna_write_ok.do">
        <input type="hidden" name="userSeq" value="${userSeq}">
        <div class="form-group">
                <div class="stits">
                    <p>문의유형</p>
                </div>
                <select class="form-control" name="qnaCategory" style="border: 1px solid #ccc" ;>
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
                <input type="text" class="form-control" name="qnaTitle" style="height: 40px" />
            </div>
            <div class="form-group">
                <textarea class="form-control" id="qnaContent" name="qnaContent" placeholder="내용을 입력해 주세요."></textarea>
            </div>
    </div>
    <div class="btn_wrap">
        <button type="submit" class="btn btn-primary">등록하기</button>
    </div>
</form>
    <script type="text/javascript">
        window.onload = function() {
            CKEDITOR.replace('qnaContent', {
                filebrowserUploadUrl: '/qna/imageUpload',
                height: 400,
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
    <jsp:include page="/WEB-INF/views/includes/footer.jsp"></jsp:include>
</body>
</html>