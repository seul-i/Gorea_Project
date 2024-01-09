<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<c:set var="to" value="${requestScope.to}" />

<html>
<head>
    <title>게시글 수정</title>
    <link rel="stylesheet" type="text/css" href="/css/trendseoul/write.css">
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
    <jsp:include page="/WEB-INF/views/korean/includes/header.jsp" />

    <div class="container">
        <h2>게시글 수정</h2>
        <form action="./trend_modify_ok.do" method="post" name="mfrm" enctype="multipart/form-data" class="form-horizontal">
            <input type="hidden" name="seoulSeq" value="${param.seoulSeq}" />

            <div class="form-group">
                <input type="text" class="form-control" name="seoulTitle" value="${to.seoulTitle}" style="height: 50px" placeholder="제목을 입력해 주세요." />
                <input type="text" class="form-control" name="seoulsubTitle" value="${to.seoulsubTitle}" placeholder="부제목을 입력해 주세요." />
            </div>

		<div class="form-group">
			    <label for="location">지역 선택</label>
			    <select class="form-control" name="seoulLocGu"  value="${to.seoulLocGu} id="location">
			    	<option value="강남구">강남구</option>
			        <option value="영등포구">영등포구</option>
			        <option value="마포구">마포구</option>
			        <option value="송파구">송파구</option>
			        <option value="중구">중구</option>
			        <option value="용산구">용산구</option>
		            <option value="종로구">종로구</option>
			    	<option value="기타">기타</option>
			    </select>
			    
			    <label for="location">카테고리 선택</label>
			    <select class="form-control" name="seoulcategoryNo" value="${to.seoulcategoryNo}" id="category">
			    	<option value="1">카페&디저트</option>
			        <option value="2">주점</option>
			        <option value="3">한식</option>
			        <option value="4">중식</option>
			        <option value="5">일식</option>
			        <option value="6">아시아식</option>
		            <option value="7">서양식</option>
			    	<option value="8">레스토랑</option>
				    <option value="9">백화점</option>
			        <option value="10">쇼핑몰</option>
			        <option value="11">면세점</option>
			        <option value="12">시장</option>
			        <option value="13">뷰티</option>
			        <option value="14">관광지</option>
		            <option value="15">도시공원</option>
			    	<option value="16">자연공원</option>
			    	<option value="17">전시시설</option>
			        <option value="18">공연시설</option>
			        <option value="19">역사</option>
		            <option value="20">성당&교회</option>
			    	<option value="21">절</option>
			    </select>
			</div>
            <div class="form-group">
                <textarea class="form-control" id="content" name="seoulContent" placeholder="내용을 입력해 주세요."> ${to.seoulContent} </textarea>
            </div>
            
             <div class="form-group">
                <div class="input-info">
            		<span class="label">주소</span>
            		<span class="mark">:</span>
            		 <input type="text" class="form-control" name="seoulLoc"  value="${to.seoulLoc}" placeholder="주소를 입력해 주세요."/>
            	</div>
            	<div class="input-info">
            		<span class="label">사이트</span>
            		<span class="mark">:</span>
            		 <input type="text" class="form-control" name="seoulSite"  value="${to.seoulSite}" placeholder="사이트를 입력해 주세요."/>
            	</div>
            	<div class="input-info">
            		<span class="label">이용시간</span>
            		<span class="mark">:</span>
            		 <input type="text" class="form-control" name="seoulusageTime"  value="${to.seoulusageTime}" placeholder="이용시간을 입력해 주세요."/>
            	</div>
            	<div class="input-info">
            		<span class="label">이용요금</span>
            		<span class="mark">:</span>
            		 <input type="text" class="form-control" name="seoulusageFee"  value="${to.seoulusageFee}" placeholder="이용요금을 입력해 주세요."/>
            	</div>
           	    <div class="input-info">
            		<span class="label">교통정보</span>
            		<span class="mark">:</span>
            		 <input type="text" class="form-control" name="seoulTrafficinfo"  value="${to.seoulTrafficinfo}" placeholder="교통정보를 입력해 주세요."/>
            	</div>
            	<div class="input-info">
            		<span class="label">꼭알아야할것</span>
            		<span class="mark">:</span>
            		 <input type="text" class="form-control" name="seoulNotice"  value="${to.seoulNotice}" placeholder="꼭 알아야할 것을 입력해 주세요."/>
            	</div>
            </div>

            <div class="btn_wrap">
                <button type="submit" class="btn btn-primary">저장하기</button>
            </div>
        </form>
    </div>

    <script type="text/javascript">
        window.onload = function() {
            CKEDITOR.replace('seoulContent', {
                filebrowserUploadUrl: 'imageUpload',
                height: 500,
                toolbar: [
                    { name: 'clipboard', items: ['Undo', 'Redo'] },
                    { name: 'styles', items: ['Font', 'FontSize'] },
                    { name: 'basicstyles', items: ['Bold', 'Italic', 'Underline', 'Strike', 'RemoveFormat', 'CopyFormatting'] },
                    { name: 'colors', items: ['TextColor', 'BGColor'] },
                    { name: 'align', items: ['JustifyLeft', 'JustifyCenter', 'JustifyRight'] },
                    { name: 'links', items: ['Link', 'Unlink'] },
                    { name: 'paragraph', items: ['NumberedList', 'BulletedList', '-', 'Blockquote'] },
                    { name: 'insert', items: ['Image'] },
                    { name: 'tools', items: ['Maximize'] },
                    { name: 'editing', items: ['Scayt'] }
                ]
            });
        };
    </script>
</body>
</html>
