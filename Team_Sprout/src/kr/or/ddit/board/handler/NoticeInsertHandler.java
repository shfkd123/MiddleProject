package kr.or.ddit.board.handler;

import java.net.URLEncoder;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;

import kr.or.ddit.board.service.INoticeService;
import kr.or.ddit.board.service.NoticeServiceImpl;
import kr.or.ddit.board.vo.NoticeBoardVO;
import kr.or.ddit.comm.handler.CommandHandler;
import kr.or.ddit.comm.service.AtchFileServiceImpl;
import kr.or.ddit.comm.service.IAtchFileService;
import kr.or.ddit.comm.vo.AtchFileVO;
import kr.or.ddit.util.FileUploadRequestWrapper;


public class NoticeInsertHandler implements CommandHandler {

	private static final String VIEW_PAGE = "/WEB-INF/view/board/noticeBoardInsert.jsp";
	
	@Override
	public boolean isRedirect(HttpServletRequest req) {
		if(req.getMethod().equals("GET")) {
			return false;
		}else {
			return true;
		}
	}

	@Override
	public String process(HttpServletRequest req, HttpServletResponse resp) throws Exception {
		if (req.getMethod().equals("GET")) { // GET
			return VIEW_PAGE;
		} else { //Post방식인 경우isRedirect를 한다.
			
			FileItem item = ((FileUploadRequestWrapper)req).getFileItem("atchFile");

			//String userId = (String) req.getSession().getAttribute("userId"); //로그인시 저장되어있는 아이디를 가져온다. 
			//String userId = "mem001"; //테스트
			
			String userId = req.getParameter("userId");
			AtchFileVO atchFileVO = new AtchFileVO();
			
			IAtchFileService fileService = AtchFileServiceImpl.getInstance();
			atchFileVO = fileService.saveAtchFile(item, userId);
			
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
			nv.setAtchFileId(atchFileVO.getAtchFileId());

			int cnt = noticeService.insertNoticeBoard(nv);

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
