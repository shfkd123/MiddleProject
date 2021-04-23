package kr.or.ddit.boardComment.service;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.ibatis.sqlmap.client.SqlMapClient;

import kr.or.ddit.boardComment.dao.INoticeCmDao;
import kr.or.ddit.boardComment.dao.NoticeCmDaoImpl;
import kr.or.ddit.boardComment.vo.NoticeCmVO;
import kr.or.ddit.util.SqlMapClientUtil;

public class NoticeCmServiceImpl implements INoticeCmService{

	private INoticeCmDao NoticeCmDao;
	private SqlMapClient smc;
	
	public static NoticeCmServiceImpl noticCmService;
	
	private NoticeCmServiceImpl() {
		NoticeCmDao = NoticeCmDaoImpl.getInstance();
		smc = SqlMapClientUtil.getInstance();
	}
	
	public static NoticeCmServiceImpl getInstance() {
		if (noticCmService == null) {
			noticCmService = new NoticeCmServiceImpl();
		}
		return noticCmService;
	}
	
	
	
	@Override
	public int insertNoticeCm(NoticeCmVO ncv) {
		int cnt = 0;
		
		try {
			smc.startTransaction();
			cnt = NoticeCmDao.insertNoticeCm(smc, ncv);
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

	@Override
	public List<NoticeCmVO> getNoticeCmList(String ncNm) {
		List<NoticeCmVO> noticeCmList = new ArrayList<>();

		try {
			noticeCmList = NoticeCmDao.getNoticeCmList(smc, ncNm);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return noticeCmList;
	}
	@Override
	public List<NoticeCmVO> getNoticeCmListByNoticeNm(String noticeNm) {
		List<NoticeCmVO> noticeCmList = new ArrayList<>();
		
		try {
			noticeCmList = NoticeCmDao.getNoticeCmListByNoticeNm(smc, noticeNm);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return noticeCmList;
	}

	@Override
	public int updateNoticeCm(NoticeCmVO ncv) {
		int cnt = 0;

		try {
			cnt = NoticeCmDao.updateNoticeCm(smc, ncv);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return cnt;
	}

	@Override
	public int deleteNoticeCm(String ncNm) {

		int cnt = 0;

		try {
			cnt = NoticeCmDao.deleteNoticeCm(smc, ncNm);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return cnt;
	}

}
