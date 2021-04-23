package kr.or.ddit.boardComment.dao;

import java.sql.SQLException;
import java.util.List;

import com.ibatis.sqlmap.client.SqlMapClient;

import kr.or.ddit.boardComment.vo.FreeCmVO;

public interface IFreeCmDao {
	
	/**
	 * 자유게시판 댓글 목록 출력 메서드
	 * @param smc
	 * @return
	 * @throws SQLException
	 */
	public List<FreeCmVO> getAllFreeCm(SqlMapClient smc, String freeNm) throws SQLException;
	
	/**
	 * 자유게시판 댓글 작성 메서드
	 * @param smc
	 * @param fcv
	 * @return
	 * @throws SQLException
	 */
	public int insertFreeCm(SqlMapClient smc, FreeCmVO fcv) throws SQLException;
	
	/**
	 * 자유게시판 댓글 수정 메서드
	 * @param smc
	 * @param fcv
	 * @return
	 * @throws SQLException
	 */
	public int updateFreeCm(SqlMapClient smc, FreeCmVO fcv) throws SQLException;
	
	/**
	 * 자유게시판 댓글 삭제 메서드
	 * @param smc
	 * @param freeCmNm
	 * @return
	 * @throws SQLException
	 */
	public int deleteFreeCm(SqlMapClient smc, String fcNm) throws SQLException;
	
}
