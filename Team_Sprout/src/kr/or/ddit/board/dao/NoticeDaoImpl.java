package kr.or.ddit.board.dao;

import java.sql.SQLException;
import java.util.List;

import com.ibatis.sqlmap.client.SqlMapClient;

import kr.or.ddit.board.vo.NoticeBoardVO;
import kr.or.ddit.util.SqlMapClientUtil;

public class NoticeDaoImpl implements INoticeBoardDao{

private static INoticeBoardDao noticeDao;
	
	private NoticeDaoImpl() {
		SqlMapClientUtil.getInstance();
	}
	
	public static INoticeBoardDao getInstance() {
		if(noticeDao == null) {
			noticeDao = new NoticeDaoImpl();
		}
		return noticeDao;
	}
	
	@Override //공지사항 게시글 등록
	public int insertNoticeBoard(SqlMapClient smc, NoticeBoardVO nv) throws SQLException {
		int cnt = 0;
		
		Object obj = smc.insert("noticeBoard.insertNoticeBoard", nv);
		
		if (obj == null) {
			cnt = 1; //성공
		}
		return cnt;
	}

	@Override //공지사항 게시글 조회
	public List<NoticeBoardVO> getNoticeBoardList(SqlMapClient smc) throws SQLException {
		
		List<NoticeBoardVO> noticeList = smc.queryForList("noticeBoard.getNoticeBoardList");
		
		return noticeList;
	}

	@Override //공지사항 게시글 수정
	public int updateNoticeBoard(SqlMapClient smc, NoticeBoardVO nv) throws SQLException {
		int cnt = 0;
		
		cnt = smc.update("noticeBoard.updateNoticeBoard", nv);
		return cnt;
	}

	

	@Override //공지사항 게시글 검색 (제목, 내용, 작성자)
	public List<NoticeBoardVO> getSearchNoticeBoard(SqlMapClient smc, NoticeBoardVO nv) throws SQLException {
		
		List<NoticeBoardVO> noticeList = smc.queryForList("noticeBoard.getsearchNoticeBoard", nv);
		return noticeList;
	}

	@Override //공지사항 삭제
	public int deleteNoticeBoard(SqlMapClient smc, String notice_nm) throws SQLException {
		int cnt = 0;

		cnt = smc.update("noticeBoard.deleteNoticeBoard", notice_nm);

		return cnt;
	}

	@Override //공지사항 단건 조회
	public NoticeBoardVO getNoticeBoard(SqlMapClient smc, String notice_nm) throws SQLException {
		NoticeBoardVO nv = (NoticeBoardVO)smc.queryForObject("noticeBoard.getNoticeBoardInfo", notice_nm);
		return nv;
	}

}
