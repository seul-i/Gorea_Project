<%@page import="com.gorea.dto_board.Gorea_Notice_BoardTO"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page session="false"%>
<!DOCTYPE html>
<c:set var="language" value="${language}" />
<html>
<head>
<title>GO!rea</title>
<link rel="stylesheet" type="text/css" href="/css/notice/modify.css">
<script src="https://cdn.ckeditor.com/4.22.1/full-all/ckeditor.js"></script>
</head>
<body>
	<jsp:include page="/WEB-INF/views/includes/header${language}.jsp"></jsp:include>
	<div class="location">
      <i class="fa-solid fa-house"></i>
      <span class="ar">></span>
      <c:choose>
         <c:when test="${language eq 'korean'}">
         
            여행자 지원 <span class="ar">></span> 
             <span> 
                <a href="./notice.do">공지사항</a>
             </span>
          
         </c:when>
         <c:when test="${language eq 'english'}">
         
            recommend <span class="ar">></span> 
             <span> 
                <a href="./notice.do">notice</a>
             </span>
         
         </c:when>
         <c:when test="${language eq 'japanese'}">
         
            おすすめ <span class="ar">></span> 
             <span> 
                <a href="./notice.do">エディターおすすめの場所</a>
             </span>
         
         </c:when>
         <c:when test="${language eq 'chinese'}">
         
            
            建议 <span class="ar">></span> 
             <span> 
                <a href="./notice.do">编辑推荐的地方</a>
             </span>
         
         </c:when>
         <c:otherwise>제목</c:otherwise>
      </c:choose>
   </div>
	<div class="containers">
		<div class="tith2">
            <h2>공지사항 수정</h2> <!-- 제목을 중앙 정렬 -->
            <!-- 폼과 나머지 내용 -->
        </div>
		<form action="./notice_modify_ok.do" method="post" name="mfrm"
			enctype="multipart/form-data" class="form-horizontal">
			<c:set var="to" value="${requestScope.to}" />
			<input type="hidden" name="noticeSeq" value="${param.noticeSeq}" /> 
			<input type="hidden" name="cpage" value="${cpage}" /> 
			<input type="hidden" name="searchType" value="${searchType}" /> 
			<input type="hidden"name="searchKeyword" value="${searchKeyword}" />
			<div class="form-group">
			<div class="stits">
                    <p>제목</p>
                </div>
				<input type="text" class="form-control" value="${to.noticeTitle}"
					name="noticeTitle" style="height: 50px" />
			</div>
			<div class="form-group">
				<textarea class="form-control" id="noticeContent" name="noticeContent">${to.noticeContent}</textarea>
			</div>

			<div class="btn_wrap">
				<button type="submit" class="btn btn-primary" id="mbtn">저장하기</button>
			</div>
		</form>
	</div>
	<script type="text/javascript">
        window.onload = function() {
            CKEDITOR.replace('noticeContent', {
                filebrowserUploadUrl: '/notice/imageUpload',
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
            var title = document.mfrm.noticeTitle.value.trim();
            var content = CKEDITOR.instances.noticeContent.getData().trim();
            
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