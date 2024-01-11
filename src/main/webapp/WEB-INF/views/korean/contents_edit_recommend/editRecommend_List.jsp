<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.gorea.dto_board.Gorea_EditRecommend_BoardTO"%>
<%@ page import="com.gorea.dto_board.Gorea_PagingTO"%>

<c:set var="paging" value="${paging}" />
<c:set var="lists" value="${paging.lists}" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Go!rea</title>
<link rel="stylesheet" type="text/css" href="/css/list/list.css">
<link rel="stylesheet" type="text/css" href="/css/header/header.css">
<link rel="stylesheet" type="text/css" href="/css/footer/footer.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.css" />
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;700&display=swap">
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>

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

	<c:import url="includes/${language}Header.jsp" />

	<div class="banner" id="banner">
		<img src="/img/banner/editrecommendbanner.jpg" alt="banner">
		<div class="banner-text">
			<h1>에디터 추천 장소</h1>
		</div>
	</div>

	<div class="location">
		<i class="fa-solid fa-house"></i> <span class="ar">></span> 추천 <span
			class="ar">></span> <span> <a
			href="/korean/editRecommend_list.do?cpage=${paging.cpage}">에디터 추천
				장소</a>
		</span>
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

	<div style="text-align: right; margin-right: 25px;">
		<button class="w-btn-outline w-btn-blue-outline" type="button"
			onclick="location.href='editRecommend_write.do'">글쓰기</button>
	</div>



	<div class="pagination">
		<!-- 처음 페이지 버튼 -->
		<c:choose>
			<c:when test="${paging.cpage == 1}">
				<span class="pagination-item disabled">&lt;&lt;</span>
			</c:when>
			<c:otherwise>
				<a href="/korean/editRecommend_list.do?cpage=1"
					class="pagination-item">&lt;&lt;</a>
			</c:otherwise>
		</c:choose>

		<!-- 이전 페이지 버튼 -->
		<c:choose>
			<c:when test="${paging.cpage == 1}">
				<span class="pagination-item disabled">&lt;</span>
			</c:when>
			<c:otherwise>
				<a href="/korean/editRecommend_list.do?cpage=${paging.cpage - 1}"
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
							<a href="/korean/editRecommend_list.do?cpage=${i}"
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
							<a href="/korean/editRecommend_list.do?cpage=${i}"
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
				<a href="/korean/editRecommend_list.do?cpage=${paging.cpage + 1}"
					class="pagination-item">&gt;</a>
			</c:otherwise>
		</c:choose>

		<!-- 마지막 페이지 버튼 -->
		<c:choose>
			<c:when test="${paging.cpage == paging.totalPage}">
				<span class="pagination-item disabled">&gt;&gt;</span>
			</c:when>
			<c:otherwise>
				<a href="/korean/editRecommend_list.do?cpage=${paging.totalPage}"
					class="pagination-item">&gt;&gt;</a>
			</c:otherwise>
		</c:choose>
	</div>


		<c:import url="includes/footer.jsp" />
</body>
</html>
