package kr.or.ddit.project.handler;

import java.net.URLEncoder;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.fileupload.FileItem;

import kr.or.ddit.board.service.FreeServiceImpl;
import kr.or.ddit.board.service.IFreeService;
import kr.or.ddit.board.vo.FreeBoardVO;
import kr.or.ddit.comm.handler.CommandHandler;
import kr.or.ddit.comm.service.AtchFileServiceImpl;
import kr.or.ddit.comm.service.IAtchFileService;
import kr.or.ddit.comm.vo.AtchFileVO;
import kr.or.ddit.comm.vo.PagingVO;
import kr.or.ddit.project.service.IProjectOptionService;
import kr.or.ddit.project.service.IProjectService;
import kr.or.ddit.project.service.ProjectOptionServiceImpl;
import kr.or.ddit.project.service.ProjectServiceImpl;
import kr.or.ddit.project.vo.ProjectOptionVO;
import kr.or.ddit.project.vo.ProjectVO;
import kr.or.ddit.user.vo.UserVO;
import kr.or.ddit.util.FileUploadRequestWrapper;

public class ProjectHandler implements CommandHandler{

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
				return "/WEB-INF/view/project/projectInsert.jsp";
			} else {
				
				String userId = uv.getUserId();

				IProjectService service = ProjectServiceImpl.getInstance();
				IProjectOptionService serviceOption = ProjectOptionServiceImpl.getInstance();
				
				ProjectVO pv = new ProjectVO(); 
				BeanUtils.populate(pv, req.getParameterMap());
				pv.setUserId(userId);
				
//				if((String)req.getParameter("atchFileId") == "") {
//					FileItem item = ((FileUploadRequestWrapper)req).getFileItem("atchFileId");
//					AtchFileVO atchFileVO = new AtchFileVO();
//					
//					IAtchFileService fileService = AtchFileServiceImpl.getInstance();
//					atchFileVO = fileService.saveAtchFile(item, userId);
//					
//					pv.setAtchFileId(atchFileVO.getAtchFileId());
//				}
//				
				long newPjNm = service.insertProject(pv);
				
				
				FileItem item = ((FileUploadRequestWrapper)req).getFileItem("atchFileId");
				
				AtchFileVO atchFileVO = new AtchFileVO();
				
				atchFileVO.setAtchFileId(req.getParameter("atchFileId") == null ?
						-1 : Long.parseLong(req.getParameter("atchFileId")));
				
				if(item !=null && !item.getName().equals("")) {
					IAtchFileService fileService = AtchFileServiceImpl.getInstance();
					atchFileVO = fileService.saveAtchFile(item, userId); // 첨부파일 저장
					pv.setAtchFileId(atchFileVO.getAtchFileId());
				}
				
				/*프로젝트 옵션 전송*/
				String[] poName = req.getParameterValues("poName");
				String[] poAddPrice = req.getParameterValues("poAddPrice");
				String[] poContent = req.getParameterValues("poContent");
				
				for ( int i = 0 ; i < poName.length ; i++ ) {
					ProjectOptionVO pov = new ProjectOptionVO(); 
					
					pov.setPjNm(newPjNm);
					pov.setPoName(poName[i]);
					pov.setPoAddPrice(Long.parseLong(poAddPrice[i]));
					pov.setPoContent(poContent[i]);
					
					serviceOption.insertProjectOption(pov);
				}
				
				String msg = "";
				if(newPjNm > 0 ) {
					msg = "성공";
				} else {
					msg = "실패";
				}
				String redirectUrl = req.getContextPath() 
						+ "/project/projectBoard.do?msg="
						+ URLEncoder.encode(msg, "UTF-8");
				return redirectUrl;
			}
			
		}  else if("D".equals(flag)) { // 프로젝트 삭제
			ProjectVO pv = new ProjectVO();
			
			pv.setPjNm(Integer.parseInt(req.getParameter("PjNm")));
			
			IProjectService service = ProjectServiceImpl.getInstance();
			
			int cnt = service.deleteProject(pv);
			
			String msg = "";
			if(cnt > 0){
				msg = "성공";
			} else {
				msg = "실패";
			}
			
			String redirectUrl = req.getContextPath() + "/project/ProjectBoard.do?msg=" + URLEncoder.encode(msg, "UTF-8");
			
			return redirectUrl;
			
		} else if("SEL".equals(flag)) { // 한 프로젝트 조회
			long pjNm = Long.parseLong(req.getParameter("pjNm"));
			
			IProjectService service = ProjectServiceImpl.getInstance();
			IProjectOptionService serviceOption = ProjectOptionServiceImpl.getInstance();
			
			ProjectVO pv = service.getProject(pjNm);
			ProjectOptionVO pov = serviceOption.getProjectOption(pjNm);
			
			if(pv.getAtchFileId() > 0) { // 첨부파일이 존재할 때
				AtchFileVO fileVO = new AtchFileVO();
				
				fileVO.setAtchFileId(pv.getAtchFileId());
				
				IAtchFileService fileService = AtchFileServiceImpl.getInstance();
				
				List<AtchFileVO> atchFileList = fileService.getAtchFileList(fileVO);
				
				req.setAttribute("atchFileList", atchFileList);
			}
			
			req.setAttribute("pv", pv);
			
			return "/WEB-INF/view/project/projectSelect.jsp";
			
		} else if("SCH".equals(flag)) { // 게시글 검색
			String pjName = "";
			String pjCategory = "";

			pjName = req.getParameter("pjName");
			
			IProjectService service = ProjectServiceImpl.getInstance();
			
			List<ProjectVO> list = service.searchProject(pjName);
			
			req.setAttribute("pjName", pjName);
			req.setAttribute("list", list);
			
			return "/WEB-INF/view/project/projectList.jsp";
			
		} else if("INS".equals(flag)) {
			return "/WEB-INF/view/project/projectInsert.jsp";
		} 
		
	
		ProjectVO projectVO = new ProjectVO();
		
		BeanUtils.populate(projectVO, req.getParameterMap());
		
		IProjectService service2 = ProjectServiceImpl.getInstance();
		
		List<ProjectVO> list = service2.getAllProjectList();
		
		req.setAttribute("list", list);
		
		return "/WEB-INF/view/project/projectList.jsp";
	}

}
