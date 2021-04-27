<%@page import="kr.or.ddit.board.vo.ReportBoardVO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<head>
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<title>SPROUT 관리자 페이지</title>

</head>
<body class="sb-nav-fixed">

	<!-- 상단 헤더 -->
	<%@include file="/WEB-INF/view/include/adminHead.jsp"%>

	<!-- 레이아웃 -->
	<div id="layoutSidenav">

		<!-- 좌측 네비 -->
		<div id="layoutSidenav_nav">
			<%@include file="/WEB-INF/view/include/adminNav.jsp"%>

			<!-- 본문  -->
			<div id="layoutSidenav_content">

				<!-- 게시판 -->
				<div class="container">
					<h4><br><br>
						<b>신고게시판 관리</b>
					</h4><br>
					<table class="table table-hover">
						<thead>
							<tr>
								<th><input type="checkbox" value="" name="num"></th>
								<th>번호</th>
								<th>제목</th>
								<th>작성자</th>
								<th>날짜</th>
							</tr>
						</thead>
						<tbody>
							<%
								List<ReportBoardVO> list = (List<ReportBoardVO>) request.getAttribute("list");
								for (int i = 0; i < list.size(); i++) {
									String reportNm = list.get(i).getReportNm();
							%>
							<tr>
								<td><input type="checkbox" value="" name="num"></td>
								<td><%=list.size() - i%></td>
								<td><a href="#" onclick="boardSelect('<%=reportNm%>')">
										<%=list.get(i).getReportTitle()%>
								</a></td>
								<td><%=list.get(i).getReportWriter()%></td>
								<td><%=list.get(i).getReportDate()%></td>
							</tr>
							<%
								}
							%>
						</tbody>
					</table>
					<!-- 페이지 이동 -->
					<div class="text-center">
						<ul class="pagination">
							<li><a href="">1</a></li>
							<li><a href="">2</a></li>
							<li><a href="">3</a></li>
							<li><a href="">4</a></li>
							<li><a href="">5</a></li>
						</ul>
					</div>
					<!-- 검색 창 -->
					<div class="text-center">
						<input type="text" id="schInput" name="search">
						<button type="button" class="btn btn-success"
							onclick="searchBoard()">검색</button>
					</div>
					<hr>
					<!-- 등록 버튼  -->
					<div id="btn" style="text-align: right">
						<button type="button" class="btn btn-success" id="insertBtn"
							onclick="insertBoard()">등록</button>
					</div>
					<form id="fm">
						<input type="hidden" name="reportNm" id="reportNm"> <input
							type="hidden" name="flag" id="flag">
					</form>
					<br> <br> <br>
				</div>

			</div>

		</div>
</body>
</html>
