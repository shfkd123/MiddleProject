package kr.or.ddit.board.handler;

import java.net.URLEncoder;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.fileupload.FileItem;

import kr.or.ddit.board.service.CommunityServiceImpl;
import kr.or.ddit.board.service.ICommunityService;
import kr.or.ddit.board.service.IQnaService;
import kr.or.ddit.board.service.QnaServiceImpl;
import kr.or.ddit.board.vo.CommunityBoardVO;
import kr.or.ddit.board.vo.QnaBoardVO;
import kr.or.ddit.boardComment.service.IQnaCmService;
import kr.or.ddit.boardComment.service.QnaCmServiceImpl;
import kr.or.ddit.boardComment.vo.QnaCmVO;
import kr.or.ddit.comm.handler.CommandHandler;
import kr.or.ddit.comm.service.AtchFileServiceImpl;
import kr.or.ddit.comm.service.IAtchFileService;
import kr.or.ddit.comm.vo.AtchFileVO;
import kr.or.ddit.user.vo.UserVO;
import kr.or.ddit.util.FileUploadRequestWrapper;

public class CommunityBoardHandler implements CommandHandler {

	@Override
	public boolean isRedirect(HttpServletRequest req) {
		String flag = (String)req.getParameter("flag");
		
		if("C".equals(flag) || "U".equals(flag)) {
			if(req.getMethod().equals("GET")) { 
				return false;
			}else { 
				return true;
			}
		}
		if("D".equals(flag)) {
			return true;
		}
		return false;
	}

	@Override
	public String process(HttpServletRequest req, HttpServletResponse resp) throws Exception {
		String flag = (String) req.getParameter("flag");
		
		HttpSession session = req.getSession();
		
		UserVO uv = (UserVO) session.getAttribute("userVO");
		
		if("C".equals(flag)) { // 게시글 작성
			if(req.getMethod().equals("GET")) {
				return "/WEB-INF/view/board/CommunityBoardInsert.jsp";
			} else {
				String userId = uv.getUserId();
				
				CommunityBoardVO cbv = new CommunityBoardVO();
				
				ICommunityService service = CommunityServiceImpl.getInstance();
				
				String cbTitle = req.getParameter("cbTitle");
				String cbContent = req.getParameter("cbContent");
				cbv.setCbTitle(cbTitle);
				cbv.setCbContent(cbContent);
				cbv.setCbWriter(userId);
				
				
				if((String)req.getParameter("attachFile") == "") {
					FileItem item = ((FileUploadRequestWrapper)req).getFileItem("atchFileId");
					AtchFileVO atchFileVO = new AtchFileVO();
					
					IAtchFileService fileService = AtchFileServiceImpl.getInstance();
					atchFileVO = fileService.saveAtchFile(item, userId);
					
					cbv.setAtchFileId(atchFileVO.getAtchFileId());
				}
				
				///////////////////////////////////////////////////////////////////////////////////////////////////////
				//int cnt = service.insertQnaBoard(cbv);

				int cnt = 0;
				String msg = "";
				
				if(cnt > 0) {
					msg = "성공";
				} else {
					msg = "실패";
				}
				String redirectUrl = req.getContextPath() 
						+ "/board/qnaBoard.do?msg=" 
						+ URLEncoder.encode(msg, "UTF-8");
				return redirectUrl;
			}
			
		} else if("U".equals(flag)) { // 게시글 수정
			
			String userId = uv.getUserId();
			
			FileItem item = ((FileUploadRequestWrapper)req).getFileItem("atchFileId");
			
			AtchFileVO atchFileVO = new AtchFileVO();
			
			atchFileVO.setAtchFileId(req.getParameter("atchFileId") == null ?
					-1 : Long.parseLong(req.getParameter("atchFileId")));
			
			if(item !=null && !item.getName().equals("")) {
				
				IAtchFileService fileService = AtchFileServiceImpl.getInstance();
				
				atchFileVO = fileService.saveAtchFile(item, userId); // 첨부파일 저장
			}
			
			IQnaService service = QnaServiceImpl.getInstance();
			
			QnaBoardVO cbv = new QnaBoardVO();
			
			cbv.setQnaNm(req.getParameter("qnaNm"));
			cbv.setQnaTitle(req.getParameter("qnaTitle"));
			cbv.setQnaContent(req.getParameter("qnaContent"));
			cbv.setAtchFileId(atchFileVO.getAtchFileId());
			
			int cnt = service.updateQnaBoard(cbv);
			
			String msg = "";
			if(cnt > 0) {
				msg = "성공";
			}else {
				msg = "실패";
			}
			String redirectUrl = req.getContextPath() + "/board/communityBoard.do?msg=" + URLEncoder.encode(msg, "UTF-8");
			return redirectUrl;	
		} else if("D".equals(flag)) { // 게시글 삭제
			QnaBoardVO cbv = new QnaBoardVO();
			
			cbv.setQnaNm(req.getParameter("qnaNm"));
			
			IQnaService service = QnaServiceImpl.getInstance();
			
			int cnt = service.deleteQnaBoard(cbv);
			
			String msg = "";
			if(cnt > 0){
				msg = "성공";
			} else {
				msg = "실패";
			}
			String redirectUrl = req.getContextPath() + "/board/qnaBoard.do?msg=" + URLEncoder.encode(msg, "UTF-8");
			return redirectUrl;
		} else if("SEL".equals(flag)) { // 한 게시글 조회
			String qnaNm = req.getParameter("qnaNm");
			
			IQnaService service = QnaServiceImpl.getInstance();
			
			QnaBoardVO cbv = service.getQnaBoard(qnaNm);
			
			if(cbv.getAtchFileId() > 0) { // 첨부파일이 존재할 때
				AtchFileVO fileVO = new AtchFileVO();
				
				fileVO.setAtchFileId(cbv.getAtchFileId());
				
				IAtchFileService fileService = AtchFileServiceImpl.getInstance();
				
				List<AtchFileVO> atchFileList = fileService.getAtchFileList(fileVO);
				
				req.setAttribute("atchFileList", atchFileList);
			}
			
			req.setAttribute("cbv", cbv);

			// 댓글 전부 보여줌
			IQnaCmService cmService = QnaCmServiceImpl.getInstance();
			
			List<QnaCmVO> cmList = cmService.getAllQnaCm(qnaNm);
			
			req.setAttribute("qnaCmList", cmList);
			
			return "/WEB-INF/view/board/qnaBoardSelect.jsp";
			
		} else if("SCH".equals(flag)) { // 게시글 검색
			String str = "";

			str = req.getParameter("search");
			
			IQnaService service = QnaServiceImpl.getInstance();
			
			List<QnaBoardVO> list = service.searchQnaBoard(str);
			
			req.setAttribute("list", list);
			
			return "/WEB-INF/view/board/qnaBoardList.jsp";
		} else if("INS".equals(flag)) {
			return "/WEB-INF/view/board/qnaBoardInsert.jsp";
		} else if("UPD".equals(flag)) {
			String qnaNm = (String)req.getParameter("qnaNm");
			
			IQnaService service = QnaServiceImpl.getInstance();
			
			QnaBoardVO cbv = service.getQnaBoard(qnaNm);
			
			if(cbv.getAtchFileId() > 0) {
				AtchFileVO fileVO = new AtchFileVO();
				fileVO.setAtchFileId(cbv.getAtchFileId());
				
				IAtchFileService atchFileService = AtchFileServiceImpl.getInstance();
				List<AtchFileVO> atchFileList = atchFileService.getAtchFileList(fileVO);
				
				req.setAttribute("atchFileList", atchFileList);
			}
			
			req.setAttribute("cbv", cbv);
			
			return "/WEB-INF/view/board/qnaBoardUpdate.jsp";
		}
		
		// 모든 게시글 조회
		QnaBoardVO boardVO = new QnaBoardVO();
		
		BeanUtils.populate(boardVO, req.getParameterMap());
		
		IQnaService service = QnaServiceImpl.getInstance();
		
		List<QnaBoardVO> list = service.getAllQnaBoardList();
		
		req.setAttribute("list", list);
		
		return "/WEB-INF/view/board/qnaBoardList.jsp";
	}

}
