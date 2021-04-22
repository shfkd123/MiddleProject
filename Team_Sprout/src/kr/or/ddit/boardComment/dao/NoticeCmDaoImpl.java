package kr.or.ddit.boardComment.dao;

import java.sql.SQLException;
import java.util.List;

import com.ibatis.sqlmap.client.SqlMapClient;

import kr.or.ddit.board.dao.NoticeDaoImpl;
import kr.or.ddit.board.vo.NoticeBoardVO;
import kr.or.ddit.boardComment.vo.NoticeCmVO;

public class NoticeCmDaoImpl implements INoticeCmDao{

	private static INoticeCmDao NoticeCmDao;
	
	public static INoticeCmDao getInstance() {
		if(NoticeCmDao == null) {
			NoticeCmDao = new NoticeCmDaoImpl();
		}
		return NoticeCmDao;
	}

	//공지사항 댓글 등록
	@Override
	public int insertNoticeCm(SqlMapClient smc, NoticeCmVO ncv) throws SQLException {
		int cnt = 0;
		
		Object obj = smc.insert("noticeCm.insertNoticeCm", ncv);
		
		if (obj == null) {
			cnt = 1; //성공
		}
		return cnt;
	}

	//공지사항 댓글 조회
	@Override
	public List<NoticeCmVO> getNoticeCmList(SqlMapClient smc) throws SQLException {
		List<NoticeCmVO> noticeCmList = smc.queryForList("noticeCm.getNoticeCmList");
		
		return noticeCmList;
	}

	//공지사항 댓글 수정
	@Override
	public int updateNoticeCm(SqlMapClient smc, NoticeCmVO ncv) throws SQLException {
		int cnt = 0;
		
		cnt = smc.update("noticeCm.updateNoticeCm", ncv);
		return cnt;
	}

	//공지사항 댓글 삭제
	@Override
	public int deleteNoticeCm(SqlMapClient smc, String ncNm) throws SQLException {
		int cnt = 0;

		cnt = smc.update("noticeCm.deleteNoticeCm", ncNm);

		return cnt;
	}
}