package kr.or.ddit.boardComment.handler;

import java.net.URLEncoder;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;

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
import kr.or.ddit.util.FileUploadRequestWrapper;

public class NoticeCmInsertHandler implements CommandHandler{

	private static final String VIEW_PAGE = "/WEB-INF/view/board/noticeBoardSelect.jsp";
	
	@Override
	public boolean isRedirect(HttpServletRequest req) {
		return false;
	}

	@Override
	public String process(HttpServletRequest req, HttpServletResponse resp) throws Exception {
	
			
			//로그인한 유저
			String userId = (String) req.getSession().getAttribute("userId");
			
			//1.요청 파라미터
			String ncNm = req.getParameter("ncNm");
			String noticeNm = req.getParameter("noticeNm");
			String ncContent = req.getParameter("ncContent");
			
			// 2. 서비스 객체 생성하기
			INoticeCmService noticeCmService = NoticeCmServiceImpl.getInstance();
			INoticeService noticeService = NoticeServiceImpl.getInstance();
			//3.댓글 등록하기
			NoticeCmVO ncv = new NoticeCmVO();	
					
			ncv.setNoticeNm(noticeNm);
			ncv.setNcContent(ncContent);
			ncv.setNcNm(ncNm);
			ncv.setUserId(userId);
			
			req.setAttribute("userId", userId);
			
			noticeCmService.insertNoticeCm(ncv);
			
			List<NoticeCmVO> noticeCmList = noticeCmService.getNoticeCmList(ncNm);
			req.setAttribute("noticeCmList", noticeCmList);
			NoticeBoardVO noticeVO = new NoticeBoardVO();
			noticeVO = noticeService.getNoticeBoard(noticeNm);
			req.setAttribute("noticeVO", noticeVO);
			
			//첨부파일이 존재할 때
			if((String)req.getParameter("attachFile") == "") {
				FileItem item = ((FileUploadRequestWrapper)req).getFileItem("atchFileId");
				AtchFileVO atchFileVO = new AtchFileVO();
				
				IAtchFileService fileService = AtchFileServiceImpl.getInstance();
				atchFileVO = fileService.saveAtchFile(item, userId);
				
				noticeVO.setAtchFileId(atchFileVO.getAtchFileId());
			}
			
			return VIEW_PAGE;
		
		}

	
}
