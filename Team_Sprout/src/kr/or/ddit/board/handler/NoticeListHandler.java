package kr.or.ddit.board.handler;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.or.ddit.board.service.INoticeService;
import kr.or.ddit.board.service.NoticeServiceImpl;
import kr.or.ddit.board.vo.NoticeBoardVO;
import kr.or.ddit.comm.handler.CommandHandler;

public class NoticeListHandler implements CommandHandler{

	private static final String VIEW_PAGE = "/WEB-INF/view/board/noticeBoardList.jsp";
	
	@Override
	public boolean isRedirect(HttpServletRequest req) {
		return false;//-->forward
	}

	@Override
	public String process(HttpServletRequest req, HttpServletResponse resp) throws Exception {
		// 1. 서비스 객체 생성하기
		INoticeService noticeService = NoticeServiceImpl.getInstance();
		
		// 2. 회원정보 조회
		List<NoticeBoardVO> noticeList = noticeService.getNoticeBoardList();

		req.setAttribute("noticeList", noticeList);

		return VIEW_PAGE;
	}

}
