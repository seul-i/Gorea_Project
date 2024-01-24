<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page import="com.gorea.dto_board.Gorea_TrendSeoul_ListTO" %>
<%@ page import="com.gorea.dto_board.Gorea_PagingTO"%>

<c:set var="language" value="${language}" />
<c:set var="paging" value="${paging}" />
<c:set var="boardList" value="${paging.boardList}" />

<c:set var="role"
   value="${SPRING_SECURITY_CONTEXT.authentication.principal.gorea_UserTO.userRole}" />

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Go!rea TrendSoeul</title>
    <link rel="stylesheet" type="text/css" href="/css/trendseoul/list.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.css"/>
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    <script type="text/javascript">
    
    let language = '${language}';
    	
    // 이전 페이지로 이동하는 함수
    function goToPreviousPage() {
        var currentPage = ${paging.cpage};

        // 현재 페이지가 1페이지인 경우에는 동작하지 않도록 체크
        if (currentPage > 1) {
            // 이동할 URL 생성
            var url = "/${language}/trend_seoul.do?cpage=" + (currentPage - 1);

            // 실제로 페이지 이동
            window.location.href = url;
        }
    }
    
    $(document).ready(function () {
		$('.album').on('click', function() {
			
      			if (!("${not empty SPRING_SECURITY_CONTEXT}" == "true")) {
      				
            		if(language === 'korean'){
            			
        	        	alert("로그인이 필요합니다. 로그인 페이지로 이동합니다.");
            			
            		}else if(language === 'english'){
            			
        	        	alert("Login is required. Go to the login page.");
            			
            		}else if(language === 'japanese'){
            			
        	        	alert("ログインが必要です。ログインページに移動します。");

            		}else if(language === 'chinese'){
            			
        	        	alert("需要登录。进入登录页面。");

            		}
            		
            		window.location.href = "/${language}/login.do";
    	        		 
    	   		}else{
            		
				var seoulSeq = $(this).data('seq');
				window.location.href = '/${language}/trend_view.do?seoulSeq=' + seoulSeq;
                
				}
		});
    });
    </script>

</head>
<body>

<jsp:include page="/WEB-INF/views/includes/header${language}.jsp"></jsp:include>

    <div class="commonBanner" id="comBanner">
        <img src="/img/banner/trendSeoulbanner.jpg" alt="banner" style="object-position: center;">
        
        <div class="commonBanner-text">
            <h1>
            <c:choose>
                <c:when test="${language eq 'korean'}">트렌드 서울</c:when>
                <c:when test="${language eq 'english'}">Trend seoul</c:when>
                <c:when test="${language eq 'japanese'}">トレンドソウル</c:when>
                <c:when test="${language eq 'chinese'}">潮流首尔</c:when>
            </c:choose>
            </h1>
        </div>
	</div>

	<div class="location">
		<i class="fa-solid fa-house"></i> <span class="ar">></span>
		<c:choose>
			<c:when test="${language eq 'korean'}">
         
	            명소 <span class="ar">></span>
				<span> <a href="./editRecommend_list.do">트렌드 서울</a>
				</span>

			</c:when>
			<c:when test="${language eq 'english'}">
         
	            sights <span class="ar">></span>
				<span> <a href="./editRecommend_list.do">Trend seoul</a>
				</span>

			</c:when>
			<c:when test="${language eq 'japanese'}">
         
	            観光 <span class="ar">></span>
				<span> <a href="./editRecommend_list.do">トレンドソウル</a>
				</span>

			</c:when>
			<c:when test="${language eq 'chinese'}">
         
            
	            景点 <span class="ar">></span>
				<span> <a href="./editRecommend_list.do">潮流首尔</a>
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
             <input type="submit" value="검색">
         </c:when>
         <c:when test="${language eq 'english'}">
               <input type="submit" value="search">
         </c:when>
         <c:when test="${language eq 'japanese'}">
               <input type="submit" value="検索">
         </c:when>
         <c:when test="${language eq 'chinese'}">
             <input type="submit" value="搜索">
         </c:when>
      </c:choose>
    
      </form>
   </div>

	<section class="albums">
		<div class="album-container">
			<c:forEach var="to" items="${boardList}">
				<div class='album' data-seq='${to.seoulSeq}'>
					<div class='image'>
						<img src='${to.firstImageUrl}' alt=''>
					</div>
					<div class='content'>
						<div class='content-sub'>
							<c:choose>
								<c:when test="${fn:length(to.seoulLocGu) > 10}">
										    <p>[
										        <script>
										            var seoulLocgu = "${to.seoulLocGu}";
										            if (seoulLocgu.length > 10) {
										            	seoulLocgu = seoulLocgu.substring(0, 10) + "...";
										            }
										            document.write(seoulLocgu);
										        </script>
										        ]
										        ${to.mainCategory}/${to.subCategory}
										    </p>
								</c:when>
								
								<c:otherwise>
										<p>[${to.seoulLocGu}] ${to.mainCategory}/${to.subCategory}</p>
								</c:otherwise>
							</c:choose>

							<span></span>
						</div>

						<div class="starpoint">
							<div class="starpoint_box">
								<c:forEach var="i" begin="1" end="10">
									<label for="starpoint_${to.seoulSeq}_${i}" class="label_star"
										title="${i/2}"> <span class="blind">${i/2}점</span>
									</label>
									<input type="radio" name="starpoint_${to.seoulSeq}"
										id="starpoint_${to.seoulSeq}_${i}" class="star_radio"
										<c:if test="${i/2 == to.seoulScore}">checked</c:if>>
								</c:forEach>

								<span class="starpoint_bg"></span>

							</div>
						</div>

						<div class='content-main'>
							<!-- 출력 제목 글자가 10자 이상이면 h5 테그 -->
							<c:choose>
								
								<c:when test="${fn:length(to.seoulTitle) > 10}">
								    <h5>
								        <script>
								            var seoulTitle = "${to.seoulTitle}";
								            if (seoulTitle.length > 10) {
								                seoulTitle = seoulTitle.substring(0, 15) + "...";
								            }
								            document.write(seoulTitle);
								        </script>
								    </h5>
								</c:when>
								
								<c:otherwise>
									<h4>${to.seoulTitle}</h4>
								</c:otherwise>
							</c:choose>

							<div class='icons' id='likeButton'>
								<i class='fa fa-star-o fa-2x'
									style='color: grey; font-size: 1.5em;'></i> <i
									class='fa fa-star fa-2x'
									style='color: #94b8f4; font-size: 1.5em;'></i>
							</div>
						</div>
					</div>
				</div>
			</c:forEach>
		</div>
	</section>

	<c:choose>
		<c:when test="${role eq 'ROLE_ADMIN'}">
			<div class="write_button_container">
				<a href="/korean/trend_write.do" class="write_button">글쓰기</a>
			</div>
		</c:when>
	</c:choose>
	
	<div class="pagination-container">
		<div class="pagination">
			<!-- 처음 페이지 버튼 -->
			<c:choose>
				<c:when test="${paging.cpage == 1}">
					<span class="pagination-item disabled">&lt;&lt;</span>
				</c:when>
				<c:otherwise>
					<a href="/${language}/trend_seoul.do?cpage=1"
						class="pagination-item">&lt;&lt;</a>
				</c:otherwise>
			</c:choose>
	
			<!-- 이전 페이지 버튼 -->
			<c:choose>
				<c:when test="${paging.cpage == 1}">
					<span class="pagination-item disabled">&lt;</span>
				</c:when>
				<c:otherwise>
					<a href="/${language}/trend_seoul.do?cpage=${paging.cpage - 1}"
						class="pagination-item">&lt;</a>
				</c:otherwise>
			</c:choose>
	
			<!-- 페이지 번호 -->
			<c:choose>
				<c:when test="${paging.totalPage <= 5}">
					<!-- 페이지 개수가 5 이하인 경우 -->
					<c:forEach var="i" begin="${1}" end="${paging.totalPage}"
						varStatus="loop">
						<c:choose>
							<c:when test="${i == paging.cpage}">
								<span class="pagination-item active">${i}</span>
							</c:when>
							<c:otherwise>
								<a href="/${language}/trend_seoul.do?cpage=${i}"
									class="pagination-item">${i}</a>
							</c:otherwise>
						</c:choose>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<!-- 페이지 개수가 5 초과인 경우 -->
					<c:forEach var="i" begin="${paging.firstPage}"
						end="${paging.lastPage}" varStatus="loop">
						<c:choose>
							<c:when test="${i == paging.cpage}">
								<span class="pagination-item active">${i}</span>
							</c:when>
							<c:otherwise>
								<a href="/${language}/trend_seoul.do?cpage=${i}"
									class="pagination-item">${i}</a>
							</c:otherwise>
						</c:choose>
					</c:forEach>
				</c:otherwise>
			</c:choose>
	
			<!-- 다음 페이지 버튼 -->
			<c:choose>
				<c:when test="${paging.cpage == paging.totalPage}">
					<span class="pagination-item disabled">&gt;</span>
				</c:when>
				<c:otherwise>
					<a href="/${language}/trend_seoul.do?cpage=${paging.cpage + 1}"
						class="pagination-item">&gt;</a>
				</c:otherwise>
			</c:choose>
	
			<!-- 마지막 페이지 버튼 -->
			<c:choose>
				<c:when test="/${paging.cpage == paging.totalPage}">
					<span class="pagination-item disabled">&gt;&gt;</span>
				</c:when>
				<c:otherwise>
					<a href="/${language}/trend_seoul.do?cpage=${paging.totalPage}"
						class="pagination-item">&gt;&gt;</a>
				</c:otherwise>
			</c:choose>
		</div>
	</div>
	<jsp:include page="/WEB-INF/views/includes/footer.jsp"></jsp:include>

</body>
</html>
