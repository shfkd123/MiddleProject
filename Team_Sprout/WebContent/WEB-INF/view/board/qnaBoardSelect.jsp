<%@page import="kr.or.ddit.user.vo.UserVO"%>
<%@page import="kr.or.ddit.boardComment.vo.QnaCmVO"%>
<%@page import="kr.or.ddit.comm.vo.AtchFileVO"%>
<%@page import="java.util.List"%>
<%@page import="kr.or.ddit.board.vo.QnaBoardVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	QnaBoardVO qbv = (QnaBoardVO)request.getAttribute("qbv");

	List<AtchFileVO> atchFileList = (List<AtchFileVO>) request.getAttribute("atchFileList");
	
	List<QnaCmVO> qnaCmList = (List<QnaCmVO>)request.getAttribute("qnaCmList");
	
	UserVO uv = (UserVO)session.getAttribute("userVO");
	
	String userNick = uv.getUserNickName();
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
<link rel="stylesheet" href="../../css/main/boardDetail.css">
<style type="text/css">
</style>
<script type="text/javascript">
	$(document).ready(function(){
		<%
		if(userNick != qbv.getQnaWriter()){
		%>
			$("#updateWrite").hide();
			$("#deleteWrite").hide();
		<%
		} else if(userNick == qbv.getQnaWriter()){
		%>
			$("#updateWrite").show();
			$("#deleteWrite").show();
		<%
		}
		%>
	});
</script>
</head>
<body>
	<!-- 테이블 -->
	<div class="container">
		<table class="table">
			<thead>
				<tr id="head">
					<th>번호</th>
					<td><%=qbv.getQnaNm() %></td>
					<th>작성일</th>
					<td><%=qbv.getQnaDate() %></td>
				</tr>
			</thead>
			<tbody>
				<tr>
					<th>작성자</th>
					<td colspan="3"><%=qbv.getQnaWriter() %></td>
				</tr>
				<tr>
					<th>제목</th>
					<td colspan="3"><%=qbv.getQnaTitle() %></td>
				</tr>
				<tr>
					<th>내용</th>
					<td colspan="3"><%=qbv.getQnaContent() %></td>
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
			<input type="hidden" name="qnaNm" id="qnaNm">
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
		
<script type="text/javascript">
	function goList(){
		location.href = "qnaBoard.do";
	}
	function updateBoard(){
		document.getElementById("qnaNm").value = "<%=qbv.getQnaNm() %>";
		document.getElementById("flag").value = "UPD";
		var fm = document.getElementById("fm");
		fm.method = "post";
		fm.action = "qnaBoard.do";
		fm.submit();
	}
	function deleteBoard(){
		if(confirm("정말로 삭제하시겠습니까?")){
			alert("삭제되었습니다.");
			document.getElementById("qnaNm").value = "<%=qbv.getQnaNm() %>";
			document.getElementById("flag").value = "D";
			var fm = document.getElementById("fm");
			fm.method = "post";
			fm.action = "qnaBoard.do";
			fm.submit();
		} else {
			return;
		}
	}
</script>
		<!-- 댓글 조회 -->
		<%
		
		%>
		<h4><b><span>댓글 총 <%=qnaCmList.size() %>개</span></b></h4>
		<table class="table">
			<thead>
				
				<tr>
					<th>작성자</th>
					<th style="text-align: left;">댓글</th>
					<th style="text-align: right;">작성일</th>
				</tr>
			</thead>
			<tbody>
			<%
			for(int i = 0; i < qnaCmList.size(); i++){
			%>
				<tr>
					<td style="text-align: left;"><%=qnaCmList.get(i).getqcWriter() %></td>
					<td style="text-align: right;"><%=qnaCmList.get(i).getQcContent() %></td>
					<td><%=qnaCmList.get(i).getQcDate() %>
						<div class="btn-group"  style="float: right;">
							<button type="button" class="btn btn-default btn-xs dropdown-toggle"
								data-toggle="dropdown">
								<span class="caret"></span>
							</button>
							<ul class="dropdown-menu" role="menu" id="cmtMenu">
								<li><a href="#" onclick="cmUpdate()">수정</a></li>
								<li><a href="#" onclick="cmDelete()">삭제</a></li>
							</ul>
						</div>
					</td>
				</tr>
			<%
			}
			%>
			</tbody>
		</table>
		<hr>
		<!-- 댓글 작성  -->
		<h4><b><span>댓글 작성</span></b></h4>
		<table class="table">
			<thead>
				<tr>
					<th></th>
					<th></th>
					<th></th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td colspan="3">
						<%
						if(userNick == null)  {
						%>
						<textarea class="form-control" readonly="readonly" rows="5" placeholder="댓글은 회원만 작성할 수 있습니다."></textarea>
						<%
						} else {
						%>
						<textarea class="form-control" rows="5" id="comment"></textarea>
						<%
						}
						%>
					</td>
				</tr>
				<tr>
					<td colspan="3" style="text-align: right;">
						<button type="button" class="btn btn-success" onclick="cmUpdate()">댓글 등록</button>
					</td>
				</tr>	
				
			</tbody>
		</table>
		<form id="fmCm">
			<input type="hidden" id="comment" name="comment">
			<input type="hidden" id="userId" name="userId">
			<input type="hidden" id="flag" name="flag">
		</form>
	</div>
</body>
<script type="text/javascript">
	function cmUpdate(){
		document.getElementById("qnaNm").value = "<%=qbv.getQnaNm() %>";
		document.getElementById("flag").value = "UPD";
		var fm = document.getElementById("fm");
		fmCm.method = "post";
		fm.action = "qnaBoard.do";
		fm.submit();
	}
</script>
</html>