package kr.or.ddit.board.handler;

import java.net.URLEncoder;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.fileupload.FileItem;

import kr.or.ddit.board.service.FreeServiceImpl;
import kr.or.ddit.board.service.IFreeService;
import kr.or.ddit.board.service.IQnaService;
import kr.or.ddit.board.service.QnaServiceImpl;
import kr.or.ddit.board.vo.FreeBoardVO;
import kr.or.ddit.board.vo.QnaBoardVO;
import kr.or.ddit.comm.handler.CommandHandler;
import kr.or.ddit.comm.service.AtchFileServiceImpl;
import kr.or.ddit.comm.service.IAtchFileService;
import kr.or.ddit.comm.vo.AtchFileVO;
import kr.or.ddit.user.vo.UserVO;
import kr.or.ddit.util.FileUploadRequestWrapper;

public class QnaBoardHandler implements CommandHandler {

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
		String userId = uv.getUserId();
		
		if("C".equals(flag)) { // 게시글 작성
			if(req.getMethod().equals("GET")) {
				return "/WEB-INF/view/board/qnaBoardInsert";
			} else {
				
				QnaBoardVO qbv = new QnaBoardVO();
				
				IQnaService service = QnaServiceImpl.getInstance();
				
				String qnaTitle = req.getParameter("qnaTitle");
				String qnaContent = req.getParameter("qnaContent");
				qbv.setQnaTitle(qnaTitle);
				qbv.setQnaContent(qnaContent);
				qbv.setQnaWriter(userId);
				
				if((String)req.getParameter("attachFile") == "") {
					FileItem item = ((FileUploadRequestWrapper)req).getFileItem("atchFileId");
					AtchFileVO atchFileVO = new AtchFileVO();
					
					IAtchFileService fileService = AtchFileServiceImpl.getInstance();
					atchFileVO = fileService.saveAtchFile(item, userId);
					
					qbv.setAtchFileId(atchFileVO.getAtchFileId());
				}
				
				int cnt = service.insertQnaBoard(qbv);

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
			
			FileItem item = ((FileUploadRequestWrapper)req).getFileItem("atchFileId");
			
			AtchFileVO atchFileVO = new AtchFileVO();
			
			atchFileVO.setAtchFileId(req.getParameter("atchFileId") == null ?
					-1 : Long.parseLong(req.getParameter("atchFileId")));
			
			if(item !=null && !item.getName().equals("")) {
				
				IAtchFileService fileService = AtchFileServiceImpl.getInstance();
				
				atchFileVO = fileService.saveAtchFile(item, userId); // 첨부파일 저장
			}
			
			IQnaService service = QnaServiceImpl.getInstance();
			
			QnaBoardVO qbv = new QnaBoardVO();
			
			qbv.setQnaNm(req.getParameter("qnaNm"));
			qbv.setQnaTitle(req.getParameter("qnaTitle"));
			qbv.setQnaContent(req.getParameter("qnaContent"));
			qbv.setAtchFileId(atchFileVO.getAtchFileId());
			
			int cnt = service.updateQnaBoard(qbv);
			
			String msg = "";
			if(cnt > 0) {
				msg = "성공";
			}else {
				msg = "실패";
			}
			String redirectUrl = req.getContextPath() + "/board/qnaBoard.do?msg=" + URLEncoder.encode(msg, "UTF-8");
			return redirectUrl;	
		} else if("D".equals(flag)) { // 게시글 삭제
			QnaBoardVO qbv = new QnaBoardVO();
			
			qbv.setQnaNm(req.getParameter("qnaNm"));
			
			IQnaService service = QnaServiceImpl.getInstance();
			
			int cnt = service.deleteQnaBoard(qbv);
			
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
			QnaBoardVO boardVO = new QnaBoardVO();
			boardVO.setQnaNm(qnaNm);
			IQnaService service = QnaServiceImpl.getInstance();
			
			QnaBoardVO qbv = service.getQnaBoard(boardVO);
			
			if(qbv.getAtchFileId() > 0) { // 첨부파일이 존재할 때
				AtchFileVO fileVO = new AtchFileVO();
				
				fileVO.setAtchFileId(qbv.getAtchFileId());
				
				IAtchFileService fileService = AtchFileServiceImpl.getInstance();
				
				List<AtchFileVO> atchFileList = fileService.getAtchFileList(fileVO);
				
				req.setAttribute("atchFileList", atchFileList);
			}
			req.setAttribute("qbv", qbv);
			
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
			
			QnaBoardVO boardVO = new QnaBoardVO();
			boardVO.setQnaNm(qnaNm);
			
			QnaBoardVO qbv = service.getQnaBoard(boardVO);
			
			if(qbv.getAtchFileId() > 0) {
				AtchFileVO fileVO = new AtchFileVO();
				fileVO.setAtchFileId(qbv.getAtchFileId());
				
				IAtchFileService atchFileService = AtchFileServiceImpl.getInstance();
				List<AtchFileVO> atchFileList = atchFileService.getAtchFileList(fileVO);
				
				req.setAttribute("atchFileList", atchFileList);
			}
			
			req.setAttribute("qbv", qbv);
			
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
