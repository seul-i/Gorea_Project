<%@page import="com.gorea.dto_board.Gorea_TrendSeoul_BoardTO"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<%
request.setCharacterEncoding("utf-8");
	
	Gorea_TrendSeoul_BoardTO to = (Gorea_TrendSeoul_BoardTO)request.getAttribute("to");
	
	String go_seoul_seq = request.getParameter("go_seoul_seq");
	
	String subject = to.getGo_seoul_subject();
	String subtitle = to.getGo_seoul_subtitle();
	String content = to.getGo_seoul_content();
	String location = to.getGo_seoul_loc();
	String tel = to.getTel();
	String address = to.getAddress();
	String facilities = to.getFacilities();
	String traffic_info = to.getTraffic_info();
%>
<html>
<head>
    <title>게시글 수정</title>
    <link rel="stylesheet" type="text/css" href="/css/trendseoul/write.css">
    <script src="https://cdn.ckeditor.com/4.22.1/full-all/ckeditor.js"></script>
	<script type="text/javascript">
	window.onload = function() {
		document.getElementById( "mbtn" ).onclick = function() {
			if( document.mfrm.subject.value.trim() == "" ) {
				alert( "제목을 입력하셔야 합니다." );
				return false;
			}
			if( document.mfrm.content.value.trim() == "" ) {
				alert( "내용을 입력하셔야 합니다." );
				return false;
			}
			document.mfrm.submit();
		};
	};
</script>
</head>
<body>
	<jsp:include page="/WEB-INF/views/korean/includes/header.jsp"></jsp:include>
    <div class="container">
        <h2>게시글 수정</h2>
        <form action="./trend_modify_ok.do" method="post" name="mfrm" enctype="multipart/form-data" class="form-horizontal">
        <input type="hidden" name="go_seoul_seq" value="<%=go_seoul_seq %>"/>
            <div class="form-group">
                <input type="text" class="form-control" name="go_seoul_subject" value="<%=subject %>" style="height: 50px" placeholder="제목을 입력해 주세요."/>
                <input type="text" class="form-control" name="go_seoul_subtitle" value="<%=subtitle %>" placeholder="부제목을 입력해 주세요."/>
            </div>
            
             <div class="form-group">
			    <label for="location">지역 선택</label>
			    <select class="form-control" name="go_seoul_loc" value="<%=location %>" id="location">
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
                <textarea class="form-control" id="content" name="go_seoul_content" placeholder="내용을 입력해 주세요."><%=content %></textarea>
            </div>
            
            
             <div class="form-group">
                <div class="phone">
            		<span class="label">전화번호</span>
            		<span class="mark">:</span>
            		 <input type="text" class="form-control" name="tel" value="<%=tel %>" placeholder="전화번호를 입력해 주세요."/>
            	</div>
            	<div class="address">
            		<span class="label">주소</span>
            		<span class="mark">:</span>
            		 <input type="text" class="form-control" name="address" value="<%=address %>" placeholder="주소를 입력해 주세요."/>
            	</div>
            	<div class="amenity">
            		<span class="label">편의시설</span>
            		<span class="mark">:</span>
            		 <input type="text" class="form-control" name="facilities" value="<%=facilities %>" placeholder="편의시설을 입력해 주세요."/>
            	</div>
            	<div class="transportation">
            		<span class="label">교통정보</span>
            		<span class="mark">:</span>
            		 <input type="text" class="form-control" name="traffic_info" value="<%=traffic_info %>" placeholder="교통시설 입력해 주세요."/>
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