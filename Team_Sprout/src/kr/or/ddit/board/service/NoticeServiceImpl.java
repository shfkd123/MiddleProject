package kr.or.ddit.board.service;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.ibatis.sqlmap.client.SqlMapClient;

import kr.or.ddit.board.dao.INoticeBoardDao;
import kr.or.ddit.board.dao.NoticeDaoImpl;
import kr.or.ddit.board.vo.NoticeBoardVO;
import kr.or.ddit.util.SqlMapClientUtil;

public class NoticeServiceImpl implements INoticeService{

	private INoticeBoardDao noticeDao;
	private SqlMapClient smc;
	
	public static NoticeServiceImpl noticeService;
	
	private NoticeServiceImpl() {
		noticeDao = NoticeDaoImpl.getInstance();
		smc = SqlMapClientUtil.getInstance();
	}
	
	public static NoticeServiceImpl getInstance() {
		if (noticeService == null) {
			noticeService = new NoticeServiceImpl();
		}
		return noticeService;
		
	}
	
	//공지글 등록
	@Override
	public int insertNoticeBoard(NoticeBoardVO nv) {
		int cnt = 0;
		
		try {
			smc.startTransaction();
			cnt = noticeDao.insertNoticeBoard(smc, nv);
			smc.commitTransaction();
		} catch (SQLException e) {
			try {
				smc.endTransaction();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			e.printStackTrace();
		}
		return cnt;
	}
	
	//공지글 조회
	@Override
	public List<NoticeBoardVO> getNoticeBoardList() {
		List<NoticeBoardVO> noticeList = new ArrayList<>();

		try {
			noticeList = noticeDao.getNoticeBoardList(smc);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return noticeList;
	}
	


	//공지글 삭제
	@Override
	public int deleteNoticeBoard(String noticeNm) {
		
		int cnt = 0;

		try {
			cnt = noticeDao.deleteNoticeBoard(smc, noticeNm);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return cnt;
	}

	//공지사항 수정
	@Override
	public int updateNoticeBoard(NoticeBoardVO nv) {
		int cnt = 0;

		try {
			cnt = noticeDao.updateNoticeBoard(smc, nv);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return cnt;
	}

	//공지글 단건조회
	@Override
	public NoticeBoardVO getNoticeBoard(String notice_nm) {
		NoticeBoardVO nv = null;

		try {
			nv = noticeDao.getNoticeBoard(smc, notice_nm);
		} catch (SQLException ex) {
			ex.printStackTrace();
		}
		return nv;
	}

	//공지글 검색
	@Override
	public List<NoticeBoardVO> getSearchNoticeBoardList(String notice_title) {
		List<NoticeBoardVO> noticeList = new ArrayList<>();
		try {
			noticeList = noticeDao.getSearchNoticeBoard(smc, notice_title);

		} catch (SQLException ex) {
			ex.printStackTrace();
		}
		return noticeList;
	}
}
