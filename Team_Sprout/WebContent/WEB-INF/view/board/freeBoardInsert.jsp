<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<title>자유게시판 작성</title>
</head>
<body>
	<form action="freeBoardInsert.do" method="post"
		enctype="multipart/form-data">
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
				<td><input type="file" name="atchFileId" id="attachFile" onchange="setThumbnail()"></td>
			</tr>
		</table>
		<input type="submit" value="저장">
	</form>


	<div style="height: 700px">
		<div id="imgPrint" style="width: 500px;"></div>
	</div>

	<script type="text/javascript">
		function setThumbnail() {
			var files = document.getElementById("attachFile").files;
			var file = files[0];

			/* 선택된 파일이 없을때 경고문 출력 */
			if (files.length < 1) {
				alert("선택된 파일이 없습니다.");
				return;
			}

			/* 기존 이미지파일 제거 */
			if (document.getElementById("imgPrint").children.length > 0) {
				document.getElementById("imgPrint").children[0].remove();
			}

			/* 파일출력 */
			var reader = new FileReader();
			/* 1.이미지 파일일 경우 파일내용 불러오기*/
			if (file.type.substr(0, 5) == "image") {
				// == if(file.type.match("image")){ 
				// == if(file.type.indexOf("image") == 0 ){ 
				reader.readAsDataURL(file);

				/* 2.그 외의 경우 파일내용 불러오기*/
			} else {
				var reader = new FileReader();
				reader.readAsText(file);
			}

			/* 3-1.무명함수를 이용해서 불러온 파일내용 출력*/
			reader.onload = function() {
				/* 3-2.이미지파일일 경우 img태그를 생성해서 이미지 출력*/
				if (file.type.match("image")) {
					var imgObj;
					imgObj = document.createElement("img");
					imgObj.src = reader.result;
					imgObj.style.width = "450px";
					document.getElementById("imgPrint").style.height = "400px";
					document.getElementById("imgPrint").appendChild(imgObj);
				}
			}
		}
	</script>





</body>
</html>