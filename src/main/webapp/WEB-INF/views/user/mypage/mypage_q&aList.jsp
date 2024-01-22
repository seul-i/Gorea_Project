<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="paging" value="${paging}" />
<c:set var="userSeq" value="${SPRING_SECURITY_CONTEXT.authentication.principal.gorea_UserTO.userSeq}" />

<!DOCTYPE html>
<html>
<head>
    <meta charset="EUC-KR">
    <title>Go!rea</title>
    <link rel="stylesheet" type="text/css" href="/css/mypage/mypageHeader.css">
    <link rel="stylesheet" type="text/css" href="/css/mypage/qnaList.css">
        <script>
    	
    // 이전 페이지로 이동하는 함수
    function goToPreviousPage() {
        var currentPage = ${paging.cpage};

        // 현재 페이지가 1페이지인 경우에는 동작하지 않도록 체크
        if (currentPage > 1) {
            // 이동할 URL 생성
            var url = "/${language}/qnaList.do?cpage=" + (currentPage - 1);

            // 실제로 페이지 이동
            window.location.href = url;
        }
    }
    
    </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/includes/header${language}.jsp"></jsp:include>
   		<div class="commonBanner" id="comBanner">
      	  <img src="/img/banner/Top5Banner.jpg" alt="banner">
	        <div class="commonBanner-text">
	            <h1>마이페이지</h1>
	        </div>
	    </div>
 	   <div class="menuContainer">
       <div class="menuinner">
           <div class="mypage-menuBtn">
               <a href="mypage.do" class="mypagebtn active userInfo">회원정보</a>
               <a href="boardList.do?userSeq=${userSeq}" class="mypagebtn active boardList">게시글 관리</a>
               <a href="replyList.do?userSeq=${userSeq}" class="mypagebtn active replyList">댓글 관리</a>
               <a href="#" class="mypagebtn active likeList">즐겨찾기</a>
               <a href="qnaList.do?userSeq=${userSeq }" class="mypagebtn active qna">1:1 문의내역</a>
               <a href="userLeave.do?userSeq=${userSeq }" class="mypagebtn active bye">회원탈퇴</a>
           </div>
       </div>
   </div>
    <section class="mypage-section">
        <div class="mypage-container">
            <div class="menu-title">
                <b>1:1 문의 내역</b>
            </div>

		<div class="board-wrap">
		    <table class="board-list">
		        <thead>
		            <th class="col-num">답변 상태</th>
		            <th class="col-title">제목</th>
		            <th class="col-date">작성일</th>
		        </thead>
		
		        <c:choose>
		            <c:when test="${not empty lists}">
		                <c:forEach var="qna" items="${lists}">
		                    <tbody>
		                        <tr class="boardList">
		                            <td>답변 대기중</td>
		                            <td>
		                                <a href="/${language}/qna_view.do?qnaSeq=${qna.qnaSeq}">[${qna.qnaCategory}]${qna.qnaTitle}</a>
		                            </td>
		                            <td>${qna.qnapostDate }</td>
		                        </tr>
		                    </tbody>
		                </c:forEach>
		            </c:when>
		            <c:otherwise>
                            <tbody>
                                <tr>
                                    <td colspan="5">등록된 게시물이 없습니다.</td>
                                </tr>
                            </tbody>
                        </c:otherwise>
		        </c:choose>
		    </table>
		</div>

                  <div class="bottom-container">
				    <div class="pagination-container">
				        <div class="pagination">
				        <!-- 처음 페이지 버튼 -->
				        <c:if test="${paging.cpage > 1}">
				            <a href="/user/${language}/qnaList.do?userSeq=${userSeq }cpage=1" class="pagination-item">&lt;&lt;</a>
				            <a href="/user/${language}/qnaList.do?userSeq=${userSeq }&cpage=${paging.cpage - 1}" class="pagination-item">&lt;</a>
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
						            <a href="/user/${language}/qnaList.do?userSeq=${userSeq}&cpage=${i}" class="pagination-item">${i}</a>
						        </c:otherwise>
						    </c:choose>
						</c:forEach>
	
				
				        <!-- 다음 페이지 버튼 -->
				        <c:if test="${paging.cpage < paging.totalPage}">
				            <a href="/user/${language}/qnaList.do?userSeq=${userSeq}&cpage=${paging.cpage + 1}" class="pagination-item">&gt;</a>
				            <a href="/user/${language}/qnaList.do?userSeq=${userSeq}&cpage=${paging.totalPage}" class="pagination-item">&gt;&gt;</a>
				        </c:if>
				        <c:if test="${paging.cpage == paging.totalPage}">
				            <span class="pagination-item disabled">&gt;</span>
				            <span class="pagination-item disabled">&gt;&gt;</span>
				        </c:if>
				    </div>
				    </div>
				</div>
          	</div> 
		</div>
 	</section> 
 	
 	<jsp:include page="/WEB-INF/views/includes/footer.jsp"></jsp:include> 
</body>
</html>
