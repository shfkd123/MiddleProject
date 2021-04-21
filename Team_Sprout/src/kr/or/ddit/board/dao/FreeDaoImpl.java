package kr.or.ddit.board.dao;

import java.sql.SQLException;
import java.util.List;

import com.ibatis.sqlmap.client.SqlMapClient;

import kr.or.ddit.board.vo.FreeBoardVO;
import kr.or.ddit.util.SqlMapClientUtil;

public class FreeDaoImpl implements IFreeBoardDao{

private static IFreeBoardDao freeDao;
	
	private FreeDaoImpl() {
		SqlMapClientUtil.getInstance();
	}
	
	public static IFreeBoardDao getInstance() {
		if(freeDao == null) {
			freeDao = new FreeDaoImpl();
		}
		return freeDao;
	}
	
	@Override //공지사항 게시글 등록
	public int insertFreeBoard(SqlMapClient smc, FreeBoardVO fv) throws SQLException {
		int cnt = 0;
		
		Object obj = smc.insert("freeBoard.insertFreeBoard", fv);
		
		if (obj == null) {
			cnt = 1; //성공
		}
		return cnt;
	}

	@Override //공지사항 게시글 조회
	public List<FreeBoardVO> getFreeBoardList(SqlMapClient smc) throws SQLException {
		
		List<FreeBoardVO> freeList = smc.queryForList("freeBoard.getFreeBoardList");
		
		return freeList;
	}

	@Override //공지사항 게시글 수정
	public int updateFreeBoard(SqlMapClient smc, FreeBoardVO fv) throws SQLException {
		int cnt = 0;
		
		cnt = smc.update("freeBoard.updateFreeBoard", fv);
		return cnt;
	}

	

	@Override //공지사항 게시글 검색 (제목, 내용, 작성자)
	public List<FreeBoardVO> getSearchFreeBoard(SqlMapClient smc, FreeBoardVO fv) throws SQLException {
		
		List<FreeBoardVO> freeList = smc.queryForList("freeBoard.getsearchFreeBoard", fv);
		return freeList;
	}

	@Override //공지사항 삭제
	public int deleteFreeBoard(SqlMapClient smc, String freeNm) throws SQLException {
		int cnt = 0;

		cnt = smc.update("freeBoard.deleteFreeBoard", freeNm);

		return cnt;
	}

	@Override //공지사항 단건 조회
	public FreeBoardVO getFreeBoard(SqlMapClient smc, String freeNm) throws SQLException {
		FreeBoardVO fv = (FreeBoardVO)smc.queryForObject("freeBoard.getFreeBoardInfo", freeNm);
		return fv;
	}

}
