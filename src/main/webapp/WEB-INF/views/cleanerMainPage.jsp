<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" type="text/css"
	href="./resources/css/joinAndLogin.css">
<style>
td {
	width: 200px;
}
</style>
<script type="text/javascript"
	src="https://openapi.map.naver.com/openapi/v3/maps.js?clientId=KIERPGXQe2fEJW21vSSg&submodules=geocoder"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript"
	src="./resources/js/MarkerOverlappingRecognizer.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script>
function logout(){
	location.href="cleanerlogout";
}
function searchButton(){
	var search=document.getElementById("search").value;
	location.href="cleanerMainPage?search="+search;
	
}


function boardDetail(num){
	var number=num;
	window.open("boardDetail?number="+number,"boardDetails","top=100, left=100, width=300, height=300");
	
}
</script>

</head>
<%@ include file="loginCheck2.jsp"%>
<%@ include file="updateDB.jsp"%>
<body>
	<div>
		<div  class="box1">
			<h1>${sessionScope.cleanerLoginId }님환영합니다.</h1>
			<div>

				<input type="button" id="logout" value="로그아웃" onclick="logout()" />
			</div>

			<div style="font-szie: 30px;">

				<h2 style="padding-left: 300px;">구인 게시판</h2>
				<h2 style="padding-left: 300px;">[전체글수]
					${navi.totalRecordsCount}</h2>
			</div>
			<div style="padding-left: 340px;">
				<input type="text" id="search" placeholder="검색" /><input
					type="button" id="searchButton" name="searchButton" value="검색"
					onclick="searchButton()" />
			</div>
			<table style="padding-left: 50px;">
				<tr>
					<td>번호</td>
					<td>주소</td>
					<td>원하는 날짜</td>
				</tr>
				<!-- 여기다가 원티드 그거를 넣고 -->
				<c:forEach var="list" items="${list }" varStatus="status">
					<tr>
						<td>${status.count}</td>
						<td><a style="color : blue;" onclick="javascript:boardDetail(${list.seqwc })">${list.address }</a></td>
						<td>${list.wantedTime }</td>

					</tr>
				</c:forEach>
			</table>
			
			<div style="padding-left: 100px;">
				<a href="cleanerMainPage?page=${navi.currentPage-1}">Pre </a> <a
					href="cleanerMainPage?page=${navi.currentPage+1}">Next </a>
			</div>
			<div style="padding-left: 200px;">
				<c:forEach var="i" begin="${navi.startPageGroup}"
					end="${navi.endPageGroup}" step="1">
					<a href="cleanerMainPage?page=${i}"><span
						style="color: grey; font-size: 25px;">${i}</span></a>
				</c:forEach>

			</div>
		</div>
		<div class="box2">
			<h1>청소 구인 Map화면</h1> <h1>마우스 우클릭시 근처 약 60km이내 마커가 나옴</h1>


			<div>
				<input type="text" id="searchingi" name="searchingi"
					placeholder="검색" /><input type="button" id="searching"
					name="searching" value="검색" />

			</div>
			<div id="map" style="width: 100%; height: 700px;"></div>
		</div>
	</div>


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
			$("#searching").on("click",function(){
				var search=document.getElementById("searchingi").value;
		 	
			
			$.ajax({
				url : "MapForCleaner",
				type : "get",
				data : { "search" : search},
				success : function(list2) {
					
					
					$.each(list2,function(index,item) {
						var myaddress = list2[index].address;// 도로명 주소나 지번 주소만 가능 (건물명 불가!!!!)
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
								content : "<div>"+"이름 : "+list2[index].name+"</br>"+
								"전화번호 : "+list2[index].phone+"</br>"+
								"주소 :"+list2[index].address+" "+list2[index].address2+"</br>"+
								"원하는 날짜 :"+list2[index].wantedTime+" 원하는 시간 :"+list2[index].specificTime+"시"+"</br>"+
								"상세정보 :"+list2[index].details+
								
								"</div>"
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
		
		})
	</script>
	<script>
	
	
	
	
	$(function(){
		var clist=[];
		// 마커 클릭 이벤트 처리
		naver.maps.Event.addListener(map, "rightclick", function(e) {
			 var addr=new naver.maps.Point(e.coord);
				$.ajax({
					url : "MapForCleaner",
					type : "get",
					/* data : { "search" : search}, */
					success : function(list2) {
						
	///////////////////////리스트를 여기다가 담아야될듯.
						
	
						$.each(list2,function(index,item) {
							var myaddress = list2[index].address;// 도로명 주소나 지번 주소만 가능 (건물명 불가!!!!)
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
								
							});
						});
					      
						
						$.each(list2,function(index,item) {
							
							var myaddress = list2[index].address;// 도로명 주소나 지번 주소만 가능 (건물명 불가!!!!)
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
								var a=Math.abs((addr.y)-(result.items[0].point.y));
								var b=Math.abs((addr.x)-(result.items[0].point.x));
								
								var c= (a*a) + (b*b);
								
								
							
								
								
								// 마커 표시
							
								if(Math.sqrt(c)<0.45){
									var marker = new naver.maps.Marker({
										position : myaddr,
										map : map
									});
								}
							
						
								
							
								
								
								 recognizer.add(marker);

							        window.MARKER = marker; 
								
								// 마크 클릭시 인포윈도우 오픈
								var infowindow = new naver.maps.InfoWindow({
									content : "<div>"+"이름 : "+list2[index].name+"</br>"+
									"전화번호 : "+list2[index].phone+"</br>"+
									"주소 :"+list2[index].address+" "+list2[index].address2+"</br>"+
									"원하는 날짜 :"+list2[index].wantedTime+" 원하는 시간 :"+list2[index].specificTime+"시"+"</br>"+
									"상세정보 :"+list2[index].details+
									
									"</div>"
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
		
		
		
		
		
		
		
	})
	
	</script>
</body>
</html>