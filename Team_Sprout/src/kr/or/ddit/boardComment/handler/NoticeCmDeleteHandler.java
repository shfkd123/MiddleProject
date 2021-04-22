package kr.or.ddit.boardComment.handler;

import java.net.URLEncoder;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.or.ddit.boardComment.service.INoticeCmService;
import kr.or.ddit.boardComment.service.NoticeCmServiceImpl;
import kr.or.ddit.comm.handler.CommandHandler;

public class NoticeCmDeleteHandler implements CommandHandler{

	@Override
	public boolean isRedirect(HttpServletRequest req) {
		return true;
	}

	@Override
	public String process(HttpServletRequest req, HttpServletResponse resp) throws Exception {
			// 1.요청파라미터 정보 가져오기
			String ncNm = req.getParameter("ncNm");
			
			// 2. 삭제처리
			INoticeCmService noticeCmService = NoticeCmServiceImpl.getInstance();

			int cnt = noticeCmService.deleteNoticeCm(ncNm);

			String msg = "";

			if (cnt > 0) {
				msg = "성공";
			} else {
				msg = "실패";
			}

			// 4. 목록 조회화면으로 이동
			String redirectUrl = req.getContextPath() + "/board/noticeList.do?msg=" + URLEncoder.encode(msg, "UTF-8");

			return redirectUrl;
	}
}
