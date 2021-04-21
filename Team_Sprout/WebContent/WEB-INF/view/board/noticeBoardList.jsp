
<%@page import="kr.or.ddit.board.vo.NoticeBoardVO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	List<NoticeBoardVO> noticeList = (List<NoticeBoardVO>)request.getAttribute("noticeList");

%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항게시판</title>
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
					<th><input type="checkbox" value=""></th>
					<th>번호</th>
					<th>제목</th>
					<th>작성자</th>
					<th>날짜</th>
				</tr>
			</thead>
			<tbody>
			<%
		
				for(int i =0; i <noticeList.size(); i++){
			%>
				<tr>
					<td><input type="checkbox" value=""></td>
					<td><%=noticeList.get(i).getNoticeNm()%></td>
					<td><a href="noticeSelect.do?noticeNm=<%=noticeList.get(i).getNoticeNm()%>"><%=noticeList.get(i).getNoticeTitle()%></a></td>
					<td><%=noticeList.get(i).getUserId()%></td>
					<td><%=noticeList.get(i).getNoticeDate()%></td>
				</tr>
				<%
				}
			if(noticeList.size() < 1) {
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
			<input type="text">
			<button type="button" class="btn btn-success">검색</button>
		</div>
		<hr>
		<!-- 등록 수정 삭제 버튼  -->
		<div id="btn">
			<button type="button" class="btn btn-success" id="insert">등록</button>
			<button type="button" class="btn btn-success">삭제</button>
			
		</div>	
	</div>
</body>
<script type="text/javascript">
	$("#insert").click(function(){
		location.href = "noticeInsert.do";
	});
</script>
</html>