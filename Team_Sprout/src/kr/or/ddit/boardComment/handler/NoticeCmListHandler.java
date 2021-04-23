package kr.or.ddit.boardComment.handler;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.or.ddit.boardComment.service.INoticeCmService;
import kr.or.ddit.boardComment.service.NoticeCmServiceImpl;
import kr.or.ddit.boardComment.vo.NoticeCmVO;
import kr.or.ddit.comm.handler.CommandHandler;

public class NoticeCmListHandler implements CommandHandler{

	@Override
	public boolean isRedirect(HttpServletRequest req) {
		return false;
	}

	@Override
	public String process(HttpServletRequest req, HttpServletResponse resp) throws Exception {
		
		String ncNm = req.getParameter("ncNm");
		
		// 1. 서비스 객체 생성하기
		INoticeCmService noticeCmService = NoticeCmServiceImpl.getInstance();
		
		// 2.공지 댓글 조회
		List<NoticeCmVO> noticeCmList = noticeCmService.getNoticeCmList(ncNm);

		req.setAttribute("noticeCmList", noticeCmList);

		return "/WEB-INF/view/board/noticeBoardList.jsp";
	}
}
