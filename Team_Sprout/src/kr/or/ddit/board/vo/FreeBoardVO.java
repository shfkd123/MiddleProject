package kr.or.ddit.board.vo;

public class FreeBoardVO {

	private String freeNm;
	private String freeTitle;
	private String freeContent;
	private String freeDate;
	private String userId;
	private long atchFileId = -1;
	
	public String getFreeNm() {
		return freeNm;
	}
	public void setFreeNm(String freeNm) {
		this.freeNm = freeNm;
	}
	public String getFreeTitle() {
		return freeTitle;
	}
	public void setFreeTitle(String freeTitle) {
		this.freeTitle = freeTitle;
	}
	public String getFreeContent() {
		return freeContent;
	}
	public void setFreeContent(String freeContent) {
		this.freeContent = freeContent;
	}
	public String getFreeDate() {
		return freeDate;
	}
	public void setFreeDate(String freeDate) {
		this.freeDate = freeDate;
	}
	public long getAtchFileId() {
		return atchFileId;
	}
	public void setAtchFileId(long atchFileId) {
		this.atchFileId = atchFileId;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	
	
}
