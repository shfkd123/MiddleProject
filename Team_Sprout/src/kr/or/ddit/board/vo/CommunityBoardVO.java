package kr.or.ddit.board.vo;

public class CommunityBoardVO {
	private String cbNm;
	private String pjNm;
	private String userId;
	private String cbTitle;
	private String cbContent;
	private String cbDate;
	private long atchFileId = -1;
	
	public String getCbNm() {
		return cbNm;
	}
	public void setCbNm(String cbNm) {
		this.cbNm = cbNm;
	}
	public String getPjNm() {
		return pjNm;
	}
	public void setPjNm(String pjNm) {
		this.pjNm = pjNm;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getCbTitle() {
		return cbTitle;
	}
	public void setCbTitle(String cbTitle) {
		this.cbTitle = cbTitle;
	}
	public String getCbContent() {
		return cbContent;
	}
	public void setCbContent(String cbContent) {
		this.cbContent = cbContent;
	}
	public String getCbDate() {
		return cbDate;
	}
	public void setCbDate(String cbDate) {
		this.cbDate = cbDate;
	}
	public long getAtchFileId() {
		return atchFileId;
	}
	public void setAtchFileId(long atchFileId) {
		this.atchFileId = atchFileId;
	}
	
	
}
