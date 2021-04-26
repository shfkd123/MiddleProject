package kr.or.ddit.board.handler;

import java.net.URLEncoder;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.websocket.Session;

import org.apache.commons.fileupload.FileItem;

import kr.or.ddit.board.service.INoticeService;
import kr.or.ddit.board.service.NoticeServiceImpl;
import kr.or.ddit.board.vo.NoticeBoardVO;
import kr.or.ddit.comm.handler.CommandHandler;
import kr.or.ddit.comm.service.AtchFileServiceImpl;
import kr.or.ddit.comm.service.IAtchFileService;
import kr.or.ddit.comm.vo.AtchFileVO;
import kr.or.ddit.user.vo.UserVO;
import kr.or.ddit.util.FileUploadRequestWrapper;

public class NoticeUpdateHandler implements CommandHandler {

	private static final String VIEW_PAGE = "/WEB-INF/view/board/noticeBoardUpdate.jsp";

	@Override
	public boolean isRedirect(HttpServletRequest req) {
		if (req.getMethod().equals("GET")) { // Get방식인 경우.
			return false;
		} else { // POST 방식인 경우...
			return true;
		}
	}

	@Override
	public String process(HttpServletRequest req, HttpServletResponse resp) throws Exception {
		if (req.getMethod().equals("GET")) { // GET

			String userId = (String) req.getSession().getAttribute("userId");
			
			String noticeNm = req.getParameter("noticeNm");
			
			INoticeService noticeService = NoticeServiceImpl.getInstance();
			
			
			NoticeBoardVO noticeVO =  noticeService.getNoticeBoard(noticeNm);
			
			req.setAttribute("noticeNm", noticeVO);
			
			FileItem item = ((FileUploadRequestWrapper)req).getFileItem("atchFileId");
			
			AtchFileVO atchFileVO = new AtchFileVO();
			
			atchFileVO.setAtchFileId(req.getParameter("atchFileId") == null ?
					-1 : Long.parseLong(req.getParameter("atchFileId")));
			
			if(item !=null && !item.getName().equals("")) {
				
				IAtchFileService fileService = AtchFileServiceImpl.getInstance();
				
				atchFileVO = fileService.saveAtchFile(item, userId); // 첨부파일 저장
			}
			
			
			return VIEW_PAGE;
		}else { // POST방식의 경우

			FileItem item = ((FileUploadRequestWrapper)req).getFileItem("atchFile")==null?null:((FileUploadRequestWrapper)req).getFileItem("atchFile");

			//String userId = (String) req.getSession().getAttribute("userId"); //로그인시 저장되어있는 아이디를 가져온다. 
			String userId = "mem001"; //테스트
			/*
			String userId = req.getParameter("userId");*/
			AtchFileVO atchFileVO = new AtchFileVO();
			
			IAtchFileService fileService = AtchFileServiceImpl.getInstance();
			
			if(item!=null) {
				atchFileVO = fileService.saveAtchFile(item, userId);
			}
			// 1. 요청파라미터 정보 가져오기
			String noticeTitle = req.getParameter("noticeTitle");
			String noticeContent = req.getParameter("noticeContent");

			// 2. 서비스 객체 생성하기
			INoticeService noticeService = NoticeServiceImpl.getInstance();

			// 3. 게시글 등록하기
			NoticeBoardVO nv = new NoticeBoardVO();
			
			nv.setNoticeTitle(noticeTitle);
			nv.setUserId(userId);
			nv.setNoticeContent(noticeContent);
			
			if(atchFileVO!=null) {
				nv.setAtchFileId(atchFileVO.getAtchFileId());
			}
			
			int cnt = noticeService.updateNoticeBoard(nv);

			String msg = "";

			if (cnt > 0) {
				msg = "성공";
			} else {
				msg = "실패";
			}
			
			//4. 목록 조회화면으로 이동 - Redirect
			String redirectUrl = req.getContextPath() + 
					"/board/noticeList.do?msg=" + URLEncoder.encode(msg, "UTF-8"); 
			
			return redirectUrl;
		}
	}
}
