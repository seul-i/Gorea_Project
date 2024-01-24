<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="com.gorea.dto_board.Gorea_Recommend_BoardTO"%>
<%@ page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<c:set var="language" value="${language}" />
<c:set var="paging" value="${paging}" />
<c:set var="boardList1" value="${paging.boardList1}" />
<c:set var="lists" value="${requestScope.lists}" />
<c:set var="userSeq" value="${SPRING_SECURITY_CONTEXT.authentication.principal.gorea_UserTO.userSeq}" />

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Go!rea</title>
    <link rel="stylesheet" type="text/css" href="/css/userRecommend/list.css">
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    <script>
	    $(document).ready(function() {
	        $(".things").click(function() {
	            var seq = $(this).closest(".things").find(".thumb a").attr("href");
	            window.location.href = seq; // 클릭한 thumb의 링크로 이동
	        });
	    });
	    
	    // 이전 페이지로 이동하는 함수
	    function goToPreviousPage() {
	        var currentPage = ${paging.cpage};
	
	        // 현재 페이지가 1페이지인 경우에는 동작하지 않도록 체크
	        if (currentPage > 1) {
	            // 이동할 URL 생성
	            var url = "/${language}/userRecom.do?cpage=" + (currentPage - 1);
	
	            // 실제로 페이지 이동
	            window.location.href = url;
	        }
	    }
    </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/includes/header${language}.jsp"></jsp:include>
    <div class="board_wrap">
		<div class="board_title">
			<c:choose>
            	<c:when test="${language eq 'korean'}"><strong>여행자 추천</strong></c:when>
            	<c:when test="${language eq 'english'}"><strong>Visitor's Picks</strong></c:when>
            	<c:when test="${language eq 'japanese'}"><strong>旅行者のおすすめ</strong></c:when>
            	<c:when test="${language eq 'chinese'}"><strong>旅客推荐</strong></c:when>
            </c:choose>
		</div>
		<div class="board_list_wrap">
			<div class="boardList">
				
				<!-- list 부분 -->
				<c:if test="${empty lists }">
					<div style="text-align: center; padding: 20px; font-size: 18px;">
                        <c:choose>
                        	<c:when test="${language eq 'korean'}"> 등록된 게시글이 없습니다. </c:when>
                        	<c:when test="${language eq 'english'}"> There are no registered posts. </c:when>
                        	<c:when test="${language eq 'japanese'}"> 登録された投稿はありません。</c:when>
                        	<c:when test="${language eq 'chinese'}"> 没有注册的帖子。</c:when>
                        </c:choose>
                    </div>
				</c:if>
				
				<c:if test="${not empty lists }">
					<c:forEach var="to" items="${lists }">
						<div class="things">
							<div class="thumb">
								<c:choose>
									<c:when test="${not empty to.firstImageUrl }">
										<img src='${to.firstImageUrl }' alt=''>
									</c:when>
									<c:otherwise>
										<img src='/img/userRecom/no-image.png' alt='' >
									</c:otherwise>
								</c:choose>
								<a href='/${language}/userRecom_view.do?seq=${to.userRecomSeq}<c:if test="${not empty param.cpage}">&cpage=${param.cpage}</c:if><c:if test="${not empty param.searchType}">&searchType=${param.searchType}</c:if><c:if test="${not empty param.searchKeyword}">&searchKeyword=${param.searchKeyword}</c:if>'></a>
							</div>
							
							<div class="info">
								<div class="title"><c:out value="${to.userRecomTitle}"/></div>
								<br>
								<div class="info_bottom_container">
									<div class="info_bottom">
										<div class="bottom_left">
											<div class="userNickname">${to.userNickname }</div>
											<div class="postdate">${to.userRecompostDate }</div>
										</div>
										<div class="bottom_right">
											<div class="hit"><img src='/img/userRecom/hit_pngwing.com.png' alt='hit'> <c:out value='${to.userRecomHit}' /></div>
										</div>
									</div>
								</div>
							</div>
							
						</div>
					</c:forEach>
				</c:if>
				
			</div>
		
			<div class="bottom-container">
				<div class="pagination-container">
		        	<div class="pagination">
					<!-- 처음 페이지 버튼 -->
						<c:choose>
							<c:when test="${paging.cpage == 1}">
								<span class="pagination-item disabled">&lt;&lt;</span>
							</c:when>
							<c:otherwise>
								<a href="/${language}/userRecom.do?cpage=1" class="pagination-item">&lt;&lt;</a>
							</c:otherwise>
						</c:choose>
		
					<!-- 이전 페이지 버튼 -->
						<c:choose>
							<c:when test="${paging.cpage == 1}">
								<span class="pagination-item disabled">&lt;</span>
							</c:when>
							<c:otherwise>
								<a href="/${language}/userRecom.do?cpage=${paging.cpage - 1}" class="pagination-item">&lt;</a>
							</c:otherwise>
						</c:choose>
			
						<!-- 페이지 번호 -->
						<c:choose>
							<c:when test="${paging.totalPage <= 5}">
								<!-- 페이지 개수가 5 이하인 경우 -->
								<c:forEach var="i" begin="${1}" end="${paging.totalPage}" varStatus="loop">
									<c:choose>
										<c:when test="${i == paging.cpage}">
											<span class="pagination-item active">${i}</span>
										</c:when>
										<c:otherwise>
											<a href="/${language}/userRecom.do?cpage=${i}" class="pagination-item">${i}</a>
										</c:otherwise>
									</c:choose>
								</c:forEach>
							</c:when>
							<c:otherwise>
								<!-- 페이지 개수가 5 초과인 경우 -->
								<c:forEach var="i" begin="${paging.firstPage}" end="${paging.lastPage}" varStatus="loop">
									<c:choose>
										<c:when test="${i == paging.cpage}">
											<span class="pagination-item active">${i}</span>
										</c:when>
										<c:otherwise>
											<a href="/${language}/userRecom.do?cpage=${i}" class="pagination-item">${i}</a>
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
								<a href="$/${language}/userRecom.do?cpage=${paging.cpage + 1}" class="pagination-item">&gt;</a>
							</c:otherwise>
						</c:choose>
			
						<!-- 마지막 페이지 버튼 -->
						<c:choose>
							<c:when test="${paging.cpage == paging.totalPage}">
								<span class="pagination-item disabled">&gt;&gt;</span>
							</c:when>
							<c:otherwise>
								<a href="/${language}/userRecom.do?cpage=${paging.totalPage}" class="pagination-item">&gt;&gt;</a>
							</c:otherwise>
						</c:choose>
					</div>	
				</div>
				<!-- 쓰기 버튼 -->
		        <div class="write_button_container">
		        	<c:choose>
		        		<c:when test="${not empty userSeq }">
			        		<c:choose>
			        			<c:when test="${language eq 'korean' }">
				        			<input type="hidden" name="userSeq" value="${userSeq}"/>
				        			<a href="/${language}/userRecom_write.do" class="write_button">글쓰기</a>
				        		</c:when>
				        		<c:when test="${language eq 'english' }">
				        			<input type="hidden" name="userSeq" value="${userSeq}"/>
				        			<a href="/${language}/userRecom_write.do" class="write_button">write</a>
				        		</c:when>
				        		<c:when test="${language eq 'japanese' }">
				        			<input type="hidden" name="userSeq" value="${userSeq}"/>
				        			<a href="/${language}/userRecom_write.do" class="write_button">書く</a>
				        		</c:when>
				        		<c:when test="${language eq 'chinese' }">
				        			<input type="hidden" name="userSeq" value="${userSeq}"/>
				        			<a href="/${language}/userRecom_write.do" class="write_button">写作</a>
				        		</c:when>
			        		</c:choose>
		        		</c:when>
		        	</c:choose>
			    </div>           
	        </div>
	        
	        
		    <div class="search_container">
           		<form action="userRecom.do" method="get">
    				<select name="searchType">
    					<c:choose>
    						<c:when test="${language eq 'korean'}">
        						<option value="title">제목</option>
        						<option value="titleContent">제목 + 내용</option>
        					</c:when>
        					<c:when test="${language eq 'english'}">
        						<option value="title">title</option>
        						<option value="titleContent">title + content</option>
        					</c:when>
        					<c:when test="${language eq 'japanese'}">
        						<option value="title">タイトル</option>
        						<option value="titleContent">タイトル + コンテンツ</option>
        					</c:when>
        					<c:when test="${language eq 'chinese'}">
        						<option value="title">标题</option>
        						<option value="titleContent">标题 + 内容</option>
        					</c:when>
        				</c:choose>
    				</select>
    				<c:choose>
    					<c:when test="${language eq 'korean' }">
	    					<input type="text" name="searchKeyword" placeholder="검색어 입력">
	    					<input type="submit" value="검색">
	    				</c:when>
	    				<c:when test="${language eq 'english' }">
	    					<input type="text" name="searchKeyword" placeholder="enter...">
	    					<input type="submit" value="search">
	    				</c:when>
	    				<c:when test="${language eq 'japanese' }">
	    					<input type="text" name="searchKeyword" placeholder="検索語を入力">
	    					<input type="submit" value="検索">
	    				</c:when>
	    				<c:when test="${language eq 'chinese' }">
	    					<input type="text" name="searchKeyword" placeholder="输入搜索词">
	    					<input type="submit" value="搜索">
	    				</c:when>
	    			</c:choose>
				</form>
        	</div>
        
        </div>
    </div>
    <div style="height:200px">
   
   </div>
    <jsp:include page="/WEB-INF/views/includes/footer.jsp"></jsp:include>
</body>
</html>
