<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<link rel="stylesheet" type="text/css"
	href="./resources/css/joinAndLogin.css">
<title>customerIndex</title>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script src="./resources/js/post.js"></script>

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
						alert(result);
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
	}

	$(function() {
		$('#minus').on('click', function() {
			
			$("#table2  > tr:last").remove();

		});
	});
</script>
<script>
	function custjoin() {
		var name = document.getElementById("name").value;
		var id = document.getElementById("id").value;
		var password = document.getElementById("password").value;
		var phone = document.getElementById("phone").value;

		if (name.length < 2) {
			alert("이름 글자는 2글자 이상입니다.");
			return false;
		} else if (id.length == 0 || password.length == 0) {
			alert("id 와 password는 반드시 채워주세요");
			return false;
		} else if (phone.length < 8) {
			alert("전화번호를 제대로 기입해주세요 (-포함가능)");
		} else {
			return true;
		}

	}
</script>

</head>

<body>
	<div>
		<div class="box1">
			<h1>회원가입</h1>
			<form action="customerJoin" method="post"
				onsubmit="return custjoin()">
				<table id="table1">
					<tr>
						<td>ID</td>
						<td><input type="text" name="id" id="id" /></td>
					</tr>
					<tr>
						<td>Password</td>
						<td><input type="password" name="password" id="password" /></td>
					</tr>
					<tr>
						<td>이름</td>
						<td><input type="text" name="name" id="name" /></td>
					</tr>
					<tr>
						<td>전화번호</td>
						<td><input type="text" name="phone" id="phone"
							placeholder="예: 010-3333-4444" /></td>
					</tr>
					<tr>
						<td>주소</td>

						<td><input type="button" onclick="execDaumPostcode()"
							value="주소 찾기"></td>
					</tr>
					<tr>
						<td></td>
						<td><input type="text" name="address" id="jibunAddress"
							placeholder="지번주소"></td>

						<td><input type="text" name="address2" id="jibunAddress2"
							placeholder="상세주소"></td>
					</tr>

				</table>
				<table id="table2">

				</table>
				<div style="margin-left: 100px;">
					
					<input type="button" id="plus" name="plus" value="주소추가"
						onclick="execDaumPostcode2()" /> <input type="button" id="minus"
						name="minus" value="주소삭제" /><br /> <input type="submit"
						id="send" name="send" value="회원가입" />
				</div>
			</form>

		</div>
		<div class="box2">
			<h1>로그인</h1>
			<form action="customerLogin" method="post">
				<table>
					<tr>
						<td>ID</td>
						<td><input type="text" id="loginid" name="id" /></td>
					</tr>
					<tr>
						<td>Password</td>
						<td><input type="password" id="loginpassword" name="password" /></td>
					</tr>
					<tr>
						<th colspan="2"><input type="submit" id="login" name="login"
							value="로그인" /></th>
					</tr>
				</table>
			</form>
		</div>
	</div>
</body>
</html>
