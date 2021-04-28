<%@page import="kr.or.ddit.user.vo.UserVO"%>
<%@page import="kr.or.ddit.project.vo.ProjectVO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   <%@include file="/WEB-INF/view/include/head.jsp"%>
<%
List<ProjectVO> list = (List<ProjectVO>)request.getAttribute("list");

 uv = (UserVO)session.getAttribute("userVO");
%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>나의 프로젝트 - Sprout</title>
<link rel="stylesheet" type="text/css"
	href="/Team_Sprout/css/mypage/mpMyprj.css">

</head>
<body>
	<!-- 상단 전체   -->
	<div class="col-sm-12">

		<!-- 왼쪽 공백 2 -->
		<div class="col-sm-2"></div>

		<!-- 검색창 10 -->
		<div class="col-sm-8">
			<br>
			<br>
			<h3 style="font-weight: bold">내가 만든 프로젝트</h3>

			<br>
			<h4 style="font-weight: bold">총 <%=list.size() %>개의 프로젝트</h4>
		</div>

		<!-- 오른쪽 공백 2 -->
		<div class="col-sm-2"></div>
	</div>

	<!-- 펀딩 리스트 12 -->
	<div class="col-sm-12" >
	</div>
	<%
	if(list.size() == 0){
	%>
	<br><br><br><br><br>
	<h2 align="center">게시한 프로젝트가 없습니다.</h2>			
	<br><br><br><br><br><br><br><br><br><br><br><br>
	<%	
	} else {
		for(int i = 0; i < list.size(); i++) {
	%>
	<div class="col-sm-12">
		<!-- 왼쪽 공백 2 -->
		<div class="col-sm-2"></div>
		<div class="col-sm-8">
			<img src="/images/img1.jpg" class="img-rounded"
				style="width: 100%" alt="Image">
			<h4>
				<a href="/Team_Sprout/project/projectBoard.do?flag=SEL&pjNm=<%=list.get(i).getPjNm() %>"><%=list.get(i).getPjName() %></a>
			</h4>
			<p>
				<%=list.get(i).getPjCategory() %>
			</p>
			<span class="gold"><%=list.get(i).getPjPricePer() %>% 달성</span>
			<progress value="<%=list.get(i).getPjPricePer() %>" max="100"></progress>
			<div class="time">
				<span class="glyphicon glyphicon-time"></span> <span><%=list.get(i).getPjExpDate() %>일 남음</span>
			</div>
			<div class="btn-group btn-group-justified">
				<a href="#" class="btn btn-success">구매후기게시판</a>
				<a href="#" class="btn btn-success">통계</a>
			</div>
		</div>
	</div>
	<%	}
	} %>
	<!-- 여백 2-->
	<div class="col-sm-2">
	</div>

</body>
<%@include file="/WEB-INF/view/include/footer.jsp"%>
</html>

