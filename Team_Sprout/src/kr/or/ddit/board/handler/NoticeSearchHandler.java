package kr.or.ddit.board.handler;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.or.ddit.board.service.INoticeService;
import kr.or.ddit.board.service.NoticeServiceImpl;
import kr.or.ddit.board.vo.NoticeBoardVO;
import kr.or.ddit.comm.handler.CommandHandler;

public class NoticeSearchHandler implements CommandHandler{

	@Override
	public boolean isRedirect(HttpServletRequest req) {
		return false;
	}

	@Override
	public String process(HttpServletRequest req, HttpServletResponse resp) throws Exception {
		
		String notice_title = req.getParameter("notice_title");
		
		// 1. 서비스 객체 생성하기
		INoticeService noticeService = NoticeServiceImpl.getInstance();
		NoticeBoardVO nv = new NoticeBoardVO();
		
		//검색된 정보 조회
		List<NoticeBoardVO> noticeList = noticeService.getSearchNoticeBoardList(notice_title);
		
		req.setAttribute("notice_title", notice_title);
		req.setAttribute("noticeList", noticeList);
		
		return "/WEB-INF/view/board/noticeBoardList.jsp";
				
		
	}

}
