<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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

<link rel="stylesheet" type="text/css" href="/css/main/main_content.css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://cdn.jsdelivr.net/npm/remixicon@4.1.0/fonts/remixicon.css" rel="stylesheet" />

<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css">   

<title>Go!rea Main</title>

</head>

<body>

   <jsp:include page="/WEB-INF/views/includes/header${language}.jsp"></jsp:include>
   
   <!-- 메인 슬라이더 베너 영역 -->
   <div class="carousel slide" id="carouselDemo" data-bs-wrap="true" data-bs-ride="carousel">
      <div class="carousel-inner">
         <div class="carousel-item active" data-bs-interval="3000">
            <img src="/img/main/DDP.jpg" class="w-100">
            <div class="carousel-caption">
               <c:choose>
                        <c:when test="${language eq 'korean'}">서울로 떠나는 특별한 순간을 만나보세요!</c:when>
                        <c:when test="${language eq 'english'}">Meet special moments in Seoul!</c:when>
                        <c:when test="${language eq 'japanese'}">特別な瞬間をソウルで体験してください！</c:when>
                        <c:when test="${language eq 'chinese'}">在首尔度过特别的时刻！</c:when>
                    </c:choose>
               </div>
         </div>

           <div class="carousel-item " data-bs-interval="3000">
               <img src="/img/main/banner1.jpg" class="w-100">
               <div class="carousel-caption">
               <c:choose>
                        <c:when test="${language eq 'korean'}">서울로 떠나는 특별한 순간을 만나보세요!</c:when>
                        <c:when test="${language eq 'english'}">Meet special moments in Seoul!</c:when>
                        <c:when test="${language eq 'japanese'}">特別な瞬間をソウルで体験してください！</c:when>
                        <c:when test="${language eq 'chinese'}">在首尔度过特别的时刻！</c:when>
                    </c:choose>
               </div>
           </div>

           <div class="carousel-item " data-bs-interval="3000">
               <img src="/img/main/banner2.jpg" class="w-100">
               <div class="carousel-caption">
               <c:choose>
                        <c:when test="${language eq 'korean'}">서울로 떠나는 특별한 순간을 만나보세요!</c:when>
                        <c:when test="${language eq 'english'}">Meet special moments in Seoul!</c:when>
                        <c:when test="${language eq 'japanese'}">特別な瞬間をソウルで体験してください！</c:when>
                        <c:when test="${language eq 'chinese'}">在首尔度过特别的时刻！</c:when>
                    </c:choose>
               </div>
         </div>
       </div>

       <button class="carousel-control-prev" type="button" data-bs-target="#carouselDemo" data-bs-slide="prev">
           <span class="carousel-control-prev-icon"></span>
       </button>
   
       <button class="carousel-control-next" type="button" data-bs-target="#carouselDemo" data-bs-slide="next">
          <span class="carousel-control-next-icon"></span>
      </button>
   </div>
   
   <!-- 에디터 추천 여행 & 꿀팁 영역 -->
   <div class="section_title">
      <c:choose>
          <c:when test="${language eq 'korean'}">
              <h2>에디터의 서울 이야기</h2>
          </c:when>
          
          <c:when test="${language eq 'english'}">
              <h2>Editor's Seoul Story</h2>
          </c:when>
          
          <c:when test="${language eq 'japanese'}">
              <h2>編集者のソウル物語</h2>
          </c:when>
          
          <c:when test="${language eq 'chinese'}">
              <h2>编辑的灵魂故事</h2>
          </c:when>
      </c:choose>
      
      <h5> "Click the page to check it out" </h5>
   </div>

   <div class="buttons-container">
      <c:choose>
          <c:when test="${language eq 'korean'}">
              <button>에디터의 추천 장소</button>
              <button>에디터의 팁</button>
          </c:when>
          
          <c:when test="${language eq 'english'}">
              <button>Editor Pick</button>
              <button>Editor Tip</button>
          </c:when>
          
          <c:when test="${language eq 'japanese'}">
              <button>エディタ推薦場所</button>
              <button>エディターのおすすめのコツ</button>
          </c:when>
          
          <c:when test="${language eq 'chinese'}">
              <button>编辑推荐场所</button>
              <button>编辑推荐秘诀</button>
          </c:when>
      </c:choose>
   </div>
   
   
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
                        <strong>
                        <c:choose>
                          <c:when test="${language eq 'korean'}">디스커버서울패스 활용하기</c:when>
                            <c:when test="${language eq 'english'}">Discover Seoul Pass Usage</c:when>
                            <c:when test="${language eq 'japanese'}">ディスカバーソウルパスの利用方法</c:when>
                            <c:when test="${language eq 'chinese'}">发现首尔通的使用方法</c:when>
                         </c:choose>
                      </strong>
                    </div>
               </li>
               
               <li class="image-item">
                  <div class="image-content">
                       <img src="/img/main/ddareung.jpg" alt="img-2">
                        <strong>
                        <c:choose>
                            <c:when test="${language eq 'korean'}">따릉이 이용하기</c:when>
                            <c:when test="${language eq 'english'}">Using Seoul Bike (Ddareungi)</c:when>
							<c:when test="${language eq 'japanese'}">自転車（따릉이）の利用方法</c:when>
                            <c:when test="${language eq 'chinese'}">使用首尔自行车</c:when>
                        </c:choose>
                       </strong>
                    </div>
               </li>
               
               <li class="image-item">
                  <div class="image-content">
                   <img src="/img/main/discover.jpg" alt="img-3">
                    <strong>
                        <c:choose>
                          <c:when test="${language eq 'korean'}">디스커버서울패스 활용하기</c:when>
                            <c:when test="${language eq 'english'}">Discover Seoul Pass Usage</c:when>
                            <c:when test="${language eq 'japanese'}">ディスカバーソウルパスの利用方法</c:when>
                            <c:when test="${language eq 'chinese'}">发现首尔通的使用方法</c:when>
                         </c:choose>
                      </strong>
                    </div>
               </li>
            </ul>
            
            <button id="next-slide" class="slide-button material-symbols-rounded">
               <i class="fa-solid fa-arrow-right"></i>
            </button>
            </div>
            
            <div class="slider-scrollbar">
                <div class="scrollbar-track">
                  <div class="scrollbar-thumb">
               </div>
               
         </div>
      </div>
   </div>
   </div>
   
   <!-- 중앙 배너 -->
   <section class="banner_container">
		<div class="section_container">
         <div class="banner_content">
            <h2 style="font-weight: bold">
		    	<c:choose>
			        <c:when test="${language eq 'korean'}">서울 어디로 가야할까?</c:when>
			        <c:when test="${language eq 'english'}">Where to Go in Seoul?</c:when>
			        <c:when test="${language eq 'japanese'}">ソウル、どこに行くべきか？</c:when>
			        <c:when test="${language eq 'chinese'}">首尔去哪里？</c:when>
			    </c:choose>
			</h2>

			    <c:choose>
			        <c:when test="${language eq 'korean'}">
			          <p>
			           서울은 동서남북으로 다양한 매력이 넘치는 도시입니다. <br>
			           전통 마을인 한옥마을에서는 고요한 아름다움이 펼쳐지며 <br> 
			           도심 속 낭만을 느낄 수 있는 남산 서울타워는 반드시 방문해야 할 명소입니다. <br>
			           현대적인 상업지구 강남에서는 최신 트렌드를 경험하며, <br>
			           인사동의 예술과 역사로 가득한 곳에서는 독특한 문화를 만날 수 있습니다. <br>
			           한강을 따라 자전거를 타거나 산책하며 자연 속에서 시간을 보내는 것도 추천합니다. <br>
			           역사적인 장소를 탐험하며 서울의 다양한 얼굴을 발견해보세요! <br>
			       </p>
			      </c:when>
			
			      <c:when test="${language eq 'english'}">
			        <p>
			           Seoul is a city full of diverse charms from east to west, north to south. <br>
			              The quiet beauty unfolds in the traditional Hanok Village <br>
			           Namsan Seoul Tower, where you can feel the romance in the city, is a must-visit attraction. <br>
			              Experience the latest trends in Gangnam, a modern commercial district, <br>
			           In Insa-dong, a place full of art and history, you can experience a unique culture. <br>
			           We also recommend spending time in nature by biking or walking along the Han River. <br>
			           Discover the many faces of Seoul as you explore historical places! <br>
			        </p>
			      </c:when>
			
			      <c:when test="${language eq 'japanese'}">
			        <p>
			           ソウルは東西南北で様々な魅力が溢れる都市です。 <br>
			              伝統的な村の韓屋村では静かな美しさが広がっています。
			            都心の中でロマンを感じられる南山ソウルタワーは、必ず訪れるべきスポットです。 <br>
			            近代的な商業地区江南では最新のトレンドを体験しています。
			            仁寺洞の芸術と歴史に満ちた場所では、ユニークな文化に出会うことができます。 <br>
			            漢江に沿って自転車に乗ったり散歩したり、自然の中で時間を過ごすのもおすすめです。 <br>
			            歴史的な場所を探索し、ソウルの様々な顔を発見！ <br>
			        </p>
			      </c:when>
			
			      <c:when test="${language eq 'chinese'}">
			          <p>
			              首尔是一座从东到西、从北到南都充满多样魅力的城市。 <br>
			             传统韩屋村的静谧之美<br>
			           南山首尔塔是您必去的景点，在这里您可以感受到城市的浪漫。 <br>
			            体验现代商业区江南的最新潮流，<br>
			           在仁寺洞这个充满艺术和历史的地方，你可以体验到独特的文化。 <br>
			           我们还建议您骑自行车或沿着汉江散步，在大自然中度过美好时光。 <br>
			           当您探索历史名胜时，发现首尔的方方面面！ <br>
			          </p>
			      </c:when>
				</c:choose>
			</div>
		</div>
	</section>
   
   
   <!-- 서울명소 , 데이터 출력시 6개 -->
   <section class="journey_container">
    <div class="section_container">
        <h2 class="section_title" style="font-weight: 500">
            <c:choose>
                <c:when test="${language eq 'korean'}">서울의 대표적인 명소</c:when>
                <c:when test="${language eq 'english'}">Representative Places in Seoul</c:when>
                <c:when test="${language eq 'japanese'}">ソウルの代表的な観光地</c:when>
                <c:when test="${language eq 'chinese'}">首尔的代表性景点</c:when>
            </c:choose>
        </h2>

        <p class="section_subtitle">The most searched places</p>

        <div class="journey_grid">
            <div class="country_card">
                <div class="overlay">
                    <i class="ri-map-pin-2-fill"></i> 
                    <span>
                        <c:choose>
                            <c:when test="${language eq 'korean'}">광장시장</c:when>
                            <c:when test="${language eq 'english'}">Gwangjang Market</c:when>
                            <c:when test="${language eq 'japanese'}">広場市場</c:when>
                            <c:when test="${language eq 'chinese'}">广场市场</c:when>
                        </c:choose>
                    </span>
                </div>
                <img src="/img/main/gwangjang.jpg" alt="country" />
            </div>

            <div class="country_card">
                <div class="overlay">
                    <i class="ri-map-pin-2-fill"></i> 
                    <span>
                        <c:choose>
                            <c:when test="${language eq 'korean'}">광화문 광장</c:when>
                            <c:when test="${language eq 'english'}">Gwanghwamun Square</c:when>
                            <c:when test="${language eq 'japanese'}">光化門広場</c:when>
                            <c:when test="${language eq 'chinese'}">光化门广场</c:when>
                        </c:choose>
                    </span>
                </div>
                <img src="/img/main/gwanghwamun.jpg" alt="country" />
            </div>

            <div class="country_card">
                <div class="overlay">
                    <i class="ri-map-pin-2-fill"></i> 
                    <span>
                        <c:choose>
                            <c:when test="${language eq 'korean'}">경복궁</c:when>
                            <c:when test="${language eq 'english'}">Gyeongbokgung Palace</c:when>
                            <c:when test="${language eq 'japanese'}">景福宮</c:when>
                            <c:when test="${language eq 'chinese'}">景福宫</c:when>
                        </c:choose>
                    </span>
                </div>
                <img src="/img/main/gyeongbokgung.jpg" alt="country" />
            </div>
        </div>
    </div>
</section>
   

   <!-- 여행 정보 -->
	<h2 class="section_title" style="font-weight: 500">
		<c:choose>
	        <c:when test="${language eq 'korean'}">여행 정보</c:when>
	        <c:when test="${language eq 'english'}">Travel Information</c:when>
	        <c:when test="${language eq 'japanese'}">旅行情報</c:when>
	        <c:when test="${language eq 'chinese'}">旅行信息</c:when>
		</c:choose>
	</h2>
	<div>
    <ul class="icons">
        <li>
            <div class="icon_img">
                <img src="/img/main/weather.png">
            </div>
            <div class="contents1_bold">
                <c:choose>
                    <c:when test="${language eq 'korean'}">날씨 정보</c:when>
                    <c:when test="${language eq 'english'}">Weather Information</c:when>
                    <c:when test="${language eq 'japanese'}">天気情報</c:when>
                    <c:when test="${language eq 'chinese'}">天气信息</c:when>
                </c:choose>
            </div>
            <button class="more">MORE</button>
        </li>

        <li>
            <div class="icon_img">
                <img src="/img/main/traffic.png">
            </div>
            <div class="contents1_bold">
                <c:choose>
                    <c:when test="${language eq 'korean'}">교통 정보</c:when>
                    <c:when test="${language eq 'english'}">Traffic Information</c:when>
                    <c:when test="${language eq 'japanese'}">交通情報</c:when>
                    <c:when test="${language eq 'chinese'}">交通信息</c:when>
                </c:choose>
            </div>
            <button class="more">MORE</button>
        </li>

        <li>
            <div class="icon_img">
                <img src="/img/main/exchange_rate.png">
            </div>
            <div class="contents1_bold">
                <c:choose>
                    <c:when test="${language eq 'korean'}">환율 정보</c:when>
                    <c:when test="${language eq 'english'}">Exchange Rate Information</c:when>
                    <c:when test="${language eq 'japanese'}">為替レート情報</c:when>
                    <c:when test="${language eq 'chinese'}">汇率信息</c:when>
                </c:choose>
            </div>
            <button class="more">MORE</button>
        </li>

        <li>
            <div class="icon_img">
                <img src="/img/main/quarantine.png">
            </div>
            <div class="contents1_bold">
                <c:choose>
                    <c:when test="${language eq 'korean'}">방역 정보</c:when>
                    <c:when test="${language eq 'english'}">Quarantine Information</c:when>
                    <c:when test="${language eq 'japanese'}">検疫情報</c:when>
                    <c:when test="${language eq 'chinese'}">防疫信息</c:when>
                </c:choose>
            </div>
            <button class="more">MORE</button>
        </li>
    </ul>
	</div>
   
   
   <script type="text/javascript" src="../../js/main.js"></script>
   <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.min.js"></script>
   
   <jsp:include page="/WEB-INF/views/includes/footer.jsp"></jsp:include>
</body>
</html>