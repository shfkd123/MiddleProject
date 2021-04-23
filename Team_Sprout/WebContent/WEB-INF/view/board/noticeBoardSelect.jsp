<%@page import="kr.or.ddit.user.vo.UserVO"%>
<%@page import="kr.or.ddit.boardComment.vo.NoticeCmVO"%>
<%@page import="kr.or.ddit.comm.vo.AtchFileVO"%>
<%@page import="java.util.List"%>
<%@page import="kr.or.ddit.board.vo.NoticeBoardVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
UserVO uv = (UserVO)session.getAttribute("userVO");
String userNick = "";
if(uv == null) {
	
} else {
userNick = uv.getUserNickName();

}

//NoticeBoard
NoticeBoardVO noticeVO = (NoticeBoardVO) request.getAttribute("noticeVO");
List<AtchFileVO> atchFileList = (List<AtchFileVO>)request.getAttribute("atchFileList");
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

<!-- 댓글 Modal -->
  <div class="modal fade" id="myModal" role="dialog">
    <div class="modal-dialog">
    
      <!-- 수정 Modal content-->
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          <h4 class="modal-title">댓글 수정하기</h4>
        </div>
        <div class="modal-body">
          <textarea class="form-control" rows="3"></textarea>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        </div>
      </div>
      
    </div>
  </div>
  
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
			
			<form id="fm" enctype="multipart/form-data">
				<input type="hidden" name="noticeNm" id=""noticeNm"">
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
		<!-- 댓글 조회 -->
	<h4><b><span>댓글 총 <%=noticeCmList.size() %>개</span></b></h4>
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
			for(int i = 0; i < noticeCmList.size(); i++){
				if(noticeCmList.size() == 0){
				%>
				<tr>
					<td colspan="3" align="left">댓글이 없습니다.</td>
				</tr>
				<%	
				} else {
			%><!-- 댓글 수정 Modal -->
				<div class="modal fade" id="myModal" role="dialog">
					<div class="modal-dialog">
				      <!-- 수정 Modal content-->
				      <div class="modal-content">
				        <div class="modal-header">
				          <button type="button" class="close" data-dismiss="modal">&times;</button>
				          <h4 class="modal-title">댓글 수정하기</h4>
				        </div>
				        <div class="modal-body">
				          <textarea class="form-control" rows="3" id="editCm"></textarea>
				        </div>
				        <div class="modal-footer">
				          <button type="button" class="btn btn-default" onclick="cmUpdate('<%=noticeCmList.get(i).getNcNm() %>')">저장</button>
				          <button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
				        </div>
				      </div>
				 	</div>
		  		</div>
				<tr>
					<td style="text-align: left;">
					<%=noticeCmList.get(i).getUserId()%>
					</td>
					<td style="text-align: right;"><%=noticeCmList.get(i).getNcContent() %></td>
					<td><%=noticeCmList.get(i).getNcDate() %>
						<div class="btn-group"  style="float: right;">
							<button type="button" class="btn btn-default btn-xs dropdown-toggle"
								data-toggle="dropdown">
								<span class="caret"></span>
							</button>
							<ul class="dropdown-menu" role="menu" id="cmtMenu">
								<li><a data-toggle="modal" data-target="#myModal">수정</a>
								</li>
								<li><a href="#" onclick="cmDelete('<%=noticeCmList.get(i).getNcNm() %>')">삭제</a></li>
							</ul>
						</div>
					</td>
				</tr>
			<%
				}
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
						if(uv == null)  {
						%>
						<textarea class="form-control" readonly="readonly" rows="5" placeholder="댓글은 회원만 작성할 수 있습니다."></textarea>
						<%
						} else {
						%>
						<textarea class="form-control" rows="5" id="commentWrite"></textarea>
						<%
						}
						%>
					</td>
				</tr>
				<tr>
					<td colspan="3" style="text-align: right;">
						<button type="button" class="btn btn-success" onclick="cmCreate()">댓글 등록</button>
					</td>
				</tr>	
				
			</tbody>
		</table>
		<form id="fmCm">
			<input type="hidden" id="ncNm" name="ncNm">
			<input type="hidden" id="fmQcNm" name="ncNmCm">
			<input type="hidden" id="comment" name="ncContent">
			<input type="hidden" id="userId" name="userId">
			<input type="hidden" id="cmType" name="ncType">
			<input type="hidden" id="flagCm" name="flagCm">
		</form>
	</div>
</body>
<script type="text/javascript">
$("#list").click(function(){
	location.href = "noticeList.do";
});
$("#delete").click(function(){
	if(!confirm("이 게시글을 삭제하시겠습니까?"))
		return;
<%-- 	location.href = "noticeDelete.do?noticeNm=" + "<%=noticeVO.getNoticeNm()%>"; --%>
});
$("#update").click(function(){
<%-- 	location.href = "noticeUpdate.do?noticeNm=" + "<%=noticeVO.getNoticeNm()%>"; --%>
});

function noticeCmInsert(noticeNm){
	alert("등록!!!!!!!!!!!!!!!!!");
	document.getElementById("ncNm").value = "<%=noticeVO.getNoticeNm() %>";
	document.getElementById("ncContent").value = "<%=noticeVO.getNoticeContent() %>";
	
	var fmCm = document.getElementById("fmCm");
	fmCm.method = "post";
	fmCm.action = "noticeInsertComment.do";
	fmCm.submit();
	
}

</script>
</html>