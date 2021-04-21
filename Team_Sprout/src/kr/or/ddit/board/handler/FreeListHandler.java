package kr.or.ddit.board.handler;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.or.ddit.board.service.IFreeService;
import kr.or.ddit.board.service.FreeServiceImpl;
import kr.or.ddit.board.vo.FreeBoardVO;
import kr.or.ddit.comm.handler.CommandHandler;

public class FreeListHandler implements CommandHandler{

	private static final String VIEW_PAGE = "/WEB-INF/view/board/freeBoardList.jsp";
	
	@Override
	public boolean isRedirect(HttpServletRequest req) {
		return false;//-->forward
	}

	@Override
	public String process(HttpServletRequest req, HttpServletResponse resp) throws Exception {
		// 1. 서비스 객체 생성하기
		IFreeService freeService = FreeServiceImpl.getInstance();
		
		// 2. 회원정보 조회
		List<FreeBoardVO> freeList = freeService.getFreeBoardList();

		req.setAttribute("freeList", freeList);

		return VIEW_PAGE;
	}

}
