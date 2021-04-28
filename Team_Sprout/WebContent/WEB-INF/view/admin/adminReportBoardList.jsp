<%@page import="kr.or.ddit.user.vo.UserVO"%>
<%@page import="kr.or.ddit.comm.vo.PagingVO"%>
<%@page import="kr.or.ddit.board.vo.ReportBoardVO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@include file="/WEB-INF/view/include/adminHead.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>신고 게시판</title>
<link rel="stylesheet" type="text/css"
	href="/Team_Sprout/css/main/main.css">
<link rel="stylesheet" href="/Team_Sprout/css/main/board.css">
</head>
<body>
<%
	if (session != null && session.getAttribute("userVO") != null) {
		UserVO uv = (UserVO) session.getAttribute("userVO");
	}

	PagingVO pv = (PagingVO)request.getAttribute("pv");
%>

	<!-- 전체-->
	<div class="col-sm-12">

		<!-- 왼쪽 여백 -->
		<div class="col-sm-2"></div>

		<!-- 게시판 -->
		<div class="col-sm-8">
					<h4>
				<b>신고 </b>
			</h4>
			<table class="table table-hover">
				<thead>
					<tr>
						<th>번호</th>
						<th>제목</th>
						<th>작성자</th>
						<th>날짜</th>
					</tr>
				</thead>
				<tbody>
					<%
						List<ReportBoardVO> list = (List<ReportBoardVO>) request.getAttribute("list");
						Integer totalCount = (Integer)request.getAttribute("totalCount");
						for (int i = 0; i < list.size(); i++) {
							String reportNm = list.get(i).getReportNm();
					%>
					<tr>
						<td><%=totalCount - list.get(i).getrNum() + 1 %></td>
						<td><a href="#" onclick="boardSelect('<%=reportNm%>')"> <%=list.get(i).getReportTitle()%>
						</a></td>
						<td><%=list.get(i).getReportWriter()%></td>
						<td><%=list.get(i).getReportDate()%></td>
					</tr>
					<%
						}
					%>
				</tbody>
			</table>
			<div class="text-center">
			<!-- 페이징 처리 시작 -->
				<%if(pv.getTotalCount() > 0) {%>
				<ul class="pagination">
					<%if(pv.getFirstPageNo() > pv.getPageSize()) { %>
					<li><a href="adminReportBoard.do?pageNo=<%=pv.getFirstPageNo() - pv.getPageSize() %>">이전</a></li>
					<%} %>
					<%for(int pNo = pv.getFirstPageNo(); pNo <= pv.getLastPageNo(); pNo++){ %>
					<li>
						<a href="adminReportBoard.do?pageNo=<%=pNo %>">
							<%=pNo %>
						</a>
					</li>
					<%} %>
					<%if(pv.getLastPageNo() < pv.getTotalPageCount()){ %>
					<li><a href="adminReportBoard.do?pageNo=<%=pv.getFirstPageNo() + pv.getPageSize() %>">다음</a></li>
				</ul>
				<%}
				} %>
			</div>
		<!-- 페이징 처리 끝.. -->
			<!-- 검색 창 -->
			<div class="text-center">
				<input type="text" id="schInput" name="search">
				<button type="button" class="btn btn-success"
					onclick="searchBoard()">검색</button>
			</div>
			<hr>
			<!-- 등록 버튼  -->
			<div id="btn" style="text-align: right">
				<button type="button" class="btn btn-success" id="insertBtn"
					onclick="insertBoard()">등록</button>
			</div>
			<form id="fm">
				<input type="hidden" name="reportNm" id="reportNm"> <input
					type="hidden" name="flag" id="flag">
			</form>
		</div>

		<!-- 오른쪽 여백 -->
		<div class="col-sm-2"></div>

	</div>

</body>
<script type="text/javascript">


	function boardSelect(reportNm) {
		document.getElementById("reportNm").value = reportNm;
		document.getElementById("flag").value = "SEL";
		var fm = document.getElementById("fm");
		fm.method = "post";
		fm.action = "adminReportBoard.do";
		fm.submit();
	}

	function insertBoard() {
		document.getElementById("flag").value = "INS";
		var fm = document.getElementById("fm");
		fm.method = "post";
		fm.action = "adminReportBoard.do";
		fm.submit();
	}

	function searchBoard() {
		document.getElementById("flag").value = "SCH";

		var fm = document.getElementById("fm");
		fm.method = "post";
		fm.action = "adminReportBoard.do";
		fm.submit();
	}
</script>
</html>