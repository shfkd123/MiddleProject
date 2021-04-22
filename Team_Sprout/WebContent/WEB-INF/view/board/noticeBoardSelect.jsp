<%@page import="kr.or.ddit.boardComment.vo.NoticeCmVO"%>
<%@page import="kr.or.ddit.comm.vo.AtchFileVO"%>
<%@page import="java.util.List"%>
<%@page import="kr.or.ddit.board.vo.NoticeBoardVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
//NoticeBoard
NoticeBoardVO noticeVO = (NoticeBoardVO) request.getAttribute("noticeVO");
List<AtchFileVO> atchFileList = (List<AtchFileVO>) request.getAttribute("atchFileList");
List<NoticeBoardVO> noticeList = (List<NoticeBoardVO>)request.getAttribute("noticeList");

//NoticeComment
NoticeCmVO noticeCmVO = (NoticeCmVO) request.getAttribute("noticeCmVO");
List<NoticeCmVO> noticeCmList = (List<NoticeCmVO>)request.getAttribute("noticeCmList");

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>게시글 상세조회</title>
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
</head>
<body>
<!-- 테이블 -->
	<div class="container">
		<table class="table">
			<thead>
				<tr id="head">
					<th>번호</th>
					<td><%=noticeVO.getNoticeNm()%></td>
					<th>작성일</th>
					<td><%=noticeVO.getNoticeDate()%></td>
				</tr>
			</thead>
				<tr>
					<th>작성자</th>
					<td colspan="3"><%=noticeVO.getUserId()%></td>
				</tr>
				<tr>
					<th>제목</th>
					<td colspan="3"><%=noticeVO.getNoticeTitle()%></td>
				</tr>
				<tr>
					<th>내용</th>
					<td colspan="3"><%=noticeVO.getNoticeContent()%></td>
				</tr>
				<tr>
					<th>첨부파일</th>
					<td colspan="3"><%
				if(atchFileList != null){
					for(AtchFileVO atchFileVO : atchFileList){
				%>
				<div>
					<a
						href="<%=request.getContextPath() %>/filedownload.do?fileId=<%=atchFileVO.getAtchFileId() %>&fileSn=<%=atchFileVO.getFileSn()%>">
						<%=atchFileVO.getOrignlFileNm() %></a>
				</div> <%	
					}
				}
				%></td>
				</tr>
			<tbody>
			</table>
		<hr>
		<!-- 등록 수정 삭제 버튼  -->
	<div id="btn">
		<button type="button" class="btn btn-success" id="list">목록</button>
		<button type="button" class="btn btn-success" id="delete">삭제</button>
		<button type="button" class="btn btn-success" id="update">수정</button>
	</div>
	<hr>

		<h4><b><span>댓글 총 개</span></b></h4>
		<table class="table">
			<thead>
				<tr>
					<th>번호</th>
					<th style="text-align: left;">작성자아이디</th>
					<th style="text-align: right;">
						날짜
						<div class="btn-group"  style="float: right;">
							<button type="button" class="btn btn-default btn-xs dropdown-toggle"
								data-toggle="dropdown">
								<span class="caret"></span>
							</button>
							<ul class="dropdown-menu" role="menu">
								<li><a href="#">수정</a></li>
								<li><a href="#">삭제</a></li>
							</ul>
						</div>
					</th>
				</tr>
			</thead>
			<tbody>
			<!-- 댓글 조회 -->
			<%
				for(int i=0; i <noticeCmList.size(); i++){
					
			%>
				<tr>
					<td colspan="3">댓글 내용 이다.</td>
					<td><%=noticeCmList.get(i).getNcNm()%></td>
					<td><%=noticeCmList.get(i).getUserId() %></td>
					<td><%=noticeCmList.get(i).getNcDate() %></td>
				</tr>
				<%
				}
			if(noticeCmList.size() < 1){
				%>
				<tr>
					<td colspan="3" style="text-align: center">게시글이 없습니다.</td>
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
						<textarea class="form-control" rows="5" placeholder="댓글은 회원만 작성할 수 있습니다."></textarea>
					</td>
				</tr>
				<tr>
					<td colspan="3" style="text-align: right;">
						<button type="button" class="btn btn-success">댓글 등록</button>
					</td>
				</tr>	
			</tbody>
		</table>
	</div>
</body>
<script type="text/javascript">
$("#list").click(function(){
	location.href = "noticeList.do";
});
$("#delete").click(function(){
	if(!confirm("이 게시글을 삭제하시겠습니까?"))
		return;
	location.href = "noticeDelete.do?noticeNm=" + "<%=noticeVO.getNoticeNm()%>";
});
$("#update").click(function(){
	location.href = "noticeUpdate.do?noticeNm=" + "<%=noticeVO.getNoticeNm()%>";
});

</script>
</html>