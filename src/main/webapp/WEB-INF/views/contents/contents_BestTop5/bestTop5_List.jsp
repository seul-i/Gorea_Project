<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:set var="language" value="${language}" />

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="robots" content="index, follow, max-image-preview:large, max-snippet:-1, max-video-preview:-1">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
   	<script src="http://ajax.aspnetcdn.com/ajax/jQuery/jquery-1.12.4.min.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-Fy6S3B9q64WdZWQUiU+q4/2Lc9npb8tCaSX9FK7E8HnRr0Jz8D6OP9dO5Vg3Q9ct" crossorigin="anonymous"></script>
		
    <!-- 내가 변경한 css가 밑에있어야함 -->
    <link rel="stylesheet" type="text/css" href="/css/Top5/top5list.css">
    
    <script src="https://use.fontawesome.com/releases/v5.2.0/js/all.js"></script>
	<title>Gorea_BestTop5</title>

	<script type="text/javascript">
		// JavaScript로 클릭 이벤트 처리
		document.addEventListener("DOMContentLoaded", function() {
		    var searchLinks = document.querySelectorAll('.top5List-searchbox a');
		
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
			
		    
		    
		    $(document).ready(function () {
		    	
		    	document.getElementById('writeButton').addEventListener('click', function() {
		      		if (!("${not empty SPRING_SECURITY_CONTEXT}" == "true")) {
		            	alert("로그인이 필요합니다. 로그인 페이지로 이동합니다.");
		            	window.location.href = "/${language}/login.do";
		            		 
		       		}else{
		       			window.location.href = "/${language}/bestTop5_write.do";
					}
				});
		    	
		    	$('.carousel-inner').on('click', function() {
		      		if (!("${not empty SPRING_SECURITY_CONTEXT}" == "true")) {
		            	alert("로그인이 필요합니다. 로그인 페이지로 이동합니다.");
		            	window.location.href = "/${language}/login.do";
		            		 
		       		}else{
		       			var Top5Seq = $(this).data('seq');
		       			console.log(Top5Seq);
		       			window.location.href = "/${language}/bestTop5_view.do";
					}
				});
		    	
		    });
		    
		    // 달력 초기화 과정 ///////////////
		    var currentDate = new Date();
	
		    // 년도와 월을 YYYY-MM 형식으로 만들기
		    var currentYear = currentDate.getFullYear();
		    var currentMonth = ('0' + (currentDate.getMonth() + 1)).slice(-2); // 월은 0부터 시작하므로 1을 더하고 두 자리로 만듭니다.
	
		    // 초기값 설정
		    document.getElementById('start').value = currentYear + '-' + currentMonth;
		    
		});
	</script>

</head>

<body>
	<jsp:include page="/WEB-INF/views/includes/header${language}.jsp"></jsp:include>

	<!-- 배너 부분 -->
	<div class="commonBanner" id="comBanner">
        <img src="/img/banner/Top5Banner.jpg" alt="banner">
        <div class="commonBanner-text">
            <h1>Best Top5</h1>
        </div>
    </div>
	
	<!-- 메인 컨텐츠 부분 ------------------------------------------------->
	<div class="BestTop3place">
		<div class="BestTop3Month">
			<h1>This Month's Best 3</h1>
			<input type="month" id="start" name="start" min="2023-12" value="2024-01" />
		</div>
		
		<div class="BestTop3Imgbox">
			<div class="rank2">
				<img src="/img/nation-icon/nation-wr.png">
					<div class="ranktxt">
						<p>title 들어갈곳</p>
						<i class="fa-solid fa-crown 2nd" style="color:#bdbcb0"></i>
						<p>2nd</p>
					</div>
			</div>
			<div class="rank1">
				<img src="/img/nation-icon/nation-wr.png">
					<div class="ranktxt">
						<p>title 들어갈곳</p>
						<i class="fa-solid fa-crown 1st" style="color:#ffe307"></i>
						<p>1st</p>
					</div>
			</div>
			<div class="rank3">
				<img src="/img/nation-icon/nation-wr.png">
					<div class="ranktxt">
						<p>title 들어갈곳</p>
						<i class="fa-solid fa-crown 3rd" style="color:#A47C5D"></i>
						<p>3rd</p>
					</div>
			</div>
		</div>
	</div>
	
	<div class="top5List-search">
		<div class="top5List-searchbox">
		 	<a href="/${language}/bestTop5.do" class="active">최신순</a>
		 	<a href="/${language}/bestTop5_PS.do">인기순</a>
			 <form id="myForm" action="/{language}/bestTop5_NS.do" method="GET">
				<select name="nation" id="nationSelect" style="margin-right:20px" onchange="submitForm()">
					<option value="전체" selected>All</option>
	        		<option value="대한민국">한국인</option>
	        		<option value="미국">American</option>
	        		<option value="일본">日本人</option>
	        		<option value="중국">中国人</option>
	        		<option value="기타국가">Etc</option>
    			</select>
			</form>
			<button type="button" class="btn btn-primary" id="writeButton">
				글 작성하기
			</button>
		</div>
	</div>
	
	<c:forEach var="top5ListData" items="${boardList}">
		<div>
			<div class="top5List-container">
				<div class="carousel slide" id="carouselDemo${top5ListData.top5Seq}" data-bs-wrap="true">

					<div class='top5Icons' id='likeButton'>
						<div style="display: flex; justify-content: center; margin-bottom:10px;">
							<c:if test="${top5ListData.userNation eq '대한민국'}">
								<img src="/img/nation-icon/nation-kr.png" alt="">
							</c:if>
							<c:if test="${top5ListData.userNation eq '미국'}">
								<img src="/img/nation-icon/nation-en.png" alt="">
							</c:if>
							<c:if test="${top5ListData.userNation eq '일본'}">
								<img src="/img/nation-icon/nation-jp.png" alt="">
							</c:if>
							<c:if test="${top5ListData.userNation eq '중국'}">
								<img src="/img/nation-icon/nation-chn.png" alt="">
							</c:if>
							<c:if test="${top5ListData.userNation eq '기타국가' || empty top5ListData.userNation}}">
								<img src="/img/nation-icon/nation-wr.png" alt="">
							</c:if>
						</div>
						<div style="display: flex; justify-content: center; margin-bottom:10px;">
							<i class='fa fa-star-o fa-2x' style='color: grey;'></i>
							<i class='fa fa-star fa-2x' style='color: #fff23f;'></i>
						</div>
					</div>
					
					<div class="carousel-inner" data-seq="${top5ListData.top5Seq}">
						<div class="carousel-item active">
							<img src="${top5ListData.firstImageUrl1}">
					            <div class="carousel-caption">
					                <h1>01</h1>
					                <h4>'${top5ListData.userNickname}'의 <br/>추천장소</h4>
					                <h5>${top5ListData.seoulTitle1}</h5>
					                <p>[${top5ListData.seoulLocGu1}] ${top5ListData.mainCategory1}/${top5ListData.subCategory1}</p>
					                <span> 1/5 </span>
					            </div>
					        </div>
					
					        <div class="carousel-item">
					            <img src="${top5ListData.firstImageUrl2}">
					            <div class="carousel-caption">
					                <h1>02</h1>
					                <h4>'${top5ListData.userNickname}'추천장소</h4>
					                <h5>${top5ListData.seoulTitle2}</h5>
					                <p>[${top5ListData.seoulLocGu2}] ${top5ListData.mainCategory2}/${top5ListData.subCategory2}</p>
					                <span> 2/5 </span>
					            </div>
					        </div>
					
					        <div class="carousel-item">
					            <img src="${top5ListData.firstImageUrl3}">
					            <div class="carousel-caption">
					                <h1>03</h1>
					                <h4>'${top5ListData.userNickname}'의 <br/>추천장소</h4>
					                <h5>${top5ListData.seoulTitle3}</h5>
					                <p>[${top5ListData.seoulLocGu3}] ${top5ListData.mainCategory3}/${top5ListData.subCategory3}</p>
					                <span> 3/5 </span>
					            </div>
					        </div>
					        
					        <div class="carousel-item">
					            <img src="${top5ListData.firstImageUrl4}">
					            <div class="carousel-caption">
					                <h1>04</h1>
					                <h4>'${top5ListData.userNickname}'의 <br/>추천장소</h4>
					                <h5>${top5ListData.seoulTitle4}</h5>
					                <p>[${top5ListData.seoulLocGu4}] ${top5ListData.mainCategory4}/${top5ListData.subCategory4}</p>
					                <span> 4/5 </span>
					            </div>
					        </div>
					        
					        <div class="carousel-item">
					            <img src="${top5ListData.firstImageUrl5}">
					            <div class="carousel-caption">
					                <h1>05</h1>
					                <h4>'${top5ListData.userNickname}'의 추천장소</h4>
					                <h5>${top5ListData.seoulTitle5}</h5>
					                <p>[${top5ListData.seoulLocGu5}] ${top5ListData.mainCategory5}/${top5ListData.subCategory5}</p>
								<span> 5/5 </span>
								</div>
							</div>
					</div>
				
				    <div class="carousel-indicators">
				        <button type="button" class="active" data-bs-target="#carouselDemo${top5ListData.top5Seq}" data-bs-slide-to="0">
				            <img src="${top5ListData.firstImageUrl1}" />
				        </button>
				
				        <button type="button" data-bs-target="#carouselDemo${top5ListData.top5Seq}" data-bs-slide-to="1">
				            <img src="${top5ListData.firstImageUrl2}" />
				        </button>
				
				        <button type="button" data-bs-target="#carouselDemo${top5ListData.top5Seq}" data-bs-slide-to="2">
				            <img src="${top5ListData.firstImageUrl3}" />
				        </button>
				        
				        <button type="button" data-bs-target="#carouselDemo${top5ListData.top5Seq}" data-bs-slide-to="3">
				            <img src="${top5ListData.firstImageUrl4}" />
				        </button>
				        
				        <button type="button" data-bs-target="#carouselDemo${top5ListData.top5Seq}" data-bs-slide-to="4">
				            <img src="${top5ListData.firstImageUrl5}" />
				        </button>
				    </div>
				    
				    <div style="height:50px; border-bottom: 1px solid #dbdbdb;">			    
				    </div>
				</div>
			</div>
		
			<div style="height:150px"></div>
		</div>
	</c:forEach>
	
	<script type="text/javascript">

	
    // language 값을 HTML 속성에 저장
    var language = "${language}";
    
    function submitForm() {
        var selectedValue = $("#nationSelect").val();
        
        if (selectedValue === "전체") {
            window.location.href = "/" + language + "/bestTop5.do";
        } else {
            window.location.href = "/" + language + "/bestTop5_NS.do?nation=" + encodeURIComponent(selectedValue);
        }
    }

    $(document).ready(function() {
    	
    	// 현재 URL에서 쿼리 문자열 가져오기
        var queryString = window.location.search;

        // 쿼리 문자열을 객체로 파싱
        var queryParams = new URLSearchParams(queryString);

        // 'nation' 파라미터의 값을 가져오기
        var nationValue = queryParams.get('nation');
        
		if(nationValue === null){
			$("#nationSelect").val("전체");
		} else{
			$("#nationSelect").val(nationValue);
		}
        // 서버에서 가져온 값으로 select를 선택
        
    });
	</script>
	
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.min.js"></script>
		
	<jsp:include page="/WEB-INF/views/includes/footer.jsp"></jsp:include>
	
</body>
</html>