<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:if test="${sessionScope.loginId eq null}">
	<script>
		alert("로그인해야 하는 서비스입니다.");
		location.href="customer";
	</script>
</c:if>