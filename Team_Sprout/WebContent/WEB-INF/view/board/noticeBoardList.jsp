
<%@page import="kr.or.ddit.user.vo.UserVO"%>
<%@page import="kr.or.ddit.boardComment.vo.NoticeCmVO"%>
<%@page import="kr.or.ddit.board.vo.NoticeBoardVO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@include file="/WEB-INF/view/include/head.jsp"%>   
<%
    NoticeBoardVO noticeVO = (NoticeBoardVO) request.getAttribute("noticeVO");
	List<NoticeBoardVO> noticeList = (List<NoticeBoardVO>)request.getAttribute("noticeList");

	if(session != null && session.getAttribute("userVO") != null){
		uv = (UserVO)session.getAttribute("userVO");
	}
%>

    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항게시판</title>
<meta charset="utf-8">
<link rel="stylesheet" type="text/css"
	href="/Team_Sprout/css/main/main.css">
<link rel="stylesheet" href="/Team_Sprout/css/main/board.css">
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
		<br><br>
			<table class="table table-hover">
			<thead>
				<tr>
					<!-- <th><input type="checkbox" id="AllCheck"></th> -->
					<th>번호</th>
					<th>제목</th>
					<th>작성자</th>
					<th>날짜</th>
				</tr>
			</thead>
			<tbody>
			<%
				for(int i=0; i <noticeList.size(); i++){
					//System.out.print(noticeList.get(i).toString());
			%>
				<tr>
					<!-- <td><input type="checkbox" value="" name="num"></td> -->
					<td><%=noticeList.get(i).getNoticeNm()%></td>
					<td>
						<a href="#" onclick="boardSelect('<%=noticeList.get(i).getNoticeNm()%>')">
						<%=noticeList.get(i).getNoticeTitle() %>
						</a>
					</td>
					<td><%=noticeList.get(i).getUserId()%></td>
					<td><%=noticeList.get(i).getNoticeDate()%></td>
				</tr>
				<%
				}
			if(noticeList.size() < 1) {
				%>
				
				<tr>
					<td colspan="5" style="text-align: center">게시글이 없습니다.</td>
				</tr>

				<%
			}
			
			%>
			</tbody>
		</table>
		<!-- 페이지 이동 -->
		<div class="text-center">
			<ul class="pagination">
				<li><a href="">1</a></li>
				<li><a href="">2</a></li>
				<li><a href="">3</a></li>
				<li><a href="">4</a></li>
				<li><a href="">5</a></li>
			</ul>
		</div>
		<!-- 검색 창 -->
		<div class="text-center">
			<input type="text" id="searchInput" placeholder="제목 검색">
			<button type="button" id="search" class="btn btn-success">검색</button>
		</div>
		<hr>
		
		<!-- 등록 수정 삭제 버튼  -->
		<div id="btn">
			<button type="button" class="btn btn-success" id="insertBtn" onclick="insert()">등록</button>
			<button type="button" class="btn btn-success" id="delete">삭제</button>			
		</div>	
		
		<form id="fm">
			<input type="hidden" name="noticeNm" id="noticeNm">
		</form>
		
		<form id="fmCm">
			<input type="hidden" name="ncNm" id="ncNmCm">	
		</form>
		</div>

		<!-- 오른쪽 여백 -->
		<div class="col-sm-2"></div>

	</div>

</body>
<script type="text/javascript">

function boardSelect(noticeNm){
	document.getElementById("noticeNm").value = noticeNm;
	var fm = document.getElementById("fm");
	fm.action = "noticeSelect.do";
	fm.method = "post";
	fm.submit();
}
	
function insert(){

	var fm = document.getElementById("fm");
	fm.action = "noticeInsert.do";
	fm.method = "get";
	fm.submit();
}
	
	/* $("#AllCheck").click(function(){
		// '전체선택' 체크박스가 체크 되어 있을때
		if($(this).prop("checked")){
			$(":checkbox").prop("checked", true);
		} 
		// '전체선택' 체크박스가 체크가 되어있지 않을때
		else if($(this).prop("checked", false)){
			$(":checkbox").prop("checked", false);
		}
	
		// 체크박스가 전부 체크되어있으면 '전체선택' 체크
		// 체크박스에 하나라도 체크되어있지 않으면 '전체선택' 체크해제
		$(":checkbox").click(function(){
			if($("[name=num]").not(":checked").length == 0) {
				$("#AllCheck").prop("checked", true);
			} else if ($("[name=num]").not(":checked").length > 0){
				$("#AllCheck").prop("checked", false);
			}
		});
		
	});
 */

 	$("#delete").click(function(){
		var tempList = [];
		if($("[name=num]").prop("checked")){
			console.log($("[name=num]").prop("checked"));
			tempList.append();
			
		if(confirm("삭제하시겠습니까?")){	
			for(var i=0; i <noticeList.size(); i++){	
		<%-- 		location.href = "noticeDelete.do?noticeNm=" + "<%=noticeList.get(i).getNoticeNm()%>"; --%>
			}		
		}else
			return;
		}
	});
	
 	
	$("#search").click(function(){
		console.log($("#searchInput").val());
		
		var searchTitle = $("#searchInput").val();
		
		location.href = "noticeSearch.do?notice_title=" + searchTitle;
	});
	
</script>
<%@include file="/WEB-INF/view/include/footer.jsp"%>
</html>