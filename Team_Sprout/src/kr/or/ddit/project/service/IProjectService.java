package kr.or.ddit.project.service;

import java.util.List;

import kr.or.ddit.comm.vo.PagingVO;
import kr.or.ddit.project.vo.ProjectVO;

public interface IProjectService {

	/**
	 * 프로젝트 게시판 전체목록 조회 메서드
	 * @return List<ProjectVO>
	 */
	public List<ProjectVO> getAllProjectList(PagingVO pagingVO);
	
	/**
	 * 프로젝트 게시글 조회 메서드
	 * @return ProjectVO
	 */
	public ProjectVO getProject(String pjNm);
	
	/**
	 * 프로젝트 게시글 등록 메서드
	 * @return 작업성공 : 1, 작업실패 : 0
	 */
	public int insertProject(ProjectVO pv);
	
	/**
	 * 프로젝트 게시글 수정 메서드
	 * @return 작업성공 : 1, 작업실패 : 0
	 */
	public int updateProject(ProjectVO pv);
	
	/**
	 * 프로젝트 게시글 삭제 메서드
	 * @return 작업성공 : 1, 작업실패 : 0
	 */
	public int deleteProject(ProjectVO pv);
	
	/**
	 * 프로젝트 게시글 검색하는 메서드
	 * @param pv
	 * @return List<ProjectVO>
	 */
	public List<ProjectVO> searchProject(String str);
	
	/**
	 * 전체 프로젝트 게시글 수 반환하는 메서드
	 * @return 전체 게시글 수 
	 */
	public int getAllProjectListCount();
}
