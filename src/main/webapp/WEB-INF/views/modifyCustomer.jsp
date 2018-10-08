<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" type="text/css"
	href="./resources/css/joinAndLogin.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script>
	//본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.
	function execDaumPostcode2() {
		new daum.Postcode(
				{
					oncomplete : function(data) {
						// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

						// 도로명 주소의 노출 규칙에 따라 주소를 조합한다.
						// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
						var fullRoadAddr = data.roadAddress; // 도로명 주소 변수
						var extraRoadAddr = ''; // 도로명 조합형 주소 변수

						// 법정동명이 있을 경우 추가한다. (법정리는 제외)
						// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
						if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
							extraRoadAddr += data.bname;
						}
						// 건물명이 있고, 공동주택일 경우 추가한다.
						if (data.buildingName !== '' && data.apartment === 'Y') {
							extraRoadAddr += (extraRoadAddr !== '' ? ', '
									+ data.buildingName : data.buildingName);
						}
						// 도로명, 지번 조합형 주소가 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
						if (extraRoadAddr !== '') {
							extraRoadAddr = ' (' + extraRoadAddr + ')';
						}
						// 도로명, 지번 주소의 유무에 따라 해당 조합형 주소를 추가한다.
						if (fullRoadAddr !== '') {
							fullRoadAddr += extraRoadAddr;
						}

						// 우편번호와 주소 정보를 해당 필드에 넣는다.
						/*      document.getElementById('sample4_postcode').value = data.zonecode; //5자리 새우편번호 사용
						     document.getElementById('sample4_roadAddress').value = fullRoadAddr; */

						var result = null;
						result = data.jibunAddress;
						
						var ext = "";
						ext += "<tr>";
						ext += "<td>" + "추가주소" + "</td>";
						ext += "<td>"
								+ "<input type=text name='address' id='address' value='"+result+"'/>";
						ext += "<td>"
								+ "<input type=text name='address2' id='address2' placeholder='상세주소'/>"
								+ "</td>";
						ext += "</tr>";
						$("#table2").append(ext);
					}
				}).open();
		/* 	 new daum.Postcode({}).close();  */
	};
	
	$(function() {
		$('#minus').on('click', function() {
			
			$("#table2  > tr:last").remove();

		});
	});
</script>
<script>
function deletetr(td){
	$(td).parent().parent().remove();
	
}
	
</script>
	
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>회원정보 수정</title>
</head>
<%@ include file="loginCheck.jsp"%>
<body>
<h1>회원정보 수정</h1>
<form action="modifyFinish" method="get">
<table>
<tr>
<td>이름</td><td>${customer.name }</td>
</tr>
<tr>
<td>ID</td><td>${customer.id}</td>
</tr>
<tr>
<td>Phone</td><td><input type="text" name="phone" value="${customer.phone }"/></td>
</tr>
 <c:forEach var="list" items="${list }">
<tr> 
<td>주소</td>


<td><input style="width: 600px;" type="text" name="totalAddress" value="${list }"/></td>
<%-- <td><input type="text" name="address2" value="${sel }"/></td> --%>



<td><input type="button" name="btu" id="btu" value="delete" onclick="deletetr(this)"/></td>
</tr>
</c:forEach> 

</table>
<table id="table2">

</table>
<div>
<input type="button" id="plus" name="plus" value="주소추가"
						onclick="execDaumPostcode2()" />
						<input type="button" id="minus"
						name="minus" value="추가주소 삭제" /><br/>
						<input type="submit" name="send" value="수정"/>
</div>
</form>
</body>
</html>