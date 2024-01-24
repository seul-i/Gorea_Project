<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<c:set var="language" value="${language}" />
<c:set var="userSeq" value="${SPRING_SECURITY_CONTEXT.authentication.principal.gorea_UserTO.userSeq}" />

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
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-Fy6S3B9q64WdZWQUiU+q4/2Lc9npb8tCaSX9FK7E8HnRr0Jz8D6OP9dO5Vg3Q9ct" crossorigin="anonymous"></script>
		
		<link rel="stylesheet" type="text/css" href="/css/top5/top5write.css" />
		
	    
			
	</head>
	
	<body>
		
		<jsp:include page="/WEB-INF/views/includes/header${language}.jsp"></jsp:include>
		
		<div class="banner" id="banner">
        	<img src="/img/banner/edittipbanner.jpg" alt="banner">
        	<div class="banner-text">
            <h1>에디터 꿀팁</h1>
        	</div>
    	</div>	
	
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
									
										<div class="card">
											<div class="card-image">
												<img id="${boardList.seoulSeq}" src="${boardList.firstImageUrl}" alt="">
											</div>
												
											<div class="card-info">
												<p>${boardList.mainCategory}/${boardList.subCategory}</p>
												<h4>${boardList.seoulTitle}</h4>
											</div>
											
											<div class="buttons">
												<button class="select-button" id="" data-dismiss="modal">선택하기</button>
												<button onclick="openNewWindow('${boardList.seoulSeq}')">상세보기</button>
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
		
		
		<div style="height:100px"></div>
		
		<form method="post" action="./bestTop5_write_ok.do">
			<input type="hidden" name="userSeq" value="${userSeq}">
			<div class="row" id="place1">
				<div class="col-sm-1">
				<input type="hidden" value="" name="seoulSeq1">
				</div>
				<div class="col-sm-3" style="height: 300px">
					<img src="/img/trendseoul/noimg.png" data-toggle="modal" data-target="#moaModal" style="width: 100%; height:100%;">
				</div>
				<div class="col-sm-7" style="display: grid; align-items: center">
					<div class="form-group">
						<h4>PlaceName / mainCategory / subCategory </h4><br/>
						<label for="comment">Comment:</label>
						<textarea class="form-control" rows="5" id="comment" name="comment1"></textarea>
					</div>
				</div>
				<div class="col-sm-1"></div>
			</div>	
			<hr>
			
			<div class="row" id="place2">
				<div class="col-sm-1">
				<input type="hidden" value="" name="seoulSeq2">
				</div>
				<div class="col-sm-3" style="height: 300px">
					<img src="/img/trendseoul/noimg.png" data-toggle="modal" data-target="#moaModal" style="width: 100%; height:100%;">
				</div>
				<div class="col-sm-7" style="display: grid; align-items: center">
					<div class="form-group">
						<h4>장소명 / 카테고리1 / 카테고리2 </h4><br/>
						<label for="comment">Comment:</label>
						<textarea class="form-control" rows="5" id="comment" name="comment2"></textarea>
					</div>
				</div>
				<div class="col-sm-1"></div>
			</div>
			<hr>
			
			<div class="row" id="place3">
				<div class="col-sm-1">
				<input type="hidden" value="" name="seoulSeq3">
				</div>
				<div class="col-sm-3" style="height: 300px">
					<img src="/img/trendseoul/noimg.png" data-toggle="modal" data-target="#moaModal" style="width: 100%; height:100%;">
				</div>
				<div class="col-sm-7" style="display: grid; align-items: center">
					<div class="form-group">
						<h4>장소명 / 카테고리1 / 카테고리2 </h4><br/>
						<label for="comment">Comment:</label>
						<textarea class="form-control" rows="5" id="comment" name="comment3"></textarea>
					</div>
				</div>
				<div class="col-sm-1"></div>
			</div>
			<hr>
			
			<div class="row" id="place4">
				<div class="col-sm-1">
				<input type="hidden" value="" name="seoulSeq4">
				</div>
				<div class="col-sm-3" style="height: 300px">
					<img src="/img/trendseoul/noimg.png" data-toggle="modal" data-target="#moaModal" style="width: 100%; height:100%;">
				</div>
				<div class="col-sm-7" style="display: grid; align-items: center">
					<div class="form-group">
						<h4>장소명 / 카테고리1 / 카테고리2 </h4><br/>
						<label for="comment">Comment:</label>
						<textarea class="form-control" rows="5" id="comment" name="comment4"></textarea>
					</div>
				</div>
				<div class="col-sm-1"></div>
			</div>
			<hr>
			
			<div class="row" id="place5">
				<div class="col-sm-1">
				<input type="hidden" value="" name="seoulSeq5">
				</div>
				<div class="col-sm-3" style="height: 300px">
					<img src="/img/trendseoul/noimg.png" data-toggle="modal" data-target="#moaModal" style="width: 100%; height:100%;">
				</div>
				<div class="col-sm-7" style="display: grid; align-items: center">
					<div class="form-group">
						<h4>장소명 / 카테고리1 / 카테고리2 </h4><br/>
						<label for="comment">Comment:</label>
						<textarea class="form-control" rows="5" id="comment" name="comment5"></textarea>
					</div>
				</div>
				<div class="col-sm-1"></div>
			</div>
			
			<div class="row">
				<div class="col-sm-4"></div>
				<div class="col-sm-5"></div>
					<div class="col-sm-2">
						<button type="submit" class="btn btn-primary btn-block" style="margin-bottom : 20px; height: 50px">작성하기</button>
					</div>
				<div class="col-sm-1"></div>
			</div>
			
		</form>
			  
	<script type="text/javascript">
				
	////////////////////////////////// 비동기 처리 //////////////////////////////////////////////////////////////////////////
				
	$(document).ready(function () {
					
		initializePagination();
					
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
				            	
						// 서버에서 json 출력 데이터 업데이트 , 기존 데이터 empty 
						var subCategorySelect = $("select[name='subCategory']");
						subCategorySelect.empty(); 
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
				    	
				    	var btnValue = $(".select-button").attr("id");
				        var selectedseoulLocGu = $("select[name='seoulLocGu']").val();
				        var selectedMainCategory = $("select[name='mainCategory']").val();
				        var selectedsubCategory = $("select[name='subCategory']").val();
				        
				        console.log(btnValue);
				        console.log(selectedseoulLocGu);
				        console.log(selectedMainCategory);
				        console.log(selectedsubCategory);
				        
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
				                        var card = $("<div class='card'>");
				                        card.append("<div class='card-image'><img id='" + data[i].seoulSeq + "' src='" + data[i].firstImageUrl + "'alt=''></div>");
				                        card.append("<div class='card-info'><p>" + data[i].mainCategory + "/" + data[i].subCategory + "</p><h4>" + data[i].seoulTitle + "</h4></div>");
				                        card.append("<div class='buttons'><button class='select-button' id='" + btnValue + "' data-dismiss='modal'>선택하기</button><button onclick='openNewWindow(" + data[i].seoulSeq + ")'>상세보기</button></div></div>");


				                        cardContent.append(card);
				                    }

				                    initializePagination();
				                    selectedPlace();
				                    
				                } else {
				                    alert("검색 결과가 없습니다");
				                }
				            },
				            error: function (error) {
				                console.log("Error:", error);
				            }
				        });
				        
				    });
				    
				    selectedPlace();

				});
		
				
				// x (닫기) 를 눌렀을때 데이터 , 페이징 처리 초기화
				document.querySelector('.close[data-dismiss="modal"]').addEventListener('click', function() {
					
					initializeList();
				    
				    initializePagination();
				});
				
				// 해당 링크로 이동하는 함수
				function openNewWindow(seoulSeq) {
					
					var language = '${language}';
					
					console.log(language);
					
			        var url = '/'+language+'/trend_view.do?seoulSeq=' + seoulSeq;
			        
			        console.log(url);
			        
			        window.open(url, '_blank');
			    }
				
				// Ajax 비동기 출력 데이터 초기화 함수
				function initializeList(){
					
					var selectedseoulLocGu = "";
			        var selectedMainCategory = "";
			        var selectedsubCategory = "";

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

			                    var cardContent = $(".top5container .card-content");
			                    cardContent.empty();

			                    for (var i = 0; i < data.length; i++) {
			                        var card = $("<div class='card'>");
			                        card.append("<div class='card-image'><img id='" + data[i].seoulSeq + "' src='" + data[i].firstImageUrl + "'alt=''></div>");
			                        card.append("<div class='card-info'><p>" + data[i].mainCategory + "/" + data[i].subCategory + "</p><h4>" + data[i].seoulTitle + "</h4></div>");
			                        card.append("<div class='buttons'><button class='select-button' id='' data-dismiss='modal'>선택하기</button><button onclick='openNewWindow(" + data[i].seoulSeq + ")'>상세보기</button></div></div>");

			                        
			                        
			                        cardContent.append(card);
			                    }
			                    
			                 	// 각 선택 요소의 값을 첫 번째 옵션 값으로 설정
			                    $('select[name="seoulLocGu"]').val($('select[name="seoulLocGu"] option:first').val());
			                    $('select[name="mainCategory"]').val($('select[name="mainCategory"] option:first').val());
			                    $('select[name="subCategory"]').val($('select[name="subCategory"] option:first').val());

			                    initializePagination();
			                    
			                    selectedPlace();

			            },
			            error: function (error) {
			                console.log("Error:", error);
			            }
			        });
					
				}
				
				// modal에서 선택한 데이터를 넘겨받는 함수
				function selectedPlace(){
					
					$(".row .col-sm-3 img").on("click", function () {

				        var card = $(this).closest(".row");
				        var placeId = card.attr("id");

				        // 출력 확인을 위한 콘솔 로그
				        console.log("Place ID: " + placeId);

				        // 모달 안의 버튼에 place1 아이디 값을 넣어줌
				        $("#moaModal .select-button").attr("id", placeId);
				    });
					
					$(".select-button").click(function() {
						// Find the parent card element
					    var card = $(this).closest('.card');
					    var modalId = 'moaModal';

					    var seoulSeq = card.find('img').attr('id');
					    var imageUrl = card.find('img').attr('src');
					    var mainCategory = card.find('.card-info p').text();
					    var subCategory = mainCategory.split('/')[1].trim();
					    mainCategory = mainCategory.split('/')[0].trim();
					    var title = card.find('.card-info h4').text();
					    var buttonId = $(this).attr('id');
					    
					    

					    console.log("seoulSeq: " + seoulSeq);
					    console.log("firstImageUrl: " + imageUrl);
					    console.log("mainCategory: " + mainCategory);
					    console.log("subCategory: " + subCategory);
					    console.log("seoulTitle: " + title);
					    console.log("buttonId: " + buttonId);
					    
			            if (buttonId === "place1") {
			            	
			            	$("#place1 input").attr("value", seoulSeq);
			                $('#place1 img').attr("src", imageUrl);
			                $('#place1 h4').text(title + " / " + mainCategory + " / " + subCategory);
			                
			                
			            } else if (buttonId === "place2") {
			            	
			            	$("#place2 input").attr("value", seoulSeq);
			            	$('#place2 img').attr("src", imageUrl);
			                $('#place2 h4').text(title + " / " + mainCategory + " / " + subCategory);


			            }else if(buttonId ==="place3"){
			            	
			            	$("#place3 input").attr("value", seoulSeq);
			            	$('#place3 img').attr("src", imageUrl);
			                $('#place3 h4').text(title + " / " + mainCategory + " / " + subCategory);


			            }else if(buttonId ==="place4"){
			            	
			            	$("#place4 input").attr("value", seoulSeq);
			            	$('#place4 img').attr("src", imageUrl);
			                $('#place4 h4').text(title + " / " + mainCategory + " / " + subCategory);


			            }else if(buttonId ==="place5"){
			            	
			            	$("#place5 input").attr("value", seoulSeq);
			            	$('#place5 img').attr("src", imageUrl);
			                $('#place5 h4').text(title + " / " + mainCategory + " / " + subCategory);
			                

			            }else{
			            	
			            }
			            
			            initializeList();

			        });
 
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
			
			</script>
		
		<jsp:include page="/WEB-INF/views/includes/footer.jsp"></jsp:include>
		
	</body>
</html>