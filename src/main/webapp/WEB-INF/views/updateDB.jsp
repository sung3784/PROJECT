<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

	<script>
		$(function(){
			setInterval(function(){
				
				$.ajax({
					url : "updateDB",
					type : "get",
					success : function(data){
						console.log(data);
					},
					error : function(data){
						alert("통신에러");
					}
					
					
					
				})
				
				
				
			}, 5000);
			
			
			
			
		})
		
		
	</script>