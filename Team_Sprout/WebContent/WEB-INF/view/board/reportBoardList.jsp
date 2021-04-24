<%@page import="kr.or.ddit.board.vo.ReportBoardVO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>신고 게시판</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
  <link rel="stylesheet" href="/Team_Sprout/css/main/board.css">
</head>
<body>
	<!-- 테이블 -->
	<div class="container">
		<table class="table table-hover">
			<thead>
				<tr>
					<th>번호</th>
					<th>제목</th>
					<th>작성자</th>
					<th>날짜</th>
				</tr>
			</thead>
			<tbody>
			<%
			List<ReportBoardVO> list = (List<ReportBoardVO>)request.getAttribute("list");
			for(int i = 0; i < list.size(); i++) {
				String reportNm = list.get(i).getReportNm();
			%>
			<tr>
				<td><%=list.size() - i %></td>
				<td>
					<a href="#" onclick="boardSelect('<%= reportNm %>')">
						<%=list.get(i).getReportTitle() %>
					</a>
				</td>
				<td><%=list.get(i).getReportWriter() %></td>
				<td><%=list.get(i).getReportDate() %></td>
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
			<button type="button" class="btn btn-success" onclick="searchBoard()">검색</button>
		</div>
		<hr>
		<!-- 등록 버튼  -->
		<div id="btn" style="text-align: right">
			<button type="button" class="btn btn-success" id="insertBtn" onclick="insertBoard()">등록</button>
		</div>
		<form id="fm">
			<input type="hidden" name="reportNm" id="reportNm">
			<input type="hidden" name="flag" id="flag">
		</form>
	</div>
</body>
<script type="text/javascript">
	$(document).ready(function(){
		<%if(session.getAttribute("userVO") == null){ %>
			$("#insertBtn").hide();
		<%} else {%>
			$("#insertBtn").show();
		<%}%>
	});
	function boardSelect(reportNm){
		document.getElementById("reportNm").value = reportNm;
		document.getElementById("flag").value = "SEL";
		var fm = document.getElementById("fm");
		fm.method = "post";
		fm.action = "reportBoard.do";
		fm.submit();
	}

	function insertBoard(){
		document.getElementById("flag").value = "INS";
		var fm = document.getElementById("fm");
		fm.method = "post";
		fm.action = "reportBoard.do";
		fm.submit();
	}
	
	function searchBoard() {
		document.getElementById("flag").value = "SCH";
		
		var fm = document.getElementById("fm");
		fm.method = "post";
		fm.action = "reportBoard.do";
		fm.submit();
	}
</script>
</html>