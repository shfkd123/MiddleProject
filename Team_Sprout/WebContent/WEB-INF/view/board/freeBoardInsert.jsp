<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>자유게시판 작성</title>
</head>
<body>
	<form action="freeBoardInsert.do" method="post" enctype="multipart/form-data">
		<table>
			<tr>
				<td>제목:</td>
				<td><input type="text" name="freeTitle"></td>
			</tr>
			<tr>
				<td>작성자:</td>
				<td><input type="text" name="userId" value=""></td>
			</tr>
			<tr>
				<td>내용:</td>
				<td><textarea rows="5" cols="10" name="freeContent"></textarea></td>
			</tr>
			<tr>
				<td>첨부파일</td>
				<td><input type="file" name="atchFileId"></td>
			</tr>
		</table>
		<input type="submit" value="저장">
	</form>
</body>
</html>