<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<c:set var="language" value="${language}" />
<c:set var="googlemap" value="${googlemap}"/>
<c:set var="seq" value="${param.seoulSeq}" />
<c:set var="to" value="${requestScope.to}" />
<c:set var="userSeq" value="${SPRING_SECURITY_CONTEXT.authentication.principal.gorea_UserTO.userSeq}" />

<!DOCTYPE html>

<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>게시판 뷰</title>
    <link rel="stylesheet" type="text/css" href="/css/trendseoul/view.css">
    
    <c:choose>
    	<c:when test="${language eq 'korean'}">
    		 <script src="https://maps.googleapis.com/maps/api/js?key=${googlemap}&libraries=places&callback=initMap&language=ko" defer></script>
    	</c:when>
	    <c:when test="${language eq 'english'}">
	        <script src="https://maps.googleapis.com/maps/api/js?key=${googlemap}&libraries=places&callback=initMap&language=en" defer></script>
	    </c:when>
	    <c:when test="${language eq 'japanese'}">
	        <script src="https://maps.googleapis.com/maps/api/js?key=${googlemap}&libraries=places&callback=initMap&language=ja" defer></script>
	    </c:when>
	    <c:when test="${language eq 'chinese'}">
	        <script src="https://maps.googleapis.com/maps/api/js?key=${googlemap}&libraries=places&callback=initMap&language=zh-CN" defer></script>
	    </c:when>
	</c:choose>
    
    <script src="../../js/map.js"></script>
        <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.min.js"></script>
<script type="text/javascript" src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
    
    <script>
    document.addEventListener('DOMContentLoaded', function () {
        // HTML에서 class가 'star'인 모든 요소들을 가져옵니다.
        const stars = document.querySelectorAll('.star');

        // HTML에서 id가 'ratingInput'인 요소를 가져옵니다.
        const ratingInput = document.getElementById('ratingInput');

        // 각각의 별에 클릭 이벤트를 추가합니다.
        stars.forEach(star => {
            star.addEventListener('click', function () {
                // 클릭된 별의 데이터 속성인 'data-rating' 값을 가져와서 현재 별점으로 설정합니다.
                const rating = this.dataset.rating;

                // 별점 값을 'ratingInput' input 요소의 값으로 설정합니다.
                ratingInput.value = rating;

                // highlightStars 함수를 호출하여 클릭된 별을 포함한 이하의 별을 채웁니다.
                highlightStars(rating);
            });
        });

        // 클릭된 별을 포함한 이하의 별을 채우는 함수
        function highlightStars(highlightRating) {
            // stars NodeList를 forEach로 순회합니다.
            stars.forEach(star => {
                // 각 별의 데이터 속성인 'data-rating' 값을 가져옵니다.
                const rating = star.dataset.rating;

                // 클릭된 별 이하의 별은 채워진 별로 표시하고, 그 이상의 별은 비어있는 별로 표시합니다.
                star.innerHTML = rating <= highlightRating ? '<i class="fas fa-star"></i>' : '<i class="far fa-star"></i>';
            });
        }
    });

    // ============================= 리뷰 리스트 =============================
    function updateCommentList() {
        $.ajax({
            type: 'GET',
            url: "/korean/list/" + $("#seoulSeq").val(),
            success: function (response) {
                var reviewContainer = $("#reviewContainer");
                reviewContainer.empty();

                for (var i = 0; i < response.length; i++) {
                    var comment = response[i];

                    var html = '<div class="review" id="comment_' + comment.seoulReviewSeq + '">';
                    html += '<div class="review-rating">';

                    for (var j = 0; j < 5; j++) {
                        if (j < comment.seoulScore) {
                            html += '<i class="fas fa-star"></i>'; // Filled star
                        } else {
                            html += '<i class="far fa-star"></i>'; // Empty star
                        }
                    }

                    html += '</div>';
                    html += '<div class="review-author">' + comment.userNickname + '</div>';
                    
                    // 댓글 내용(comment)과 리뷰 날짜(reviewDate) 표시
                    html += '<div class="review-body">' + comment.comment + '</div>';
                    html += '<div class="review-timestamp">' + comment.reviewDate + '</div>';
                    
                 // 추가: 로그인한 경우에만 수정/삭제 버튼 표시
                    var loginUserSeq = "${SPRING_SECURITY_CONTEXT.authentication.principal.gorea_UserTO.userSeq}";
                    if (loginUserSeq == comment.userSeq) {
                     	// 수정 폼 추가
    	                html += '<div class="reviewModify-form" id="reviewModifyForm_' + comment.seoulReviewSeq + '" style="display:none;">';
    	                html += '<input type="hidden" name="' + comment.seoulReviewSeq + '" value="' + comment.seoulReviewSeq + '">'
    	                html += '<div class="rating-container">';
    	                html += '<input type="hidden" id="revieModifyRating_' + comment.seoulReviewSeq + '" value="' + comment.seoulScore + '">';
    	                for (var k = 1; k <= 5; k++) {
    	                    if (k <= comment.seoulScore) {
    	                        html += '<div class="star" data-rating="' + k + '"><i class="fas fa-star"></i></div>';
    	                    } else {
    	                        html += '<div class="star" data-rating="' + k + '"><i class="far fa-star"></i></div>';
    	                    }
    	                }
    	                html += '</div>';

    	                html += '<div class="comment-container">';
    	                html += '<textarea style="resize: none;" id="reviewModifyComment_' + comment.seoulReviewSeq + '" placeholder="댓글 내용">' + comment.comment + '</textarea>';
    	                html += '<button class="save btn" data-review="' + comment.seoulReviewSeq + '">저장</button>';
    	                html += '</div>';
    	                html += '</div>';
    	                    
                        // "수정" 버튼에 클릭 이벤트 추가 및 수정 폼 표시
                        html += '<div>';
                        html += '<button class="modify" data-review="' + comment.seoulReviewSeq + '" data-user-seq="' + comment.userSeq + '">수정</button>';
                        html += '<button class="delete" data-review="' + comment.seoulReviewSeq + '" data-user-seq="' + comment.userSeq + '">삭제</button>';
                        html += '</div>';
                        html += '</div>';
                    }

                    html += '</div>';
                    reviewContainer.append(html);
                }

                // "수정" 버튼에 클릭 이벤트 추가
                $(".modify").on("click", function () {
                    var seoulReviewSeq = $(this).data("review");
                    var reviewElement = $("#comment_" + seoulReviewSeq);
                    
                 // 서버에서 받아온 댓글 정보 중에서 작성자 userSeq를 추출
                    var reviewUserSeq = $(this).data("user-seq");

                    // 현재 로그인한 사용자의 userSeq 가져오기
                    var loginUserSeq = "${SPRING_SECURITY_CONTEXT.authentication.principal.gorea_UserTO.userSeq}";
                    

                    // 댓글 작성자와 로그인한 사용자가 동일한 경우에만 수정 허용
                    if (reviewUserSeq == loginUserSeq) {
                        reviewElement.find(".review-body").hide();  // 댓글 내용 숨김
                        reviewElement.find(".review-timestamp").hide();  // 리뷰 날짜 숨김
                        reviewElement.find(".modify").hide();
                        reviewElement.find(".delete").hide();
                        reviewElement.find(".review-rating").hide();
                        reviewElement.find("#reviewModifyForm_" + seoulReviewSeq).show();  // 수정 폼 표시

                        // 별점 수정 폼에 있는 별점에 대한 클릭 이벤트 추가
                        $("#reviewModifyForm_" + seoulReviewSeq + " .star").on("click", function () {
                            var rating = $(this).data("rating");
                            setRating(seoulReviewSeq, rating);
                        });

                        // 리뷰 수정 후 저장
                        $("#reviewModifyForm_" + seoulReviewSeq + " .save").on("click", function () {
                            var seoulReviewSeq = $(this).data("review");  // seoulReviewSeq를 여기에서 정의합니다.
                            var seoulScore = $("#revieModifyRating_" + seoulReviewSeq).val();
                            var comment = $("#reviewModifyComment_" + seoulReviewSeq).val();

                            // 수정된 데이터를 서버로 전송
                            saveReview(seoulReviewSeq, seoulScore, comment);
                        });
                    } else {
                        // 댓글 작성자와 로그인한 사용자가 다를 경우에는 수정을 허용하지 않음
                        alert("댓글을 작성한 사용자만이 수정할 수 있습니다.");
                    }
                });
},
            error: function () {
                console.error("error");
                alert("Error fetching comments");
            }
        });
    }
    
 	// ============================= 리뷰 작성 =============================
    $(document).ready(function() {
	    // 리뷰를 서버로 전송하는 이벤트 핸들러
	    $("#submitReviewBtn").click(function() {
	        // 리뷰 폼에서 입력한 데이터 가져오기
	        $.ajax({
	            type: 'POST',
	            url: "/korean/reviewOk",
	            data: {
	                seoulSeq: $("#seoulSeq").val(),
	                comment: $("#comment").val(), 
	                seoulScore: $("#ratingInput").val(), // 'seoulScore'로 수정
	                userSeq: "${SPRING_SECURITY_CONTEXT.authentication.principal.gorea_UserTO.userSeq}"
	               
	            },
	            success: function(response) {
	                // 성공적으로 처리된 경우 알림창 표시 또는 원하는 동작 수행
	                alert("작성 성공");
	                // 댓글 입력창 초기화
	                $("#comment").val("");
	                $("#ratingInput").val("0");
	                
	                // 댓글 목록 갱신 (옵션: 목록을 바로 갱신하거나 페이지 전체를 리로드하는 방법도 가능)
	                updateCommentList();
	            },
	            error: function() {
	                console.error("error");
	                alert("댓글 서버 전송 실패");
	            }
	        });
	    });

	});
  
 	// ============================= 리뷰 수정 =============================
 	// 수정 폼에서 별점을 선택하고 설정하는 함수
    function setRating(seoulReviewSeq, rating) {
        // 선택한 별점을 표시하기 위해 해당 리뷰의 수정 폼에서 클래스 조작
        
        $("#reviewModifyForm_" + seoulReviewSeq + " .star").each(function () {
            var starRating = $(this).data("rating");

            if (starRating <= rating) {
                $(this).html('<i class="fas fa-star"></i>'); // Filled star
            } else {
                $(this).html('<i class="far fa-star"></i>'); // Empty star
            }
        });

        // 수정 폼의 숨겨진 input 업데이트
        $("#revieModifyRating_" + seoulReviewSeq).val(rating);
    }
 

 	
	 // 저장 함수
    function saveReview(seoulReviewSeq, seoulScore, comment) {
        // 서버로 수정된 데이터를 전송하는 AJAX 코드
    	$.ajax({
    	    type: 'POST',
    	    url: "/korean/modifyOk",
    	    data: {
    	        seoulReviewSeq: seoulReviewSeq,
    	        seoulScore: seoulScore,
    	        comment: comment
    	    },
    	    success: function (response) {
    	        alert("댓글 수정 성공");
    	        updateCommentList();
    	    },
    	    error: function (xhr, textStatus, errorThrown) {
    	        console.error("Error updating comment:", errorThrown);
    	        // 추가 디버깅 정보를 콘솔에 출력
    	        console.log(xhr.responseText);
    	    }
    	});

    }
	    
	// ============================= 리뷰 삭제 =============================
 	// 삭제 버튼 클릭 이벤트
   	 $(document).on("click", ".delete", function(event) {
   	 	   event.preventDefault();
     	   var seoulReviewSeq = $(this).data("review");
           // 서버에서 받아온 댓글 정보 중에서 작성자 userSeq를 추출
           var reviewUserSeq = $(this).data("user-seq");
			// 현재 로그인한 사용자의 userSeq 가져오기
           var loginUserSeq = "${SPRING_SECURITY_CONTEXT.authentication.principal.gorea_UserTO.userSeq}";
           
        // 작성자와 로그인 사용자가 동일한지 확인
           if (reviewUserSeq != loginUserSeq) {
               alert("본인이 작성한 댓글만 삭제할 수 있습니다.");
               return; // 본인이 작성한 댓글이 아니면 삭제 중단
           }
	        
       		// 서버에 댓글 삭제 요청
	        $.ajax({
	            type: 'post',
	            url: "/korean/delete/" + seoulReviewSeq,
	            success: function (response) {
	                if (response > 0) {
	                    // 댓글 목록 갱신
	                    updateCommentList();
	                    alert('댓글 삭제 성공');
	                } else {
	                    console.error("error");
	                    alert('댓글 삭제 실패');
	                }
	            },
	            error: function () {
	                console.error("error");
	                alert("서버와 통신 중 오류 발생");
	            }
	        });
	    });

   
		 // 페이지 로딩 시 초기 댓글 목록을 가져와서 표시
	    $(document).ready(function () {
	        updateCommentList(); // 초기 로딩 시에 호출
	    });

	    // 페이지 새로고침 시에도 댓글 목록을 업데이트
	    $(window).on('beforeunload', function () {
	        updateCommentList(); // 페이지를 떠날 때 호출
	    });

</script>
</head>
<body>

    <jsp:include page="/WEB-INF/views/includes/header${language}.jsp"></jsp:include>
     <main>
        <section>
            <div class="container">
            	<div class="category">${to.subCategory} </div>
                <div class="post-title">${to.seoulTitle}</div>
                <div class="post-info">
                    <div class="post-info-right">
                        <span class="post-info-item">작성일: ${to.seoulpostDate}</span>
                        <span class="post-info-item">조회수: ${to.seoulHit}</span>
                    </div>
                </div>
                <div class="post-content">
                    <div class="content-img">
                        <img src="${to.firstImageUrl}" alt="">
                    </div>
                    <div class="content-text">
                        <span>${to.seoulContent}</span>
                    </div>
                    
                    <div class="content-info">
                        <div class="info">
                            <span class="label">주소</span>
                            <span class="mark">:</span>
                            <span class="value">${to.seoulLoc}</span>
                        </div>
                        <div class="info">
                            <span class="label">사이트</span>
                            <span class="mark">:</span>
                            <span class="value">
                                <c:if test="${not empty to.seoulSite}">
                                    <a href="${to.seoulSite}" target="_blank">Site Link</a>
                                </c:if>
                                <c:if test="${empty to.seoulSite}">
                                    정보 없음
                                </c:if>
                            </span>
                        </div>
                        <div class="info">
                            <span class="label">이용시간</span>
                            <span class="mark">:</span>
                            <span class="value">${to.seoulusageTime}</span>
                        </div>
                        <div class="info">
                            <span class="label">이용요금</span>
                            <span class="mark">:</span>
                            <span class="value">${to.seoulusageFee}</span>
                        </div>
                        <div class="info">
                            <span class="label">교통정보</span>
                            <span class="mark">:</span>
                            <span class="value">${to.seoulTrafficinfo}</span>
                        </div>
                        <div class="info">
                            <span class="label">꼭 알아야할 것</span>
                            <span class="mark">:</span>
                            <span class="value">${to.seoulNotice}</span>
                        </div>
                    </div>
                </div>
                
                <div id="map" data-address="${to.seoulLoc}"></div>
                
                <div class="map"> </div>
                <form id="reviewForm" method="post">
				    <input type="hidden" id="seoulSeq" value="${param.seoulSeq}" />
				    <input type="hidden" name="userSeq" value="${userSeq}">
				    <div class="review-form">
				        <!-- 별점 입력 폼 -->
				        <div class="rating-container">
				            <input type="hidden" id="ratingInput" value="0"> <!-- 초기값: 0점 -->
				            <div class="star" data-rating="1"><i class="far fa-star"></i></div>
				            <div class="star" data-rating="2"><i class="far fa-star"></i></div>
				            <div class="star" data-rating="3"><i class="far fa-star"></i></div>
				            <div class="star" data-rating="4"><i class="far fa-star"></i></div>
				            <div class="star" data-rating="5"><i class="far fa-star"></i></div>
				        </div>
				
				        <div class="comment-container">
				            <textarea style="resize: none;" id="comment" placeholder="리뷰를 입력하세요"></textarea>
				            <button type="button" class="btn" id="submitReviewBtn">리뷰 작성</button>
				        </div>
				    </div>
				</form>
				
				
				<div class="review-section">
  				    <div id="reviews-count">추천 5개 리뷰 3개</div>
				    <div id="reviewContainer">
				    	
				    </div>
				</div>
				
                <div class="post-actions" style="text-align: right; margin-top: 10px;">
                    <input type="button" value="삭제" class="btn" style="cursor: pointer;" onclick="location.href='./trend_delete_ok.do?seoulSeq=${seq}'" />
                    <input type="button" value="수정" class="btn" style="cursor: pointer;" onclick="location.href='./trend_modify.do?seoulSeq=${seq}'" />
                     <input type="button" value="목록" class="btn" style="cursor: pointer;" onclick="location.href='./trend_seoul.do'" />
                </div>
            </div>
        </section>
    </main>
</body>
</html>
