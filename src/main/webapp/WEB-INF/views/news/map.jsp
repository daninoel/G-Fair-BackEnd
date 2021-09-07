<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<!DOCTYPE html>

<html>
<head>
    <meta charset="utf-8">
    <title>이미지 지도에 마커 표시하기</title>
    
</head>
<body>

<div id="map" style="width:500px;height:350px;"></div>

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=130b36355b3a84c4d7446fe051474853"></script>
<script>
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
		    mapOption = { 
		        center: new kakao.maps.LatLng(37.66993579643038, 126.74618349109039), // 지도의 중심좌표
		        level: 5 // 지도의 확대 레벨
		    };
		
		var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
		
		
		var markerPosition  = new kakao.maps.LatLng(37.66993579643038, 126.74618349109039); 
		
		
		var marker = new kakao.maps.Marker({
		    position: markerPosition
		});
		
		
		marker.setMap(map);


// marker.setMap(null);    
</script>
</body>
</html>