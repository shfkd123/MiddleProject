package kr.or.ddit.boardComment.handler;

import java.net.URLEncoder;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.or.ddit.board.vo.NoticeBoardVO;
import kr.or.ddit.boardComment.service.INoticeCmService;
import kr.or.ddit.boardComment.service.NoticeCmServiceImpl;
import kr.or.ddit.boardComment.vo.NoticeCmVO;
import kr.or.ddit.comm.handler.CommandHandler;

public class NoticeCmInsertHandler implements CommandHandler{

	private static final String VIEW_PAGE = "/WEB-INF/view/board/noticeBoardSelect.jsp";
	
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
		if (req.getMethod().equals("GET")) {
			return VIEW_PAGE;
		} else { 
			String ncContent = req.getParameter("ncContent");

			// 2. 서비스 객체 생성하기
			INoticeCmService noticeCmService = NoticeCmServiceImpl.getInstance();

			// 3. 게시글 등록하기
			NoticeCmVO ncv = new NoticeCmVO();
			
			ncv.setNcContent(ncContent);

			int cnt = noticeCmService.insertNoticeCm(ncv);

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
