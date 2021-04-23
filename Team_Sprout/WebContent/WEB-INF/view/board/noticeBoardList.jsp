
<%@page import="kr.or.ddit.user.vo.UserVO"%>
<%@page import="kr.or.ddit.boardComment.vo.NoticeCmVO"%>
<%@page import="kr.or.ddit.board.vo.NoticeBoardVO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
    NoticeBoardVO noticeVO = (NoticeBoardVO) request.getAttribute("noticeVO");
	List<NoticeBoardVO> noticeList = (List<NoticeBoardVO>)request.getAttribute("noticeList");

	
	UserVO uv = null;
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
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
  <link rel="stylesheet" href="../../css/main/board.css">
</head>

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
				<a href="#"><img src="../../images/logo.png" id="logoImg" style="width: 100px; margin:5px;"></a>
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
							<li><a href="#">구매후기</a></li>
							<li><a href="#">FAQ</a></li>
							<li><a href="/Team_Sprout/board/qnaBoard.do">Q&#38;A</a></li>
							<li><a href="#">신고</a></li>
						</ul>
						</li>
				</ul>			
				<ul class="nav navbar-nav navbar-right">
					<%
					if(uv == null) {
					%>
					<li><a href="#" class="btn-lg"><span
							class="glyphicon glyphicon-search"></span></a></li>
					<li id="notlog"><a href="../login/login.jsp" class="btn-lg"><span
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
					<th><input type="checkbox" id="AllCheck"></th>
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
					<td><input type="checkbox" value="" name="num"></td>
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
			<button type="button" class="btn btn-success" id="insert">등록</button>
			<button type="button" class="btn btn-success" id="delete">삭제</button>			
		</div>	
		
		<form id="fm">
			<input type="hidden" name="noticeNm" id="noticeNm">
		</form>
		
		<form id="fmCm">
			<input type="hidden" name="ncNm" id="ncNmCm">	
		</form>
	</div>
</body>
<script type="text/javascript">
	function boardSelect(noticeNm){
		document.getElementById("noticeNm").value = noticeNm;
		var fm = document.getElementById("fm");
		fm.action = "noticeSelect.do";
		fm.method = "post";
		fm.submit();
		
// 		document.getElementById("ncNmCm").value = noticeNm;
// 		var fmCm = document.getElementById("fmCm");
// 		fm.action = "noticeBoardCm.do";
// 		fm.submit();
	}

	$("#insert").click(function(){
		location.href = "noticeInsert.do";
	});
	
	$("#AllCheck").click(function(){
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
</html>