<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="language" value="${language}" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="robots"
	content="index, follow, max-image-preview:large, max-snippet:-1, max-video-preview:-1">
<meta name="viewport" content="width=device-width, initial-scale=1">

<link rel="stylesheet" type="text/css" href="/css/main/Main.css">
<link rel="stylesheet" type="text/css" href="/css/main/main_content.css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://cdn.jsdelivr.net/npm/remixicon@4.1.0/fonts/remixicon.css"
	rel="stylesheet" />

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" integrity="sha512-ZdLyr5KIMQofg0YOxaxQ5ccpLl84e8Pk70j/CSpUJ+9qX8e9/BZj7tF0LxcOWpwmW1Q6GkO/tu96r+JXbxx8bA==" crossorigin="anonymous" referrerpolicy="no-referrer" />

<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css">	

<title>Go!rea Main</title>

<!--  
<script type="text/javascript" src="/js/main/jquery.min.js"></script>
<script type="text/javascript" src="/js/main/skel.min.js"></script>
<script type="text/javascript" src="/js/main/main.js"></script>
-->
</head>

<body>

	<jsp:include page="/WEB-INF/views/includes/header${language}.jsp"></jsp:include>
	
	<!--  
	<section class="banner half">
		<article>
			<img src="/img/main/DDP.jpg" width="100%">
			<div class="inner">
				<header>
					<h2 style="font-weight: bold;">동 대 문</h2>
				</header>
			</div>
		</article>

		<article>
			<img src="/img/main/gangnam.jpg" width="100%">
			<div class="inner">
				<header>
					<h2 style="font-weight: bold;">강 남</h2>
				</header>
			</div>
		</article>

		<article>
			<img src="/img/main/sungsu.jpg" alt="" width="100%">
			<div class="inner">
				<header>
					<h2 style="font-weight: bold;">성 수 동</h2>
				</header>
			</div>
		</article>

		<article>
			<img src="/img/main/gang.jpg" width="100%">
			<div class="inner">
				<header>
					<h2 style="font-weight: bold;">광 장 시 장</h2>
				</header>
			</div>
		</article>

		<article>
			<img src="/img/main/nowon.jpg" width="100%">
			<div class="inner">
				<header>
					<h2 style="font-weight: bold;">노 원</h2>
				</header>
			</div>
		</article>
	</section>
	-->
	
	<div class="carousel slide" 
		 id="carouselDemo"
		 data-bs-wrap="true" 
		 data-bs-ride="carousel">

    <div class="carousel-inner">

        <div class="carousel-item active">
            <img src="/img/main/DDP.jpg" class="w-100">
            
            <div class="carousel-caption">
               <h2 style="font-weight: bold;">서울로 떠나는 특별한 순간을 만나보세요!</h2>
            </div>
            
        </div>

        <div class="carousel-item " 
        data-bs-interval="3000">
            <img src="/img/main/gangnam.jpg" class="w-100">
            <div class="carousel-caption">
               <h2 style="font-weight: bold;">서울로 떠나는 특별한 순간을 만나보세요!</h2>
            </div>
        </div>

        <div class="carousel-item "
        data-bs-interval="3000">
            <img src="/img/main/sungsu.jpg" class="w-100">
            <div class="carousel-caption">
               <h2 style="font-weight: bold;">서울로 떠나는 특별한 순간을 만나보세요!</h2>
            </div>
        </div>
    </div>

    <button class="carousel-control-prev" 
    type="button"
    data-bs-target="#carouselDemo" 
    data-bs-slide="prev">
        <span class="carousel-control-prev-icon"></span>
    </button>

    <button class="carousel-control-next"
    type="button"
    data-bs-target="#carouselDemo"
    data-bs-slide="next">
    <span class="carousel-control-next-icon"></span>
</button>

</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.min.js"></script>
	
	<h2 class="section_title" style="font-weight: 500">에디터 꿀팁</h2>
	
  <div class="section_header">
	<div class="slide_container">
  <div class="slider-wrapper">
    <button id="prev-slide" class="slide-button material-symbols-rounded">
      <i class="fa-solid fa-arrow-left"></i>
    </button>
    <ul class="image-list">
      <li class="image-item">
        <div class="image-content">
          <img src="/img/main/discover.jpg" alt="img-1">
          <strong>디스커버서울패스 <br> 활용하기</strong>
        </div>
      </li>
      <li class="image-item">
        <div class="image-content">
          <img src="/img/main/ddareung.jpg" alt="img-2">
          <strong>따릉이 이용하기</strong>
        </div>
      </li>
      <li class="image-item">
        <div class="image-content">
          <img src="/img/main/discover.jpg" alt="img-3">
          <strong>디스커버서울패스 이용하기</strong>
        </div>
      </li>
      <li class="image-item">
        <div class="image-content">
          <img src="/img/main/ddareung.jpg" alt="img-4">
          <strong>따릉이 이용하기</strong>
        </div>
      </li>
      <li class="image-item">
        <div class="image-content">
          <img src="/img/main/discover.jpg" alt="img-5">
          <strong>디스커버서울패스 이용하기</strong>
        </div>
      </li>
      <li class="image-item">
        <div class="image-content">
          <img src="/img/main/ddareung.jpg" alt="img-6">
          <strong>따릉이 이용하기</strong>
        </div>
      </li>
      <!-- 나머지 이미지에 대한 내용 추가 -->
    </ul>
    <button id="next-slide" class="slide-button material-symbols-rounded">
      <i class="fa-solid fa-arrow-right"></i>
    </button>
  </div>
  <div class="slider-scrollbar">
    <div class="scrollbar-track">
      <div class="scrollbar-thumb"></div>
    </div>
  </div>
</div>
</div>

	<section class="banner_container">
		<div class="section_container">
			<div class="banner_content">
				<h2 style="font-weight: bold">축제 정보</h2>
				<p>
					서울에서 풍부한 다양성과 즐거움이 넘치는 다양한 축제들이 연중 진행되고 있습니다. <br> 봄의 화려한
					꽃축제부터 가을의 풍성한 먹거리 축제까지, 서울은 언제나 활기찬 행사들로 가득합니다. <br> 축제 일정 자세히
					보기를 클릭하면, 각 축제의 일정과 특별한 프로그램들을 확인할 수 있습니다. <br> 서울의 다양한 문화와
					먹거리를 즐기며 특별한 순간을 만들어보세요. 축제들이 여러분을 기다리고 있습니다!
				</p>
				<!-- <button>축제 일정 자세히 보기</button>  -->
			</div>
		</div>
	</section>

	<section class="journey_container">
		<div class="section_container">
			<h2 class="section_title" style="font-weight: 500">서울의 대표적인 명소</h2>
			<p class="section_subtitle">The most searched places</p>

			<div class="buttons-container">
				<button class="button">Button 1</button>
				<button class="button">Button 2</button>
			</div>

			<div class="journey_grid">
				<div class="country_card">
					<div class="overlay">
						<i class="ri-map-pin-2-fill"></i> <span>광장시장</span>
					</div>
					<img src="/img/main/gwangjang.jpg" alt="country" />
				</div>

				<div class="country_card">
					<div class="overlay">
						<i class="ri-map-pin-2-fill"></i> <span>광화문 광장</span>
					</div>
					<img src="/img/main/gwanghwamun.jpg" alt="country" />
				</div>

				<div class="country_card">
					<div class="overlay">
						<i class="ri-map-pin-2-fill"></i> <span>경복궁</span>
					</div>
					<img src="/img/main/gyeongbokgung.jpg" alt="country" />
				</div>

				<div class="country_card">
					<div class="overlay">
						<i class="ri-map-pin-2-fill"></i> <span>남산골한옥마을</span>
					</div>
					<img src="/img/main/hanok.jpg" alt="country" />
				</div>

				<div class="country_card">
					<div class="overlay">
						<i class="ri-map-pin-2-fill"></i> <span>롯데월드</span>
					</div>
					<img src="/img/main/lotteworld.jpg" alt="country" />
				</div>

				<div class="country_card">
					<div class="overlay">
						<i class="ri-map-pin-2-fill"></i> <span>국립중앙박물관</span>
					</div>
					<img src="/img/main/national_museum.jpg" alt="country" />
				</div>
			</div>
		</div>
	</section>

	<h2 class="section_title" style="font-weight: 500">여행 정보</h2>

		<ul class="icons">
			<li>

				<div class="icon_img">

					<img src="/img/main/weather.png">
				</div>
				<div class="contents1_bold">날씨 정보</div>

				<button class="more">MORE</button>
			</li>

			<li>

				<div class="icon_img">

					<img src="/img/main/traffic.png">
				</div>
				<div class="contents1_bold">교통 정보</div>

				<button class="more">MORE</button>
			</li>

			<li>

				<div class="icon_img">

					<img src="/img/main/exchange_rate.png">
				</div>
				<div class="contents1_bold">환율 정보</div>

				<button class="more">MORE</button>
			</li>

			<li>

				<div class="icon_img">

					<img src="/img/main/quarantine.png">
				</div>
				<div class="contents1_bold">방역 정보</div>

				<button class="more">MORE</button>
			</li>
		</ul>
	</div>


	<div class="test"
		style="border-bottom: 1px solid rgba(0, 0, 0, 0.15); height: 200px;">
	</div>

	<jsp:include page="/WEB-INF/views/includes/footer.jsp"></jsp:include>
</body>
</html>