package kr.or.ddit.board.dao;

import java.sql.SQLException;
import java.util.List;

import com.ibatis.sqlmap.client.SqlMapClient;

import kr.or.ddit.board.vo.ReportBoardVO;


public interface IReportBoardDao {

	public List<ReportBoardVO> getAllReportBoard(SqlMapClient smc) throws SQLException;
	
	/**
	 * 게시글 조회
	 * @param smc
	 * @param QnaNm
	 * @return
	 * @throws SQLException
	 */
	public ReportBoardVO getReportBoard(SqlMapClient smc, String QnaNm) throws SQLException;

	/**
	 * 게시글 등록
	 * @param smc
	 * @param rbv
	 * @return
	 * @throws SQLException
	 */
	public int insertReportBoard(SqlMapClient smc, ReportBoardVO rbv) throws SQLException;
	
	/**
	 * 게시글 수정
	 * @param smc
	 * @param rbv
	 * @return
	 * @throws SQLException
	 */
	public int updateReportBoard(SqlMapClient smc, ReportBoardVO rbv) throws SQLException;
	
	/**
	 * 게시글 삭제
	 * @param smc
	 * @param rbv
	 * @return
	 * @throws SQLException
	 */
	public int deleteReportBoard(SqlMapClient smc, ReportBoardVO rbv) throws SQLException;
	
	/**
	 * 게시글 검색
	 * @param smc
	 * @param str
	 * @return
	 * @throws SQLException
	 */
	public List<ReportBoardVO> searchReportBoard(SqlMapClient smc, String str) throws SQLException;
}
