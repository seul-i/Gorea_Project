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
    <link rel="stylesheet" type="text/css" href="/css/notice/modify.css">
    <script src="https://cdn.ckeditor.com/4.22.1/full-all/ckeditor.js"></script>
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
                    <li><a href="adminuserRecom.do">장소추천</a></li>
                    <li><a href="adminfreeboard.do">자유게시판</a></li>
                    <li><a href="adminEditReco.do">에디터 추천 장소</a></li>
                    <li><a href="admineditTip.do">에디터 꿀팁</a></li>
                    <li><a href="adminTrendseoul.do">트렌드 서울</a></li>
                    <li><a href="adminnotice.do">공지사항</a></li>
                </ul>
            </li>
            <li class="tooltip">
                <a href="javascript:void(0);" onclick="toggleSubmenu('member-management-submenu')" data-target="member-management-submenu">
                    <i class="fas fa-users"></i> <span class="menu-item-text">회원 관리</span><span class="submenu-indicator">∨</span>
                </a>
                <ul id="member-management-submenu" class="submenu">
                    <li><a href="adminUserList.do">회원 목록 확인</a></li>
                    <!-- 
                    <li><a href="#">회원 비밀번호 변경</a></li>
                    <li><a href="#">회원 탈퇴</a></li>  -->
                </ul>
            </li>
            <li class="tooltip">
                <a href="adminqna.do"><i class="fas fa-envelope"></i> <span class="menu-item-text">문의 관리</span></a>
            </li>
            <li class="tooltip">
                <a href="#"><i class="fas fa-chart-bar"></i> <span class="menu-item-text">통계 관리</span></a>
            </li>
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
                <h2>트렌드 서울 수정</h2>
            </div>
            <form action="./adminTrend_modify_ok.do" method="post" name="mfrm" enctype="multipart/form-data" class="form-horizontal">
                <c:set var="to" value="${requestScope.to}" />
                <input type="hidden" name="seoulSeq" value="${param.seoulSeq}" /> 
                <input type="hidden" name="cpage" value="${cpage}" /> 
                <input type="hidden" name="searchType" value="${searchType}" /> 
                <input type="hidden" name="searchKeyword" value="${searchKeyword}" />
                <div class="form-group">
                    <div class="stits">
                        <p>제목</p>
                    </div>
                    <input type="text" class="form-control" value="${to.seoulTitle}" name="seoulTitle" style="height: 50px" />
                </div>
                <div class="form-group">
                    <div class="stits">
                        <p>부제목</p>
                    </div>
                    <input type="text" class="form-control" value="${to.seoulsubTitle}" name="seoulsubTitle" style="height: 50px" />
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
                    <textarea class="form-control" id="noticeContent" name="seoulContent">${to.seoulContent}</textarea>
                </div>
                 <div class="form-group">
                  	<div class="stits">
                        <p>주소</p>
                    </div>
                    <input type="text" class="form-control" value="${to.seoulLoc}" name="seoulLoc" style="height: 50px" />
                </div>
                
                 <div class="form-group">
	                <div class="stits">
                        <p>사이트</p>
                    </div>
                    <input type="text" class="form-control" value="${to.seoulSite}" name="seoulSite" style="height: 50px" />
                 </div>
                 
                 <div class="form-group">
                	<div class="stits">
                        <p>이용시간</p>
                    </div>
                    <input type="text" class="form-control" value="${to.seoulusageTime}" name="seoulusageTime" style="height: 50px" />
                 </div>
                 
                 <div class="form-group">
                	<div class="stits">
                        <p>이용요금</p>
                    </div>
                    <input type="text" class="form-control" value="${to.seoulusageFee}" name="seoulusageFee" style="height: 50px" />
                 </div>
                <div class="form-group">
                	<div class="stits">
                        <p>부제목</p>
                    </div>
                    <input type="text" class="form-control" value="${to.seoulTrafficinfo}" name="seoulTrafficinfo" style="height: 50px" />
                </div>
                <div class="form-group">
                	<div class="stits">
                        <p>꼭 알아야할 것!</p>
                    </div>
                    <input type="text" class="form-control" value="${to.seoulNotice}" name="seoulNotice" style="height: 50px" />
                </div>
                <div class="btn_wrap">
                    <button type="submit" class="btn btn-primary" id="mbtn">저장하기</button>
                </div>
            </form>
        </div>

        <script type="text/javascript">
            window.onload = function() {
                CKEDITOR.replace('seoulContent', {
                    filebrowserUploadUrl: '/imageUpload',
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
                var title = document.mfrm.seoulTitle.value.trim();
                var content = CKEDITOR.instances.seoulContent.getData().trim();
                
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
    <script type="text/javascript" src="/js/admin/admin.js"></script>
</body>
</html>