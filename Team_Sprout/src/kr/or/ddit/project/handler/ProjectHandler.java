package kr.or.ddit.project.handler;

import java.net.URLEncoder;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.fileupload.FileItem;

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
				ProjectVO pv = new ProjectVO(); 
				
				IProjectService service = ProjectServiceImpl.getInstance();
				IProjectOptionService serviceOption = ProjectOptionServiceImpl.getInstance();
				
				
				String pjName = req.getParameter("pjName");
				String pjContent = req.getParameter("pjContent");
				String PjCategory = req.getParameter("PjCategory");
				String pjPriceAmount = req.getParameter("pjPriceAmount");
				pv.setPjName(pjName);
				pv.setPjContent(pjContent);
				pv.setUserId(userId);
				pv.setPjCategory(PjCategory);
				pv.setPjPriceAmount(pjPriceAmount);
				
//				req.getParameterValues(pjName)
				
				
				if((String)req.getParameter("attachFile") == "") {
					FileItem item = ((FileUploadRequestWrapper)req).getFileItem("atchFileId");
					AtchFileVO atchFileVO = new AtchFileVO();
					
					IAtchFileService fileService = AtchFileServiceImpl.getInstance();
					atchFileVO = fileService.saveAtchFile(item, userId);
					
					pv.setAtchFileId(atchFileVO.getAtchFileId());
				}
				
				int cnt = service.insertProject(pv);

				String msg = "";
				
				if(cnt > 0) {
					msg = "성공";
				} else {
					msg = "실패";
				}
				String redirectUrl = req.getContextPath() 
						+ "/project/faqBoard.do?msg="
						+ URLEncoder.encode(msg, "UTF-8");
				return redirectUrl;
			}
			
		}  else if("D".equals(flag)) { // 프로젝트 삭제
			ProjectVO pv = new ProjectVO();
			
			pv.setPjNm(req.getParameter("PjNm"));
			
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
			String pjNm = req.getParameter("pjNm");
			
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
		
		// 모든 프로젝트 조회
		
		// 요청 페이지 번호
		int pageNo = 
			req.getParameter("pageNo") == null ? 
			1 : Integer.parseInt(req.getParameter("pageNo"));
		
		PagingVO pagingVO = new PagingVO();
		
		
		
		ProjectVO projectVO = new ProjectVO();
		
		BeanUtils.populate(projectVO, req.getParameterMap());
		
		IProjectService service = ProjectServiceImpl.getInstance();
		
		int totalCount = service.getAllProjectListCount();
		pagingVO.setTotalCount(totalCount);
		pagingVO.setCurrentPageNo(pageNo);
		pagingVO.setCountPerPage(5);
		pagingVO.setPageSize(5);

		List<ProjectVO> list = service.getAllProjectList(pagingVO);
		
		   
		req.setAttribute("list", list);
		req.setAttribute("pagingVO", pagingVO);
		
		return "/WEB-INF/view/project/projectList.jsp";
	}

}
