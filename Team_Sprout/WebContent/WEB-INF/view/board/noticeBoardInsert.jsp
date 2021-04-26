
<%@page import="kr.or.ddit.board.vo.NoticeBoardVO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/view/include/head.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>게시글 등록</title>
<link rel="stylesheet" type="text/css"
	href="/Team_Sprout/css/main/main.css">
<link rel="stylesheet" href="/Team_Sprout/css/main/boardWrite.css">
<style type="text/css">
#menu_title {
	text-align: center;
	background-image: url('/Team_Sprout/images/main_image.png');
	width: 100%;
	height: 250px;
	color: white;
}
div.col-sm-12 {
	margin: 0px;
	padding: 0px;
}
</style>
</head>
<body>
<!-- 헤더 이미지 및 문구 -->
	<div class="col-sm-12">
		<div id="menu_title">
			<p>
			<br><br><br>
				<h3><b>공지</b></h3>
				<br>
				* 메이커/서포터에게 전하는 안내
			</p>
		</div>
	</div>
	<!-- 전체-->
	<div class="col-sm-12">

		<!-- 왼쪽 여백 -->
		<div class="col-sm-2"></div>

		<!-- 게시판 -->
		<div class="col-sm-8">
			<h4>
				<b>작성하기</b>
			</h4>
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
		</div>

		<!-- 오른쪽 여백 -->
		<div class="col-sm-2"></div>

	</div>
</body>
<script type="text/javascript">
$("#noticeList").click(function(){
	location.href = "noticeList.do";
});

 $("#noticeInsert").click(function(){
	
	var fm = document.getElementById("fm");
	fm.action = "noticeInsert.do";
	fm.submit();
	
});


</script>
<%@include file="/WEB-INF/view/include/footer.jsp"%>
</html>