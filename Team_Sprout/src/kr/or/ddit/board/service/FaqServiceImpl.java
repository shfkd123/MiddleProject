package kr.or.ddit.board.service;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.ibatis.sqlmap.client.SqlMapClient;

import kr.or.ddit.board.dao.IFaqBoardDao;
import kr.or.ddit.board.vo.FaqBoardVO;


public class FaqServiceImpl implements IFaqService {
	
	private IFaqBoardDao FaqBoardDao;
	private SqlMapClient smc;
	
	private static IFaqService faqService;
	
	public static IFaqService getInstance() {
		if(faqService == null) {
			faqService = new FaqServiceImpl();
		}
		return faqService;
	}

	@Override
	public List<FaqBoardVO> getAllFaqBoard() {
		List<FaqBoardVO> list = new ArrayList<>();
		try {
			list = FaqBoardDao.getAllFaqBoard(smc);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public FaqBoardVO getFaqBoard(String faqNm) {
		FaqBoardVO fbv = new FaqBoardVO();
		try {
			fbv = FaqBoardDao.getFaqBoard(smc, faqNm);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return fbv;
	}

	@Override
	public int insertFaqBoard(FaqBoardVO fbv) {
		int cnt = 0;
		try {
			cnt = FaqBoardDao.insertFaqBoard(smc, fbv);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return cnt;
	}

	@Override
	public int updateFaqBoard(FaqBoardVO fbv) {
		int cnt = 0;
		try {
			cnt = FaqBoardDao.updateFaqBoard(smc, fbv);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return cnt;
	}

	@Override
	public int deleteFaqBoard(FaqBoardVO fbv) {
		int cnt = 0;
		try {
			cnt = FaqBoardDao.deleteFaqBoard(smc, fbv);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return cnt;
	}

	@Override
	public List<FaqBoardVO> searchQnaBoard(String str) {
		List<FaqBoardVO> list = new ArrayList<>();
		
		try {
			list = FaqBoardDao.searchFaqBoard(smc, str);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}

}
