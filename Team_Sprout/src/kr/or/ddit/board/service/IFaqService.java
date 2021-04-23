package kr.or.ddit.board.service;

import java.util.List;

import kr.or.ddit.board.vo.FaqBoardVO;



public interface IFaqService {

	/**
	 * 게시글 전체 조회
	 * @return List
	 */
	public List<FaqBoardVO> getAllFaqBoard();
	
	/**
	 * 게시글 조회
	 * @param faqNm
	 * @return 
	 */
	public FaqBoardVO getFaqBoard(String faqNm);
	
	
	/**
	 * 게시글 등록
	 * @param fbv
	 * @return 
	 */
	public int insertFaqBoard(FaqBoardVO fbv);
	

	/**
	 * 게시글 수정
	 * @param fbv
	 * @return
	 */
	public int updateFaqBoard(FaqBoardVO fbv);

	/**
	 * 게시글 삭제
	 * @param fbv
	 * @return
	 */
	public int deleteFaqBoard(FaqBoardVO fbv);
	
	/**
	 * 게시글 검색
	 * @param str
	 * @return
	 */
	public List<FaqBoardVO> searchQnaBoard(String str);
}
