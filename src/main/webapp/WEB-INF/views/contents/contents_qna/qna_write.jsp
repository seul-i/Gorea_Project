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
	
	<div class="commonBanner" id="comBanner">
        <img src="/img/banner/QnaBanner.jpg" alt="banner">
        <div class="commonBanner-text">
            <h1>QnA</h1>
        </div>
    </div>
    
    <div class="containers">
        <div class="tith2">
            <h1>QnA</h1>
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
	        <c:choose>
				<c:when test="${language eq 'korean'}">
				
					<div>
			        	<div class="form-group">
			                <div class="stits">
			                    <p>문의유형</p>
			                </div>
			                <select class="form-control" name="qnaCategory">
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
			                <input type="text" class="form-control" name="qnaTitle"/>
			            </div>
			            <div class="form-group">
			                <textarea class="form-control" id="qnaContent" name="qnaContent" placeholder="내용을 입력해 주세요."></textarea>
			            </div>
					</div>
				
					<div class="btn_wrap">
		        		<button type="submit" class="btn btn-primary" id="wbtn">등록하기</button>
		    		</div>
				
				</c:when>
				
				<c:when test="${language eq 'english'}">
				
					<div>
			        	<div class="form-group">
			                <div class="stits">
			                    <p>Inquiry type</p>
			                </div>
			                <select class="form-control" name="qnaCategory">
			                    <option value="컨텐츠">Content</option>
								<option value="회원">Member</option>
								<option value="사이트이용">Site Usage</option>
								<option value="게시판">Board</option>
								<option value="기타">Other</option>
			                </select>
			            </div>
			            <div class="form-group">
			                <div class="stits">
			                    <p>Title</p>
			                </div>
			                <input type="text" class="form-control" name="qnaTitle"/>
			            </div>
			            <div class="form-group">
			                <textarea class="form-control" id="qnaContent" name="qnaContent" placeholder="내용을 입력해 주세요."></textarea>
			            </div>
					</div>
				
					<div class="btn_wrap">
		        		<button type="submit" class="btn btn-primary" id="wbtn">write</button>
		    		</div>
				
				</c:when>
				
				<c:when test="${language eq 'japanese'}">
				
					<div>
			        	<div class="form-group">
			                <div class="stits" style="width:150px;">
			                    <p>お問い合わせ種類</p>
			                </div>
			                <select class="form-control" name="qnaCategory">
			                    <option value="컨텐츠">コンテンツ</option>
								<option value="회원">メンバー</option>
								<option value="사이트이용">サイト利用</option>
								<option value="게시판">フォーラム</option>
								<option value="기타">その他</option>
			                </select>
			            </div>
			            <div class="form-group">
			                <div class="stits">
			                    <p>タイトル</p>
			                </div>
			                <input type="text" class="form-control" name="qnaTitle"/>
			            </div>
			            <div class="form-group">
			                <textarea class="form-control" id="qnaContent" name="qnaContent" placeholder="내용을 입력해 주세요."></textarea>
			            </div>
					</div>
				
					<div class="btn_wrap">
		        		<button type="submit" class="btn btn-primary" id="wbtn">書く</button>
		    		</div>
				
				</c:when>
				
				<c:when test="${language eq 'chinese'}">
				
					<div>
			        	<div class="form-group">
			                <div class="stits">
			                    <p>询价类型</p>
			                </div>
			                <select class="form-control" name="qnaCategory">
			                    <option value="컨텐츠">内容</option>
								<option value="회원">会员</option>
								<option value="사이트이용">网站使用</option>
								<option value="게시판">论坛</option>
								<option value="기타">其他</option>
			                </select>
			            </div>
			            <div class="form-group">
			                <div class="stits">
			                    <p>标题</p>
			                </div>
			                <input type="text" class="form-control" name="qnaTitle"/>
			            </div>
			            <div class="form-group">
			                <textarea class="form-control" id="qnaContent" name="qnaContent" placeholder="내용을 입력해 주세요."></textarea>
			            </div>
					</div>
				
					<div class="btn_wrap">
		        		<button type="submit" class="btn btn-primary" id="wbtn">写</button>
		    		</div>
				
				</c:when>
			</c:choose>
		</form>
    </div>


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