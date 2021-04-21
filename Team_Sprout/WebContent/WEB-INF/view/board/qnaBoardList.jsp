<%@page import="kr.or.ddit.board.vo.QnaBoardVO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>QnA 게시판</title>
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
			List<QnaBoardVO> list = (List<QnaBoardVO>)request.getAttribute("list");
			
			int cnt = list.size() / 10;
			
			int tmp = 0;
			
			for(int i = 0; i < list.size(); i++) {
			%>
			<tr>
				<td><%=list.size() - i %></td>
				<td>
					<a href="qnaBoard.do?qnaNm=<%=list.get(i).getQnaNm() %>&flag=SEL">
						<%=list.get(i).getQnaTitle() %>
					</a>
				</td>
				<td><%=list.get(i).getQnaWriter() %></td>
				<td><%=list.get(i).getQnaDate() %></td>
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
		<hr>
		<!-- 등록 버튼  -->
		<div id="btn" style="text-align: right">
			<button type="button" class="btn btn-success" id="insert">등록</button>
		</div>
		<!-- 검색 창 -->
		<div class="text-center">
			<input type="text" id="schInput">
			<button type="button" class="btn btn-success" id="search">검색</button>
		</div>
		<form id="fm">
			<input type="hidden" name="targetUrl" id="targetUrl">
		</form>
	</div>
</body>
<script type="text/javascript">
	$("#insert").click(function(){
		document.getElementById("targetUrl").value = "board/qnaBoardInsert";
		
		var fm = document.getElementById("fm");
		fm.method = "post";
		fm.action = "Team_Sprout/PageServlet";
		fm.submit();
	});
	
	$("#search").click(function(){
		location.href = "qnaBoard.do?flag=SCH&qnaTitle=" + $("#schInput").val() 
						+ "&qnaWriter=" + $("#schInput").val();
	});
</script>
</html>