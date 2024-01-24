<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page import="com.gorea.dto_board.Gorea_Notice_BoardTO" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>GO!REA ADMIN</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <link rel="stylesheet" type="text/css" href="/css/admin/admin.css">
    <link rel="stylesheet" type="text/css" href="/css/freeboard/modify.css">
    <script src="https://cdn.ckeditor.com/4.22.1/full-all/ckeditor.js"></script>
</head>
<body>
    <aside>
		<button class="close-sidebar-btn" onclick="toggleSidebar()">X</button>
		<div class="logo">GO!REA</div>
		<ul>
			<li class="tooltip"><a href="#"><i
					class="fas fa-tachometer-alt"></i> <span class="menu-item-text">대시보드</span></a>
			</li>
			<li class="tooltip"><a href="#"><i class="fas fa-home"></i>
					<span class="menu-item-text">메인 관리</span></a></li>
			<li class="tooltip"><a href="javascript:void(0);"
				onclick="toggleSubmenu('data-management-submenu')"
				data-target="data-management-submenu"> <i
					class="fas fa-database"></i> <span class="menu-item-text">데이터
						관리</span><span class="submenu-indicator">∨</span>
			</a>
				<ul id="data-management-submenu" class="submenu">
					<li><a href="#">Best5</a></li>
					<li><a href="#">장소추천</a></li>
					<li><a href="/admin/adminfreeboard.do">자유게시판</a></li>
					<li><a href="#">에디터 추천 장소</a></li>
					<li><a href="#">에디터 꿀팁</a></li>
					<li><a href="#">트렌드 서울</a></li>
					<li><a href="/admin/adminnotice.do">공지사항</a></li>
				</ul></li>
			<li class="tooltip"><a href="javascript:void(0);"
				onclick="toggleSubmenu('member-management-submenu')"
				data-target="member-management-submenu"> <i class="fas fa-users"></i>
					<span class="menu-item-text">회원 관리</span><span
					class="submenu-indicator">∨</span>
			</a>
				<ul id="member-management-submenu" class="submenu">
					<li><a href="#">회원 목록 확인</a></li>
					<li><a href="#">회원 비밀번호 변경</a></li>
					<li><a href="#">회원 탈퇴</a></li>
				</ul></li>
			<li class="tooltip"><a href="#"><i class="fas fa-envelope"></i>
					<span class="menu-item-text">문의 관리</span></a></li>
			<li class="tooltip"><a href="#"><i class="fas fa-chart-bar"></i>
					<span class="menu-item-text">통계 관리</span></a></li>
		</ul>
		<footer class="sidebar-footer">
			<a href="#"></a> <a href="#"></a>
		</footer>
	</aside>
    <main>
        <div class="logo-space">
            <span class="admin-title">관리자 페이지</span>
            <button class="logout-btn">Main</button>
        </div>
        <button class="toggle-sidebar-btn" onclick="toggleSidebar()">
            <i class="fas fa-bars"></i> 
        </button>

        <div class="containers">
            <div class="tith2">
                <h2>자유게시판 수정</h2>
            </div>
            <form action="/admin/adminfreeboard_modify_ok.do" method="post" name="mfrm" enctype="multipart/form-data" class="form-horizontal">
                <c:set var="to" value="${requestScope.to}" />
                <input type="hidden" name="freeSeq" value="${param.freeSeq}" /> 
                <input type="hidden" name="cpage" value="${cpage}" /> 
                <input type="hidden" name="searchType" value="${searchType}" /> 
                <input type="hidden" name="searchKeyword" value="${searchKeyword}" />
                <div class="form-group">
                    <input type="text" class="form-control" value="${to.freeTitle}" name="freeTitle" style="height: 50px" />
                </div>
                <div class="form-group">
                    <textarea class="form-control" id="freeContent" name="freeContent">${to.freeContent}</textarea>
                </div>
                <div class="btn_wrap">
                    <button type="submit" class="btn btn-primary" id="mbtn">저장하기</button>
                    <input type="button" value="취소" class="btn" style="cursor: pointer;" onclick="location.href='/admin/adminfreeboard_view.do?freeSeq=${param.freeSeq}'" />
                </div>
            </form>
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
            
            document.getElementById('mbtn').onclick = function() {
                var title = document.mfrm.freeTitle.value.trim();
                var content = CKEDITOR.instances.freeContent.getData().trim();
                
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
    </main>
    <script type="text/javascript" src="../../js/admin.js"></script>
</body>
</html>