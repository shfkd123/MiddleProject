package kr.or.ddit.board.dao;

import java.sql.SQLException;
import java.util.List;

import com.ibatis.sqlmap.client.SqlMapClient;

import kr.or.ddit.board.vo.CommunityBoardVO;
import kr.or.ddit.comm.vo.PagingVO;
import kr.or.ddit.util.SqlMapClientUtil;

public class CommunityBoardDaoImpl implements ICommunityBoardDao {

	private static ICommunityBoardDao communityBoardVO;
	
	public CommunityBoardDaoImpl() {
		SqlMapClientUtil.getInstance();
	}
	
	public static ICommunityBoardDao getInstance() {
		if(communityBoardVO == null) {
			communityBoardVO = new CommunityBoardDaoImpl();
		}
		return communityBoardVO;
	}
	@Override
	public List<CommunityBoardVO> getAllCommunityBoard(SqlMapClient smc, PagingVO pagingVO) throws SQLException {
		List<CommunityBoardVO> communityList = smc.queryForList("community.getAllCommunityBoard", pagingVO);
		return communityList;
	}

	@Override
	public CommunityBoardVO getCommunityBoard(SqlMapClient smc, String cbNm) throws SQLException {
		return (CommunityBoardVO) smc.queryForObject("community.getCommunityBoard", cbNm);
	}

	@Override
	public int insertCommunityBoard(SqlMapClient smc, CommunityBoardVO cbv) throws SQLException {
		int cnt = 0;
		
		Object obj = smc.insert("community.insertCommunityBoard", cbv);
		
		if(obj != null) {
			cnt = 1;
		}
		return cnt;
	}

	@Override
	public int updateCommunityBoard(SqlMapClient smc, CommunityBoardVO cbv) throws SQLException {
		int cnt = 0;
		
		Object obj = smc.update("community.updateCommunityBoard", cbv);
		
		if(obj != null) {
			cnt = 1;
		}
		return cnt;
	}

	@Override
	public int deleteCommunityBoard(SqlMapClient smc, CommunityBoardVO cbv) throws SQLException {
		int cnt = 0;
		
		Object obj = smc.delete("community.deleteCommunityBoard", cbv);
		
		if(obj != null) {
			cnt = 1;
		}
		return cnt;
	}

	@Override
	public List<CommunityBoardVO> searchCommunityBoard(SqlMapClient smc, CommunityBoardVO cbv) throws SQLException {
		return smc.queryForList("community.searchCommunityBoard", cbv);
	}

	@Override
	public int getAllCommunityListCount(SqlMapClient smc) throws SQLException {
		int cnt = (int)smc.queryForObject("community.getFaqAllCount");
		return cnt;
	}

}
