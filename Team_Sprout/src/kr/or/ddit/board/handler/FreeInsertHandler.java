package kr.or.ddit.board.handler;

import java.net.URLEncoder;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;

import kr.or.ddit.comm.handler.CommandHandler;
import kr.or.ddit.comm.service.AtchFileServiceImpl;
import kr.or.ddit.comm.service.IAtchFileService;
import kr.or.ddit.board.service.IFreeService;
import kr.or.ddit.board.service.FreeServiceImpl;
import kr.or.ddit.comm.vo.AtchFileVO;
import kr.or.ddit.board.vo.FreeBoardVO;
import kr.or.ddit.util.FileUploadRequestWrapper;

public class FreeInsertHandler implements CommandHandler {

	private static final String VIEW_PAGE = "/WEB-INF/view/board/freeBoardInsert.jsp";
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

		if(req.getMethod().equals("GET")) { 

			return VIEW_PAGE;

		}else{ 
			
			
			FileItem item = ((FileUploadRequestWrapper)req).getFileItem("atchFileId");
			AtchFileVO atchFileVO = new AtchFileVO();
			String userId = req.getParameter("userId");
			
			IAtchFileService fileService = AtchFileServiceImpl.getInstance();
			atchFileVO = fileService.saveAtchFile(item, userId);
			
			
			String freeTitle = req.getParameter("freeTitle");
			String freeContent = req.getParameter("freeContent");
			/*String atchFileId = req.getParameter("atchFileId");*/
			
			IFreeService freeService = FreeServiceImpl.getInstance();
			
			FreeBoardVO fv = new FreeBoardVO();
			fv.setFreeTitle(freeTitle);
			fv.setUserId(userId);
			fv.setFreeContent(freeContent);
			fv.setAtchFileId(atchFileVO.getAtchFileId());
			
			
			int cnt = freeService.insertFreeBoard(fv);
			
			String msg = "";
			if(cnt > 0) {
				msg = "성공";
			}else {
				msg = "실패";
			}
			
			String redirectUrl = req.getContextPath() + "/board/freeBoardList.do?msg=" + URLEncoder.encode(msg, "UTF-8");
			
			return redirectUrl;
		}
	}
}
