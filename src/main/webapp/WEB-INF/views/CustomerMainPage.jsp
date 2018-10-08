<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css"
	href="./resources/css/joinAndLogin.css">
<script type="text/javascript"
	src="https://openapi.map.naver.com/openapi/v3/maps.js?clientId=KIERPGXQe2fEJW21vSSg&submodules=geocoder"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	 <script type="text/javascript" src="./resources/js/MarkerOverlappingRecognizer.js"></script>
<title>고객 메인페이지</title>
<script>
	function register() {

		location.href = "cleaningRegist";
	}
	function modify() {
		
		location.href = "modifyCustomer";
	}
	function logout() {
		location.href = "logout";
	}
</script>
</head>
<%@ include file="loginCheck.jsp"%>
<%@ include file="updateDB.jsp"%>
<body>
	<div>
		<div class="box1">
			<h1>${sessionScope.customerLoginId }님환영합니다.</h1>
			<div>
				<input type="button" id="register" value="청소등록" onclick="register()" />
				<input type="button" id="modify" value="회원정보 수정" onclick="modify()" />
				<input type="button" id="logout" value="로그아웃" onclick="logout()" />
			</div>
			
			<div style="font-szie: 30px;">
				
			<h3>청소등록 현황</h>
			</div>
			<table>
			<tr>
			<td>번호</td><td>전화번호</td><td>주소</td><td>상세주소</td>
			<td>원하는 날짜</td><td>원하는 시작시간</td><td>상세정보</td>
			</tr>
			<!-- 여기다가 원티드 그거를 넣고 -->
			<c:forEach var="list" items="${list }" varStatus="status">
			<tr>
			<td>${status.count}</td><td>${list.phone}</td><td>${list.address }</td>
			<td>${list.address2 }</td><td>${list.wantedTime }</td><td>${list.specificTime}</td>
			<td>${list.details }</td>
			</tr>
			</c:forEach>
			</table>
		</div>
		<div class="box2">
			<h1>집 주소 화면</h1>
			<div id="map" style="width: 100%; height: 700px;"></div>
		</div>
	</div>
	<!-- 	<script>
		
		var map = new naver.maps.Map('map');
		var myaddress = '서울 송파구 문정동 28-21';// 도로명 주소나 지번 주소만 가능 (건물명 불가!!!!)
		naver.maps.Service.geocode({
			address : myaddress
		}, function(status, response) {
			if (status !== naver.maps.Service.Status.OK) {
				return alert(myaddress + '의 검색 결과가 없거나 기타 네트워크 에러');
			}
			var result = response.result;
			// 검색 결과 갯수: result.total
			// 첫번째 결과 결과 주소: result.items[0].address
			// 첫번째 검색 결과 좌표: result.items[0].point.y, result.items[0].point.x
			var myaddr = new naver.maps.Point(result.items[0].point.x,
					result.items[0].point.y);
			map.setCenter(myaddr); // 검색된 좌표로 지도 이동
			// 마커 표시
			var marker = new naver.maps.Marker({
				position : myaddr,
				map : map
			});
			// 마커 클릭 이벤트 처리
			naver.maps.Event.addListener(marker, "click", function(e) {
				if (infowindow.getMap()) {
					infowindow.close();
				} else {
					infowindow.open(map, marker);
				}
			});
			// 마크 클릭시 인포윈도우 오픈
			var infowindow = new naver.maps.InfoWindow({
				content : '<h4>이유는 모르겟찌만!!!!!!!!!!! </h4>'
			});
		});
	</script> -->
	<script>
		var map = new naver.maps.Map('map', {
			zoom : 3
		});
		 var recognizer = new MarkerOverlappingRecognizer({
		        highlightRect: false,
		        tolerance: 5
		    });
		    recognizer.setMap(map);

		    var bounds = map.getBounds(),
		        southWest = bounds.getSW(),
		        northEast = bounds.getNE(),
		        lngSpan = northEast.lng() - southWest.lng(),
		        latSpan = northEast.lat() - southWest.lat();

		     function highlightMarker(marker) {
		        var icon = marker.getIcon();

		      /*   if (icon.url !== MARKER_HIGHLIGHT_ICON_URL) {
		            icon.url = MARKER_HIGHLIGHT_ICON_URL;
		            marker.setIcon(icon);
		        } */

		        marker.setZIndex(1000);
		    }

		    function unhighlightMarker(marker) {
		        var icon = marker.getIcon();

		      /*   if (icon.url === MARKER_HIGHLIGHT_ICON_URL) {
		            icon.url = MARKER_ICON_URL;
		            marker.setIcon(icon);
		        } */

		        marker.setZIndex(100);
		    } 
		
		
		$(function() {
		
			$.ajax({
				url : "example",
				type : "get",
				dataType : "json",
				success : function(list2) {
					var list = list2[0];
					var address = list2[1];
					
					
					$.each(address,function(index,item) {
						var myaddress = list[index];// 도로명 주소나 지번 주소만 가능 (건물명 불가!!!!)
						naver.maps.Service.geocode({
							address : myaddress
						}, function(status, response) {
							if (status !== naver.maps.Service.Status.OK) {
								return alert(myaddress
										+ '의 검색 결과가 없거나 기타 네트워크 에러');
							}
							var result = response.result;
							// 검색 결과 갯수: result.total
							// 첫번째 결과 결과 주소: result.items[0].address
							// 첫번째 검색 결과 좌표: result.items[0].point.y, result.items[0].point.x
							var myaddr = new naver.maps.Point(
									result.items[0].point.x,
									result.items[0].point.y);
							//map.setCenter(myaddr); // 검색된 좌표로 지도 이동
							// 마커 표시
							var marker = new naver.maps.Marker({
								position : myaddr,
								map : map
							});
							 recognizer.add(marker);

						        window.MARKER = marker; 
							
							// 마크 클릭시 인포윈도우 오픈
							var infowindow = new naver.maps.InfoWindow({
								content : item
							});
							
							// 마커 클릭 이벤트 처리
							naver.maps.Event.addListener(marker, "click", function(e) {
								if (infowindow.getMap()) {
									infowindow.close();
								} else {
									infowindow.open(map, marker);
								}
							});
						});
						  
						
						});
					 var overlapCoverMarker = null;

					    naver.maps.Event.addListener(recognizer, 'overlap', function(list) {
					        if (overlapCoverMarker) {
					            unhighlightMarker(overlapCoverMarker);
					        }

					        overlapCoverMarker = list[0].marker;

					     
					    }); 

					    naver.maps.Event.addListener(recognizer, 'clickItem', function(e) {
					        recognizer.hide();

					        if (overlapCoverMarker) {
					            unhighlightMarker(overlapCoverMarker);

					            overlapCoverMarker = null;
					        }
					    });
				},
				error : function(data) {
					alert("통신에러");
				}
			});

		});
	</script>
	
</body>
</html>
