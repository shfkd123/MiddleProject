<%@page import="kr.or.ddit.boardComment.vo.CommunityCmVO"%>
<%@page import="kr.or.ddit.board.vo.CommunityBoardVO"%>
<%@page import="kr.or.ddit.user.vo.UserVO"%>
<%@page import="kr.or.ddit.comm.vo.AtchFileVO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    	<%@include file="/WEB-INF/view/include/adminHead.jsp"%>
<%
	CommunityBoardVO cbv = (CommunityBoardVO)request.getAttribute("cbv");

	List<AtchFileVO> atchFileList = (List<AtchFileVO>) request.getAttribute("atchFileList");
	
	List<CommunityCmVO> communityCmList = (List<CommunityCmVO>)request.getAttribute("communityCmList");
	
	UserVO uv = (UserVO)session.getAttribute("userVO");

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상세조회</title>
<link rel="stylesheet" type="text/css"
	href="/Team_Sprout/css/main/main.css">
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
					<td><%=cbv.getCbNm() %></td>
					<th>작성일</th>
					<td><%=cbv.getCbDate() %></td>
				</tr>
			</thead>
			<tbody>
				<tr>
					<th>작성자</th>
					<td colspan="3"><%=cbv.getCbWriter() %></td>
				</tr>
				<tr>
					<th>제목</th>
					<td colspan="3"><%=cbv.getCbTitle() %></td>
				</tr>
				<tr>
					<th>내용</th>
					<td colspan="3"><%=cbv.getCbContent()%></td>
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
			<input type="hidden" name="cbNm" id="cbNm">
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
		<h4><b><span>댓글 총 <%=communityCmList.size() %>개</span></b></h4>
		<table class="table">
			<thead>
				<tr>
					<th>작성자</th>
					<th style="text-align: left;">댓글</th>
					<th style="text-align: left;">작성일</th>
				</tr>
			</thead>
			<tbody>
			<%
			for(int i = 0; i < communityCmList.size(); i++){
				if(communityCmList.size() == 0){
				%>
				<tr>
					<td colspan="3" align="left">댓글이 없습니다.</td>
				</tr>
				<%	
				} else {
				%>
				<tr>
					<td style="text-align: left;">
					<%=communityCmList.get(i).getCcWriter() %>
					</td>
					<td style="text-align: right;"><%=communityCmList.get(i).getCcContent() %></td>
					<td><%=communityCmList.get(i).getCcDate() %>
						<%if(uv != null) {
							if(uv.getUserNickName().equals(communityCmList.get(i).getCcWriter())){
							%>
							<div class="btn-group" style="float: right;">
								<button type="button" class="btn btn-default btn-xs dropdown-toggle"
									data-toggle="dropdown">
									<span class="caret"></span>
								</button>
								<ul class="dropdown-menu" role="menu" id="cmtMenu">
									<li><a data-toggle="modal" data-target="#myModal">수정</a>
									</li>
									<li><a href="#" onclick="cmDelete('<%=communityCmList.get(i).getCcNm() %>')">삭제</a></li>
								</ul>
							</div>
							<%
							}
						}
						%>
						<!-- 댓글 수정 Modal -->
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
						          <button type="button" class="btn btn-default" onclick="cmUpdate('<%=communityCmList.get(i).getCcNm() %>')">저장</button>
						          <button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
						        </div>
						      </div>
						 	</div>
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
<!-- 						<div class="checkbox"> -->
<!-- 							<label><input type="checkbox" id="secret">비공개</label> -->
<!-- 						</div> -->
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
			<input type="hidden" id="ccNm" name="ccNm">
			<input type="hidden" id="fmCcNm" name="ccNmCm">
			<input type="hidden" id="comment" name="qcContent">
			<input type="hidden" id="userId" name="userId">
			<input type="hidden" id="ccType" name="ccType">
			<input type="hidden" id="flagCm" name="flagCm">
		</form>
	</div>
<script type="text/javascript">
	$(document).ready(function(){
		$("#updateWrite").css("display", "none");
		$("#deleteWrite").css("display", "none");
		<%
		if(uv != null){
			if(uv.getUserNickName().equals(cbv.getCbWriter())){
			%>
				$("#updateWrite").css("display", "inline");
				$("#deleteWrite").css("display", "inline");
			<%
			}
		}
		%>
	});
	
	function goList(){
		location.href = "adminCommunityBoard.do";
	}
	
	function updateBoard(){
		document.getElementById("cbNm").value = "<%=cbv.getCbNm()%>";
		document.getElementById("flag").value = "UPD";
		var fm = document.getElementById("fm");
		fm.method = "post";
		fm.action = "adminCommunityBoard.do";
		fm.submit();
	}
	
	function deleteBoard(){
		if(confirm("정말로 삭제하시겠습니까?")){
			alert("삭제되었습니다.");
			document.getElementById("cbNm").value = "<%=cbv.getCbNm() %>";
			document.getElementById("flag").value = "D";
			var fm = document.getElementById("fm");
			fm.method = "post";
			fm.action = "adminCommunityBoard.do";
			fm.submit();
		} else {
			return;
		}
	}
	function cmCreate(){
		<%if(uv == null){%>
			alert("댓글은 회원만 작성 가능합니다.");
			return;
		<%}%>
		document.getElementById("ccNm").value = "<%=cbv.getCbNm() %>";
		<%
		if(uv != null){
		%>
		document.getElementById("userId").value = "<%=uv.getUserId() %>";
		<%}%>
		document.getElementById("comment").value = $("#commentWrite").val();
		document.getElementById("flagCm").value = "C";
		var fmCm = document.getElementById("fmCm");
		fmCm.method = "post";
		fmCm.action = "adminCommunityBoardComment.do";
		fmCm.submit();
	}
	
	function cmUpdate(ccNm){
		if(confirm("수정하시겠습니까?")){
			alert("수정이 완료되었습니다.");
			<%
			if(uv != null){
			%>
			document.getElementById("userId").value = "<%=uv.getUserId() %>";
			<%}%>
			document.getElementById("ccNm").value = "<%=cbv.getCbNm() %>";
			document.getElementById("fmCcNm").value = ccNm;
			document.getElementById("comment").value = $("#editCm").val();
			document.getElementById("flagCm").value = "U";
			var fmCm = document.getElementById("fmCm");
			fmCm.method = "post";
			fmCm.action = "adminCommunityBoardComment.do";
			fmCm.submit();
		}
		return;
	}
	
	function cmDelete(ccNm){
		if(confirm("정말 댓글을 삭제하시겠습니까?")){
			alert("댓글이 삭제되었습니다.");
			<%
			if(uv != null){
			%>
			document.getElementById("userId").value = "<%=uv.getUserId() %>";
			<%}%>
			document.getElementById("ccNm").value = "<%=cbv.getCbNm() %>";
			document.getElementById("fmCcNm").value = ccNm;
			document.getElementById("flagCm").value = "D";
			var fmCm = document.getElementById("fmCm");
			fmCm.method = "post";
			fmCm.action = "adminCommunityBoardComment.do";
			fmCm.submit();
		}
		return;
	}
</script>
</body>
</html>