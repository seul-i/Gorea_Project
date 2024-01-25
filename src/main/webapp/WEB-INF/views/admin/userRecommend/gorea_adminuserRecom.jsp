<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.gorea.dto_board.Gorea_Recommend_BoardTO"%>
<%@ page import="java.util.ArrayList"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GO!REA ADMIN</title>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
<link rel="stylesheet" type="text/css" href="/css/admin/admin.css">
<link rel="stylesheet" type="text/css" href="/css/notice/list.css">
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
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
					<li><a href="adminuserRecom.do">유저추천</a></li>
					<li><a href="adminfreeboard.do">자유게시판</a></li>
					<li><a href="adminEditReco.do">에디터 추천 장소</a></li>
					<li><a href="admineditTip.do">에디터 꿀팁</a></li>
					<li><a href="adminTrendseoul.do">트렌드 서울</a></li>
					<li><a href="adminnotice.do">공지사항</a></li>
				</ul></li>
			<li class="tooltip"><a href="javascript:void(0);"
				onclick="toggleSubmenu('member-management-submenu')"
				data-target="member-management-submenu"> <i class="fas fa-users"></i>
					<span class="menu-item-text">회원 관리</span><span
					class="submenu-indicator">∨</span>
			</a>
				<ul id="member-management-submenu" class="submenu">
					<li><a href="adminUserList.do">회원 목록 확인</a></li>
					<li><a href="#">회원 비밀번호 변경</a></li>
					<li><a href="#">회원 탈퇴</a></li>
				</ul></li>
			<li class="tooltip"><a href="adminqna.do"><i class="fas fa-envelope"></i>
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
		<c:set var="paging" value="${paging}" />
		<c:set var="userRecom" value="${paging.boardList1}" />
		<c:set var="role" value="${SPRING_SECURITY_CONTEXT.authentication.principal.gorea_UserTO.userRole}" />
		
		<div class="board_wrap">
			<div class="board_title">
				<strong>유저추천 관리</strong>
			</div>
			<div class="board_list">
				<div class="top">
					<div class="num">번호</div>
					<div class="title">제목</div>
					<div class="writer">글쓴이</div>
					<div class="date">작성일</div>
				</div>
				
				<c:if test="${empty lists}">
					<div style="text-align: center; padding: 20px; font-size: 18px;">등록된 게시글이 없습니다.</div>
				</c:if>
				<c:if test="${not empty lists }">
					<c:forEach items="${lists }" var="to">
						<div class="list-item">
							<div class='num'>${to.userRecomSeq }</div>
							<div class='title'>
								<a href='/admin/adminuserRecom_view.do?seq=${to.userRecomSeq }<c:if test="${not empty param.cpage}">&cpage=${param.cpage}</c:if><c:if test="${not empty param.searchType}">&searchType=${param.searchType}</c:if><c:if test="${not empty param.searchKeyword}">&searchKeyword=${param.searchKeyword}</c:if>'>
   									 ${to.userRecomTitle}
								</a>
							</div>
							<div class='writer'>${to.userNickname }</div>
							<div class='date'>${to.userRecompostDate }</div>
							<div class='count'>
								<a href='/admin/adminuserRecom_delete_ok.do?seq=${to.userRecomSeq }'
									onclick="return confirm( '정말 삭제하시겠습니까?' );">삭제</a>
							</div>
						</div>
					</c:forEach>
				</c:if>
			</div>
			<div class="bottom-container">
				<div class="pagination-container">
					<div class="pagination">
						<!-- 처음 페이지 버튼 -->
						<c:if test="${paging.cpage > 1}">
							<a 
								href="/admin/adminuserRecom.do?cpage=1<c:if test="${not empty param.searchType and not empty param.searchKeyword}">&searchType=${param.searchType}&searchKeyword=${param.searchKeyword}</c:if>"
								class="pagination-item">&lt;&lt;</a>
							<a
								href="/admin/adminuserRecom.do?cpage=${paging.cpage - 1}<c:if test="${not empty param.searchType and not empty param.searchKeyword}">&searchType=${param.searchType}&searchKeyword=${param.searchKeyword}</c:if>"
								class="pagination-item">&lt;</a>
						</c:if>
						<c:if test="${paging.cpage == 1}">
							<span class="pagination-item disabled">&lt;&lt;</span>
							<span class="pagination-item disabled">&lt;</span>
						</c:if>
	
						<!-- 페이지 번호 -->
						<c:forEach var="i" begin="${paging.firstPage}" end="${paging.lastPage}" varStatus="loop">
							<c:choose>
								<c:when test="${i == paging.cpage}">
									<span class="pagination-item active">${i}</span>
								</c:when>
								<c:otherwise>
									<a
										href="/admin/adminuserRecom.do?cpage=${i}<c:if test="${not empty param.searchType and not empty param.searchKeyword}">&searchType=${param.searchType}&searchKeyword=${param.searchKeyword}</c:if>"
										class="pagination-item">${i}</a>
								</c:otherwise>
							</c:choose>
						</c:forEach>
	
						<!-- 다음 페이지 버튼 -->
						<c:if test="${paging.cpage < paging.totalPage}">
							<a
								href="/admin/adminuserRecom.do?cpage=${paging.cpage + 1}<c:if test="${not empty param.searchType and not empty param.searchKeyword}">&searchType=${param.searchType}&searchKeyword=${param.searchKeyword}</c:if>"
								class="pagination-item">&gt;</a>
							<a
								href="/admin/adminuserRecom.do?cpage=${paging.totalPage}<c:if test="${not empty param.searchType and not empty param.searchKeyword}">&searchType=${param.searchType}&searchKeyword=${param.searchKeyword}</c:if>"
								class="pagination-item">&gt;&gt;</a>
						</c:if>
						<c:if test="${paging.cpage == paging.totalPage}">
							<span class="pagination-item disabled">&gt;</span>
							<span class="pagination-item disabled">&gt;&gt;</span>
						</c:if>
					</div>
				</div>
				<div class="search_container">
					<form action="/admin/adminuserRecom.do" method="get">
						<select name="searchType">
							<option value="title">제목</option>
							<option value="titleContent">제목 + 내용</option>
						</select> <input type="text" name="searchKeyword" placeholder="검색어 입력">
						<input type="submit" value="검색">
					</form>
				</div>	
			</div>
		</div>	
	</main>
	<script type="text/javascript" src="../../js/admin.js"></script>
</body>
</html>