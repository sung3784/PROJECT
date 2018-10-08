<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
</head>
<body style="background-image:url('resources/images/sponge.jpg');">
	<table>
	<tr>
	<td>이름</td><td>${wc.name }</td>
	</tr>
	<tr>
	<td>전화번호</td><td>${wc.phone }</td>
	</tr>
	<tr>
	<td>주소</td><td>${wc.address }</td>
	</tr>
	<tr>
	<td>상세주소</td><td>${wc.address2 }</td>
	</tr>
	<tr>
	<td>원하는 날짜</td><td>${wc.wantedTime }</td>
	</tr>
	<tr>
	<td>원하는 시간</td><td>${wc.specificTime }시</td>
	</tr>
	<tr>
	<td>세부사항</td><td><textArea>${wc.details}</textArea></td>
	</tr>
	
	</table>
</body>
</html>