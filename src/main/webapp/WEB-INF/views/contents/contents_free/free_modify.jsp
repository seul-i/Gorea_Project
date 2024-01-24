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
	<jsp:include page="/WEB-INF/views/includes/header${language}.jsp"></jsp:include>
	<div class="containers">
		<c:choose>
    		<c:when test="${language eq 'korean' }">
				<h2>게시글 수정</h2>
				<form action="./freeboard_modify_ok.do" method="post" name="mfrm" enctype="multipart/form-data" class="form-horizontal">
					<c:set var="to" value="${requestScope.to}" />
					<input type="hidden" name="freeSeq" value="${param.freeSeq}" /> 
					<input type="hidden" name="cpage" value="${cpage}" /> 
					<input type="hidden" name="searchType" value="${searchType}" /> 
					<input type="hidden"name="searchKeyword" value="${searchKeyword}" />
					<div class="form-group">
						<input type="text" class="form-control" value="${to.freeTitle}"	name="freeTitle" style="height: 50px" />
					</div>
					<div class="form-group">
						<textarea class="form-control" id="freeContent" name="freeContent">${to.freeContent}</textarea>
					</div>
		
					<div class="btn_wrap">
						<button type="submit" class="btn btn-primary" id="mbtn">저장하기</button>
						<input type="button" value="목록" class="btn" style="cursor: pointer;" onclick="location.href='freeboard.do'" />
					    <input type="button" value="취소" class="btn" style="cursor: pointer;" onclick="location.href='freeboard_view.do?freeSeq=${param.freeSeq}'" />
					</div>
				</form>
			</c:when>
			 <c:when test="${language eq 'english' }">
		        <h2>Edit post</h2>
		        <form action="/${language }/freeboard_modify_ok.do" method="post" name="mfrm" enctype="multipart/form-data" class="form-horizontal">
			        <c:set var="to" value="${requestScope.to}" />
			        <input type="hidden" name="freeSeq" value="${ param.freeSeq }" /> 
					<input type="hidden" name="cpage" value="${cpage}" /> 
					<input type="hidden" name="searchType" value="${searchType}" /> 
					<input type="hidden"name="searchKeyword" value="${searchKeyword}" />
					<input type="hidden" name="userSeq" value="${userSeq}"/>
			        <div class="form-group">
			            <input type="text" class="form-control" value="${to.freeTitle}" name="freeTitle" style="height: 50px" />
			        </div>
			        <div class="form-group">
			            <textarea class="form-control" id="freeContent" name="freeContent">${to.freeContent}</textarea>
			        </div>
			        <div class="btn_wrap">
			        	<button type="submit" class="btn btn-primary" id="mbtn">Save</button>
			           	<input type="button" value="List" class="btn" style="cursor: pointer;" onclick="location.href='freeboard.do'" />
			           	<input type="button" value="Cancel" class="btn" style="cursor: pointer;" onclick="location.href='freeboard_view.do?freeSeq=${param.freeSeq}'" />
			        </div>
		    	</form>
		    </c:when>
		    <c:when test="${language eq 'japanese' }">
		        <h2>投稿を編集</h2>
		        <form action="/${language }/freeboard_modify_ok.do" method="post" name="mfrm" enctype="multipart/form-data" class="form-horizontal">
			        <c:set var="to" value="${requestScope.to}" />
			        <input type="hidden" name="freeSeq" value="${ param.freeSeq }" /> 
					<input type="hidden" name="cpage" value="${cpage}" /> 
					<input type="hidden" name="searchType" value="${searchType}" /> 
					<input type="hidden"name="searchKeyword" value="${searchKeyword}" />
					<input type="hidden" name="userSeq" value="${userSeq}"/>
			        <div class="form-group">
			            <input type="text" class="form-control" value="${to.freeTitle}" name="freeTitle" style="height: 50px" />
			        </div>
			        <div class="form-group">
			            <textarea class="form-control" id="freeContent" name="freeContent">${to.freeContent}</textarea>
			        </div>
			
			        <div class="btn_wrap">
			        	<button type="submit" class="btn btn-primary" id="mbtn">保存</button>
			           	<input type="button" value="リスト" class="btn" style="cursor: pointer;" onclick="location.href='freeboard.do'" />
			           	<input type="button" value="キャンセル" class="btn" style="cursor: pointer;" onclick="location.href='freeboard_view.do?freeSeq=${param.freeSeq}'" />
			        </div>
		    	</form>
		    </c:when>
		    <c:when test="${language eq 'chinese' }">
		        <h2>编辑帖子</h2>
		        <form action="/${language }/freeboard_modify_ok.do" method="post" name="mfrm" enctype="multipart/form-data" class="form-horizontal">
			        <c:set var="to" value="${requestScope.to}" />
			        <input type="hidden" name="freeSeq" value="${ param.seq }" /> 
					<input type="hidden" name="cpage" value="${cpage}" /> 
					<input type="hidden" name="searchType" value="${searchType}" /> 
					<input type="hidden"name="searchKeyword" value="${searchKeyword}" />
					<input type="hidden" name="userSeq" value="${userSeq}"/>
			        <div class="form-group">
			            <input type="text" class="form-control" value="${to.freeTitle}" name="freeTitle" style="height: 50px" />
			        </div>
			        <div class="form-group">
			            <textarea class="form-control" id="freeContent" name="freeContent">${to.freeContent}</textarea>
			        </div>
			
			        <div class="btn_wrap">
			        	<button type="submit" class="btn btn-primary" id="mbtn">节省</button>
			           	<input type="button" value="列表" class="btn" style="cursor: pointer;" onclick="location.href='freeboard.do'" />
			           	<input type="button" value="消除" class="btn" style="cursor: pointer;" onclick="location.href='freeboard_view.do?freeSeq=${param.freeSeq}'" />
			        </div>
		    	</form>
		    </c:when>
		</c:choose>
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
     // 폼 제출 시에 제목과 내용이 입력되었는지 확인
	    document.getElementById('mbtn').onclick = function() {
	        var title = document.mfrm.freeTitle.value.trim();
	        var content = CKEDITOR.instances.freeContent.getData().trim();
	        
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