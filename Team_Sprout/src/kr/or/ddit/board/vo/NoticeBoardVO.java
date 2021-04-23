package kr.or.ddit.board.vo;

import java.util.List;

import kr.or.ddit.boardComment.vo.NoticeCmVO;
import kr.or.ddit.comm.vo.AtchFileVO;

public class NoticeBoardVO {

	private String noticeNm;
	private int boardNm;
	private String noticeTitle;
	private String noticeContent;
	private String noticeDate;
	private String userId; 
	private long atchFileId = -1;
	
	private List<AtchFileVO> atchFileVOList;
	private List<NoticeCmVO> noticeCmVOList;
	
	
	public String getNoticeNm() {
		return noticeNm;
	}
	public void setNoticeNm(String noticeNm) {
		this.noticeNm = noticeNm;
	}
	public int getBoardNm() {
		return boardNm;
	}
	public void setBoardNm(int boardNm) {
		this.boardNm = boardNm;
	}
	public String getNoticeTitle() {
		return noticeTitle;
	}
	public void setNoticeTitle(String noticeTitle) {
		this.noticeTitle = noticeTitle;
	}
	public String getNoticeContent() {
		return noticeContent;
	}
	public void setNoticeContent(String noticeContent) {
		this.noticeContent = noticeContent;
	}
	public String getNoticeDate() {
		return noticeDate;
	}
	public void setNoticeDate(String noticeDate) {
		this.noticeDate = noticeDate;
	}
	
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public long getAtchFileId() {
		return atchFileId;
	}
	public void setAtchFileId(long atchFileId) {
		this.atchFileId = atchFileId;
	}
	public List<AtchFileVO> getAtchFileVOList() {
		return atchFileVOList;
	}
	public void setAtchFileVOList(List<AtchFileVO> atchFileVOList) {
		this.atchFileVOList = atchFileVOList;
	}
	public List<NoticeCmVO> getNoticeCmVOList() {
		return noticeCmVOList;
	}
	public void setNoticeCmVOList(List<NoticeCmVO> noticeCmVOList) {
		this.noticeCmVOList = noticeCmVOList;
	}
	
}
