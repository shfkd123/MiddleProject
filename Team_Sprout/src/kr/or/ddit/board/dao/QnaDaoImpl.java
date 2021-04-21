package kr.or.ddit.board.dao;

import java.sql.SQLException;
import java.util.List;

import com.ibatis.sqlmap.client.SqlMapClient;

import kr.or.ddit.board.vo.QnaBoardVO;
import kr.or.ddit.util.SqlMapClientUtil;

public class QnaDaoImpl implements IQnaBoardDao {

	private static IQnaBoardDao qba;
	
	public QnaDaoImpl() {
		SqlMapClientUtil.getInstance();
	}
	
	public static IQnaBoardDao getInstance() {
		if(qba == null) {
			qba = new QnaDaoImpl();
		}
		return qba;
	}

	@Override
	public List<QnaBoardVO> getAllQnaBoard(SqlMapClient smc) throws SQLException {
		return smc.queryForList("qnaBoard.getAllQnaBoard");
	}

	@Override
	public QnaBoardVO getQnaBoard(SqlMapClient smc, String QnaNm) throws SQLException {
		return (QnaBoardVO) smc.queryForObject("qnaBoard.getQnaBoard", QnaNm);
	}

	@Override
	public int insertQnaBoard(SqlMapClient smc, QnaBoardVO qbv) throws SQLException {
		int cnt = 0;
		
		Object obj = smc.insert("qnaBoard.insertQnaBoard", qbv);
		
		if(obj != null) {
			cnt = 1;
		}
		return cnt;
	}

	@Override
	public int updateQnaBoard(SqlMapClient smc, QnaBoardVO qbv) throws SQLException {
		int cnt = 0;
		
		Object obj = smc.update("qnaBoard.updateQnaBoard", qbv);
		
		if(obj != null) {
			cnt = 1;
		}
		return cnt;
	}

	@Override
	public int deleteQnaBoard(SqlMapClient smc, QnaBoardVO qbv) throws SQLException {
		int cnt = 0;
		
		Object obj = smc.delete("qnaBoard.deleteQnaBoard", qbv);
		
		if(obj != null) {
			cnt = 1;
		}
		return cnt;
	}

	@Override
	public List<QnaBoardVO> searchQnaBoard(SqlMapClient smc, QnaBoardVO qbv) throws SQLException {
		return smc.queryForList("qnaBoard.searchQnaBoard", qbv);
	}
}
