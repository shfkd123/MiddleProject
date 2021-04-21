package kr.or.ddit.project.vo;

public class ProjectVO {
	private String pjNm;
	private String userNd;
	private String pjType;
	private String pjName;
	private String pjContent;
	private long atchFileId = - 1;
	private String pjPriceAmount;
	private String pjCondition;
	private String pjDday;
	private String pjOpenday;
	private String pjReward;
	
	public String getPjNm() {
		return pjNm;
	}
	public void setPjNm(String pjNm) {
		this.pjNm = pjNm;
	}
	public String getUserNd() {
		return userNd;
	}
	public void setUserNd(String userNd) {
		this.userNd = userNd;
	}
	public String getPjType() {
		return pjType;
	}
	public void setPjType(String pjType) {
		this.pjType = pjType;
	}
	public String getPjName() {
		return pjName;
	}
	public void setPjName(String pjName) {
		this.pjName = pjName;
	}
	public String getPjContent() {
		return pjContent;
	}
	public void setPjContent(String pjContent) {
		this.pjContent = pjContent;
	}
	public long getAtchFileId() {
		return atchFileId;
	}
	public void setAtchFileId(long atchFileId) {
		this.atchFileId = atchFileId;
	}
	public String getPjPriceAmount() {
		return pjPriceAmount;
	}
	public void setPjPriceAmount(String pjPriceAmount) {
		this.pjPriceAmount = pjPriceAmount;
	}
	public String getPjCondition() {
		return pjCondition;
	}
	public void setPjCondition(String pjCondition) {
		this.pjCondition = pjCondition;
	}
	public String getPjDday() {
		return pjDday;
	}
	public void setPjDday(String pjDday) {
		this.pjDday = pjDday;
	}
	public String getPjOpenday() {
		return pjOpenday;
	}
	public void setPjOpenday(String pjOpenday) {
		this.pjOpenday = pjOpenday;
	}
	public String getPjReward() {
		return pjReward;
	}
	public void setPjReward(String pjReward) {
		this.pjReward = pjReward;
	}
}
