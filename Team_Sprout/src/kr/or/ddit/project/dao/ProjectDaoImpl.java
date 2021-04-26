package kr.or.ddit.project.dao;

import java.sql.SQLException;
import java.util.List;

import com.ibatis.sqlmap.client.SqlMapClient;

import kr.or.ddit.comm.vo.PagingVO;
import kr.or.ddit.project.vo.ProjectVO;
import kr.or.ddit.util.SqlMapClientUtil;

public class ProjectDaoImpl implements IProjectDao {

	private static IProjectDao projectDao;
	
	public ProjectDaoImpl() {
		SqlMapClientUtil.getInstance();
	}
	
	public static IProjectDao getInstance() {
		if(projectDao == null) {
			projectDao = new ProjectDaoImpl();
		}
		return projectDao;
	}

	@Override
	public List<ProjectVO> getAllProject(SqlMapClient smc, PagingVO pagingVO) throws SQLException {
		return smc.queryForList("project.getAllProject");
	}

	@Override
	public ProjectVO getProject(SqlMapClient smc, String pjNm) throws SQLException {
		return (ProjectVO) smc.queryForObject("project.getProject", pjNm);
	}

	@Override
	public int insertProject(SqlMapClient smc, ProjectVO pv) throws SQLException {
		int cnt = 0;
		
		Object obj = smc.insert("project.insertProject", pv);
		
		if(obj != null) {
			cnt = 1;
		}
		return cnt;
	}

	@Override
	public int updateProject(SqlMapClient smc, ProjectVO pv) throws SQLException {
		return smc.update("project.updateProject", pv);
	}

	@Override
	public int deleteProject(SqlMapClient smc, ProjectVO pv) throws SQLException {
		return smc.delete("project.deleteProject", pv);
	}

	@Override
	public List<ProjectVO> searchProject(SqlMapClient smc, String str) throws SQLException {
		return smc.queryForList("project.searchProject", str);
	}
	
	@Override
	public int getAllProjectListCount(SqlMapClient smc) throws SQLException {
		int cnt = (int)smc.queryForObject("project.getProjectAllCount");
		return cnt;
	}
}
