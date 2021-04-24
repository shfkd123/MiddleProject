<%@page import="kr.or.ddit.board.vo.FaqBoardVO"%>
<%@page import="kr.or.ddit.user.vo.UserVO"%>
<%@page import="kr.or.ddit.comm.vo.AtchFileVO"%>
<%@page import="java.util.List"%>
<%@page import="kr.or.ddit.board.vo.QnaBoardVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	FaqBoardVO fbv = (FaqBoardVO)request.getAttribute("fbv");

	List<AtchFileVO> atchFileList = (List<AtchFileVO>) request.getAttribute("atchFileList");
		
	UserVO uv = (UserVO)session.getAttribute("userVO");

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상세조회</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script src=""></script>
<link rel="stylesheet" href="../../css/main/boardDetail.css">
<style type="text/css">
</style>
</head>
<body>
	<!-- 테이블 -->
	<div class="container">
		<table class="table">
			<thead>
				<tr id="head">
					<th>번호</th>
					<td><%=fbv.getFaqNm() %></td>
					<th>작성일</th>
					<td><%=fbv.getFaqDate() %></td>
				</tr>
			</thead>
			<tbody>
				<tr>
					<th>작성자</th>
					<td colspan="3"><%=fbv.getFaqWriter() %></td>
				</tr>
				<tr>
					<th>제목</th>
					<td colspan="3"><%=fbv.getFaqTitle() %></td>
				</tr>
				<tr>
					<th>내용</th>
					<td colspan="3"><%=fbv.getFaqContent() %></td>
				</tr>
				<tr>
					<th>첨부파일</th>
					<td colspan="3">
						<%
					if(atchFileList != null){
						for(AtchFileVO atchFileVO : atchFileList){
					%>
						<div>
							<a
							href="<%=request.getContextPath() %>/filedownload.do?fileId=<%=atchFileVO.getAtchFileId() %>&fileSn=<%=atchFileVO.getFileSn()%>">
							<%=atchFileVO.getOrignlFileNm() %></a>
						</div>
						<%	
						}
					}
					%>
				</td>
			</tr>
			</tbody>
		</table>
		<form id="fm" enctype="multipart/form-data">
			<input type="hidden" name="faqNm" id="faqNm">
			<input type="hidden" name="flag" id="flag">
		</form>
		<hr>
		<!-- 등록 수정 삭제 버튼  -->
		<div id="btn" align="right">
			<button type="button" class="btn btn-success" onclick="goList()">목록</button>
			<button type="button" id="updateWrite" class="btn btn-success" onclick="updateBoard()">수정</button>
			<button type="button" id="deleteWrite" class="btn btn-success" onclick="deleteBoard()">삭제</button>
		</div>	
		<hr>
	
	</div>
<script type="text/javascript">
	$(document).ready(function(){
		<%
		if(uv != null){
			if(!uv.getUserNickName().equals(fbv.getFaqWriter())){
			%>
				$("#updateWrite").hide();
				$("#deleteWrite").hide();
			<%
			} else if(uv.getUserNickName().equals(fbv.getFaqWriter())){
			%>
				$("#updateWrite").show();
				$("#deleteWrite").show();
			<%
			}
		}
		%>
	});
	
	function goList(){
		location.href = "faqBoard.do";
	}
	
	function updateBoard(){
		document.getElementById("faqNm").value = "<%=fbv.getFaqNm() %>";
		document.getElementById("flag").value = "UPD";
		var fm = document.getElementById("fm");
		fm.method = "post";
		fm.action = "faqBoard.do";
		fm.submit();
	}
	
	function deleteBoard(){
		if(confirm("정말로 삭제하시겠습니까?")){
			alert("삭제되었습니다.");
			document.getElementById("faqNm").value = "<%=fbv.getFaqNm() %>";
			document.getElementById("flag").value = "D";
			var fm = document.getElementById("fm");
			fm.method = "post";
			fm.action = "faqBoard.do";
			fm.submit();
		} else {
			return;
		}
	}
	
</script>
</body>
</html>