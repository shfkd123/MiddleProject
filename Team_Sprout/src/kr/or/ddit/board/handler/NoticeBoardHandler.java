package kr.or.ddit.board.handler;

import java.net.URLEncoder;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;

import kr.or.ddit.board.service.INoticeService;
import kr.or.ddit.board.service.NoticeServiceImpl;
import kr.or.ddit.board.vo.NoticeBoardVO;
import kr.or.ddit.comm.handler.CommandHandler;
import kr.or.ddit.comm.service.AtchFileServiceImpl;
import kr.or.ddit.comm.service.IAtchFileService;
import kr.or.ddit.comm.vo.AtchFileVO;
import kr.or.ddit.util.FileUploadRequestWrapper;

public class NoticeBoardHandler implements CommandHandler {

	@Override
	public boolean isRedirect(HttpServletRequest req) {

		return false;
	}

	@Override
	public String process(HttpServletRequest req, HttpServletResponse resp) throws Exception {
		String flag = req.getParameter("flag");
		try {
			// if(flag.equals("L")) {
			if ("L".equals(flag)) { // 목록조회
				// 1. 서비스 객체 생성하기
				INoticeService noticeService = NoticeServiceImpl.getInstance();

				// 2. 회원정보 조회
				List<NoticeBoardVO> noticeList = noticeService.getNoticeBoardList();

				req.setAttribute("noticeList", noticeList);

				return "/WEB-INF/view/board/noticeBoardlist.jsp";

			} else if ("C".equals(flag)) { // 등록
				if (req.getMethod().equals("GET")) { // GET
					return "/WEB-INF/view/board/noticeBoardInsert.jsp";
				} else if (req.getMethod().equals("POST")) { // Post방식인 경우isRedirect를 한다.

					FileItem item = ((FileUploadRequestWrapper) req).getFileItem("atchFile");
					String userId = req.getParameter("userId");

					AtchFileVO atchFileVO = new AtchFileVO();

					IAtchFileService fileService = AtchFileServiceImpl.getInstance();
					atchFileVO = fileService.saveAtchFile(item, userId);

					// 1. 요청파라미터 정보 가져오기
					String noticeTitle = req.getParameter("noticeTitle");
					String noticeContent = req.getParameter("noticeContent");

					// 2. 서비스 객체 생성하기
					INoticeService noticeService = NoticeServiceImpl.getInstance();

					// 3. 게시글 등록하기
					NoticeBoardVO nv = new NoticeBoardVO();

					nv.setNoticeTitle(noticeTitle);
					nv.setNoticeContent(noticeContent);
					nv.setAtchFileId(atchFileVO.getAtchFileId());

					int cnt = noticeService.insertNoticeBoard(nv);

					String msg = "";

					if (cnt > 0) {
						msg = "성공";
					} else {
						msg = "실패";
					}

					// 4. 목록 조회화면으로 이동 - Redirect
					String redirectUrl = req.getContextPath() + "/board/noticeBoardList.do?msg="
							+ URLEncoder.encode(msg, "UTF-8");

					return redirectUrl;

				}
				return null;

			} else if ("U".equals(flag)) { // 수정
				if (req.getMethod().equals("GET")) { // GET 방식인 경우 redirect를 하지 않는다.

					String noticeNm = req.getParameter("noticeNm");

					INoticeService noticeservice = NoticeServiceImpl.getInstance();
					NoticeBoardVO nv = noticeservice.getNoticeBoard(noticeNm);

					if (nv.getAtchFileId() > 0) { // 첨부파일이 존재하면
						// 첨부파일 정보 조회

						AtchFileVO fileVO = new AtchFileVO();
						fileVO.setAtchFileId(nv.getAtchFileId());

						IAtchFileService atchFileService = AtchFileServiceImpl.getInstance();
						atchFileService.getAtchFileList(fileVO);

						List<AtchFileVO> atchFileList = atchFileService.getAtchFileList(fileVO);

						req.setAttribute("atchFileList", atchFileList);
					}

					// 2. 모델정보 등록
					req.setAttribute("NoticeBoardVO", nv);

					return "/WEB-INF/view/board/updateForm.jsp";
				} else { // POST방식의 경우

					FileItem item = ((FileUploadRequestWrapper) req).getFileItem("atchFile");
					String userId = req.getParameter("userId");
					AtchFileVO atchFileVO = new AtchFileVO();

					// 기존 첨부파일 아이디 정보 가져오기
					atchFileVO.setAtchFileId(
							req.getParameter("atchFile") == null ? -1 : Long.parseLong(req.getParameter("atchFile")));

					if (item != null && !item.getName().equals("")) {

						IAtchFileService fileService = AtchFileServiceImpl.getInstance();

						atchFileVO = fileService.saveAtchFile(item, userId); // 첨부파일 저장

					}
					// 1.요청 파라미터 정보 가져오기
					String noticeTitle = req.getParameter("noticeNm");
					String noticeContent = req.getParameter("noticeContent");

					// 2. 서비스 객체 생성하기
					INoticeService noticeService = NoticeServiceImpl.getInstance();

					// 3. 회원정보 수정하기
					NoticeBoardVO nv = new NoticeBoardVO();

					nv.setNoticeTitle(noticeTitle);
					nv.setNoticeContent(noticeContent);
					nv.setAtchFileId(atchFileVO.getAtchFileId());

					int cnt = noticeService.updateNoticeBoard(nv);

					String msg = "";

					if (cnt > 0) {
						msg = "성공";
					} else {
						msg = "실패";
					}

					// 4. 목록 조회화면으로 이동
					String redirectUrl = req.getContextPath() + "/board/noticeBoardList.do?msg="
							+ URLEncoder.encode(msg, "UTF-8");

					return redirectUrl;
				}

			} else if ("D".equals(flag)) { // 삭제
				// 1.요청파라미터 정보 가져오기
				String noticeNm = req.getParameter("noticeNm");

				// 2. 삭제처리
				INoticeService noticeService = NoticeServiceImpl.getInstance();

				int cnt = noticeService.deleteNoticeBoard(noticeNm);

				String msg = "";

				if (cnt > 0) {
					msg = "성공";
				} else {
					msg = "실패";
				}

				// 4. 목록 조회화면으로 이동
				String redirectUrl = req.getContextPath() + "/board/noticeBoardList.do?msg="
						+ URLEncoder.encode(msg, "UTF-8");

				return redirectUrl;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
}
