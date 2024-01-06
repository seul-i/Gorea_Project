<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page import="com.gorea.dto_board.Gorea_TrendSeoul_BoardTO" %>
<%@ page import="java.util.ArrayList" %>
<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>

<c:set var="boardList" value="${requestScope.boardList}" />
<c:set var="totalRecord" value="${fn:length(boardList)}" />

<fmt:formatNumber var="totalRecord" value="${totalRecord}" />

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
            $('.album').on('click', function() {
                var seoulSeq = $(this).data('seq');
                window.location.href = '/korean/trend_view.do?seoulSeq=' + seoulSeq;
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
            <c:forEach var="to" items="${boardList}">
			    <div class='album' data-seq='${to.seoulSeq}'>
			        <div class='image'>
			            <img src='../../upload/${to.firstImageUrl}' alt=''>
			        </div>
			        <div class='content'>
			            <div class='content-top'>
			                <h3 class='title'>${to.seoulTitle}</h3>
			                <div class='icons' id='likeButton'>
			                    <i class='fa fa-star-o fa-2x' style='color: #94b8f4;'></i>
			                    <i class='fa fa-star fa-2x' style='color: #94b8f4;'></i>
			                </div>
			            </div>
			            <div class='explain'>${to.seoulsubTitle}</div>
			        </div>
			    </div>
			</c:forEach>
        </div>
    </section>
    <div class="writeBtn">
   		<a href="./trend_write.do">글쓰기<i class="fa fa-pen"></i></a>
    </div>
    
    

</div>
<jsp:include page="/WEB-INF/views/korean/includes/footer.jsp"></jsp:include>
</body>
</html>
