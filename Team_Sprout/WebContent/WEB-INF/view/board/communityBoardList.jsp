<%@page import="kr.or.ddit.project.vo.ProjectVO"%>
<%@page import="kr.or.ddit.board.vo.CommunityBoardVO"%>
<%@page import="kr.or.ddit.user.vo.UserVO"%>
<%@page import="kr.or.ddit.board.vo.QnaBoardVO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>후기게시판</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="../../css/main/board.css">
<script type="text/javascript">
	function LogOut(){
		if(confirm("로그아웃 하시겠습니까?")){
			alert("로그아웃 되었습니다.");
			location.href = "/Team_Sprout/user/logOut.do";
		}
		return;
	}
</script>
</head>
<%
	UserVO uv = null;
	if(session != null && session.getAttribute("userVO") != null){
		uv = (UserVO)session.getAttribute("userVO");
	}
	ProjectVO pj = (ProjectVO) request.getAttribute("pjName");
%>
<body>
	<nav class="navbar">
		<!-- 왼쪽 여백 -->
		<div class="col-sm-2"></div>
		<!-- nav바 -->
		<div class="col-sm-8" id="a_head">
			<div class="navbar-header">
				<button type="button" class="navbar-toggle" data-toggle="collapse"
					data-target="#myNavbar">
					<span class="icon-bar"></span> <span class="icon-bar"></span> <span
						class="icon-bar"></span>
				</button>
				<a href="/Team_Sprout/user/logOut.do"><img src="/images/logo.png" id="logoImg" style="width: 100px; margin:5px;"></a>
			</div>
			<div class="collapse navbar-collapse" id="myNavbar">
				<ul class="nav navbar-nav">
					<li><a href="#" class="a_title">인기프로젝트</a></li>
					<li><a href="#" class="a_title">프로젝트검색</a></li>
										<li class="dropdown"><a class="dropdown-toggle"
						data-toggle="dropdown" href="#">커뮤니티 <span class="glyphicon glyphicon-chevron-down"></span></a>
						<ul class="dropdown-menu">
							<li><a href="/Team_Sprout/board/noticeList.do">공지사항</a></li>
							<li><a href="/Team_Sprout/board/freeBoard.do" class="a_title">커뮤니티</a></li>
							<li><a href="/Team_Sprout/board/communityBoard.do">구매후기</a></li>
							<li><a href="/Team_Sprout/board/faqBoard.do">FAQ</a></li>
							<li><a href="/Team_Sprout/board/qnaBoard.do">Q&#38;A</a></li>
							<li><a href="/Team_Sprout/board/reportBoard.do">신고</a></li>
						</ul>
						</li>
				</ul>			
				<ul class="nav navbar-nav navbar-right">
					<%
					if(uv == null) {
					%>
					<li id="notlog"><a href="/Team_Sprout/user/signIn.do" class="btn-lg"><span
							class="glyphicon glyphicon-user"></span></a></li>
					<%
					} else {
					%>
					<li id="userInfo" class="dropdown">
						<a class="btn-lg"class="dropdown-toggle" data-toggle="dropdown"  href="#">
						<span id="mypage"><%=uv.getUserNickName() %> 님 <span class="glyphicon glyphicon-chevron-down"></span></span>
						</a>
						<ul class="dropdown-menu">
							<li><a href="#">회원정보수정</a></li>
							<li><a href="#">후원현황</a></li>
							<li><a href="#">관심프로젝트</a></li>
							<li><a href="#">내가 만든 프로젝트</a></li>
							<li><a href="#">메세지</a></li>
						</ul>
					</li>
					
					<li id="yeslog">
						<a href="#" onclick="LogOut()" class="btn-lg">
						<span><span class="glyphicon glyphicon-log-out"></span> LOGOUT</span>
						</a>
					</li>
					<%	
					}
					%>
				</ul>
			</div>
		</div>
	<!-- 오른쪽 여백 -->
	<div class="col-sm-2"></div>
	</nav>

	<!-- 테이블 -->
	<div class="container">
		<table class="table table-hover">
			<thead>
				<tr>
					<th>번호</th>
					<th>프로젝트 이름</th>
					<th>작성자</th>
					<th>날짜</th>
				</tr>
			</thead>
			<tbody>
			<%
			List<CommunityBoardVO> list = (List<CommunityBoardVO>)request.getAttribute("list");
			
			for(int i = 0; i < list.size(); i++) {
				String cbNm = list.get(i).getCbNm();
			%>
			<tr>
				<td><%=list.size() - i %></td>
				<td>
					<a href="#" onclick="boardSelect('<%=cbNm %>')">
						<%=list.get(i).getCbTitle() %>
					</a>
				</td>
				<td><%=list.get(i).getCbWriter() %></td>
				<td><%=list.get(i).getCbDate() %></td>
			</tr>
			<%
			}
			if(list.size() < 1) {
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
			<input type="text" id="schInput" placeholder="제목 혹은 작성자">
			<button type="button" class="btn btn-success" onclick="searchBoard()">검색</button>
		</div>
		<hr>
		<!-- 등록 버튼  -->
		<div id="btn" style="text-align: right">
			<button type="button" class="btn btn-success" id="insertBtn" onclick="insertBoard()">등록</button>
		</div>
		<form id="fm">
			<input type="hidden" name="cbNm" id="cbNm">
			<input type="hidden" name="flag" id="flag">
			<input type="hidden" id="schInput2" name="search">
		</form>
	</div>
</body>
<script type="text/javascript">
	$(document).ready(function(){
		<%if(session.getAttribute("userVO") == null){ %>
			$("#insertBtn").hide();
		<%} else {%>
			$("#insertBtn").show();
		<%}%>
	});
	function boardSelect(cbNm){
		document.getElementById("cbNm").value = cbNm;
		document.getElementById("flag").value = "SEL";
		var fm = document.getElementById("fm");
		fm.method = "post";
		fm.action = "communityBoard.do";
		fm.submit();
	}

	function insertBoard(){
		document.getElementById("flag").value = "INS";
		var fm = document.getElementById("fm");
		fm.method = "post";
		fm.action = "communityBoard.do";
		fm.submit();
	}
	
	function searchBoard() {
		document.getElementById("flag").value = "SCH";
		document.getElementById("schInput2").value = $("#schInput").val();
		
		var fm = document.getElementById("fm");
		fm.method = "post";
		fm.action = "communityBoard.do";
		fm.submit();
	}
</script>
</html>