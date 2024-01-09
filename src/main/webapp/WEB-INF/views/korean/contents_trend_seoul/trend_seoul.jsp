<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page import="com.gorea.dto_board.Gorea_TrendSeoul_BoardTO" %>
<%@ page import="com.gorea.dto_board.Gorea_TrendSeoul_ListTO"%>
<%@ page import="java.util.ArrayList" %>

<%-- <c:set var="paging" value="${requestScope.paging}" /> --%>
<c:set var="boardList" value="${requestScope.boardList}" />
<c:set var="totalRecord" value="${fn:length(boardList)}" />

<%-- <fmt:formatNumber var="totalRecord" value="${totalRecord}" /> --%>

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
//             	if (!("${not empty SPRING_SECURITY_CONTEXT}" == "true")) {
//             		alert("로그인이 필요합니다. 로그인 페이지로 이동합니다.");
//             		 window.location.href = "/korean/login.do";
            		 
            	//}else{
            		
                var seoulSeq = $(this).data('seq');
                console.log(${to.seoulScore});
                window.location.href = '/korean/trend_view.do?seoulSeq=' + seoulSeq;
                
            	//}
            });
        });
    </script>

</head>
<body>

<jsp:include page="/WEB-INF/views/korean/includes/header.jsp"></jsp:include>

<div class="main">
    <section class="trendseoulBanner">
        <article>
            <img src="/img/trendseoul/성수동.jpg" width="1440" height="961">
        </article>
    </section>
    
     <section class="albums">
        <div class="album-container">
            <c:forEach var="to" items="${boardList}">
			    <div class='album' data-seq='${to.seoulSeq}'>
				        <div class='image'>
				            <img src='${to.firstImageUrl}' alt=''>
				        </div>
			        <div class='content'>
			        	<div class='content-sub'>
			        		<p>[${to.seoulLocGu}] ${to.mainCategory}/${to.subCategory}</p>
			        		
							<span></span>
			        	</div>
			        	
			        	<div class="starpoint">
						  <div class="starpoint_box">					    
						    <c:forEach var="i" begin="1" end="10">
							  <label for="starpoint_${to.seoulSeq}_${i}" class="label_star" title="${i/2}">
							    <span class="blind">${i/2}점</span>
							  </label>
							  <input type="radio" name="starpoint_${to.seoulSeq}" id="starpoint_${to.seoulSeq}_${i}" class="star_radio" <c:if test="${i/2 == to.seoulScore}">checked</c:if>>
							</c:forEach>
							
						    <span class="starpoint_bg"></span>
						    
						  </div>
						  
						  <div>
						  	<span>Koreans' Choice</span>
						  </div>
						</div>

			            <div class='content-main'>
			            	<!-- 출력 제목 글자가 10자 이상이면 h5 테그 -->
			                <c:choose>
							  <c:when test="${fn:length(to.seoulTitle) > 10}">
							    <h5>${to.seoulTitle}</h5>
							  </c:when>
							  <c:otherwise>
							    <h4>${to.seoulTitle}</h4>
							  </c:otherwise>
							</c:choose>
							
			                <div class='icons' id='likeButton'>
			                    <i class='fa fa-star-o fa-2x' style='color: #94b8f4; font-size: 1.5em;'></i>
			                    <i class='fa fa-star fa-2x' style='color: #94b8f4; font-size: 1.5em;'></i>
			                </div>
			            </div>
			        </div>
			    </div>
			</c:forEach>
        </div>
    </section>
    
<!--     <div class="writeBtn"> -->
<!--    		<a href="./trend_write.do">글쓰기<i class="fa fa-pen"></i></a> -->
<!--     </div> -->
</div>

	<jsp:include page="/WEB-INF/views/korean/includes/footer.jsp"></jsp:include>

</body>
</html>
