<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>QnA 게시글 등록</title>
</head>
<body>
	<!-- 테이블 -->
	<div class="container">
		<h4><b><span>작성</span></b></h4>
		<form>
			<table class="table">
				<thead>
				</thead>
				<tbody>
					<tr>
						<th>작성자</th>
						<td colspan="3" name="userNickName">작성자이다</td>
					</tr>
					<tr>
						<th>제목</th>
						<td colspan="3">
							<input type="text" class="form-control" placeholder="제목을 입력해주세요." name="qnaTitle">
						</td>
					</tr>
					<tr>
						<th>내용</th>
						<td colspan="3"><textarea class="form-control" rows="20"
								placeholder="내용을 입력해주세요." name="qnaContent"></textarea></td>
					</tr>
				</tbody>
			</table>
		</form>
		<hr>
		<!-- 등록 버튼  -->
		<div id="btn" style="text-align: right;">
			<button type="button" class="btn btn-success" id="upload">등록</button>
		</div>	
	</div>
</body>
<script type="text/javascript">
	$("#upload").click(function(){
		document.getElementById("targetUrl").value = "board/qnaBoardList";
		
		var fm = document.getElementById("fm");
		fm.method = "post";
		fm.action = "Team_Sprout/PageServlet";
		fm.submit();
	});
</script>
</html>