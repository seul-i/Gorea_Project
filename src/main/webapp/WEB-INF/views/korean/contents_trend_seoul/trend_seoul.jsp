<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page import="com.gorea.dto_board.Gorea_TrendSeoul_BoardTO" %>
<%@ page import="java.util.ArrayList" %>
<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>

<c:set var="boardList" value="${requestScope.boardList}" />
<c:set var="totalRecord" value="${fn:length(boardList)}" />

<fmt:formatNumber var="totalRecord" value="${totalRecord}" />

<c:set var="sbHtml" value="" />

<c:forEach var="to" items="${boardList}">
    <c:set var="go_seoul_seq" value="${to.go_seoul_seq}" />
    <c:set var="go_seoul_subject" value="${to.go_seoul_subject}" />
    <c:set var="go_seoul_subtitle" value="${to.go_seoul_subtitle}" />
    <c:set var="filename" value="${to.filename}" />
    <c:set var="firstImageUrl" value="${to.firstImageUrl}" />
    <c:set var="go_seoul_loc" value="${to.go_seoul_loc}" />

   <c:set var="sbHtml" value="${sbHtml}<div class='album' data-go_seoul_seq='${go_seoul_seq}'>
     <div class='image'>
         <img src='../../upload/${firstImageUrl}' alt=''>
     </div>
     <div class='content'>
         <div class='content-top'>
             <h3 class='title'>${go_seoul_subject}</h3>
             <div class='icons' id='likeButton'>
                 <i class='fa fa-star-o fa-2x' style='color: #94b8f4;'></i>
                 <i class='fa fa-star fa-2x' style='color: #94b8f4;'></i>
             </div>
         </div>
         <div class='explain'>${go_seoul_subtitle}</div>
       </div>
    </div>" />
</c:forEach>



<!DOCTYPE html>
<html>
<head>
    <meta charset="EUC-KR">
    <title>Go!rea</title>
    <link rel="stylesheet" type="text/css" href="/css/trendseoul/list.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.css"/>
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    <script>
        $(document).ready(function () {
            // 앨범 클릭 이벤트 처리
            $('.album').on('click', function () {
                var go_seoul_seq = $(this).data('go_seoul_seq');
                window.location.href = './trend_view.do?go_seoul_seq=' + go_seoul_seq;
            });

        });
    </script>

</head>
<body>

<jsp:include page="/WEB-INF/views/korean/includes/header.jsp"></jsp:include>

<div class="main">
    <section class="banner">
        <article>
            <img src="/img/trendseoul/성수동.jpg" width="1440" height="961">
            <div class="banner-text">
                <h2 style="font-weight:bold;">트렌드 서울</h2>
            </div>
        </article>
    </section>

    <section class="albums">
        <div class="album-container">
            ${sbHtml}
        </div>
        <div class="writeBtn">
   		 	<a href="./trend_write.do">글쓰기<i class="fa fa-pen"></i></a>
        </div>
    </section>
</div>
<jsp:include page="/WEB-INF/views/korean/includes/footer.jsp"></jsp:include>
</body>
</html>
