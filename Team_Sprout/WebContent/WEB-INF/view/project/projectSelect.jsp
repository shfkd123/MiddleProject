<%@page import="kr.or.ddit.project.vo.ProjectVO"%>
<%@page import="kr.or.ddit.project.vo.ProjectOptionVO"%>
<%@page import="kr.or.ddit.user.vo.UserVO"%>
<%@page import="kr.or.ddit.comm.vo.AtchFileVO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	ProjectVO pv = (ProjectVO)request.getAttribute("pv");

	List<AtchFileVO> atchFileList = (List<AtchFileVO>) request.getAttribute("atchFileList");
	
	List<ProjectOptionVO> listOption = (List<ProjectOptionVO>)request.getAttribute("listOption");
		
	UserVO uv = (UserVO)session.getAttribute("userVO");
	
	long pjNm = pv.getPjNm();

%>    
<!DOCTYPE html>
<html lang="en">
<head>
<title>Bootstrap Example</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
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
	href="/Team_Sprout/css/main/prjDetail.css">
<body>
	<!-- 프로젝트 제목 -->
	<div class="col-sm-12">

		<!-- 왼쪽 공백 2 -->
		<div class="col-sm-2"></div>

		<!-- 제목 -->
		<div class="col-sm-8" id="divCategory">
			<br>
			<br> <span id="pjCategory" name=""pjCategory""><%=pv.getPjCategory() %></span>
			<h2><%=pv.getPjName() %></h2>
			<br>
			<h4><%=pv.getPjNm() %></h4>
		</div>

		<!-- 오른쪽 공백 2 -->
		<div class="col-sm-2"></div>

	</div>

	<!-- 프로젝트 사진 / 설명 -->
	<div class="col-sm-12">
		<!-- 왼쪽 공백 2 -->
		<div class="col-sm-2"></div>

		<!-- 썸네일 -->
		<div class="col-sm-5">
							<%
					if (atchFileList != null) {
						for (AtchFileVO atchFileVO : atchFileList) {
				%>
				<img src='<%=atchFileVO.getImgUrl()%>' >
				<%
					}
					}
				%>
		</div>
		<!-- 설명 -->
		<div class="col-sm-3">
			<p>목표금액</p>
			<h3>
				<p><%=pv.getPjPriceAmount() %>원</p>
			</h3>
			<p>모인금액</p>
			<h3>
				<p><%=pv.getPjPrice() %>원</p>
			</h3>
			<br>
			<p>프로젝트 마감일</p>
			<h3>
				<p><%=pv.getPjDday() %></p>
			</h3>
			<br>
			<p>후원자</p>
			<h3>
				<p><%=pv.getPjFan() %>명</p>
			</h3>
			<br>
			<br>
			<br>
			<button type="button" class="btn btn-default btn-lg" onclick="goDonation()">후원하기</button>
		</div>

		<!-- 오른쪽 공백 2 -->
		<div class="col-sm-2"></div>
	</div>


	<!-- 프로젝트 옵션 / 상세 설명 -->
	<div class="col-sm-12">
		<!-- 왼쪽 공백 2 -->
		<div class="col-sm-2"></div>

		<!-- 옵션 -->
		<div class="col-sm-2">
		<% for(int i = 0; i < listOption.size(); i++){%>
			<div id="divOption">
				<p>옵션<%=i+1 %></p><br><br>
				<p><%=listOption.get(i).getPoName() %><br>
				<h4><%=listOption.get(i).getPoAddPrice() %></h4><br>
				<span><%=listOption.get(i).getPoContent() %></span>
			</div>
			<%
		}
			%>
			<br>
		</div>
		<!-- 상세 설명 -->
		<div class="col-sm-6">
			<h3>프로젝트 소개</h3>
			<p><%=pv.getPjContent() %></p>
		</div>

		<!-- 오른쪽 공백 2 -->
		<div class="col-sm-2"></div>
	</div>


	<!-- top -->
	<a style="display: scroll; position: fixed; bottom: 40px; right: 40px;"
		href="#" title="top"><img src="/images/topbutton.png"
		width="40px"></a>
	<form id="fm">
		<input type="hidden" name="pjNm" id="pjNm">
		<input type="hidden" name="flag" id="flag">
	</form>	
<script type="text/javascript">
function optionSelect(pjNm){
	document.getElementById("pjNm").value = pjNm;
	document.getElementById("flag").value = "OPT";
	var fm = document.getElementById("fm");
	fm.method = "post";
	fm.action = "projectBoard.do";
	fm.submit();
}

function goDonation(){
	document.getElementById("pjNm").value = "<%=pv.getPjNm() %>";
	var fm = document.getElementById("fm");
	fm.method = "post";
	fm.action = "donation.do";
	fm.submit();
}
</script>	
</body>
</html>