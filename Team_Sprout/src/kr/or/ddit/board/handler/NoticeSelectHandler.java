package kr.or.ddit.board.handler;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.or.ddit.board.service.INoticeService;
import kr.or.ddit.board.service.NoticeServiceImpl;
import kr.or.ddit.board.vo.NoticeBoardVO;
import kr.or.ddit.comm.handler.CommandHandler;

public class NoticeSelectHandler implements  CommandHandler{

	@Override
	public boolean isRedirect(HttpServletRequest req) {
		
		return false;
	}

	@Override
	public String process(HttpServletRequest req, HttpServletResponse resp) throws Exception {
		
		String noticeNm = req.getParameter("noticeNm");
		
		INoticeService noticeService = NoticeServiceImpl.getInstance(); 
		NoticeBoardVO nv = noticeService.getNoticeBoard(noticeNm);
		
		req.setAttribute("noticeVO", nv);
		return "/WEB-INF/view/board/noticeBoardSelect.jsp";
	}

}
