<%@page import="kr.or.ddit.project.vo.ProjectVO"%>
<%@page import="kr.or.ddit.project.vo.ProjectOptionVO"%>
<%@page import="kr.or.ddit.user.vo.UserVO"%>
<%@page import="kr.or.ddit.comm.vo.AtchFileVO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	ProjectVO pv = (ProjectVO)request.getAttribute("pv");
	ProjectOptionVO pov = (ProjectOptionVO)request.getAttribute("pov");
	

	List<AtchFileVO> atchFileList = (List<AtchFileVO>) request.getAttribute("atchFileList");
		
	UserVO uv = (UserVO)session.getAttribute("userVO");
	
	String pjNm = pv.getPjNm();
	
	pov.setPjNm(pjNm);

%>    
<!DOCTYPE html>
<html lang="en">
<head>
<title>Bootstrap Example</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
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
<link rel="stylesheet" type="text/css"
	href="/Team_Sprout/css/main/prjDetail.css">
<body>
	<!-- 프로젝트 제목 -->
	<div class="col-sm-12">

		<!-- 왼쪽 공백 2 -->
		<div class="col-sm-2"></div>

		<!-- 제목 -->
		<div class="col-sm-8" id="divCategory">
			<br>
			<br> <span id="spanCategory"><%=pv.getPjCategory() %></span>
			<h2><%=pv.getPjName() %></h2>
			<br>
			<h4>WHY</h4>
		</div>

		<!-- 오른쪽 공백 2 -->
		<div class="col-sm-2"></div>

	</div>

	<!-- 프로젝트 사진 / 설명 -->
	<div class="col-sm-12">
		<!-- 왼쪽 공백 2 -->
		<div class="col-sm-2"></div>

		<!-- 썸네일 -->
		<div class="col-sm-5">
			<img src="/images/thum1.jpg" id="thumImage">
		</div>
		<!-- 설명 -->
		<div class="col-sm-3">
			<p>모인금액</p>
			<h3>
				<p>22,000,000원</p>
			</h3>
			<br>
			<p>프로젝트 마감일</p>
			<h3>
				<p>2021년 5월 30일</p>
			</h3>
			<br>
			<p>후원자</p>
			<h3>
				<p>876명</p>
			</h3>
			<br>
			<br>
			<br>
			<button type="button" class="btn btn-default btn-lg">큰 버튼</button>
		</div>

		<!-- 오른쪽 공백 2 -->
		<div class="col-sm-2"></div>
	</div>


	<!-- 프로젝트 옵션 / 상세 설명 -->
	<div class="col-sm-12">
		<!-- 왼쪽 공백 2 -->
		<div class="col-sm-2"></div>

		<!-- 옵션 -->
		<div class="col-sm-2">
			<div id="divOption">
				<p>옵션<%=pov.getPoNm() %>
				<p><%=pov.getPoName() %>
				<h4><%=pov.getPoAddPrice() %></h4>
				<span><%=pov.getPoContent() %></span>
			</div>
			<br>
		</div>
		<!-- 상세 설명 -->
		<div class="col-sm-6">
			<h3>프로젝트 소개</h3>
			<p><%=pv.getPjContent() %></p>
		</div>

		<!-- 오른쪽 공백 2 -->
		<div class="col-sm-2"></div>
	</div>


	<!-- top -->
	<a style="display: scroll; position: fixed; bottom: 40px; right: 40px;"
		href="#" title="top"><img src="/images/topbutton.png"
		width="40px"></a>
</body>
</html>