package kr.or.ddit.board.service;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.ibatis.sqlmap.client.SqlMapClient;

import kr.or.ddit.board.dao.IFreeBoardDao;
import kr.or.ddit.board.dao.FreeDaoImpl;
import kr.or.ddit.board.vo.FreeBoardVO;
import kr.or.ddit.util.SqlMapClientUtil;

public class FreeServiceImpl implements IFreeService{

	private IFreeBoardDao freeDao;
	private SqlMapClient smc;
	
	public static FreeServiceImpl freeService;
	
	private FreeServiceImpl() {
		freeDao = FreeDaoImpl.getInstance();
		smc = SqlMapClientUtil.getInstance();
	}
	
	public static FreeServiceImpl getInstance() {
		if (freeService == null) {
			freeService = new FreeServiceImpl();
		}
		return freeService;
		
	}
	
	//공지글 등록
	@Override
	public int insertFreeBoard(FreeBoardVO fv) {
		int cnt = 0;
		
		try {
			smc.startTransaction();
			cnt = freeDao.insertFreeBoard(smc, fv);
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
	public List<FreeBoardVO> getFreeBoardList() {
		List<FreeBoardVO> freeList = new ArrayList<>();

		try {
			freeList = freeDao.getFreeBoardList(smc);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return freeList;
	}
	
	//공지글 검색
	@Override
	public List<FreeBoardVO> getSearchFreeBoardList(FreeBoardVO fv) {
		List<FreeBoardVO> freeList = new ArrayList<>();

		try {
			freeList = freeDao.getSearchFreeBoard(smc, fv);

		} catch (SQLException ex) {
			ex.printStackTrace();
		}
		return freeList;
	}

	//공지글 삭제
	@Override
	public int deleteFreeBoard(String freeNm) {
		
		int cnt = 0;

		try {
			cnt = freeDao.deleteFreeBoard(smc, freeNm);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return cnt;
	}

	@Override
	public int updateFreeBoard(FreeBoardVO fv) {
		int cnt = 0;

		try {
			cnt = freeDao.updateFreeBoard(smc, fv);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return cnt;
	}

	@Override
	public FreeBoardVO getFreeBoard(String freeNm) {
		FreeBoardVO fv = null;

		try {
			fv = freeDao.getFreeBoard(smc, freeNm);
		} catch (SQLException ex) {
			ex.printStackTrace();
		}
		return fv;
	}
}
