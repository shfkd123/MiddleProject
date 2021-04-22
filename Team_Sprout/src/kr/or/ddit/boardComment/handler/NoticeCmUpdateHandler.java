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

public class NoticeCmUpdateHandler implements CommandHandler{
	
	private static final String VIEW_PAGE = "/WEB-INF/view/board/noticeBoardSelect.jsp";
	@Override
	public boolean isRedirect(HttpServletRequest req) {
		if (req.getMethod().equals("GET")) { // Get방식인 경우.
			return false;
		} else { // POST 방식인 경우...
			return true;
		}
	}

	@Override
	public String process(HttpServletRequest req, HttpServletResponse resp) throws Exception {
		if (req.getMethod().equals("GET")) { // GET 방식인 경우 redirect를 하지 않는다.

			String ncNm = req.getParameter("ncNm");

			INoticeCmService noticeCmService = NoticeCmServiceImpl.getInstance();
			NoticeCmVO ncv = new NoticeCmVO();

			}
			// 2. 모델정보 등록
			req.setAttribute("NoticeBoardVO", null);

			return VIEW_PAGE;
		} 
//	else { // POST방식의 경우
//
//			FileItem item = ((FileUploadRequestWrapper) req).getFileItem("atchFile");
//			String userId = req.getParameter("userId");
//			AtchFileVO atchFileVO = new AtchFileVO();
//
//			// 기존 첨부파일 아이디 정보 가져오기
//			atchFileVO.setAtchFileId(
//					req.getParameter("atchFile") == null ? -1 : Long.parseLong(req.getParameter("atchFile")));
//
//			if (item != null && !item.getName().equals("")) {
//
//				IAtchFileService fileService = AtchFileServiceImpl.getInstance();
//
//				atchFileVO = fileService.saveAtchFile(item, userId); // 첨부파일 저장
//
//			}
//			// 1.요청 파라미터 정보 가져오기
//			String noticeNm = req.getParameter("noticeNm");
//			String noticeTitle = req.getParameter("noticeTitle");
//			String noticeContent = req.getParameter("noticeContent");
//
//			// 2. 서비스 객체 생성하기
//			INoticeService noticeService = NoticeServiceImpl.getInstance();
//
//			// 3. 회원정보 수정하기
//			NoticeBoardVO nv = new NoticeBoardVO();
//			
//			nv.setNoticeTitle(noticeTitle);
//			nv.setNoticeContent(noticeContent);
//			nv.setAtchFileId(atchFileVO.getAtchFileId());
//
//			int cnt = noticeService.updateNoticeBoard(nv);
//
//			String msg = "";
//
//			if (cnt > 0) {
//				msg = "성공";
//			} else {
//				msg = "실패";
//			}
//
//			// 4. 목록 조회화면으로 이동
//			String redirectUrl = req.getContextPath() + "/board/noticeList.do?msg=" + URLEncoder.encode(msg, "UTF-8");
//
//			return redirectUrl;
//		}
//	}

}
