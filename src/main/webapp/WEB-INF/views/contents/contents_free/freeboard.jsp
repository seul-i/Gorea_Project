<%@ page import="com.gorea.dto_board.Gorea_Notice_BoardTO" %>
<%@ page import="java.util.ArrayList" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="language" value="${language}" />
<c:set var="paging" value="${paging}" />
<c:set var="freeboard" value="${paging.freeboard}" />
<c:set var="userSeq" value="${SPRING_SECURITY_CONTEXT.authentication.principal.gorea_UserTO.userSeq}" />

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Go!rea</title>
    <link rel="stylesheet" type="text/css" href="/css/freeboard/list.css">
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    <script>
    	
    // 이전 페이지로 이동하는 함수
    function goToPreviousPage() {
        var currentPage = ${paging.cpage};

        // 현재 페이지가 1페이지인 경우에는 동작하지 않도록 체크
        if (currentPage > 1) {
            // 이동할 URL 생성
            var url = "/${language}/freeboard.do?cpage=" + (currentPage - 1);

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
            	<c:when test="${language eq 'korean'}"><strong>자유게시판</strong></c:when>
            	<c:when test="${language eq 'english'}"><strong>Freeboard</strong></c:when>
            	<c:when test="${language eq 'japanese'}"><strong>自由掲示板</strong></c:when>
            	<c:when test="${language eq 'chinese'}"><strong>免费膳食</strong></c:when>
            </c:choose>
        </div>
        <div class="board_list_wrap">
            <div class="board_list">
            
	            <c:choose>
	            	<c:when test="${language eq 'korean' }">
		                <div class="top">
		                    <div class="num">번호</div>
		                    <div class="title">제목</div>
		                    <div class="writer">글쓴이</div>
		                    <div class="date">작성일</div>
		                    <div class="recommend">추천수</div> <!-- 추천수 칼럼 추가 -->
		                    <div class="count">조회</div>
		                </div>
		             </c:when>
		             <c:when test="${language eq 'english' }">
		                <div class="top">
		                    <div class="num">No</div>
		                    <div class="title">title</div>
		                    <div class="writer">writer</div>
		                    <div class="date">date</div>
		                    <div class="recommend">like</div> <!-- 추천수 칼럼 추가 -->
		                    <div class="count">views</div>
		                </div>
		             </c:when>
		             <c:when test="${language eq 'japanese' }">
		                <div class="top">
		                    <div class="num">番号</div>
		                    <div class="title">タイトル</div>
		                    <div class="writer">執筆</div>
		                    <div class="date">日付</div>
		                    <div class="recommend">おすすめ</div> <!-- 추천수 칼럼 추가 -->
		                    <div class="count">ビュー</div>
		                </div>
		             </c:when>
		             <c:when test="${language eq 'chinese' }">
		                <div class="top">
		                    <div class="num">数字</div>
		                    <div class="title">标题</div>
		                    <div class="writer">作家</div>
		                    <div class="date">日期</div>
		                    <div class="recommend">建议</div> <!-- 추천수 칼럼 추가 -->
		                    <div class="count">查看</div>
		                </div>
		             </c:when>
	            </c:choose>

                <c:if test="${empty lists}">
                    <div style="text-align: center; padding: 20px; font-size: 18px;">
                        <c:choose>
                        	<c:when test="${language eq 'korean'}"> 등록된 게시글이 없습니다. </c:when>
                        	<c:when test="${language eq 'english'}"> There are no registered posts. </c:when>
                        	<c:when test="${language eq 'japanese'}"> 登録された投稿はありません。</c:when>
                        	<c:when test="${language eq 'chinese'}"> 没有注册的帖子。</c:when>
                        </c:choose>
                    </div>
                </c:if>
                <c:if test="${not empty lists}">
                    <c:forEach items="${lists}" var="to">
                        <div>
                            <div class='num'>${to.freeSeq}</div>
                            <div class='title'>
    							<a href='./freeboard_view.do?freeSeq=${to.freeSeq}
    								<c:if test="${not empty param.cpage}">&cpage=${param.cpage}</c:if>
    								<c:if test="${not empty param.searchType}">&searchType=${param.searchType}</c:if>
    								<c:if test="${not empty param.searchKeyword}">&searchKeyword=${param.searchKeyword}</c:if>'>
    								${to.freeTitle}
								</a>
							</div>
                            <div class='writer'>${to.userNickname }</div>
                            <div class='date'>${to.freepostDate}</div>
                            <div class='recommend'>${to.freeRecomcount}</div> <!-- 추천수 데이터 -->
                            <div class='count'>${to.freeHit}</div>
                        </div>
                    </c:forEach>
                </c:if>
            </div>
			<div class="bottom-container">
		    	<div class="pagination-container">
			        <div class="pagination">
				        <!-- 처음 페이지 버튼 -->
				        <c:if test="${paging.cpage > 1}">
				            <a href="/${language}/freeboard.do?cpage=1<c:if test="${not empty param.searchType and not empty param.searchKeyword}">&searchType=${param.searchType}&searchKeyword=${param.searchKeyword}</c:if>" class="pagination-item">&lt;&lt;</a>
				            <a href="/${language}/freeboard.do?cpage=${paging.cpage - 1}<c:if test="${not empty param.searchType and not empty param.searchKeyword}">&searchType=${param.searchType}&searchKeyword=${param.searchKeyword}</c:if>" class="pagination-item">&lt;</a>
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
				                    <a href="/${language}/freeboard.do?cpage=${i}<c:if test="${not empty param.searchType and not empty param.searchKeyword}">&searchType=${param.searchType}&searchKeyword=${param.searchKeyword}</c:if>" class="pagination-item">${i}</a>
				                </c:otherwise>
				            </c:choose>
				        </c:forEach>
				
				        <!-- 다음 페이지 버튼 -->
				        <c:if test="${paging.cpage < paging.totalPage}">
				            <a href="/${language}/freeboard.do?cpage=${paging.cpage + 1}<c:if test="${not empty param.searchType and not empty param.searchKeyword}">&searchType=${param.searchType}&searchKeyword=${param.searchKeyword}</c:if>" class="pagination-item">&gt;</a>
				            <a href="/${language}/freeboard.do?cpage=${paging.totalPage}<c:if test="${not empty param.searchType and not empty param.searchKeyword}">&searchType=${param.searchType}&searchKeyword=${param.searchKeyword}</c:if>" class="pagination-item">&gt;&gt;</a>
				        </c:if>
				        <c:if test="${paging.cpage == paging.totalPage}">
				            <span class="pagination-item disabled">&gt;</span>
				            <span class="pagination-item disabled">&gt;&gt;</span>
				        </c:if>
			    	</div>
		    	</div>
			    <div class="write_button_container">
			        <c:choose>
		        		<c:when test="${not empty userSeq }">
		        			<c:choose>
			        			<c:when test="${language eq 'korean' }">
				        			<input type="hidden" name="userSeq" value="${userSeq}"/>
				        			<a href="/${language}/freeboard_write.do" class="write_button">글쓰기</a>
				        		</c:when>
				        		<c:when test="${language eq 'english' }">
				        			<input type="hidden" name="userSeq" value="${userSeq}"/>
				        			<a href="/${language}/freeboard_write.do" class="write_button">write</a>
				        		</c:when>
				        		<c:when test="${language eq 'japanese' }">
				        			<input type="hidden" name="userSeq" value="${userSeq}"/>
				        			<a href="/${language}/freeboard_write.do" class="write_button">書く</a>
				        		</c:when>
				        		<c:when test="${language eq 'chinese' }">
				        			<input type="hidden" name="userSeq" value="${userSeq}"/>
				        			<a href="/${language}/freeboard_write.do" class="write_button">写作</a>
				        		</c:when>
			        		</c:choose>
		        		</c:when>
		        	</c:choose>
			    </div>
			</div>
		
	        <div class="search_container">
	           	<form action="freeboard.do" method="get">
	    			<select name="searchType" style="border: 1px solid #ccc;">
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
		    				<input type="text" name="searchKeyword" placeholder="검색어 입력" style="border: 1px solid #ccc;">
		    				<input type="submit" value="검색">
		    			</c:when>
		    			<c:when test="${language eq 'english' }">
		    				<input type="text" name="searchKeyword" placeholder="enter..." style="border: 1px solid #ccc;">
		    				<input type="submit" value="search">
		    			</c:when>
		    			<c:when test="${language eq 'japanese' }">
		    				<input type="text" name="searchKeyword" placeholder="検索語を入力" style="border: 1px solid #ccc;">
		    				<input type="submit" value="検索">
		    			</c:when>
		    			<c:when test="${language eq 'chinese' }">
		    				<input type="text" name="searchKeyword" placeholder="输入搜索词" style="border: 1px solid #ccc;">
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
