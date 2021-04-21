<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="kr.or.ddit.comm.vo.AtchFileVO"%>
<%@page import="java.util.List"%>
<%@page import="kr.or.ddit.board.vo.QnaBoardVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
QnaBoardVO qbv = (QnaBoardVO)request.getAttribute("qbv");

List<AtchFileVO> atchFileList = (List<AtchFileVO>) request.getAttribute("atchFileList");
%>
{
	"qnaNm" : "<%=qbv.getAtchFileId() %>"
    , "qnaTitle" : "<%=qbv.getQnaTitle() %>"
    , "qnaContent" : "<%=qbv.getQnaContent() %>"
    , "qnaDate" : "<%=qbv.getQnaDate() %>"
    , "qnaWriter" : "<%=qbv.getQnaWriter() %>"
    , "atchFileId" : "<%=qbv.getAtchFileId() %>"
}
[
<%
for(int i = 0; i < atchFileList.size(); i++){
	if(i > 0){
		%>, <%
	}
%>	
{
	, "fileStreCours" : <%=atchFileList.get(i).getFileStreCours() %>
	, "fileId" : <%=atchFileList.get(i).getAtchFileId() %>
	, "filesn" : <%=atchFileList.get(i).getFileSn()%>"
	, "orignFileNm" : "<%=atchFileList.get(i).getOrignlFileNm() %>"
}
<%							
}
%>
]
<!-- <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd"> -->
<!-- <html> -->
<!-- <head> -->
<!-- <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"> -->
<!-- <title>Insert title here</title> -->
<!-- </head> -->
<!-- <body> -->

<!-- </body> -->
<!-- </html> -->