<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>전체 검색 페이지</title>
<link rel="stylesheet" type="text/css" href="/css/search/searchlist.css">
</head>
<body>
	<jsp:include page="/WEB-INF/views/includes/header${language}.jsp"></jsp:include>
	<div class="container search-container">
    <strong style="text-align: center; display: block; margin-top: 80px; margin-bottom: 20px; font-size: 32px; ">통합검색</strong>
    <form action="/${language}/totalsearch.do" method="get">
        <div class="searchs-box">
            <input type="text" name="keyword" class="searchs" required placeholder="키워드를 입력해 주세요">
            <button type="submit" class="searchBtns">검색</button>
        </div>
    </form>
    <p style="text-align: center; font-size: 20px;"><span style="color: #77D6FF; font-weight: bold;">'${param.keyword}'</span>의 검색 결과 입니다. <span style="color: #77D6FF; font-weight: bold;">${totalCount}건 </span>입니다.</p>
</div>
	<div class="main-container">

		<!-- Tab Links -->
		<div class="container board-counts">
			<!-- JSP를 이용해 동적으로 탭 링크 생성 -->
			<div class="board-count">
				<a
					href="/${language}/totalsearch.do?boardType=AllBoards&keyword=${param.keyword}" class="active">전체
					게시판 (${totalCount})</a>
			</div>
			<div class="board-count">
				<a
					href="/${language}/totalsearch.do?boardType=FreeBoard&keyword=${param.keyword}">자유게시판
					(${freeBoardCount})</a>
			</div>
			<div class="board-count">
				<a
					href="/${language}/totalsearch.do?boardType=EditTip&keyword=${param.keyword}">에디터
					팁 (${editTipCount})</a>
			</div>
			<div class="board-count">
				<a
					href="/${language}/totalsearch.do?boardType=EditRecommend&keyword=${param.keyword}">에디터
					추천 (${editRecommendCount})</a>
			</div>
			<div class="board-count">
				<a
					href="/${language}/totalsearch.do?boardType=TrendSeoul&keyword=${param.keyword}">트렌드 서울 (${trendSeoulCount})</a>
			</div>
			<div class="board-count">
				<a
					href="/${language}/totalsearch.do?boardType=Notice&keyword=${param.keyword}">공지사항
					(${noticeCount})</a>
			</div>
			<!-- 추가 탭 링크 -->
		</div>

		<!-- Tab Content: 전체 게시판 -->
		<div id="AllBoards" class="tab-content container search-results"
			style="display: block;">
			<c:if test="${not empty boards}">
				<ul>
					<c:forEach items="${boards}" var="board">
						<c:choose>
							<c:when test="${board.boardType == 'FreeBoard'}">
								<li>
									<div class="cont-wrap">
										<div class="info-wrap">
											<p class="label">자유게시판</p>
											<span class="time">${board.postDate}</span>
										</div>
										<div class="title-content-wrap">
											<div class="title-wrap">
												<a href="/${language}/freeboard_view.do?freeSeq=${board.id}">
													${board.title} </a>
											</div>
											<div class="content-wrap">
												<span>${board.content}</span>
											</div>
										</div>
									</div>
								</li>
							</c:when>
							<c:when test="${board.boardType == 'Notice'}">
								<li>
									<div class="cont-wrap">
										<div class="info-wrap">
											<p class="label">공지사항</p>
											<span class="time">${board.postDate}</span>
										</div>
										<div class="title-content-wrap">
											<div class="title-wrap">
												<a href="/${language}/notice_view.do?noticeSeq=${board.id}">
													${board.title} </a>
											</div>
											<div class="content-wrap">
												<span>${board.content}</span>
											</div>
										</div>
									</div>
								</li>
							</c:when>
							<c:when test="${board.boardType == 'EditTip'}">
								<li>
									<div class="cont-wrap">
										<div class="info-wrap">
											<p class="label">에디터 팁</p>
											<span class="time">${board.postDate}</span>
										</div>
										<div class="title-content-wrap">
											<div class="title-wrap">
												<a
													href="/${language}/editTip_view.do?edittipSeq=${board.id}">
													${board.title} </a>
											</div>
											<div class="content-wrap">
												<span>${board.content}</span>
											</div>
										</div>
									</div>
								</li>
							</c:when>
							<c:when test="${board.boardType == 'EditRecommend'}">
								<li>
									<div class="cont-wrap">
										<div class="info-wrap">
											<p class="label">에디터 추천</p>
											<span class="time">${board.postDate}</span>
										</div>
										<div class="title-content-wrap">
											<div class="title-wrap">
												<a
													href="/${language}/editRecommend_view.do?editrecoSeq=${board.id}">
													${board.title} </a>
											</div>
											<div class="content-wrap">
												<span>${board.content}</span>
											</div>
										</div>
									</div>
								</li>
							</c:when>
							<c:when test="${board.boardType == 'TrendSeoul'}">
								<li>
									<div class="cont-wrap">
										<div class="info-wrap">
											<p class="label">트렌드 서울</p>
											<span class="time">${board.postDate}</span>
										</div>
										<div class="title-content-wrap">
											<div class="title-wrap">
												<a
													href="/${language}/trend_view.do?seoulSeq=${board.id}">
													${board.title} </a>
											</div>
											<div class="content-wrap">
												<span>${board.content}</span>
											</div>
										</div>
									</div>
								</li>
							</c:when>
						</c:choose>
					</c:forEach>
				</ul>
			</c:if>
			<c:if test="${empty boards}">
				<p style="text-align: center;">등록된 게시글이 없습니다.</p>
			</c:if>
		</div>
		<!-- 자유게시판 탭 컨텐츠 -->
		<div id="FreeBoard" class="tab-content container search-results"
			style="display: none;">
			<c:if test="${not empty freeBoardResults}">
				<ul>
					<c:forEach items="${freeBoardResults}" var="result">
						<li>
							<div class="cont-wrap">
								<div class="info-wrap">
									<p class="label">자유게시판</p>
									<span class="time">${result.postDate}</span>
								</div>
								<div class="title-content-wrap">
									<div class="title-wrap">
										<a href="/${language}/freeboard_view.do?freeSeq=${result.id}">
											${result.title} </a>
									</div>
									<div class="content-wrap">
										<span>${result.content}</span>
									</div>
								</div>
							</div>
						</li>
					</c:forEach>
				</ul>
			</c:if>
			<c:if test="${empty boards}">
				<p style="text-align: center;">등록된 게시글이 없습니다.</p>
			</c:if>
		</div>

		<!-- 공지사항 탭 컨텐츠 -->
		<div id="Notice" class="tab-content container search-results"
			style="display: none;">
			<c:if test="${not empty noticeResults}">
				<ul>
					<c:forEach items="${noticeResults}" var="result">
						<li>
							<div class="cont-wrap">
								<div class="info-wrap">
									<p class="label">공지사항</p>
									<span class="time">${result.postDate}</span>
								</div>
								<div class="title-content-wrap">
									<div class="title-wrap">
										<a href="/${language}/notice_view.do?noticeSeq=${result.id}">
											${result.title} </a>
									</div>
									<div class="content-wrap">
										<span>${result.content}</span>
									</div>
								</div>
							</div>
						</li>
					</c:forEach>
				</ul>
			</c:if>
			<c:if test="${empty boards}">
				<p style="text-align: center;">등록된 게시글이 없습니다.</p>
			</c:if>
		</div>
		<!-- 에디터팁  탭 컨텐츠 -->
		<div id="EditTip" class="tab-content container search-results"
			style="display: none;">
			<c:if test="${not empty EditTipResults}">
				<ul>
					<c:forEach items="${EditTipResults}" var="result">
						<li>
							<div class="cont-wrap">
								<div class="info-wrap">
									<p class="label">에디터 팁</p>
									<span class="time">${result.postDate}</span>
								</div>
								<div class="title-content-wrap">
									<div class="title-wrap">
										<a href="/${language}/notice_view.do?noticeSeq=${result.id}">
											${result.title} </a>
									</div>
									<div class="content-wrap">
										<span>${result.content}</span>
									</div>
								</div>
							</div>
						</li>
					</c:forEach>
				</ul>
			</c:if>
			<c:if test="${empty boards}">
				<p style="text-align: center;">등록된 게시글이 없습니다.</p>
			</c:if>
		</div>
		<!-- 에디터 추천 탭 컨텐츠 -->
		<div id="EditRecommend" class="tab-content container search-results"
			style="display: none;">
			<c:if test="${not empty editRecommendResults}">
				<ul>
					<c:forEach items="${editRecommendResults}" var="result">
						<li>
							<div class="cont-wrap">
								<div class="info-wrap">
									<p class="label">에디터 추천</p>
									<span class="time">${result.postDate}</span>
								</div>
								<div class="title-content-wrap">
									<div class="title-wrap">
										<a
											href="/${language}/editRecommend_view.do?editrecoSeq=${result.id}">
											${result.title} </a>
									</div>
									<div class="content-wrap">
										<span>${result.content}</span>
									</div>
								</div>
							</div>
						</li>
					</c:forEach>
				</ul>
			</c:if>
			<c:if test="${empty editRecommendResults}">
				<p style="text-align: center;">등록된 게시글이 없습니다.</p>
			</c:if>
		</div>
		<script>
			// 페이지 로드 시 첫 번째 탭을 표시
			document.getElementById('AllBoards').style.display = 'block';

			// 탭 결과 표시 함수
			function showResults(tabName) {
				var i, tabcontent;
				tabcontent = document.getElementsByClassName("tab-content");
				for (i = 0; i < tabcontent.length; i++) {
					tabcontent[i].style.display = "none";
				}
				document.getElementById(tabName).style.display = "block";
				updatePaginationLinks(tabName);
			}

			document.querySelectorAll('.content-wrap span').forEach(
					function(span) {
						if (span.textContent.length > 100) {
							span.textContent = span.textContent
									.substring(0, 100)
									+ '...';
						}
					});

			// 페이지네이션 링크 업데이트 함수
			function updatePaginationLinks(boardType) {
				var paginationLinks = document
						.querySelectorAll('.pagination a');
				paginationLinks.forEach(function(link) {
					var url = new URL(link.href);
					url.searchParams.set('boardType', boardType);
					link.href = url.toString();
				});
			}

			// 초기 탭 설정 및 페이지네이션 링크 업데이트
			updatePaginationLinks('AllBoards');
			
			var searchLinks = document.querySelectorAll('.container board-counts a');
		      
	          searchLinks.forEach(function(link) {
	              link.addEventListener('click', function(event) {
	                  // 기본 동작 취소
	                  event.preventDefault();
	      
	                  // 모든 링크에서 'active' 클래스 제거
	                  searchLinks.forEach(function(link) {
	                      link.classList.remove('active');
	                  });
	      
	                  // 클릭한 링크에 'active' 클래스 추가
	                  this.classList.add('active');
	              });
	          });
		</script>
		<div class="bottom-container">
			<div class="pagination-container">
				<div class="pagination">
					<!-- 처음 페이지 버튼 -->
					<c:if test="${paging.cpage > 1}">
						<a
							href="/${language}/totalsearch.do?boardType=${boardType}&keyword=${param.keyword}&cpage=1"
							class="pagination-item">&lt;&lt;</a>
						<a
							href="/${language}/totalsearch.do?boardType=${boardType}&keyword=${param.keyword}&cpage=${paging.cpage - 1}"
							class="pagination-item">&lt;</a>
					</c:if>
					<c:if test="${paging.cpage == 1}">
						<span class="pagination-item disabled">&lt;&lt;</span>
						<span class="pagination-item disabled">&lt;</span>
					</c:if>

					<!-- 페이지 번호 -->
					<c:forEach var="i" begin="${paging.firstPage}"
						end="${paging.lastPage}" varStatus="loop">
						<c:if test="${i == paging.cpage}">
							<span class="pagination-item active">${i}</span>
						</c:if>
						<c:if test="${i != paging.cpage}">
							<a
								href="/${language}/totalsearch.do?boardType=${boardType}&keyword=${param.keyword}&cpage=${i}"
								class="pagination-item">${i}</a>
						</c:if>
					</c:forEach>

					<!-- 다음 페이지 버튼 -->
					<c:if test="${paging.cpage < paging.totalPage}">
						<a
							href="/${language}/totalsearch.do?boardType=${boardType}&keyword=${param.keyword}&cpage=${paging.cpage + 1}"
							class="pagination-item">&gt;</a>
						<a
							href="/${language}/totalsearch.do?boardType=${boardType}&keyword=${param.keyword}&cpage=${paging.totalPage}"
							class="pagination-item">&gt;&gt;</a>
					</c:if>
					<c:if test="${paging.cpage == paging.totalPage}">
						<span class="pagination-item disabled">&gt;</span>
						<span class="pagination-item disabled">&gt;&gt;</span>
					</c:if>
				</div>
			</div>
		</div>
	</div>
	<jsp:include page="/WEB-INF/views/includes/footer.jsp"></jsp:include>
</body>
</html>