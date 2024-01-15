<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<c:set var="language" value="${language}" />

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<!-- jQuery CDN -->
		<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
		<!-- ajax CDN -->
		<script src="http://ajax.aspnetcdn.com/ajax/jQuery/jquery-1.12.4.min.js"></script>

		<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" integrity="sha384-xOolHFLEh07PJGoPkLv1IbcEPTNtaed2xpHsD9ESMhqIYd0nLMwNLD69Npy4HI+N" crossorigin="anonymous">
		<script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-Fy6S3B9q64WdZWQUiU+q4/2Lc9npb8tCaSX9FK7E8HnRr0Jz8D6OP9dO5Vg3Q9ct" crossorigin="anonymous"></script>
		
		<link rel="stylesheet" type="text/css" href="/css/top5/top5write.css" />
    <style>
      
    </style>
			
	</head>
	
	<body>
		
		<jsp:include page="/WEB-INF/views/includes/header${language}.jsp"></jsp:include>
			
<%-- 			<a href="/${language}/BestTop5_modal.do">글쓰기</a> --%>
			
			<!-- Moa Modal--> 
			<div class="modal fade" id="moaModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
				<div class="modal-dialog modal-xl" role="document">
					<div class="modal-content">
						<div class="modal-header">
							<h5 class="modal-title" id="exampleModalLabel">장소 선택하기</h5>
								<button class="close" type="button" data-dismiss="modal" aria-label="Close">
									<span aria-hidden="true">x</span>
				          		</button>
						</div>
						
						<div class="modal-body">
							<div class="serachBox">
								<ul>
									<li>
										<select name="seoulLocGu">
											<option value="">Seoul_Gu</option>
										    <c:forEach var="seoulLocgu" items="${seoulLocgu}">
										        <option value="${seoulLocgu.seoulLocGu}">${seoulLocgu.seoulLocGu}</option>
										    </c:forEach>
										</select>
									</li>
									<li>
										<select id="mainCategorySelect" name="mainCategory">
											<option value="">Main_Categroy</option>
										    <c:forEach var="item" items="${searchmianCategroy}">
										        <option value="${item.mainCategory}">${item.mainCategory}</option>
										    </c:forEach>
										</select>
									</li>
									<li>
										<select name="subCategory">
											<option value="">Sub_Categroy</option>
										    <c:forEach var="item" items="${searchsubCategroy}">
										        <option value="${item.subCategory}">${item.subCategory}</option>
										    </c:forEach>
										</select>
									</li>
									<li>
										<button id="btn">Search</button>
									</li>
								</ul>
							</div>
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
													<button onclick="buttonClicked(2)" data-toggle="modal" data-target="#ModalinModal">상세보기</button>
				
												</div>
											</div>
										</div>
									</c:forEach>
								</div>
								
								<!-- 페이징 네이션 -->
								<div class="pagination"></div>
							</div>
						</div>
			        
						<div class="modal-footer">
							<button class="btn btn-primary" type="button" data-dismiss="modal">Cancel</button>
						</div>
				</div>
			</div>
		</div>
			  
			<script type="text/javascript">
			
				////////////////////////////////// 검색 박스 비동기 처리 //////////////////////////////////////////////////////////////////////////
				
				$(document).ready(function () {
				    $("#mainCategorySelect").change(function () {
				        var selectedMainCategory = $(this).val();
				        
				        var language = '${language}';
				        
				        $.ajax({
				        	url: "/"+language+"/categorySearch.do",
				        	type: "GET",
				        	dataType : 'json',
				            data: {
				                mainCategory: selectedMainCategory
				            },
				            success: function (data) {
				            	
				            	// 서버에서 받은 데이터로 옵션을 업데이트
				                var subCategorySelect = $("select[name='subCategory']");
				                subCategorySelect.empty(); // 기존 옵션 제거
				                subCategorySelect.append("<option value='#'>Sub_Category</option>");

				                // 서버에서 받은 데이터로 옵션 추가
				                $.each(data, function(index, item) {
				                    subCategorySelect.append("<option value='" + item.subCategory + "'>" + item.subCategory + "</option>");
				                });
				            },
				            error: function (error) {
				                console.log("Error:", error);
				            }
				        });
				    });
				    
				    $('#btn').click(function(){
				        var selectedseoulLocGu = $("select[name='seoulLocGu']").val();
				        var selectedMainCategory = $("select[name='mainCategory']").val();
				        var selectedsubCategory = $("select[name='subCategory']").val();
				        var language = '${language}';

				        $.ajax({
				            url: "/"+language+"/listSearch.do",
				            type: "GET",
				            dataType: 'json',
				            data: {
				                locGu: selectedseoulLocGu,
				                mainCategory: selectedMainCategory,
				                subCategory: selectedsubCategory
				            },
				            success: function (data) {
				                if (data && data.length > 0) {
				                    var cardContent = $(".top5container .card-content");
				                    cardContent.empty();

				                    for (var i = 0; i < data.length; i++) {
				                        var card = $("<div class='card' onclick='toggleButtons(this)'>");
				                        card.append("<div class='card-image'><img id='" + data[i].seoulSeq + "' src='" + data[i].firstImageUrl + "' draggable='true' ondragstart='drag(event)' alt=''></div>");
				                        card.append("<div class='card-info'><p>" + data[i].mainCategory + "/" + data[i].subCategory + "</p><h4>" + data[i].seoulTitle + "</h4></div>");
				                        card.append("<div class='overlay' onclick='toggleButtons(this)'><div class='buttons'><button onclick='buttonClicked(1)'>선택하기</button><button onclick='buttonClicked(2)' data-toggle='modal' data-target='#ModalinModal'>상세보기</button></div></div>");

				                        cardContent.append(card);
				                    }

				                    initializePagination();
				                } else {
				                    alert("검색 결과가 없습니다");
				                }
				            },
				            error: function (error) {
				                console.log("Error:", error);
				            }
				        });
				        
				        
				    });

				});
		
				////////////////////////////////// card div 클릭시 버튼 //////////////////////////////////////////////////////////////////////////
				
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
				
				document.querySelector('.close[data-dismiss="modal"]').addEventListener('click', function() {
				    // 모든 카드 초기화
				    allCards.forEach(function (card) {
				        var buttons = card.querySelector('.buttons');
				        var overlay = card.querySelector('.overlay');
				        buttons.style.display = 'none';
				        overlay.style.display = 'none';
				    });
				    
				    initializePagination();
				});
		
				function buttonClicked(buttonNumber) {
	
				}
				
				//////////////////////////////////// 페이징 네이션 처리 부분 //////////////////////////////////////////////////////////////////////////
					
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
				
				function initializePagination() {
			
				$(function () {
				    var numberOfItems = $(".card-content .card").length;
				    var limitPerPage = 6; // 몇개 보여줄것인지
				    var totalPages = Math.ceil(numberOfItems / limitPerPage);
				    var paginationSize = 8; // 페이지네이션 몇개 보여줄것인지
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
				    
				})
				
				};
				
				$(document).ready(function () {
					initializePagination();
				});
							
			
			</script>
			  
			<a class="dropdown-item" href="#" data-toggle="modal" data-target="#moaModal">
				선택하기
			</a>
		
		<jsp:include page="/WEB-INF/views/includes/footer.jsp"></jsp:include>
		
	</body>
</html>