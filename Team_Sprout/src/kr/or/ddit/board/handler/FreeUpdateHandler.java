package kr.or.ddit.board.handler;

import java.net.URLEncoder;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.fileupload.FileItem;

import kr.or.ddit.comm.handler.CommandHandler;
import kr.or.ddit.comm.service.AtchFileServiceImpl;
import kr.or.ddit.comm.service.IAtchFileService;
import kr.or.ddit.board.service.IFreeService;
import kr.or.ddit.board.service.FreeServiceImpl;
import kr.or.ddit.comm.vo.AtchFileVO;
import kr.or.ddit.user.vo.UserVO;
import kr.or.ddit.board.vo.FreeBoardVO;
import kr.or.ddit.util.FileUploadRequestWrapper;

public class FreeUpdateHandler implements CommandHandler{

	private static final String VIEW_PAGE = "/WEB-INF/view/board/freeBoardUpdate.jsp";

	@Override
	public boolean isRedirect(HttpServletRequest req) {
		if(req.getMethod().equals("GET")) { // GET 방식인 경우 redirect를 하지 않는다.
			return false;
		}else { // POST 방식인 경우
			return true;
		}
	}

	@Override
	public String process(HttpServletRequest req, HttpServletResponse resp) throws Exception {
		if(req.getMethod().equals("GET")) { // GET 방식인 경우 redirect를 하지 않는다.
			String freeNm = req.getParameter("freeNm");
			
			IFreeService service = FreeServiceImpl.getInstance();
			
			FreeBoardVO fv = service.getFreeBoard(freeNm);
			
			if(fv.getAtchFileId() > 0) { // 첨부파일이 존재하면..
				// 첨부파일 정보 조회
				AtchFileVO fileVO = new AtchFileVO();
				fileVO.setAtchFileId(fv.getAtchFileId());
				
				IAtchFileService atchFileService = AtchFileServiceImpl.getInstance();
				List<AtchFileVO> atchFileList = atchFileService.getAtchFileList(fileVO);
				
				req.setAttribute("atchFileList", atchFileList);
			}
			
			// 2. 모델정보 등록
			req.setAttribute("freeVO", fv);
			
			return VIEW_PAGE;
			
			
		}else { // POST 방식인 경우
			
			FileItem item = ((FileUploadRequestWrapper)req).getFileItem("atchFile");
			
			AtchFileVO atchFileVO = new AtchFileVO();

			HttpSession session = req.getSession();
			UserVO uv = (UserVO) session.getAttribute("userVO");
			String userId = uv.getUserId();			
			
			// 기존의 첨부파일 아이디 정보 가져오기
			atchFileVO.setAtchFileId(req.getParameter("atchFile") == null ?
					-1 : Long.parseLong(req.getParameter("atchFile")));
			
			if(item !=null && !item.getName().equals("")) {
				
				IAtchFileService fileService = AtchFileServiceImpl.getInstance();
				
				atchFileVO = fileService.saveAtchFile(item, userId); // 첨부파일 저장
			}
			
			// 1. 요청파라미터 정보 가져오기
			String freeNm = req.getParameter("freeNm");
			String freeTitle = req.getParameter("freeTitle");
			String freeContent = req.getParameter("freeContent");
			
			// 2. 서비스 객체 생성하기
			IFreeService freeService = FreeServiceImpl.getInstance();
			
			// 3. 회원정보 수정하기
			FreeBoardVO fv = new FreeBoardVO();
			/*fv.setFreeNm(freeNm);*/
			fv.setFreeTitle(freeTitle);
			fv.setFreeContent(freeContent);
			/*fv.setUserId(userId);*/
			fv.setAtchFileId(atchFileVO.getAtchFileId());
			
			int cnt = freeService.updateFreeBoard(fv);
			
			String msg = "";
			if(cnt > 0) {
				msg = "성공";
			}else {
				msg = "실패";
			}
			
			// 4. 목록 조회화면으로 이동
			String redirectUrl = req.getContextPath() + "/board/freeBoardList.do?msg=" + URLEncoder.encode(msg, "UTF-8");
			
			return redirectUrl;			
		}
	}
}
