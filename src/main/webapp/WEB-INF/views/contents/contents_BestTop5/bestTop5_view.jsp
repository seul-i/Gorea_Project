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
    <link rel="stylesheet" type="text/css" href="/css/Top5/top5view.css">
    
    <script src="https://use.fontawesome.com/releases/v5.2.0/js/all.js"></script>
	<title>Gorea_BestTop5</title>

	<script type="text/javascript">

	</script>

</head>

<body>
	<jsp:include page="/WEB-INF/views/includes/header${language}.jsp"></jsp:include>

	<div class="commonBanner" id="comBanner">
        <img src="/img/banner/Top5Banner.jpg" alt="banner">
        <div class="commonBanner-text">
            <h1>Best Top5</h1>
        </div>
    </div>
    
    <!-- 모달 ---------------------------------------------------------->
    
	<div class="top5viewContainer">
				
		<div class="top5viewContent">
		
		<div>
			<span> 2024.01.22 </span>
		</div>
			<h2>- 장소 타이틀1 -</h2>
			<img src="" class="viewContentImg">
			<div id="comment" class="comment1">
				'인생에는 적극적인 의미의 즐거움, 행복이란 것이 존재하지 않는다.
				다만 고통과 권태가 있을 뿐이다.
				파티와 구경거리와 흥분되는 일들로 가득차 보이는 세상살이도
				그 이면의 실상을 알고 보면 고통과 권태 사이를 왔다갔다 하는
				단조로운 시계추의 운동과 다를 바 없는 것이다.
				세상의 사이비 강단 철학자들은 인생에 진정한 행복과 희망과 가치와
				보람이 있는 것처럼 열심히 떠들어대지만 나의 철학은 그러한 행복은
				존재하지 않는다는 것을 명확히 가르침으로써 사람들로 하여금 더 큰
				불행에 빠지지 않도록 하려는 것을 그 사명으로 한다.
				인생에는 다만 고통이 있을 뿐이다.
				가능한 한 그러한 고통을 피해가는 것이 삶의 지혜이고 예지이다.
				그러므로 고통의 일시적 부재인 소극적 의미의 행복만이 인생에
				주어질 수 있는 최상의 것이고, 현자의 도리는 바로 그러한 소극적
				행복만을 추구하는 것이다.'
			</div>
			<label> [ 구로구 ] 쇼핑/ 장소 </label>
			<div class="top5Map">
			</div>			
		<hr/>
			<h2>장소 타이틀1</h2>
			<img src="" alt="">
			<div id="comment" class="comment1">
				'인생에는 적극적인 의미의 즐거움, 행복이란 것이 존재하지 않는다.
			</div>
			<label> [ 구로구 ] 쇼핑/ 장소 </label>
			<div class="top5Map">
			</div>
		<hr/>
		
		</div>
	</div>
			
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