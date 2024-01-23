<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<c:set var="language" value="${language}" />
<c:set var="paging" value="${paging}" />
<c:set var="lists1" value="${paging.lists1}" />

<!-- Login 시에 Security context 에서 가져오는 유저 정보-->
<c:set var="role"
   value="${SPRING_SECURITY_CONTEXT.authentication.principal.gorea_UserTO.userRole}" />
<c:set var="nickname"
   value="${SPRING_SECURITY_CONTEXT.authentication.principal.gorea_UserTO.userNickname}" />
   
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Go!rea</title>
    <link rel="stylesheet" type="text/css" href="/css/editor/list1.css">
    
    <link rel="stylesheet" type="text/css" href="/css/header/header.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.css"/>
    <script src="https://kit.fontawesome.com/42d55d598f.js" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;700&display=swap">
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    <script>
    $(document).ready(function () {
        // 앨범 클릭 이벤트 처리
        $('.album').on('click', function () {
            var seq = $(this).data('seq');
            window.location.href = '/korean/editTip_view.do?edittipSeq=' + seq;
        });

        // 마우스 올려놓았을 때 포인터 모양으로 변경
        $('.album').hover(
            function () {
                $(this).css('cursor', 'pointer');
            },
            function () {
                $(this).css('cursor', 'auto');
            }
        );
    });

    document.addEventListener('DOMContentLoaded', function () {
        var album = document.querySelector('.album');
        if (album) {
            album.parentNode.insertBefore(album, album.parentNode.firstChild);
        }
    });

        // 이전 페이지로 이동하는 함수
        function goToPreviousPage() {
            var currentPage = ${paging.cpage};

            // 현재 페이지가 1페이지인 경우에는 동작하지 않도록 체크
            if (currentPage > 1) {
                // 이동할 URL 생성
                var url = "/korean/editTip_list.do?cpage=" + (currentPage - 1);

                // 실제로 페이지 이동
                window.location.href = url;
            }
        }
    </script>
</head>
<body>
   <jsp:include page="/WEB-INF/views/includes/header${language}.jsp"></jsp:include>
    <div class="banner" id="banner">
        <img src="/img/banner/edittipbanner.jpg" alt="banner">
        <div class="banner-text">
            <h1>에디터 꿀팁</h1>
        </div>
    </div>
    
    <div class="search_container">
           <form action="editTip_list.do" method="get">
    <select name="searchType">
        <option value="title">
                <c:choose>
                    <c:when test="${language eq 'korean'}">제목</c:when>
                    <c:when test="${language eq 'english'}">Title</c:when>
                    <c:when test="${language eq 'japanese'}">タイトル</c:when>
                    <c:when test="${language eq 'chinese'}">标题</c:when>
                    <c:otherwise>제목</c:otherwise>
                </c:choose>
            </option>
            <option value="titleContent">
                <c:choose>
                    <c:when test="${language eq 'korean'}">제목 + 내용</c:when>
                    <c:when test="${language eq 'english'}">Title + Content</c:when>
                    <c:when test="${language eq 'japanese'}">タイトル + 内容</c:when>
                    <c:when test="${language eq 'chinese'}">标题 + 内容</c:when>
                    <c:otherwise>제목 + 내용</c:otherwise>
                </c:choose>
            </option>
    </select>
    <input type="text" name="searchKeyword" placeholder="검색어 입력">
    <input type="submit" value="검색">
   </form>
        </div>

    <!-- product section -->
    <section class="albums">
      <div class="album-container">
         <c:choose>
            <c:when test="${not empty lists1}">
               <c:forEach var="eto" items="${lists1}">
                  <div class='album' data-seq='${eto.edittipSeq}'>
                     <div class='image'>
                        <img src='../../upload/${eto.firstImageUrl}' alt='' />
                        <!--  
                        <div class='i'>
                           <i class='fa fa-star-o fa-2x'></i> <i class='fa fa-star fa-2x'></i>
                        </div>
                        -->
                     </div>
                     <div class='content'>
                        <div class='title-subtitle'>
                           <div class='title'>${eto.edittipSubject}</div>
                           <div class='subtitle'>${eto.edittipSubtitle}</div>
                        </div>
                     </div>
                  </div>
               </c:forEach>
            </c:when>
            <c:otherwise>
               <div>No data available</div>
            </c:otherwise>
         </c:choose>
      </div>
   </section>
   
   <c:choose>
      <c:when test="${role eq 'ROLE_ADMIN'}">
         <div class="write_button_container">
          <a href="editTip_write.do" class="write_button">글쓰기</a>
          </div>
       </c:when>
    </c:choose>
    
    <div class="pagination-container">
   <div class="pagination">
        <!-- 처음 페이지 버튼 -->
        <c:if test="${paging.cpage > 1}">
            <a href="/${language}/editTip_list.do?cpage=1<c:if test="${not empty param.searchType and not empty param.searchKeyword}">&searchType=${param.searchType}&searchKeyword=${param.searchKeyword}</c:if>" class="pagination-item">&lt;&lt;</a>
            <a href="/${language}/editTip_list.do?cpage=${paging.cpage - 1}<c:if test="${not empty param.searchType and not empty param.searchKeyword}">&searchType=${param.searchType}&searchKeyword=${param.searchKeyword}</c:if>" class="pagination-item">&lt;</a>
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
                    <a href="/${language}/editTip_list.do?cpage=${i}<c:if test="${not empty param.searchType and not empty param.searchKeyword}">&searchType=${param.searchType}&searchKeyword=${param.searchKeyword}</c:if>" class="pagination-item">${i}</a>
                </c:otherwise>
            </c:choose>
        </c:forEach>

        <!-- 다음 페이지 버튼 -->
        <c:if test="${paging.cpage < paging.totalPage}">
            <a href="/${language}/editTip_list.do?cpage=${paging.cpage + 1}<c:if test="${not empty param.searchType and not empty param.searchKeyword}">&searchType=${param.searchType}&searchKeyword=${param.searchKeyword}</c:if>" class="pagination-item">&gt;</a>
            <a href="/${language}/editTip_list.do?cpage=${paging.totalPage}<c:if test="${not empty param.searchType and not empty param.searchKeyword}">&searchType=${param.searchType}&searchKeyword=${param.searchKeyword}</c:if>" class="pagination-item">&gt;&gt;</a>
        </c:if>
        <c:if test="${paging.cpage == paging.totalPage}">
            <span class="pagination-item disabled">&gt;</span>
            <span class="pagination-item disabled">&gt;&gt;</span>
        </c:if>
    </div>
   </div>
   
   <jsp:include page="/WEB-INF/views/includes/footer.jsp"></jsp:include>
</body>
</html>