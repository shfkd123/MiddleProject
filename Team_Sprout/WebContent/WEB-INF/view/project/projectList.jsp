<%@page import="kr.or.ddit.project.vo.ProjectVO"%>
<%@page import="kr.or.ddit.project.vo.ProjectOptionVO"%>
<%@page import="kr.or.ddit.user.vo.UserVO"%>
<%@page import="kr.or.ddit.comm.vo.AtchFileVO"%>
<%@page import="java.util.List"%>
<%@include file="/WEB-INF/view/include/head.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	ProjectVO pv = (ProjectVO) request.getAttribute("pv");

	List<ProjectVO> list = (List<ProjectVO>) request.getAttribute("list");

	List<AtchFileVO> atchFileList = (List<AtchFileVO>) request.getAttribute("atchFileList");

	 uv = (UserVO) session.getAttribute("userVO");

	/* pov.setPjNm(pjNm); */
	
	List<ProjectOptionVO> listOption = (List<ProjectOptionVO>)request.getAttribute("listOption");
	
%>
<!DOCTYPE html>
<head>
<title>프로젝트 목록</title>
<link rel="stylesheet" type="text/css"
	href="/Team_Sprout/css/main/main.css">
<link rel="stylesheet" type="text/css"
	href="/Team_Sprout/css/main/prjList.css">
<style type="text/css">
select.form-control{
	width: 200px;
	display: inline;
}
</style>
</head>
<body>
	<!-- 상단 전체   -->
	<div class="col-sm-12">

		<!-- 왼쪽 공백 2 -->
		<div class="col-sm-2"></div>

			<!-- 검색창 10 -->
		<div class="col-sm-8">
			<br> <br>
			<h3 style="font-weight: bold">프로젝트 키워드 검색</h3>
				<div class="input-group">
					<input type="text" class="form-control" placeholder="프로젝트를 검색하세요." name="pjName" id="projectSearch" value="">
		
					<div class="input-group-btn">
						<button type="button" class="btn btn-success" onclick="searchProject()">
							<i class="glyphicon glyphicon-search"></i>
						</button>
					</div>
				</div>
				
			<h3 style="font-weight: bold">프로젝트 카테고리 검색</h3>
			<select class="form-control" id="LikeySelect">
				<option id="l1" value="게임">게임</option>
				<option id="l2" value="공연">공연</option>
				<option id="l3" value="디자인">디자인</option>
				<option id="l4" value="만화">만화</option>
				<option id="l5" value="예술">예술</option>
				<option id="l6" value="공예">공예</option>
				<option id="l7" value="사진">사진</option>
				<option id="l8" value="영화">영화</option>
				<option id="l9" value="음식">음식</option>
				<option id="l10" value="책<">책</option>
				<option id="l11" value="테크">테크</option>
				<option id="l12" value="패션">패션</option>
			</select>
			<button type="button" class="btn btn-success" onclick="searchProjectSelect()")>검색</button>
			
			<br>
			<h4 style="font-weight: bold">총<%=list.size() %> 개의 프로젝트</h4>
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
	if(list.size() == 0){
	%>
		<div class="col-sm-10" align="center">
			<p>등록된 프로젝트가 없습니다.</p>
		</div>
	<%	
	} else {
		for(int i = 0; i < list.size(); i++){
			long pjNm = list.get(i).getPjNm();
			ProjectVO pv2 = list.get(i);
			if(i % 4 == 0){
		%>
		<div class="col-sm-2"></div>
		</div>
		<div class="col-sm-12">
		<!-- 왼쪽 공백 2 -->
		<div class="col-sm-2"></div>
		<%  }
		%>
		<div class="col-sm-2">
			<p>NO.<%=pjNm%></p>
			<div><img
				src="<%=request.getContextPath()%>/filedownload.do?fileId=<%=pv2.getAtchFileId()%>&fileSn=1"
				class="img-rounded" style="width: 100%; alt="Image"></div>

			<h4><p onclick="projectSelect('<%=pjNm%>')"><%=list.get(i).getPjName()%></p></h4>
			<p>
				<a href="#"><%=list.get(i).getPjCategory()%></a>
			</p>
			<span class="gold"><%=pv2.getPjPricePer() %> % 달성</span>
			<progress value="<%=pv2.getPjPricePer() %>" max="100"></progress>
			<div class="time">
				<span>마감일 : <%=list.get(i).getPjDday()%></span>
			</div>
		</div>
		<form id="fm" enctype="multipart/form-data">
			<input type="hidden" name="pjNm" id="pjNm">
			<input type="hidden" name="flag" id="flag">
			<input type="hidden" name="pjName" id="pjName">
			<input type="hidden" name="pjCategory" id="pjCategory">
		</form>
		<%
		}
	}%>
		<!-- 여백 2-->
		<div class="col-sm-2"></div>
	</div>
	
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
	
	function searchProject(){
		document.getElementById("flag").value = "SCH";
		document.getElementById("pjName").value = $("#projectSearch").val();
		var fm = document.getElementById("fm");
		fm.method = "post";
		fm.action = "projectBoard.do";
		fm.submit();
	}
	
	function searchProjectSelect(){
		
		var select = $("#LikeySelect option:selected").val();
		
		document.getElementById("flag").value = "SCHS";
		document.getElementById("pjCategory").value = select;
		var fm = document.getElementById("fm");
		fm.method = "post";
		fm.action = "projectBoard.do";
		fm.submit();
	}
	
	
	
</script>
<%@include file="/WEB-INF/view/include/footer.jsp"%>
</html>

