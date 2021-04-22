package kr.or.ddit.boardComment.service;

import java.util.List;

import kr.or.ddit.boardComment.vo.QnaCmVO;

public interface IQnaCmService {
	
	/**
	 * QnA 게시판 댓글 출력 메서드
	 * @return 작업성공 : 1, 작업실패 : 0
	 */
	public List<QnaCmVO> getAllQnaCm();
	
	/**
	 * QnA 게시판 댓글 작성 메서드
	 * @param qcv
	 * @return 작업성공 : 1, 작업실패 : 0
	 */
	public int insertQnaCm(QnaCmVO qcv);
	
	/**
	 * QnA 게시판 댓글 수정 메서드
	 * @param qcv
	 * @return 작업성공 : 1, 작업실패 : 0
	 */
	public int updateQnaCm(QnaCmVO qcv);
	
	/**
	 * QnA 게시판 댓글 삭제 메서드
	 * @param qcNm
	 * @return 작업성공 : 1, 작업실패 : 0
	 */
	public int deleteQnaCm(String qcNm);
	
}
