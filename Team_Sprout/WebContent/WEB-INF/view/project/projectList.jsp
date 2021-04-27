<%@page import="kr.or.ddit.project.vo.ProjectVO"%>
<%@page import="kr.or.ddit.project.vo.ProjectOptionVO"%>
<%@page import="kr.or.ddit.user.vo.UserVO"%>
<%@page import="kr.or.ddit.comm.vo.AtchFileVO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	ProjectVO pv = (ProjectVO)request.getAttribute("pv");

	List<ProjectVO> list = (List<ProjectVO>)request.getAttribute("list");

	List<AtchFileVO> atchFileList = (List<AtchFileVO>) request.getAttribute("atchFileList");
		
	UserVO uv = (UserVO)session.getAttribute("userVO");
	
	/* pov.setPjNm(pjNm); */

%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>프로젝트 목록</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="preconnect" href="https://fonts.gstatic.com">
<link rel="preconnect" href="https://fonts.gstatic.com">
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400&display=swap"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link href="https://fonts.googleapis.com/css?family=Lato"
	rel="stylesheet" type="text/css">
<link href="https://fonts.googleapis.com/css?family=Montserrat"
	rel="stylesheet" type="text/css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<link rel="stylesheet" type="text/css"
	href="/Team_Sprout/css/main/main.css">
<link rel="stylesheet" type="text/css"
	href="/Team_Sprout/css/main/prjList.css">

</head>
<body>
	<!-- 상단 전체   -->
	<div class="col-sm-12">

		<!-- 왼쪽 공백 2 -->
		<div class="col-sm-2"></div>

		<!-- 검색창 10 -->
		<div class="col-sm-8">
			<br>
			<br>
			<h3 style="font-weight: bold">프로젝트 검색</h3>
			<form action="/action_page.php">
				<div class="input-group">
					<input type="text" class="form-control" placeholder="프로젝트를 검색하세요."
						name="search">
					<div class="input-group-btn">
						<button class="btn btn-success" type="submit">
							<i class="glyphicon glyphicon-search"></i>
						</button>
					</div>
				</div>
			</form>
			<br>
			<h4 style="font-weight: bold">총 개의 프로젝트</h4>
		</div>

		<!-- 오른쪽 공백 2 -->
		<div class="col-sm-2"></div>

	</div>

	<!-- 펀딩 리스트 12 -->
	<div class="col-sm-12">
		<!-- 왼쪽 공백 2 -->
		<div class="col-sm-2"></div>
		<!-- 1번 항목 2-->
		<%
			for(int i = 0; i < list.size(); i++){
			long pjNm = list.get(i).getPjNm();	
			
			ProjectVO pv2 = list.get(i);
		%>
		<div class="col-sm-2">

			<img
				src="<%=request.getContextPath()%>/filedownload.do?fileId=<%=pv2.getAtchFileId()%>&fileSn=1"
				class="img-rounded" style="width: 100px; height: 100px" alt="Image">

			<h4 onclick="projectSelect('<%=list.get(i).getPjName()%>')"><%=list.get(i).getPjName()%></h4>
			<p>
				<a href="#"><%=list.get(i).getPjCategory()%></a>
			</p>
			<span class="gold">120% 달성</span>
			<progress value="100" max="100"></progress>
			<div class="time">
				<span>마감일 : <%=list.get(i).getPjDday()%></span>
			</div>
		</div>
			<%
				}
				if (list.size() <= 0) {
			%>
		<div class="col-sm-2">	
			<p>등록된 프로젝트가 없습니다.</p>
		</div>
		<%
			}
		%>

		<!-- 여백 2-->
		<div class="col-sm-2"></div>
	</div>

	<!-- top -->
	<a style="display: scroll; position: fixed; bottom: 40px; right: 40px;"
		href="#" title="top"><img src="../../images/topbutton.png"
		width="40px"></a>
	<button type="button" onclick="moveRegPage()">등록</button>
	<!-- footer -->
	<footer class="container-fluid text-center">
		<br>
		<br>
		<p>Design By Seul-gi</p>
		<p>
			스프라우트는 플랫폼 제공자로서 프로젝트의 당사자가 아니며, 직접적인 통신판매를 진행하지 않습니다.<br> 프로젝트의
			완수 및 선물제공의 책임은 해당 프로젝트의 창작자에게 있으며,<br> 프로젝트와 관련하여 후원자와 발생하는 법적
			분쟁에 대한 책임은 해당 창작자가 부담합니다.
		</p>
		<p>스프라우트(주) | 스프라우트 123-45-67890 | 대전광역시 중구, 영민빌딩 4층 ddit 403호 |
			통신판매업 2021-1234-1234-123 | 대표전화 042) 000-1234</p>
	</footer>
	<form id="fm">
		<input type="hidden" name="pjNm" id="pjNm"> <input
			type="hidden" name="flag" id="flag">
	</form>
</body>
<script type="text/javascript">
	function projectSelect(pjNm){
		document.getElementById("pjNm").value = pjNm;
		document.getElementById("flag").value = "SEL";
		var fm = document.getElementById("fm");
		fm.method = "post";
		fm.action = "projectBoard.do";
		fm.submit();
	}
	
	function moveRegPage(){
		document.getElementById("flag").value = "C";
		
		var fm = document.getElementById("fm");
		fm.method = "get";
		fm.action = "projectBoard.do";
		fm.submit();
	}

</script>
</html>

