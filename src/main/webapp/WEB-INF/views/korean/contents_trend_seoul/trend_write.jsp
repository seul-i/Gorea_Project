<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>게시글 작성</title>
    <link rel="stylesheet" type="text/css" href="/css/trendseoul/write.css">
    <script src="https://cdn.ckeditor.com/4.22.1/full-all/ckeditor.js"></script>
</head>
<body>

	<jsp:include page="/WEB-INF/views/korean/includes/header.jsp"></jsp:include>
    <div class="container">
        <h2>게시글 작성</h2>
        <form class="form-horizontal" method="post" action="./trend_write_ok.do">
            <div class="form-group">
                <input type="text" class="form-control" name="go_seoul_subject" style="height: 50px" placeholder="제목을 입력해 주세요."/>
                <input type="text" class="form-control" name="go_seoul_subtitle" placeholder="부제목을 입력해 주세요."/>
            </div>
            
             <div class="form-group">
			    <label for="location">지역 선택</label>
			    <select class="form-control" name="go_seoul_loc" id="location">
			    	<option value="강남">강남</option>
			        <option value="광화문">광화문</option>
			        <option value="동대문">동대문</option>
			        <option value="명동">명동</option>
			        <option value="성수">성수</option>
			        <option value="여의도">여의도</option>
		            <option value="이태원">이태원</option>
			        <option value="잠실">동대문</option>
			    	<option value="홍대">홍대</option>
			    	<option value="기타">기타</option>
			        <!-- Add more options as needed -->
			    </select>
			</div>
            <div class="form-group">
                <textarea class="form-control" id="content" name="go_seoul_content" placeholder="내용을 입력해 주세요."></textarea>
            </div>
            
            
             <div class="form-group">
                <div class="phone">
            		<span class="label">전화번호</span>
            		<span class="mark">:</span>
            		 <input type="text" class="form-control" name="tel" placeholder="전화번호를 입력해 주세요."/>
            	</div>
            	<div class="address">
            		<span class="label">주소</span>
            		<span class="mark">:</span>
            		 <input type="text" class="form-control" name="address" placeholder="주소를 입력해 주세요."/>
            	</div>
            	<div class="amenity">
            		<span class="label">편의시설</span>
            		<span class="mark">:</span>
            		 <input type="text" class="form-control" name="facilities" placeholder="편의시설을 입력해 주세요."/>
            	</div>
            	<div class="transportation">
            		<span class="label">교통정보</span>
            		<span class="mark">:</span>
            		 <input type="text" class="form-control" name="traffic_info" placeholder="교통시설 입력해 주세요."/>
            	</div>
            </div>

            <div class="btn_wrap">
                <button type="submit" class="btn btn-primary">저장하기</button>
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
</body>
</html>