<%@page import="kr.or.ddit.board.vo.FaqBoardVO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FAQ 게시판</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
  <link rel="stylesheet" href="../../css/main/board.css">
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
			List<FaqBoardVO> list = (List<FaqBoardVO>)request.getAttribute("list");
			for(int i = 0; i < list.size(); i++) {
				String faqNm = list.get(i).getFaqNm();
			%>
			<tr>
				<td><%=list.size() - i %></td>
				<td>
					<a href="#" onclick="boardSelect('<%=faqNm %>')">
						<%=list.get(i).getFaqTitle()%>
					</a>
				</td>
				<td><%=list.get(i).getFaqWriter()%></td>
				<td><%=list.get(i).getFaqDate() %></td>
			</tr>
			<%
			}
			if (list.size() <= 0){
			%>
				<tr>
					<td colspan="5" style="text-align: center">게시글이 없습니다.</td>
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
			<input type="hidden" name="faqNm" id="faqNm">
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
	function boardSelect(faqNm){
		document.getElementById("faqNm").value = faqNm;
		document.getElementById("flag").value = "SEL";
		var fm = document.getElementById("fm");
		fm.method = "post";
		fm.action = "faqBoard.do";
		fm.submit();
	}

	function insertBoard(){
		document.getElementById("flag").value = "INS";
		var fm = document.getElementById("fm");
		fm.method = "post";
		fm.action = "faqBoard.do";
		fm.submit();
	}
	
	function searchBoard() {
		document.getElementById("flag").value = "SCH";
		
		var searchTitle = $("#schInput").val();
		
		var fm = document.getElementById("fm");
		fm.method = "post";
		fm.action = "faqBoard.do?faqTitle=" + searchTitle;
		fm.submit();
	}
</script>
</html>