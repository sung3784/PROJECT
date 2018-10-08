<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>

	<title>Home</title>
	<style>
	button {
	outline: none !important;
	border: none;
	font-size : 60px;
	background-color : skyblue;
}
	
	</style>
	<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script>
	$(function(){
	$("#customer").on("click",function(){
		
		location.href="customer";
	});
	$("#cleaner").on("click",function(){
		
		location.href="cleaner";
	});
	})
	</script>
</head>
<body>
<h1>
	The Best Cleaner for the Best Customers
</h1>
<h2></h2>
<button id="customer">의뢰인 화면</button>
<button id="cleaner" >청소부 화면</button>

</body>
</html>
