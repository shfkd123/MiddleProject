<%@page import="kr.or.ddit.board.vo.FreeBoardVO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	List<FreeBoardVO> freeList = (List<FreeBoardVO>) request.getAttribute("freeList");

	String msg = request.getParameter("msg") == null ? "" : request.getParameter("msg");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
					int freeListSize = freeList.size();

					if (freeListSize > 0) {
						for (int i = 0; i < freeListSize; i++) {
				%>
				<tr>
					<td><%=freeList.get(i).getFreeNm()%></td>
					<td><a href="freeBoardSelect.do?freeNm=<%=freeList.get(i).getFreeNm()%>"><%=freeList.get(i).getFreeTitle()%></a></td>
					<td><%=freeList.get(i).getUserId()%></td>
					<td><%=freeList.get(i).getFreeDate()%></td>
				</tr>
				<%
					}
					} else {
				%>
				<tr>
					<td colspan="5">등록된 게시글이 없습니다.</td>
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
		<!-- 등록 수정 삭제 버튼  -->
		<div id="btn">
			<button type="button" class="btn btn-success" id="insert">등록</button>
			<button type="button" class="btn btn-success">삭제</button>
		</div>
		<%
			if (msg.equals("성공")) { // 성공메시지가 전달되면...
		%>
		<script>
			alert('정상적으로 처리되었습니다.');
		</script>
		<%
			}
		%>

	</div>
</body>
<script type="text/javascript">
	$("#insert").click(function(){
		location.href = "freeBoardInsert.do";
	})
</script>	
</html>