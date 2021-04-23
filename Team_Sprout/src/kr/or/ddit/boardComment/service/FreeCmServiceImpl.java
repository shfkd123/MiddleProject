package kr.or.ddit.boardComment.service;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.ibatis.sqlmap.client.SqlMapClient;

import kr.or.ddit.boardComment.dao.IFreeCmDao;
import kr.or.ddit.boardComment.dao.FreeCmDaoImpl;
import kr.or.ddit.boardComment.vo.FreeCmVO;
import kr.or.ddit.util.SqlMapClientUtil;

public class FreeCmServiceImpl implements IFreeCmService{
	private IFreeCmDao freeCmDao;
	private SqlMapClient smc;
	
	private static IFreeCmService freeCmService;
	
	public FreeCmServiceImpl() {
		freeCmDao = FreeCmDaoImpl.getInstance();
		smc = SqlMapClientUtil.getInstance();
	}
	
	public static IFreeCmService getInstance() {
		if(freeCmService == null) {
			freeCmService = new FreeCmServiceImpl();
		}
		return freeCmService;
	}
	
	@Override
	public List<FreeCmVO> getAllFreeCm(String freeNm) {
		List<FreeCmVO> list = new ArrayList<>();
		try {
			list = freeCmDao.getAllFreeCm(smc, freeNm);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public int insertFreeCm(FreeCmVO fcv) {
		int cnt = 0;
		try {
			cnt = freeCmDao.insertFreeCm(smc, fcv);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return cnt;
	}

	@Override
	public int updateFreeCm(FreeCmVO fcv) {
		int cnt = 0;
		try {
			cnt = freeCmDao.updateFreeCm(smc, fcv);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return cnt;
	}

	@Override
	public int deleteFreeCm(String fcNm) {
		int cnt = 0;
		try {
			cnt = freeCmDao.deleteFreeCm(smc, fcNm);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return cnt;
	}

}
