<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>GO!REA ADMIN</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <link rel="stylesheet" type="text/css" href="/css/admin/admin.css">
    <link rel="stylesheet" type="text/css" href="/css/notice/view.css">
</head>
<body>
    <aside>
        <button class="close-sidebar-btn" onclick="toggleSidebar()">X</button>
        <div class="logo">GO!REA</div>
        <ul>
            <li class="tooltip">
                <a href="#"><i class="fas fa-tachometer-alt"></i> <span class="menu-item-text">대시보드</span></a>
            </li>
            <li class="tooltip">
                <a href="#"><i class="fas fa-home"></i> <span class="menu-item-text">메인 관리</span></a>
            </li>
            <li class="tooltip">
                <a href="javascript:void(0);" onclick="toggleSubmenu('data-management-submenu')" data-target="data-management-submenu">
                    <i class="fas fa-database"></i> <span class="menu-item-text">데이터 관리</span><span class="submenu-indicator">∨</span>
                </a>
                <ul id="data-management-submenu" class="submenu">
                    <li><a href="#">Best5</a></li>
                    <li><a href="#">장소추천</a></li>
                    <li><a href="/admin/adminfreeboard.do">자유게시판</a></li>
                    <li><a href="#">에디터 추천 장소</a></li>
                    <li><a href="#">에디터 꿀팁</a></li>
                    <li><a href="#">트렌드 서울</a></li>
                    <li><a href="/admin/adminnotice.do">공지사항</a></li>
                </ul>
            </li>
            <li class="tooltip">
                <a href="javascript:void(0);" onclick="toggleSubmenu('member-management-submenu')" data-target="member-management-submenu">
                    <i class="fas fa-users"></i> <span class="menu-item-text">회원 관리</span><span class="submenu-indicator">∨</span>
                </a>
                <ul id="member-management-submenu" class="submenu">
                    <li><a href="#">회원 목록 확인</a></li>
                    <li><a href="#">회원 비밀번호 변경</a></li>
                    <li><a href="#">회원 탈퇴</a></li>
                </ul>
            </li>
            <li class="tooltip">
                <a href="#"><i class="fas fa-envelope"></i> <span class="menu-item-text">문의 관리</span></a>
            </li>
            <li class="tooltip">
                <a href="#"><i class="fas fa-chart-bar"></i> <span class="menu-item-text">통계 관리</span></a>
            </li>
        </ul>
        <footer class="sidebar-footer">
            <a href="#"></a>
            <a href="#"></a>
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
        
        <!-- 자유게시판 -->
        <c:set var="seq" value="${param.freeSeq}" />
        <c:set var="to" value="${requestScope.to}" />
        <c:set var="role" value="${SPRING_SECURITY_CONTEXT.authentication.principal.gorea_UserTO.userRole}" />

        <div class="containers">
            <div class="tith2">
                <h1>자유게시판</h1>
            </div>
            <div class="post-title"><c:out value="${to.freeTitle}" /></div>
            <div class="post-info">
                <div class="post-info-left">
                    <span class="post-info-item">작성자: <c:out value="${to.userNickname}" /></span>
                    <span class="post-info-item">작성일: <c:out value="${to.freepostDate}" /></span>
                    <span class="post-info-item">조회수: <c:out value="${to.freeHit}" /></span>
                </div>
            </div>
            <div class="post-content">
                <c:out value="${to.freeContent}" escapeXml="false" />
            </div>
			<c:url var="deleteUrl" value="/admin/adminfreeboard_delete_ok.do">
            <c:param name="freeSeq" value="${seq}" />
            <c:if test="${not empty param.cpage}"><c:param name="cpage" value="${param.cpage}" /></c:if>
            <c:if test="${not empty param.searchType}"><c:param name="searchType" value="${param.searchType}" /></c:if>
            <c:if test="${not empty param.searchKeyword}"><c:param name="searchKeyword" value="${param.searchKeyword}" /></c:if>
        </c:url>

        <c:url var="modifyUrl" value="/admin/adminfreeboard_modify.do">
            <c:param name="freeSeq" value="${seq}" />
            <c:if test="${not empty param.cpage}"><c:param name="cpage" value="${param.cpage}" /></c:if>
            <c:if test="${not empty param.searchType}"><c:param name="searchType" value="${param.searchType}" /></c:if>
            <c:if test="${not empty param.searchKeyword}"><c:param name="searchKeyword" value="${param.searchKeyword}" /></c:if>
        </c:url>

        <c:url var="listUrl" value="/admin/adminfreeboard.do">
            <c:if test="${not empty param.cpage}"><c:param name="cpage" value="${param.cpage}" /></c:if>
            <c:if test="${not empty param.searchType}"><c:param name="searchType" value="${param.searchType}" /></c:if>
            <c:if test="${not empty param.searchKeyword}"><c:param name="searchKeyword" value="${param.searchKeyword}" /></c:if>
        </c:url>
            <!-- 버튼 및 링크 -->
            <div class="post-actions">
                <div class="left-buttons">
        <c:if test="${not empty prevPost}">
            <input type="button" value="이전글" class="btn" onclick="location.href='adminfreeboard_view.do?freeSeq=${prevPost.freeSeq}&cpage=${param.cpage}&searchType=${param.searchType}&searchKeyword=${fn:escapeXml(param.searchKeyword)}'" />
        </c:if>
        <c:if test="${not empty nextPost}">
            <input type="button" value="다음글" class="btn" onclick="location.href='adminfreeboard_view.do?freeSeq=${nextPost.freeSeq}&cpage=${param.cpage}&searchType=${param.searchType}&searchKeyword=${fn:escapeXml(param.searchKeyword)}'" />
        </c:if>
    </div>
                <div class="right-buttons">
                            <input type="button" value="삭제" class="btn" onclick="confirmDelete('${deleteUrl}')" />
                            <input type="button" value="수정" class="btn" onclick="location.href='${modifyUrl}'" />
                    		<input type="button" value="목록" class="btn" onclick="location.href='${listUrl}'" />
                </div>
            </div>
        </div>

        <script>
            function confirmDelete(deleteUrl) {
                if (confirm("글을 삭제하시겠습니까?")) {
                    location.href = deleteUrl;
                }
            }
        </script>
    </main>
    <script type="text/javascript" src="../../js/admin.js"></script>
</body>
</html>
        