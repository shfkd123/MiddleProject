package kr.or.ddit.boardComment.handler;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.or.ddit.comm.handler.CommandHandler;
import kr.or.ddit.user.vo.UserVO;

public class QnaCmHandler implements CommandHandler {
	@Override
	public boolean isRedirect(HttpServletRequest req) {
		return false;
	}

	@Override
	public String process(HttpServletRequest req, HttpServletResponse resp) throws Exception {
		String flag = (String) req.getParameter("flag");
		
		HttpSession session = req.getSession();
		UserVO uv = (UserVO) session.getAttribute("userId");
		String userId = uv.getUserId();
		
		if("C".equals(flag)) { // 댓글 작성
			
		} else if ("R".equals(flag)) { // 댓글 목록
			
		} else if("U".equals(flag)) { // 댓글 수정
			
		} else if("D".equals(flag)) { // 댓글 삭제
			
		}
		return null;
	}

}
