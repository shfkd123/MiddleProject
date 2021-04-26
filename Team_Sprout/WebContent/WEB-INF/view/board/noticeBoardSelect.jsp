<%@page import="java.util.ArrayList"%>
<%@page import="kr.or.ddit.user.vo.UserVO"%>
<%@page import="kr.or.ddit.boardComment.vo.NoticeCmVO"%>
<%@page import="kr.or.ddit.comm.vo.AtchFileVO"%>
<%@page import="java.util.List"%>
<%@page import="kr.or.ddit.board.vo.NoticeBoardVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/view/include/head.jsp"%>
    
<%
/* UserVO uv = (UserVO)session.getAttribute("userVO");
String userNick = "";
if(uv == null) {
	
} else {
userNick = uv.getUserNickName();

}
 */
//NoticeBoard
NoticeBoardVO noticeVO = (NoticeBoardVO) request.getAttribute("noticeVO");
List<AtchFileVO> atchFileList = (List<AtchFileVO>)request.getAttribute("atchFileList");
List<NoticeCmVO> noticeCmList = (List<NoticeCmVO>)request.getAttribute("noticeCmList");
if(noticeCmList == null){
	noticeCmList = new ArrayList<NoticeCmVO>();
}
 uv = (UserVO)session.getAttribute("userVO");

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>게시글 상세조회</title>
<link rel="stylesheet" type="text/css"
	href="/Team_Sprout/css/main/main.css">
<link rel="stylesheet" href="/Team_Sprout/css/main/boardDetail.css">
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
				<input type="hidden" name="noticeNm" id="noticeNm">
				<input type="hidden" name="noticeTitle" id="noticeTitle">
				<input type="hidden" name="noticeContent" id="noticeContent">
			</form>
		<hr>
		<!-- 등록 수정 삭제 버튼  -->
		<div id="btn" align="right">
			<button type="button" class="btn btn-success" id="NoticeList" onclick="NoticeList()">목록</button>
			<button type="button" id="updateWrite" class="btn btn-success" onclick="Noticeupdate()">수정</button>
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
					<th style="text-align: left;">작성일</th>
				</tr>
			</thead>
			<tbody>
			
			<%
			for(int i = 0; i < noticeCmList.size(); i++){
				if(noticeCmList.size() < 0){
				%>
				<tr>
					<td colspan="3" align="left">댓글이 없습니다.</td>
				</tr>
				<%	
				} else {
				%>
				<tr>
					<td style="text-align: left;">
					<%=noticeCmList.get(i).getNcWriter() %>
					</td>
					<td style="text-align: right;"><%=noticeCmList.get(i).getNcContent() %></td>
					<td><%=noticeCmList.get(i).getNcContent() %>
						<%if(uv != null) {
							if(uv.getUserNickName().equals(noticeCmList.get(i).getNcWriter())){
							%>
							<div class="btn-group" style="float: right;">
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
						          <button type="button" class="btn btn-default" onclick="cmUpdate('<%=noticeCmList.get(i).getNcNm() %>')">저장</button>
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
			<input type="hidden" id="noticeNcNm" name="ncNm">
			<input type="hidden" id="fmNcNm" name="ncNm">
			<input type="hidden" id="comment" name="ncContent">
			<input type="hidden" id="userId" name="userId">
			<input type="hidden" id="ncType" name="ncType">
			<input type="hidden" id="flagCm" name="flagCm">
</div>
			<hr>
		</div>
		
		<!-- 오른쪽 여백 -->
		<div class="col-sm-2"></div>
		
	</div>
</body>
<script type="text/javascript">
<%--  $(document).ready(function(){
	$("#updateWrite").css("display", "none");
	$("#deleteWrite").css("display", "none");
	<%
	if(uv != null){
		if(uv.getUserNickName().equals(noticeVO.getUserId())){
		%>
			$("#updateWrite").css("display", "inline");
			$("#deleteWrite").css("display", "inline");
		<%
		}
	}
	%>
});
 --%>
function NoticeList(){
	var fm = document.getElementById("fm");
	fm.method = "post";
	fm.action = "noticeList.do";
	fm.submit();
}

function deleteBoard(){
	if(confirm("이 게시글을 삭제하시겠습니까?")){
		alert("삭제되었습니다.");
		document.getElementById("noticeNm").value = "<%=noticeVO.getNoticeNm()%>";
		var fm = document.getElementById("fm");
		fm.method = "post";
		fm.action = "noticeDelete.do";
		fm.submit();		
	}else {
		return;
	}	
}

function Noticeupdate(){
	document.getElementById("noticeNm").value = "<%=noticeVO.getNoticeNm()%>";
	var fm = document.getElementById("fm");
	fm.method = "get";
	fm.action = "noticeUpdate.do";
	fm.submit();
	
}

function noticeCmInsert(noticeNm){
	document.getElementById("ncNm").value = "<%=noticeVO.getNoticeNm() %>";
	document.getElementById("ncContent").value = "<%=noticeVO.getNoticeContent() %>";
	
	var fmCm = document.getElementById("fmCm");
	fmCm.method = "post";
	fmCm.action = "noticeInsertComment.do";
	fmCm.submit();
}

function cmCreate(){
	<%if(uv == null){%>
		alert("댓글은 회원만 작성 가능합니다.");
		return;
	<%}%>
	document.getElementById("noticeNcNm").value = "<%=noticeVO.getNoticeNm() %>";
	<%
	if(uv != null){
	%>
	document.getElementById("userId").value = "<%=uv.getUserId() %>";
	<%}%>
	document.getElementById("comment").value = $("#commentWrite").val();
	document.getElementById("flagCm").value = "C";
	var fmCm = document.getElementById("fmCm");
	fmCm.method = "post";
	fmCm.action = "noticeBoardComment.do";
	fmCm.submit();
}

function cmUpdate(ncNm){
	if(confirm("수정하시겠습니까?")){
		alert("수정이 완료되었습니다.");
		<%
		if(uv != null){
		%>
		document.getElementById("userId").value = "<%=uv.getUserId() %>";
		<%}%>
		document.getElementById("noticeNcNm").value = "<%=noticeVO.getNoticeNm() %>";
		document.getElementById("fmNcNm").value = ncNm;
		document.getElementById("comment").value = $("#editCm").val();
		document.getElementById("flagCm").value = "U";
		var fmCm = document.getElementById("fmCm");
		fmCm.method = "post";
		fmCm.action = "noticeBoardComment.do";
		fmCm.submit();
	}
	return;
}

function cmDelete(ncNm){
	if(confirm("정말 댓글을 삭제하시겠습니까?")){
		alert("댓글이 삭제되었습니다.");
		<%
		if(uv != null){
		%>
		document.getElementById("userId").value = "<%=uv.getUserId() %>";
		<%}%>
		document.getElementById("noticeNcNm").value = "<%=noticeVO.getNoticeNm() %>";
		document.getElementById("fmNcNm").value = qcNm;
		document.getElementById("flagCm").value = "D";
		var fmCm = document.getElementById("fmCm");
		fmCm.method = "post";
		fmCm.action = "noticeBoardComment.do";
		fmCm.submit();
	}
	return;
}
</script>
<%@include file="/WEB-INF/view/include/footer.jsp"%>
</html>