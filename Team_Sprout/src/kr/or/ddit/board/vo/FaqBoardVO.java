package kr.or.ddit.board.vo;

public class FaqBoardVO {

	private String faqNm;
	private String faqTitle;
	private String faqContent;
	private String faqDate;
	private String faqWriter;
	private long atchFileId = -1;
	
	public String getFaqNm() {
		return faqNm;
	}
	public void setFaqNm(String faqNm) {
		this.faqNm = faqNm;
	}
	public String getFaqTitle() {
		return faqTitle;
	}
	public void setFaqTitle(String faqTitle) {
		this.faqTitle = faqTitle;
	}
	public String getFaqContent() {
		return faqContent;
	}
	public void setFaqContent(String faqContent) {
		this.faqContent = faqContent;
	}
	public String getFaqDate() {
		return faqDate;
	}
	public void setFaqDate(String faqDate) {
		this.faqDate = faqDate;
	}
	public String getFaqWriter() {
		return faqWriter;
	}
	public void setFaqWriter(String faqWriter) {
		this.faqWriter = faqWriter;
	}
	public long getAtchFileId() {
		return atchFileId;
	}
	public void setAtchFileId(long atchFileId) {
		this.atchFileId = atchFileId;
	}
}
