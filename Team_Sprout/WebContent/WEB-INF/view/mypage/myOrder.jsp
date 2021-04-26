<%@page import="kr.or.ddit.user.vo.OrderVO"%>
<%@page import="kr.or.ddit.project.vo.ProjectVO"%>
<%@page import="java.util.List"%>
<%@page import="kr.or.ddit.user.vo.UserVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>나의 후원 내역</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="preconnect" href="https://fonts.gstatic.com">
<link rel="preconnect" href="https://fonts.gstatic.com">
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400&display=swap"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link href="https://fonts.googleapis.com/css?family=Lato"
	rel="stylesheet" type="text/css">
<link href="https://fonts.googleapis.com/css?family=Montserrat"
	rel="stylesheet" type="text/css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<link rel="stylesheet" type="text/css" href="/Team_Sprout/css/main/main.css">
<link rel="stylesheet" type="text/css" href="/Team_Sprout/css/mypage/mpDona.css">

</head>
<body>
<%
	UserVO uv = null;
	if(session != null && session.getAttribute("userVO") != null){
		uv = (UserVO)session.getAttribute("userVO");
	}
	
	List<OrderVO> orderList = (List<OrderVO>)request.getAttribute("orderList");
%>
	
		<!-- 상단 전체   -->
		<div class="col-sm-12">
		
			<!-- 왼쪽 공백 2 -->
			<div class="col-sm-2"></div>

		<!-- 검색창 10 -->
		<div class="col-sm-8">
		<br><br>
			<h3 style="font-weight: bold">후원현황</h3>
				
			<br>
			<h4 style="font-weight: bold">총 <%=orderList.size() %>개의 프로젝트</h4>
		</div>

		<!-- 오른쪽 공백 2 -->
			<div class="col-sm-2"></div>
		</div>

		<!-- 펀딩 리스트 12 -->	
	<div class="col-sm-12">
		<%
		if(orderList.size() == 0){
		%>
			<br><br><br><br><br>
			<h2 align="center">후원 내역이 없습니다.</h2>			
			<br><br><br><br><br><br><br><br><br><br><br><br>
		<%
		} else {
			for(int i = 0; i < orderList.size(); i++){
		%>		
		<!-- 왼쪽 공백 2 -->
		<div class="col-sm-2"></div>
		
		<!-- 항목들 -->
		<div class="col-sm-2">
			<p>후원일 <%=orderList.get(i).getOrderTime() %></p>
			<img src="/images/img1.jpg" class="img-rounded" style="width: 100%"
				alt="Image">
			<h4><a href="#">세상에 오직 하나, 한국의 판타지 아이템 도감</a></h4>
			<div id="divReult">
				<h4>후원 금액</h4>
				<p><%=orderList.get(i).getOrderPrice() %>원</p>
				<h4>선택 옵션</h4>
				<p>어쩌구 저쩌구 선물</p>
				<h4>주문상태</h4>
				<p><%=orderList.get(i).getOrderState() %></p>
			</div>
			<button type="button" class="btn btn-success btn-lg" id="payBtn">후원취소</button>
		</div>
		<%		
			}
		} %>

		
	<!-- 여백 2-->	
	<div class="col-sm-2"></div>
	</div>
	
	<!-- top -->
	<a style="display: scroll; position: fixed; bottom: 40px; right: 40px;"
		href="#" title="top"><img src="/images/topbutton.png" width="40px"></a>

	<!-- footer -->
	<footer class="container-fluid text-center">
		<br><br>
		<p>Design By Seul-gi</p>
		<p>
			스프라우트는 플랫폼 제공자로서 프로젝트의 당사자가 아니며, 직접적인 통신판매를 진행하지 않습니다.<br> 프로젝트의
			완수 및 선물제공의 책임은 해당 프로젝트의 창작자에게 있으며,<br> 프로젝트와 관련하여 후원자와 발생하는 법적
			분쟁에 대한 책임은 해당 창작자가 부담합니다.
		</p>
		<p>스프라우트(주) | 스프라우트 123-45-67890 | 대전광역시 중구, 영민빌딩 4층 ddit 403호 |
			통신판매업 2021-1234-1234-123 | 대표전화 042) 000-1234</p>
	</footer>
</body>
</html>

