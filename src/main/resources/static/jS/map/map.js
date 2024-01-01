// mapScript.js

// geocodeAddress 함수는 주소를 받아와서 해당 주소의 위도와 경도를 콜백 함수에 전달합니다.
function geocodeAddress(callback) {
    // data-address 속성을 통해 HTML에서 주소를 가져옵니다.
    var address = document.getElementById('map').getAttribute('data-address');

    // Google Maps Geocoder 객체를 생성합니다.
    var geocoder = new google.maps.Geocoder();

    // Geocoder 객체를 사용하여 주소를 위도와 경도로 변환합니다.
    geocoder.geocode({ 'address': address }, function (results, status) {
        if (status === 'OK') {
            // 변환 성공 시, 첫 번째 결과의 geometry.location을 사용하여 위도와 경도를 가져옵니다.
            var location = results[0].geometry.location;
            // 변환된 위도와 경도를 콜백 함수에 전달합니다.
            callback({ lat: location.lat(), lng: location.lng() });
        } else {
            // 변환 실패 시, 에러 메시지를 출력하고 콜백에 null 값을 전달합니다.
            console.error('Geocode was not successful for the following reason: ' + status);
            callback(null);
        }
    });
}

// initMap 함수는 페이지가 로드될 때 자동으로 호출되는 Google Maps 초기화 함수입니다.
function initMap() {
    // geocodeAddress 함수를 호출하여 주소를 위도와 경도로 변환합니다.
    geocodeAddress(function (result) {
        if (result !== null) {
            // 변환된 위도와 경도를 사용하여 지도를 생성합니다.
            var map = new google.maps.Map(document.getElementById('map'), {
                center: result, // 변환된 위치를 중심으로 설정
                zoom: 15 // 줌 레벨 설정
            });

            // 변환된 위치에 마커를 생성하여 지도에 표시합니다.
            var marker = new google.maps.Marker({
                position: result, // 마커의 위치 설정
                map: map, // 마커를 지도에 추가
                title: 'Marker Title' // 마커에 표시될 제목
            });
        } else {
            console.error('주소를 변환할 수 없습니다.');
            // 주소 변환에 실패한 경우의 로직을 추가할 수 있습니다.
        }
    });
}
