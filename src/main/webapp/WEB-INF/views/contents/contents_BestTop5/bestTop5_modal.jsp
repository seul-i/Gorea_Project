<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<script src="http://ajax.aspnetcdn.com/ajax/jQuery/jquery-1.12.4.min.js"></script>
		
		<link rel="stylesheet" type="text/css" href="/css/top5/top5write.css" />

	</head>
	
	<body>
		
		<!-- 이미지 출력부분 -->
		<div class="top5container">
			<div class= "card-content" >
				<c:forEach var="boardList" items="${boardList}">
					<div class="card" onclick="toggleButtons(this)">
							<div class="card-image">
								<img id="${boardList.seoulSeq}" src="${boardList.firstImageUrl}" draggable="true" ondragstart="drag(event)" alt="">
							</div>
							
							<div class="card-info">
								<p>${boardList.mainCategory}/${boardList.subCategory}</p>
								<h4>${boardList.seoulTitle}</h4>
							</div>
							
							<div class="overlay" onclick="toggleButtons(this)">
								<div class="buttons">
								    <button onclick="buttonClicked(1)">선택하기</button>
								    <button onclick="buttonClicked(2)">상세보기</button>
								</div>
						</div>
					</div>
				</c:forEach>
			</div>
			
			<!-- 페이징 네이션 -->
			<div class="pagination">
<!-- 					<li class="Page-item previous-page disable"><a class="page-link" href="#">Prev</a></li> -->
<!-- 					<li class="Page-item current-page active"><a class="page-link" href="#">1</a></li> -->
<!-- 					<li class="Page-item dots"><a class="page-link" href="#">...</a></li> -->
<!-- 					<li class="Page-item current-page"><a class="page-link" href="#">5</a></li> -->
<!-- 					<li class="Page-item current-page"><a class="page-link" href="#">6</a></li> -->
<!-- 					<li class="Page-item dots"><a class="page-link" href="#">...</a></li> -->
<!-- 					<li class="Page-item current-page"><a class="page-link" href="#">10</a></li> -->
<!-- 					<li class="Page-item next-page"><a class="page-link" href="#">Next</a></li> -->
			</div>
		</div>
		
		<script type="text/javascript">
		
			// card div 클릭시 버튼 
			
			var allCards = document.querySelectorAll('.card');
			
			function toggleButtons(card) {
			    // 순회하며 다른 card 초기화
				allCards.forEach(function (otherCard) {
					if (otherCard !== card) {
				        var buttons = otherCard.querySelector('.buttons');
				        var overlay = otherCard.querySelector('.overlay');
				        buttons.style.display = 'none';
				        overlay.style.display = 'none';
					}
				});
			
			    var buttons = card.querySelector('.buttons');
			    var overlay = card.querySelector('.overlay');
			    buttons.style.display = (buttons.style.display === 'none' || buttons.style.display === '') ? 'block' : 'block';
			    overlay.style.display = (overlay.style.display === 'none' || overlay.style.display === '') ? 'flex' : 'none';
			}
	
			function buttonClicked(buttonNumber) {

			}
			
			// 페이징 네이션 처리 부분
		
			function getPageList(totalPages, page, maxLength) {
			    function range(start, end) {
			        return Array.from(Array(end - start + 1), (_, i) => i + start);
			    }
		
			    var sideWidth = maxLength < 9 ? 1 : 2;
			    var leftWidth = (maxLength - sideWidth * 2 - 3) >> 1;
			    var rightWidth = (maxLength - sideWidth * 2 - 3) >> 1;
		
			    if (totalPages <= maxLength) {
			        return range(1, totalPages);
			    }
		
			    if (page <= maxLength - sideWidth - 1 - rightWidth) {
			        return range(1, maxLength - sideWidth - 1).concat(0, range(totalPages - sideWidth + 1, totalPages));
			    }
		
			    if (page >= totalPages - sideWidth - 1 - rightWidth) {
			        return range(1, sideWidth).concat(0, range(totalPages - sideWidth - 1 - rightWidth - leftWidth, totalPages));
			    }
		
			    return range(1, sideWidth).concat(0, range(page - leftWidth, page + rightWidth), 0, range(totalPages - sideWidth + 1, totalPages));
			}
		
			$(function () {
			    var numberOfItems = $(".card-content .card").length;
			    var limitPerPage = 8; // 몇개 보여줄것인지
			    var totalPages = Math.ceil(numberOfItems / limitPerPage);
			    var paginationSize = 6; // 페이지네이션 몇개 보여줄것인지
			    var currentPage;
		
			    function showPage(whichPage) {
			        if (whichPage < 1 || whichPage > totalPages) return false;
		
			        currentPage = whichPage;
		
			        $(".card-content .card").hide().slice((currentPage - 1) * limitPerPage, currentPage * limitPerPage).show();
		
			        $(".pagination li").slice(1, -1).remove();
		
			        getPageList(totalPages, currentPage, paginationSize).forEach(item => {
			            $("<li>").addClass("page-item").addClass(item ? "current-page" : "dots")
			                .toggleClass("active", item === currentPage).append($("<a>").addClass("page-link")
			                    .attr({ href: "javascript:void(0)" }).text(item || "...")).insertBefore(".next-page");
			        });
		
			        $(".previous-page").toggleClass("disable", currentPage === 1);
			        $(".next-page").toggleClass("disable", currentPage === totalPages);
		
			        return true;
			    }
		
			    $(".pagination").append(
			        $("<li>").addClass("page-item").addClass("previous-page").append($("<a>").addClass("page-link")
			            .attr({ href: "javascript:void(0)" }).text("Prev")),
			        $("<li>").addClass("page-item").addClass("next-page").append($("<a>").addClass("page-link")
			            .attr({ href: "javascript:void(0)" }).text("Next"))
			    );
			    
			    $(".card-content").show();
			    showPage(1);
			    
			    $(document).on("click",".pagination li.current-page:not(.active)", function(){
			    	return showPage(+$(this).text());
			    });
			    
			    $(".next-page").on("click",function(){
			    	return showPage(currentPage +1);
			    });
			    
			    $(".previous-page").on("click",function(){
			    	return showPage(currentPage -1);
			    })
			    
			});
		
		</script>
		
	</body>
</html>