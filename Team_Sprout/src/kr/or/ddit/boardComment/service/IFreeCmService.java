package kr.or.ddit.boardComment.service;

import java.util.List;

import kr.or.ddit.boardComment.vo.FreeCmVO;

public interface IFreeCmService {
	
	/**
	 * QnA 게시판 댓글 출력 메서드
	 * @return 작업성공 : 1, 작업실패 : 0
	 */
	public List<FreeCmVO> getAllFreeCm(String freeNm);
	
	/**
	 * QnA 게시판 댓글 작성 메서드
	 * @param fcv
	 * @return 작업성공 : 1, 작업실패 : 0
	 */
	public int insertFreeCm(FreeCmVO fcv);
	
	/**
	 * QnA 게시판 댓글 수정 메서드
	 * @param fcv
	 * @return 작업성공 : 1, 작업실패 : 0
	 */
	public int updateFreeCm(FreeCmVO fcv);
	
	/**
	 * QnA 게시판 댓글 삭제 메서드
	 * @param fcNm
	 * @return 작업성공 : 1, 작업실패 : 0
	 */
	public int deleteFreeCm(FreeCmVO fcv);
	
}
