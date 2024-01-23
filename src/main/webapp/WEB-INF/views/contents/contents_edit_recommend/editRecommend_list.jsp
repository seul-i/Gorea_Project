<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.gorea.dto_board.Gorea_EditRecommend_BoardTO"%>
<%@ page import="com.gorea.dto_board.Gorea_PagingTO" %>

<c:set var="language" value="${language}" />
<c:set var="paging" value="${paging}" />
<c:set var="lists" value="${paging.lists}" />

<!-- Login 시에 Security context 에서 가져오는 유저 정보-->
<c:set var="role"
   value="${SPRING_SECURITY_CONTEXT.authentication.principal.gorea_UserTO.userRole}" />
<c:set var="nickname"
   value="${SPRING_SECURITY_CONTEXT.authentication.principal.gorea_UserTO.userNickname}" />
 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Go!rea EditRecommend</title>
<link rel="stylesheet"
   href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.css" />
<link rel="stylesheet"
   href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;700&display=swap">
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>

<link rel="stylesheet" type="text/css" href="/css/editor/list.css">

<script>
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

        $(document).ready(function () {
            // 앨범 클릭 이벤트 처리
            $('.album').on('click', function () {
                var seq = $(this).data('seq');
                window.location.href = '/korean/editRecommend_view.do?editrecoSeq=' + seq;
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
    </script>

</head>
<body>

<jsp:include page="/WEB-INF/views/includes/header${language}.jsp"></jsp:include>

   <div class="commonBanner" id="comBanner">
        <img src="/img/banner/editrecommendbanner.jpg" alt="banner" style="object-position: center;">
        <div class="commonBanner-text">
            <h1>
            <c:choose>
                <c:when test="${language eq 'korean'}">에디터 추천 장소</c:when>
                <c:when test="${language eq 'english'}">Editor's Recommended Places</c:when>
                <c:when test="${language eq 'japanese'}">エディターおすすめの場所</c:when>
                <c:when test="${language eq 'chinese'}">编辑推荐的地方</c:when>
            </c:choose>
            </h1>
        </div>
    </div>
   
   <div class="location">
      <i class="fa-solid fa-house"></i>
      <span class="ar">></span>
      <c:choose>
         <c:when test="${language eq 'korean'}">
         
            추천 <span class="ar">></span> 
             <span> 
                <a href="./editRecommend_list.do">에디터 추천 장소</a>
             </span>
          
         </c:when>
         <c:when test="${language eq 'english'}">
         
            recommend <span class="ar">></span> 
             <span> 
                <a href="./editRecommend_list.do">Editor's Recommended Places</a>
             </span>
         
         </c:when>
         <c:when test="${language eq 'japanese'}">
         
            おすすめ <span class="ar">></span> 
             <span> 
                <a href="./editRecommend_list.do">エディターおすすめの場所</a>
             </span>
         
         </c:when>
         <c:when test="${language eq 'chinese'}">
         
            
            建议 <span class="ar">></span> 
             <span> 
                <a href="./editRecommend_list.do">编辑推荐的地方</a>
             </span>
         
         </c:when>
         <c:otherwise>제목</c:otherwise>
      </c:choose>
   </div>
   
   <div class="search_container">
      <form action="editRecommend_list.do" method="get">
      
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
       
       <c:choose>
         <c:when test="${language eq 'korean'}">
            <input type="text" name="searchKeyword" placeholder="검색어 입력">
             <input type="submit" value="검색">
         </c:when>
         <c:when test="${language eq 'english'}">
            <input type="text" name="searchKeyword" placeholder="Enter search">
               <input type="submit" value="search">
         </c:when>
         <c:when test="${language eq 'japanese'}">
            <input type="text" name="searchKeyword" placeholder="検索を入力し">
               <input type="submit" value="検索">
         </c:when>
         <c:when test="${language eq 'chinese'}">
            <input type="text" name="searchKeyword" placeholder="输入搜索">
             <input type="submit" value="搜索">
         </c:when>
      </c:choose>
    
      </form>
   </div>

   <section class="albums">
       <div class="album-container">
           <c:choose>
               <c:when test="${not empty lists}">
                   <c:forEach var="to" items="${lists}">
                       <div class='album' data-seq='${to.editrecoSeq}'>
                           <div class='image'>
                               <img src='../../upload/${to.firstImageUrl}' alt='' />
                           </div>
                           <div class='content'>
                               <div class='title-subtitle'>
                                   <div class='title'>
                                       <a href='./editRecommend_view.do?editrecoSeq=${to.editrecoSeq}<c:if test="${not empty param.cpage}">&cpage=${param.cpage}</c:if><c:if test="${not empty param.searchType}">&searchType=${param.searchType}</c:if><c:if test="${not empty param.searchKeyword}">&searchKeyword=${param.searchKeyword}</c:if>'>
                                           ${to.editrecoSubject}
                                       </a>
                                   </div>
                                   <div class='subtitle'>${to.editrecoSubtitle}</div>
                               </div>
                           </div>
                       </div>
                   </c:forEach>
               </c:when>
           </c:choose>
      </div>
   </section>

        <c:choose>
            <c:when test="${role eq 'ROLE_ADMIN'}">
                <div class="write_button_container">
                    <a href="editRecommend_write.do" class="write_button">글쓰기</a>
                </div>
            </c:when>
        </c:choose>

   
   

   <div class="pagination-container">
   <div class="pagination">
        <!-- 처음 페이지 버튼 -->
        <c:if test="${paging.cpage > 1}">
            <a href="/${language}/editRecommend_list.do?cpage=1<c:if test="${not empty param.searchType and not empty param.searchKeyword}">&searchType=${param.searchType}&searchKeyword=${param.searchKeyword}</c:if>" class="pagination-item">&lt;&lt;</a>
            <a href="/${language}/editRecommend_list.do?cpage=${paging.cpage - 1}<c:if test="${not empty param.searchType and not empty param.searchKeyword}">&searchType=${param.searchType}&searchKeyword=${param.searchKeyword}</c:if>" class="pagination-item">&lt;</a>
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
                    <a href="/${language}/editRecommend_list.do?cpage=${i}<c:if test="${not empty param.searchType and not empty param.searchKeyword}">&searchType=${param.searchType}&searchKeyword=${param.searchKeyword}</c:if>" class="pagination-item">${i}</a>
                </c:otherwise>
            </c:choose>
        </c:forEach>

        <!-- 다음 페이지 버튼 -->
        <c:if test="${paging.cpage < paging.totalPage}">
            <a href="/${language}/editRecommend_list.do?cpage=${paging.cpage + 1}<c:if test="${not empty param.searchType and not empty param.searchKeyword}">&searchType=${param.searchType}&searchKeyword=${param.searchKeyword}</c:if>" class="pagination-item">&gt;</a>
            <a href="/${language}/editRecommend_list.do?cpage=${paging.totalPage}<c:if test="${not empty param.searchType and not empty param.searchKeyword}">&searchType=${param.searchType}&searchKeyword=${param.searchKeyword}</c:if>" class="pagination-item">&gt;&gt;</a>
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