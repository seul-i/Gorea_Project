<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Welcome Vist Go!rea</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" type="text/css" href="/css/intro/intro.css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<!-- 1.한국,영어 2.일본어,중국어 -->
<link href="https://fonts.googleapis.com/css2?family=Gowun+Dodum&family=Noto+Sans+KR&family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=ZCOOL+XiaoWei&family=Zen+Kaku+Gothic+New&display=swap" rel="stylesheet">

</head>
<body>

	<c:if test="${!empty AccessDeniedMsg }">
		<script type="text/javascript">
			const msg = "${AccessDeniedMsg}";
		</script>
	</c:if>
	
	<!-- header -->
    <header>
        <div class="logo">Go!rea.World</div>
        <ul class="menu">

        </ul>
        <div class="search">
        </div>
    </header>

    <!-- slider -->

    <div class="slider">
        <!-- list Items -->
        <div class="list">
            <div class="item active">
                <img src="/img/intro/img1.jpg">
                <div class="content kr-font">
                    <p>한국어</p>
                    <h2>반갑습니다</h2>
                    <p>
                        Go!rea 는 GO+KOREA를 합친 합성어로서, <br/>
                        '한국에 가자'라는 의미를 담고 있습니다.<br/>
						급격하게 변하고 있는 트렌드 여행지를 제공하여 명동, 동대문, 종로 등 한정된 여행지보다 
						더 많은 장소를 제공하는 것이 우리의 목표입니다.<br/>
						사이트를 방문해 외국인 친구들과 소통하고 다양한 장소를 제공해주세요!<br/><br/>
						<a href="./korean/main.do" class="gomain">이동하기</a>
<!-- 						사이트를 방문해 더많은 장소를 제공받으세요! -->
                    </p>
                </div>
            </div>
            <div class="item">
                <img src="/img/intro/img2.jpg">
                <div class="content en-font">
                    <p>English</p>
                    <h2>Welcome</h2>
                    <p>
                        "Go!rea" invites you to explore beyond the usual tourist spots like Myeongdong, Dongdaemun, Jongno, and more. 
                        Discover trending travel destinations in Korea that are constantly evolving. 
                        Visit our website for a diverse range of locations and experience the latest travel trends!<br/><br/>
						<a href="./english/main.do" class="gomain">Go</a>
						
                    </p>
                </div>
            </div>
            <div class="item">
                <img src="/img/intro/img3.jpg">
                <div class="content jp-font">
                    <p>日本語</p>
                    	<h2>ようこそ</h2>
                    	<p>
                        "Go!rea"は「GO」と「KOREA」を組み合わせた造語で,「韓国に行こう」という意味が込められています。
                        私たちの目標は急速に変化しているトレンドの旅行先を提供し,明洞、東大門,鍾路などの限られた観光地よりもより多くの場所を提供することです。
						ウェブサイトを訪れて,さらに多くの場所を探索し,進化する旅行トレンドを体験してください！<br/><br/>
							<a href="./japanese/main.do" class="gomain">이동하기</a>
                    	</p>
                </div>
            </div>
            <div class="item">
                <img src="/img/intro/img4.jpg">
                <div class="content chn-font">
                    <p>中國語</p>
                    <h2>欢迎光临</h2>
                    <p>
						"Go!rea"是将“GO”和“KOREA”结合在一起的混成词，传达了“让我们去韩国”的意思。
						我们的目标是提供快速变化的热门旅行目的地，比明洞、东大门、钟路等有限的旅游胜地提供更多选择。<br/>
						访问我们的网站，探索更多地方，体验不断变化的旅行趋势吧！<br/><br/>
						<a href="./chinese/main.do" class="gomain">이동하기</a>
                    </p>
                </div>
            </div>
        </div>
        <!-- button arrows -->
        <div class="arrows">
            <button id="prev"></button>
            <button id="next"></button>
        </div>
        <!-- thumbnail -->
        <div class="thumbnail">
            <div class="item active">
                <img src="/img/intro/kr.png">
            </div>
            <div class="item">
                <img src="/img/intro/en.png">
            </div>
            <div class="item">
                <img src="/img/intro/jp.png">
            </div>
            <div class="item">
                <img src="/img/intro/ch.png">
            </div>
<!--             <div class="item"> -->
<!--                 <img src="image/img5.jpg"> -->
<!--                 <div class="content"> -->
<!--                     Name Slider -->
<!--                 </div> -->
<!--             </div> -->
        </div>
    </div>


	<script type="text/javascript" src="/js/intro/intro.js"></script>
</body>
</html>