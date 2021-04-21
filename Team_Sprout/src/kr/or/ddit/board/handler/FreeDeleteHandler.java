package kr.or.ddit.board.handler;

import java.net.URLEncoder;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.or.ddit.board.service.IFreeService;
import kr.or.ddit.board.vo.FreeBoardVO;
import kr.or.ddit.board.service.FreeServiceImpl;
import kr.or.ddit.comm.handler.CommandHandler;


public class FreeDeleteHandler implements CommandHandler {

	@Override
	public boolean isRedirect(HttpServletRequest req) {
		return true;
	}

	@Override
	public String process(HttpServletRequest req, HttpServletResponse resp) throws Exception {
		// 1.요청파라미터 정보 가져오기
		String freeNm = req.getParameter("freeNm");

		// 2. 삭제처리
		IFreeService freeService = FreeServiceImpl.getInstance();

		int cnt = freeService.deleteFreeBoard(freeNm);

		String msg = "";

		if (cnt > 0) {
			msg = "성공";
		} else {
			msg = "실패";
		}

		// 3. 목록 조회화면으로 이동
		String redirectUrl = req.getContextPath() + "/board/freeBoardList.do?msg=" + URLEncoder.encode(msg, "UTF-8");

		return redirectUrl;
	}

}
