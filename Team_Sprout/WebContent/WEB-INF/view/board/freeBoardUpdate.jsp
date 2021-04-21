<%@page import="kr.or.ddit.comm.vo.AtchFileVO"%>
<%@page import="java.util.List"%>
<%@page import="kr.or.ddit.board.vo.FreeBoardVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	FreeBoardVO freeVO = (FreeBoardVO) request.getAttribute("freeVO");

	List<AtchFileVO> atchFileList = (List<AtchFileVO>) request.getAttribute("atchFileList");
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>회원정보 변경</title>
</head>
<body>
	<form action="freeBoardUpdate.do" method="post" enctype="multipart/form-data">
		<input type="hidden" name="memId" value="<%=freeVO.getFreeNm()%>">
		<input type="hidden" name="atchFileId"
			value="<%=freeVO.getAtchFileId()%>">
		<table>
			<tr>
				<td>제목 :</td>
				<td><input type="text" name="freeTitle"
					value="<%=freeVO.getFreeTitle()%>"></td>
			</tr>
			<tr>
				<td>주 소 :</td>
				<td><textarea rows="5" cols="20" name="freeContent"><%=freeVO.getFreeContent()%></textarea></td>
			</tr>
			<tr>
				<td>기존 첨부파일 :</td>
				<td>
					<%
						if (atchFileList != null) {
							for (AtchFileVO atchFileVO : atchFileList) {
					%>
					<div>
						<a
							href="<%=request.getContextPath()%>/filedownload.do?fileId=<%=atchFileVO.getAtchFileId()%>
                        &filesn=<%=atchFileVO.getFileSn()%>">
							<%=atchFileVO.getOrignlFileNm()%>
						</a>
					</div> <%
 	}
 	}
 %>
				</td>
			</tr>
			<tr>
				<td>새로운 첨부파일</td>
				<td><input type="file" name="atchFile"></td>
			</tr>
		</table>
		<input type="submit" value="자유게시판 수정">
	</form>
</body>
</html>