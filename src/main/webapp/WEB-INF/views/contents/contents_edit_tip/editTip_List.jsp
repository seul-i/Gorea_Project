<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<c:set var="paging" value="${paging}" />
<c:set var="lists1" value="${paging.lists1}" />

<!DOCTYPE html>
<html>
<head>
    <meta charset="EUC-KR">
    <title>Go!rea</title>
    <link rel="stylesheet" type="text/css" href="/css/editor/list1.css">
    
    <link rel="stylesheet" type="text/css" href="/css/header/header.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.css"/>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;700&display=swap">
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    <script>
    $(document).ready(function () {
        // �ٹ� Ŭ�� �̺�Ʈ ó��
        $('.album').on('click', function () {
            var seq = $(this).data('seq');
            window.location.href = '/korean/editTip_view.do?edittipSeq=' + seq;
        });

        // ���콺 �÷������� �� ������ ������� ����
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

     	// ���� �������� �̵��ϴ� �Լ�
        function goToPreviousPage() {
            var currentPage = ${paging.cpage};

            // ���� �������� 1�������� ��쿡�� �������� �ʵ��� üũ
            if (currentPage > 1) {
                // �̵��� URL ����
                var url = "/korean/editTip_list.do?cpage=" + (currentPage - 1);

                // ������ ������ �̵�
                window.location.href = url;
            }
        }
    </script>
</head>
<body>

    <div class="banner" id="banner">
        <img src="/img/banner/edittipbanner.jpg" alt="banner">
        <div class="banner-text">
            <h1>������ ����</h1>
        </div>
    </div>

    <div class="location">
        ��õ <span class="ar">></span> <span> <a href="./editTip_list.do?cpage=${paging.cpage}">������ ����</a>
        </span>
    </div>

    <!-- product section -->
    <section class="albums">
		<div class="album-container">
			<c:choose>
				<c:when test="${not empty lists1}">
					<c:forEach var="eto" items="${lists1}">
						<div class='album' data-seq='${eto.edittipSeq}'>
							<div class='image'>
								<img src='../../upload/${eto.firstImageUrl}' alt='' />
								<div class='i'>
									<i class='fa fa-star-o fa-2x'></i> <i class='fa fa-star fa-2x'></i>
								</div>
							</div>
							<div class='content'>
								<div class='title-subtitle'>
									<div class='title'>${eto.edittipSubject}</div>
									<div class='subtitle'>${eto.edittipSubtitle}</div>
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
			onclick="location.href='editTip_write.do'">�۾���</button>
	</div>
    
    <div class="pagination">
		<!-- ó�� ������ ��ư -->
		<c:choose>
			<c:when test="${paging.cpage == 1}">
				<span class="pagination-item disabled">&lt;&lt;</span>
			</c:when>
			<c:otherwise>
				<a href="/korean/editTip_list.do?cpage=1"
					class="pagination-item">&lt;&lt;</a>
			</c:otherwise>
		</c:choose>

		<!-- ���� ������ ��ư -->
		<c:choose>
			<c:when test="${paging.cpage == 1}">
				<span class="pagination-item disabled">&lt;</span>
			</c:when>
			<c:otherwise>
				<a href="/korean/editTip_list.do?cpage=${paging.cpage - 1}"
					class="pagination-item">&lt;</a>
			</c:otherwise>
		</c:choose>

		<!-- ������ ��ȣ -->
		<c:choose>
			<c:when test="${paging.totalPage <= 5}">
				<!-- ������ ������ 5 ������ ��� -->
				<c:forEach var="i" begin="${1}" end="${paging.totalPage}"
					varStatus="loop">
					<c:choose>
						<c:when test="${i == paging.cpage}">
							<span class="pagination-item active">${i}</span>
						</c:when>
						<c:otherwise>
							<a href="/korean/editTip_list.do?cpage=${i}"
								class="pagination-item">${i}</a>
						</c:otherwise>
					</c:choose>
				</c:forEach>
			</c:when>
			<c:otherwise>
				<!-- ������ ������ 5 �ʰ��� ��� -->
				<c:forEach var="i" begin="${paging.firstPage}"
					end="${paging.lastPage}" varStatus="loop">
					<c:choose>
						<c:when test="${i == paging.cpage}">
							<span class="pagination-item active">${i}</span>
						</c:when>
						<c:otherwise>
							<a href="/korean/editTip_list.do?cpage=${i}"
								class="pagination-item">${i}</a>
						</c:otherwise>
					</c:choose>
				</c:forEach>
			</c:otherwise>
		</c:choose>

		<!-- ���� ������ ��ư -->
		<c:choose>
			<c:when test="${paging.cpage == paging.totalPage}">
				<span class="pagination-item disabled">&gt;</span>
			</c:when>
			<c:otherwise>
				<a href="/korean/editTip_list.do?cpage=${paging.cpage + 1}"
					class="pagination-item">&gt;</a>
			</c:otherwise>
		</c:choose>


		<!-- ������ ������ ��ư -->
		<c:choose>
			<c:when
				test="${paging.cpage == paging.totalPage or paging.totalPage <= 5}">
				<span class="pagination-item disabled">&gt;&gt;</span>
			</c:when>
			<c:otherwise>
				<a href="/korean/editTip_list.do?cpage=${paging.totalPage}"
					class="pagination-item">&gt;&gt;</a>
			</c:otherwise>
		</c:choose>
	</div>
</body>
</html>
