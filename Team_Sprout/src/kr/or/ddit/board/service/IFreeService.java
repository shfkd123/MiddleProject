package kr.or.ddit.board.service;

import java.util.List;

import kr.or.ddit.board.vo.FreeBoardVO;
import kr.or.ddit.board.vo.FreeBoardVO;

public interface IFreeService {
	
	/**
	 * 자유게시판 등록 메서드
	 * @param fv
	 * @return 성공1 실패 0 반환
	 */
	public int insertFreeBoard(FreeBoardVO fv);
	
	/**
	 * 전체 자유게시판 목록 조회 메서드
	 * @return 자유게시판 List
	 */
	public List<FreeBoardVO> getFreeBoardList();
	
	/**
	 * 자유게시판 삭제 메서드
	 * @param freeNm
	 * @return 성공1 실패 0 반환
	 */
	public int deleteFreeBoard(String freeNm);
	
	/**
	 * 자유게시판 수정 메서드
	 * @param fv
	 * @return 성공1 실패 0 반환
	 */
	public int updateFreeBoard(FreeBoardVO fv);
	
	/**
	 * 자유게시판 검색 메서드
	 * @param fv
	 * @return 검색된 결과를 담은 List
	 */
	public List<FreeBoardVO> getSearchFreeBoardList(FreeBoardVO fv);
	
	/**
	 * 자유게시판 번호로 해당 게시글 조회 
	 * @param freeNm
	 * @return 해당 게시글 정보
	 */
	public FreeBoardVO getFreeBoard(String freeNm);
	
}
