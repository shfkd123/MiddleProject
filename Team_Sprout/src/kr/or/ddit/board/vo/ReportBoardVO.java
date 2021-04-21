package kr.or.ddit.board.vo;

public class ReportBoardVO {

	private String reportNm;
	private String reportTitle;
	private String reportContent;
	private String reportDate;
	private String reportWriter;
	private long atchFileId = -1;
	
	public String getReportNm() {
		return reportNm;
	}
	public void setReportNm(String reportNm) {
		this.reportNm = reportNm;
	}
	public String getReportTitle() {
		return reportTitle;
	}
	public void setReportTitle(String reportTitle) {
		this.reportTitle = reportTitle;
	}
	public String getReportContent() {
		return reportContent;
	}
	public void setReportContent(String reportContent) {
		this.reportContent = reportContent;
	}
	public String getReportDate() {
		return reportDate;
	}
	public void setReportDate(String reportDate) {
		this.reportDate = reportDate;
	}
	public String getReportWriter() {
		return reportWriter;
	}
	public void setReportWriter(String reportWriter) {
		this.reportWriter = reportWriter;
	}
	public long getAtchFileId() {
		return atchFileId;
	}
	public void setAtchFileId(long atchFileId) {
		this.atchFileId = atchFileId;
	}
}
