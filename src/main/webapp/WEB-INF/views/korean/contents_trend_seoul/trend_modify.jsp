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
            <input type="hidden" name="go_seoul_seq" value="${param.go_seoul_seq}" />

            <div class="form-group">
                <input type="text" class="form-control" name="go_seoul_subject" value="${to.go_seoul_subject}" style="height: 50px" placeholder="제목을 입력해 주세요." />
                <input type="text" class="form-control" name="go_seoul_subtitle" value="${to.go_seoul_subtitle}" placeholder="부제목을 입력해 주세요." />
            </div>

		<div class="form-group">
		    <label for="location">지역 선택</label>
		    <select class="form-control" name="go_seoul_loc" id="location">
		        <option value="강남" <c:if test="${'강남' eq to.go_seoul_loc}">selected</c:if>>강남</option>
		        <option value="광화문" <c:if test="${'광화문' eq to.go_seoul_loc}">selected</c:if>>광화문</option>
		        <option value="동대문" <c:if test="${'동대문' eq to.go_seoul_loc}">selected</c:if>>동대문</option>
		        <option value="명동" <c:if test="${'명동' eq to.go_seoul_loc}">selected</c:if>>명동</option>
		        <option value="성수" <c:if test="${'성수' eq to.go_seoul_loc}">selected</c:if>>성수</option>
		        <option value="여의도" <c:if test="${'여의도' eq to.go_seoul_loc}">selected</c:if>>여의도</option>
		        <option value="이태원" <c:if test="${'이태원' eq to.go_seoul_loc}">selected</c:if>>이태원</option>
		        <option value="잠실" <c:if test="${'잠실' eq to.go_seoul_loc}">selected</c:if>>잠실</option>
		        <option value="홍대" <c:if test="${'홍대' eq to.go_seoul_loc}">selected</c:if>>홍대</option>
		        <option value="기타" <c:if test="${'기타' eq to.go_seoul_loc}">selected</c:if>>기타</option>
		    </select>
		</div>


            <div class="form-group">
                <textarea class="form-control" id="content" name="go_seoul_content" placeholder="내용을 입력해 주세요.">${to.go_seoul_content}</textarea>
            </div>

            <div class="form-group">
                <div class="phone">
                    <span class="label">전화번호</span>
                    <span class="mark">:</span>
                    <input type="text" class="form-control" name="tel" value="${to.tel}" placeholder="전화번호를 입력해 주세요." />
                </div>
                <div class="address">
                    <span class="label">주소</span>
                    <span class="mark">:</span>
                    <input type="text" class="form-control" name="address" value="${to.address}" placeholder="주소를 입력해 주세요." />
                </div>
                <div class="amenity">
                    <span class="label">편의시설</span>
                    <span class="mark">:</span>
                    <input type="text" class="form-control" name="facilities" value="${to.facilities}" placeholder="편의시설을 입력해 주세요." />
                </div>
                <div class="transportation">
                    <span class="label">교통정보</span>
                    <span class="mark">:</span>
                    <input type="text" class="form-control" name="traffic_info" value="${to.traffic_info}" placeholder="교통시설 입력해 주세요." />
                </div>
            </div>

            <div class="btn_wrap">
                <button type="submit" class="btn btn-primary">저장하기</button>
            </div>
        </form>
    </div>

    <script type="text/javascript">
        window.onload = function() {
            CKEDITOR.replace('go_seoul_content', {
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
