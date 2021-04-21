package kr.or.ddit.board.dao;

import java.sql.SQLException;

import java.util.List;

import com.ibatis.sqlmap.client.SqlMapClient;

import kr.or.ddit.board.vo.FreeBoardVO;


public interface IFreeBoardDao {

	/**
	 * 공지사항 등록
	 * @param smc
	 * @param fv
	 * @return 성공 1 실패 0
	 * @throws SQLException
	 */
	public int insertFreeBoard(SqlMapClient smc, FreeBoardVO fv) throws SQLException;
	
	/**
	 * 공지사항 목록 조회
	 * @param smc
	 * @return list
	 * @throws SQLException
	 */
	public List<FreeBoardVO> getFreeBoardList(SqlMapClient smc) throws SQLException;
	
	/**
	 * 공지사항 수정 
	 * @param smc
	 * @param fv
	 * @return 성공 1 실패 0
	 * @throws SQLException
	 */
	public int updateFreeBoard(SqlMapClient smc, FreeBoardVO fv) throws SQLException;
	
	
	/**
	 * 공지사항 검색 
	 * @param smc
	 * @param fv
	 * @return
	 * @throws SQLException
	 */
	public List<FreeBoardVO> getSearchFreeBoard(SqlMapClient smc, FreeBoardVO fv) throws SQLException;
	
	/**
	 * 공지사항 삭제
	 * @param smc
	 * @param free_nm
	 * @return
	 * @throws SQLException
	 */
	public int deleteFreeBoard(SqlMapClient smc, String freeNm) throws SQLException;
	
	/**
	 * 해당 번호 공지사항 조회 
	 * @param smc
	 * @param free_nm
	 * @return
	 * @throws SQLException
	 */
	public FreeBoardVO getFreeBoard(SqlMapClient smc, String free_nm) throws SQLException;
}
