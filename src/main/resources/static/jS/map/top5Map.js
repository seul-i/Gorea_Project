function geocodeAddress(address, callback) {
    var geocoder = new google.maps.Geocoder();

    geocoder.geocode({ 'address': address }, function (results, status) {
        if (status === 'OK') {
            var location = results[0].geometry.location;
            callback({ lat: location.lat(), lng: location.lng() });
        } else {
            console.error('Geocode was not successful for the following reason: ' + status);
            callback(null);
        }
    });
}

function initMap() {
    // 첫 번째 주소 변환
    var address1 = document.getElementById('map').getAttribute('data-address');
    geocodeAddress(address1, function (result1) {
        if (result1 !== null) {
            var map1 = new google.maps.Map(document.getElementById('map'), {
                center: result1,
                zoom: 15
            });

            var marker1 = new google.maps.Marker({
                position: result1,
                map: map1,
                title: 'Marker Title 1'
            });
        } else {
            console.error('첫 번째 주소를 변환할 수 없습니다.');
        }
    });

    // 두 번째 주소 변환
    var address2 = document.getElementById('map2').getAttribute('data-address2');
    geocodeAddress(address2, function (result2) {
        if (result2 !== null) {
            var map2 = new google.maps.Map(document.getElementById('map2'), {
                center: result2,
                zoom: 15
            });

            var marker2 = new google.maps.Marker({
                position: result2,
                map: map2,
                title: 'Marker Title 2'
            });
        } else {
            console.error('두 번째 주소를 변환할 수 없습니다.');
        }
    });
    
    var address3 = document.getElementById('map3').getAttribute('data-address3');
    geocodeAddress(address3, function (result3) {
        if (result3 !== null) {
            var map3 = new google.maps.Map(document.getElementById('map3'), {
                center: result3,
                zoom: 15
            });

            var marker2 = new google.maps.Marker({
                position: result3,
                map: map3,
                title: 'Marker Title 3'
            });
        } else {
            console.error('두 번째 주소를 변환할 수 없습니다.');
        }
    });
    
    var address4 = document.getElementById('map4').getAttribute('data-address4');
    geocodeAddress(address4, function (result4) {
        if (result4 !== null) {
            var map4 = new google.maps.Map(document.getElementById('map4'), {
                center: result4,
                zoom: 15
            });

            var marker4 = new google.maps.Marker({
                position: result4,
                map: map4,
                title: 'Marker Title 4'
            });
        } else {
            console.error('두 번째 주소를 변환할 수 없습니다.');
        }
    });
    
    var address5 = document.getElementById('map5').getAttribute('data-address5');
    geocodeAddress(address5, function (result5) {
        if (result5 !== null) {
            var map5 = new google.maps.Map(document.getElementById('map5'), {
                center: result5,
                zoom: 15
            });

            var marker5 = new google.maps.Marker({
                position: result5,
                map: map5,
                title: 'Marker Title 5'
            });
        } else {
            console.error('두 번째 주소를 변환할 수 없습니다.');
        }
    });
}
