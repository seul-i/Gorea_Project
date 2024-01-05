<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.gorea.dto_board.Gorea_EditRecommend_BoardTO"%>
<%@ page import="com.gorea.dto_board.Gorea_EditRecommendListTO"%>

<c:set var="paging" value="${requestScope.paging}" />
<c:set var="lists" value="${paging.lists}" />

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Go!rea</title>
    <link rel="stylesheet" type="text/css" href="/css/list/list.css">
    <link rel="stylesheet" type="text/css" href="/css/header/header.css">
    <link rel="stylesheet" type="text/css" href="/css/footer/footer.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.css" />
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;700&display=swap">
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    <script>
        $(document).ready(function() {
            // 앨범 클릭 이벤트 처리
            $('.album').on('click', function() {
                var seq = $(this).data('seq');
                window.location.href = '/korean/editRecommend_view.do?editrecoSeq=' + seq;
            });
        });

        document.addEventListener('DOMContentLoaded', function() {
            var album = document.querySelector('.album');
            album.parentNode.insertBefore(album, album.parentNode.firstChild);
        });

        // 이전 페이지로 이동하는 함수
        function goToPreviousPage() {
            var currentPage = ${paging.cpage};

            // 현재 페이지가 1페이지인 경우에는 동작하지 않도록 체크
            if (currentPage > 1) {
                // 이동할 URL 생성
                var url = "/korean/editRecommend_list.do?cpage=" + (currentPage - 1);

                // 실제로 페이지 이동
                window.location.href = url;
            }
        }
    </script>
</head>
<body>
    <jsp:include page="/WEB-INF/views/korean/includes/header.jsp"></jsp:include>

    <div class="banner" id="banner">
        <img src="/img/banner/editrecommendbanner.jpg" alt="banner">
        <div class="banner-text">
            <h1>에디터 추천 장소</h1>
        </div>
    </div>

    <div class="location">
        <i class="fa-solid fa-house"></i> <span class="ar">></span> 추천 <span class="ar">></span>
        <span> <a href="./editRecommend_list.do?cpage=${paging.cpage}">에디터 추천 장소</a> </span>
    </div>

    <section class="albums">
        <div class="album-container">
            <c:choose>
                <c:when test="${not empty lists}">
                    <c:forEach var="to" items="${lists}">
                        <div class='album' data-seq='${to.editrecoSeq}'>
                            <div class='image'>
                                <img src='../../upload/${to.firstImageUrl}' alt='' />
                                <div class='i'>
                                    <i class='fa fa-star-o fa-2x'></i> <i class='fa fa-star fa-2x'></i>
                                </div>
                            </div>
                            <div class='content'>
                                <div class='title-subtitle'>
                                    <div class='title'>${to.editrecoSubject}</div>
                                    <div class='subtitle'>${to.editrecoSubtitle}</div>
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

    <div class="pagination">
        <a href="/korean/editRecommend_list.do?cpage=1" class="icon prev" >&laquo;</a>
        <a href="/korean/editRecommend_list.do?cpage=${paging.lastPage - 1}" class="icon prev">&lt;</a>
        
        <c:forEach begin="${paging.firstPage}" end="${paging.lastPage}" var="i">
            <a href="/korean/editRecommend_list.do?cpage=${i}" >
                <c:if test="${i eq paging.cpage}" >${i}</c:if>
                <c:if test="${i ne paging.cpage}">${i}</c:if>
            </a>
        </c:forEach>
        
        <a href="/korean/editRecommend_list.do?cpage=${paging.cpage + 1}" class="icon next">&gt;</a>
        <a href="/korean/editRecommend_list.do?cpage=${paging.totalPage}" class="icon next">&raquo;</a>
    </div>
    
    <jsp:include page="/WEB-INF/views/korean/includes/footer.jsp"></jsp:include>
</body>
</html>
