<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<title>청소등록화면</title>
<script>
	$(function() {
		$("#register")
				.on(
						"click",
						function() {
							var address = document.getElementById("address").value;
							var wantedTime = document.getElementById("time").value;
							var specificTime = document
									.getElementById("specificTime").value;
							var details = document.getElementById("detail").value;
							location.href = "wantedCustomer?address=" + address
									+ "&wantedTime=" + wantedTime + "&details="
									+ details + "&specificTime=" + specificTime;
						});
	});
</script>
</head>
<%@ include file="loginCheck.jsp"%>
<body >
	<h1>청소등록</h1>
	<form>
		<table>
			<tr>
				<td style="font-size: 25px">주소 선택</td>
				<td><select id="address"
					style="font-size: 25px; width: 600px; height: 50px">
						<c:forEach var="list" items="${address}">
							<option selected="selected" value="${list}">${list}</option>
						</c:forEach>
				</select></td>
			</tr>
			<tr>
				<td style="font-size: 25px">날짜</td>
				<td><input style="font-size: 25px; width: 600px; height: 50px"
					type="Date" id="time" name="time" placeholder="예 : 2018-08-12" /></td>
			</tr>
			<tr>
				<td style="font-size: 25px">원하는 시간</td>
				<td><select id="specificTime"
					style="font-size: 25px; width: 600px; height: 50px">

						<option selected="selected" value="08">08시</option>
						<option value="09">09시</option>
						<option value="10">10시</option>
						<option value="11">11시</option>
						<option value="12">12시</option>
						<option value="13">13시</option>
						<option value="14">14시</option>
						<option value="15">15시</option>
						<option value="16">16시</option>
						<option value="17">17시</option>

				</select></td>
			</tr>
			<tr>
				<td style="font-size: 25px">상세정보</td>
				<td><textArea
						style="font-size: 20px; width: 600px; height: 200px" id="detail"
						placeholder="예: 35평 집청소, 냉장고 청소  지불금액 : 100,000  "></textArea></td>
			</tr>
			<tr>
				<th style="font-size: 25px" colspan="2"><input
					style="font-size: 25px" value="등록" type="button" id="register" /></th>
			</tr>
		</table>
	</form>
</body>
</html>