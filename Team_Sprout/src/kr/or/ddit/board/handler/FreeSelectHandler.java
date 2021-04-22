package kr.or.ddit.board.handler;

import java.io.File;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.or.ddit.base.vo.ConstVO;
import kr.or.ddit.board.service.FreeServiceImpl;
import kr.or.ddit.board.service.IFreeService;
import kr.or.ddit.board.vo.FreeBoardVO;
import kr.or.ddit.comm.handler.CommandHandler;
import kr.or.ddit.comm.service.AtchFileServiceImpl;
import kr.or.ddit.comm.service.IAtchFileService;
import kr.or.ddit.comm.vo.AtchFileVO;

public class FreeSelectHandler implements CommandHandler {

	@Override
	public boolean isRedirect(HttpServletRequest req) {

		return false;
	}

	@Override
	public String process(HttpServletRequest req, HttpServletResponse resp) throws Exception {

		String freeNm = req.getParameter("freeNm");

		//
		IFreeService freeService = FreeServiceImpl.getInstance();
		FreeBoardVO fv = freeService.getFreeBoard(freeNm);

		if (fv.getAtchFileId() > 0) { // 첨부파일 존재하면...
			// 첨부파일 정보 조회
			AtchFileVO fileVO = new AtchFileVO();
			fileVO.setAtchFileId(fv.getAtchFileId());

			IAtchFileService atchFileService = AtchFileServiceImpl.getInstance();

			List<AtchFileVO> atchFileList = atchFileService.getAtchFileList(fileVO);
			
			for(int i=0 ; i<atchFileList.size() ; i++) {
				AtchFileVO vo = atchFileList.get(i);
				vo.setTempPath(ConstVO.FILE_PATH_TEMP + "/" + vo.getAtchFileId() + "/" + vo.getOrignlFileNm());
				
				File orgFile = new File(vo.getFileStreCours());
				
				//temp폴더에 파일 만들어 주기
				File f = new File(vo.getTempPath());
				f.mkdirs();//디렉토리 만들기
				if(!f.exists()) {
//					File orgFile = new File(vo.getFileStreCours());
					
				}
				
			}
			
			req.setAttribute("atchFileList", atchFileList);
			req.setAttribute("freeVO", fv);

		}
		return "/WEB-INF/view/board/freeBoardSelect.jsp";
	}

}
