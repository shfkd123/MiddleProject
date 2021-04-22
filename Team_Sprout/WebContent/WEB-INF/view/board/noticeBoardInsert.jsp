
<%@page import="kr.or.ddit.board.vo.NoticeBoardVO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>게시글 등록</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="../../css/main/boardWrite.css">
<style type="text/css">
</style>
</head>
<body>
	<!-- 테이블 -->
	<div class="container">
		<form id="fm" method="post" enctype="multipart/form-data">
			<h4><b><span>작성</span></b></h4>
			<table class="table">
				<thead>
				</thead>
				<tbody>
					<tr>
						<th>제목</th>
						<td colspan="3">
							<input type="text" name="noticeTitle" class="form-control" placeholder="제목을 입력해주세요.">
						</td>
					</tr>
					<tr>
						<td>작성자:</td>
						<td><input type="text" name="userId" value=""></td>
					</tr>
					<tr>
						<th>내용</th>
						<td colspan="3">
							<textarea name="noticeContent" class="form-control" rows="20" placeholder="내용을 입력해주세요."></textarea>
						</td>
					</tr>
					<tr>
						<th>첨부파일</th>
						<td>
							<input type="file" name="atchFile">
						</td>
				</tr>
				</tbody>
			</table>
			<hr>
			<!-- 등록 수정 삭제 버튼  -->
			<div id="btn">
				<button type="button" class="btn btn-success" id="noticeList">목록</button>
				<button type="button" class="btn btn-success" id="noticeInsert">저장</button>
			</div>	
		</form>
	</div>
</body>
<script type="text/javascript">
$("#noticeList").click(function(){
	location.href = "noticeList.do";
});

 $("#noticeInsert").click(function(){
// 	location.href = "noticeInsert.do";
	
	var fm = document.getElementById("fm");
	fm.action = "noticeInsert.do";
	fm.submit();
	
});


</script>
</html>