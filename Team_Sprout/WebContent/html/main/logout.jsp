<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
HttpSession session2 = request.getSession();
session2.invalidate();
%>

<script>
	$(document).ready(function(){
		alert("로그아웃 되었습니다!");
		<%
		response.sendRedirect("main.jsp");
		%>
	});
</script>
