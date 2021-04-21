package kr.or.ddit.board.handler;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.or.ddit.board.service.INoticeService;
import kr.or.ddit.board.service.NoticeServiceImpl;
import kr.or.ddit.board.vo.NoticeBoardVO;
import kr.or.ddit.comm.handler.CommandHandler;
import kr.or.ddit.comm.service.AtchFileServiceImpl;
import kr.or.ddit.comm.service.IAtchFileService;
import kr.or.ddit.comm.vo.AtchFileVO;

public class NoticeSelectHandler implements  CommandHandler{

	@Override
	public boolean isRedirect(HttpServletRequest req) {
		
		return false;
	}

	@Override
	public String process(HttpServletRequest req, HttpServletResponse resp) throws Exception {
		
		String noticeNm = req.getParameter("noticeNm");
		
		//
		INoticeService noticeService = NoticeServiceImpl.getInstance(); 
		NoticeBoardVO nv = noticeService.getNoticeBoard(noticeNm);
		
		if(nv.getAtchFileId() > 0) { //첨부파일 존재하면...
			//첨부파일 정보 조회
			AtchFileVO fileVO = new AtchFileVO();
			fileVO.setAtchFileId(nv.getAtchFileId());
			
			IAtchFileService atchFileService = AtchFileServiceImpl.getInstance();
			
			List<AtchFileVO> atchFileList = atchFileService.getAtchFileList(fileVO);
			
			req.setAttribute("atchFileList", atchFileList);
			
		}
		return "/WEB-INF/view/board/noticeBoardSelect.jsp";
	}

}
