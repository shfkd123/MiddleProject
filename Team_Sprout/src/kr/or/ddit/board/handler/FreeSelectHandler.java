package kr.or.ddit.board.handler;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.or.ddit.board.service.IFreeService;
import kr.or.ddit.board.service.FreeServiceImpl;
import kr.or.ddit.board.vo.FreeBoardVO;
import kr.or.ddit.comm.handler.CommandHandler;
import kr.or.ddit.comm.service.AtchFileServiceImpl;
import kr.or.ddit.comm.service.IAtchFileService;
import kr.or.ddit.comm.vo.AtchFileVO;

public class FreeSelectHandler implements CommandHandler {

	@Override
	public boolean isRedirect(HttpServletRequest req) {

		return false;
	}

	@Override
	public String process(HttpServletRequest req, HttpServletResponse resp) throws Exception {

		String freeNm = req.getParameter("freeNm");

		//
		IFreeService freeService = FreeServiceImpl.getInstance();
		FreeBoardVO fv = freeService.getFreeBoard(freeNm);

		if (fv.getAtchFileId() > 0) { // 첨부파일 존재하면...
			// 첨부파일 정보 조회
			AtchFileVO fileVO = new AtchFileVO();
			fileVO.setAtchFileId(fv.getAtchFileId());

			IAtchFileService atchFileService = AtchFileServiceImpl.getInstance();

			List<AtchFileVO> atchFileList = atchFileService.getAtchFileList(fileVO);

			req.setAttribute("atchFileList", atchFileList);
			req.setAttribute("freeVO", fv);

		}
		return "/WEB-INF/view/board/freeBoardSelect.jsp";
	}

}
