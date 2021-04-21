package kr.or.ddit.board.handler;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.beanutils.BeanUtils;

import kr.or.ddit.board.service.IQnaService;
import kr.or.ddit.board.service.QnaServiceImpl;
import kr.or.ddit.board.vo.QnaBoardVO;
import kr.or.ddit.comm.handler.CommandHandler;
import kr.or.ddit.comm.service.AtchFileServiceImpl;
import kr.or.ddit.comm.service.IAtchFileService;
import kr.or.ddit.comm.vo.AtchFileVO;

public class QnaBoardHandler implements CommandHandler {

	@Override
	public boolean isRedirect(HttpServletRequest req) {
		return false;
	}

	@Override
	public String process(HttpServletRequest req, HttpServletResponse resp) throws Exception {
		
		String flag = req.getParameter("flag");
		
		if("C".equals(flag)) { // 게시글 작성
			QnaBoardVO boardVO = new QnaBoardVO();
			
			BeanUtils.populate(boardVO, req.getParameterMap());
			
			IQnaService service = QnaServiceImpl.getInstance();
			
			service.insertQnaBoard(boardVO);
			
			req.setAttribute("resultCnt", 1);
			
			return "/WEB-INF/view/board/qnaBoardList.jsp";
			
		} else if("U".equals(flag)) { // 게시글 수정
			QnaBoardVO qbv = new QnaBoardVO();
			
			BeanUtils.populate(qbv, req.getParameterMap());
			
			IQnaService service = QnaServiceImpl.getInstance();
			
			service.updateQnaBoard(qbv);
			
			return "/WEB-INF/view/board/qnaBoardList.jsp";
			
		} else if("D".equals(flag)) { // 게시글 삭제
			QnaBoardVO qbv = new QnaBoardVO();
			qbv.setQnaNm(req.getParameter("qnaNm"));
			
			IQnaService service = QnaServiceImpl.getInstance();
			
			service.deleteQnaBoard(qbv);
			
			return "/WEB-INF/view/board/qnaBoardList.jsp";
			
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
			
			return "/WEB-INF/view/board/qnaBoard.jsp";
			
		} else if("SCH".equals(flag)) { // 게시글 검색
			QnaBoardVO boardVO = new QnaBoardVO();
			
			BeanUtils.populate(boardVO, req.getParameterMap());
			
			IQnaService service = QnaServiceImpl.getInstance();
			
			List<QnaBoardVO> list = service.searchQnaBoard(boardVO);
			
			req.setAttribute("list", list);
			
			return "/WEB-INF/view/board/qnaBoardList.jsp";
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
