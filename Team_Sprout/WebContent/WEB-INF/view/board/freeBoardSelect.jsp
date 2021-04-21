<%@page import="kr.or.ddit.comm.vo.AtchFileVO"%>
<%@page import="java.util.List"%>
<%@page import="kr.or.ddit.board.vo.FreeBoardVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
FreeBoardVO freeVO = (FreeBoardVO) request.getAttribute("freeVO");
List<AtchFileVO> atchFileList = (List<AtchFileVO>) request.getAttribute("atchFileList");
List<FreeBoardVO> freeList = (List<FreeBoardVO>)request.getAttribute("freeList");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>게시글 상세조회</title>
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
					<td><%=freeVO.getFreeNm()%></td>
					<th>작성일</th>
					<td><%=freeVO.getFreeDate()%></td>
				</tr>
			</thead>
			<tr>
				<th>작성자</th>
				<td colspan="3"><%=freeVO.getUserId()%></td>
			</tr>
			<tr>
				<th>제목</th>
				<td colspan="3"><%=freeVO.getFreeTitle()%></td>
			</tr>
			<tr>
				<th>내용</th>
				<td colspan="3"><%=freeVO.getFreeContent()%></td>
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
					</div> <%	
					}
				}
				%>
				</td>
			</tr>
			<tbody>
		</table>
		<hr>
	</div>
	<!-- 등록 수정 삭제 버튼  -->
	<div id="btn">
		<button type="button" class="btn btn-success" id="list">목록</button>
		<button type="button" class="btn btn-success" id="insert">등록</button>
		<button type="button" class="btn btn-success" id="delete">삭제</button>
		<button type="button" class="btn btn-success" id="update">수정</button>
	</div>
	<hr>
</body>
<script type="text/javascript">
$("#update").click(function(){
	location.href = "freeBoardUpdate.do?freeNm=" + "<%=freeVO.getFreeNm()%>";
})
$("#list").click(function(){
	location.href = "freeBoardList.do";
})
$("#insert").click(function(){
	location.href = "freeBoardInsert.do";
})
$("#delete").click(function(){
	if(!confirm("삭제하시겠습니까?"))
		return;
	location.href = "freeBoardDelete.do?freeNm=" + "<%=freeVO.getFreeNm()%>";
})

</script>
</html>