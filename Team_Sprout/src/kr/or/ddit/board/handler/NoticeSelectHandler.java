package kr.or.ddit.board.handler;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.or.ddit.board.service.INoticeService;
import kr.or.ddit.board.service.NoticeServiceImpl;
import kr.or.ddit.board.vo.NoticeBoardVO;
import kr.or.ddit.boardComment.service.INoticeCmService;
import kr.or.ddit.boardComment.service.NoticeCmServiceImpl;
import kr.or.ddit.boardComment.vo.NoticeCmVO;
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
		
		INoticeService noticeService = NoticeServiceImpl.getInstance(); 
		NoticeBoardVO nv = noticeService.getNoticeBoard(noticeNm);
		
		req.setAttribute("noticeVO", nv);
		
		if(nv.getAtchFileId() > 0) { // 첨부파일이 존재할 때
			AtchFileVO fileVO = new AtchFileVO();
			
			fileVO.setAtchFileId(nv.getAtchFileId());
			
			IAtchFileService fileService = AtchFileServiceImpl.getInstance();
			
			List<AtchFileVO> atchFileList = fileService.getAtchFileList(fileVO);
			
			req.setAttribute("atchFileList", atchFileList);
			
		}
		
		//댓글 조회
		INoticeCmService cmService = NoticeCmServiceImpl.getInstance();
		
		List<NoticeCmVO> noticeCmList = cmService.getNoticeCmListByNoticeNm(noticeNm);
		
		req.setAttribute("noticeCmList", noticeCmList);
			
		return "/WEB-INF/view/board/noticeBoardSelect.jsp";
		
		
	}

}
