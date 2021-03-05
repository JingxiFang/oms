package sym.admin.bean;

public class AdminAgencyBean {
	private String agency_cd; //代理商CD
	private String agency_nm; //代理商名
	private String agency_user_cd; //业务员CD
	private String agency_user_nm; //业务员
	private String is_valid; //是否有效
	private String update_date; //更新时间
	private String update_user_id; //更新者
	public String getAgency_cd() {
		return agency_cd;
	}
	public void setAgency_cd(String agency_cd) {
		this.agency_cd = agency_cd;
	}
	public String getAgency_nm() {
		return agency_nm;
	}
	public void setAgency_nm(String agency_nm) {
		this.agency_nm = agency_nm;
	}
	public String getAgency_user_cd() {
		return agency_user_cd;
	}
	public void setAgency_user_cd(String agency_user_cd) {
		this.agency_user_cd = agency_user_cd;
	}
	public String getAgency_user_nm() {
		return agency_user_nm;
	}
	public void setAgency_user_nm(String agency_user_nm) {
		this.agency_user_nm = agency_user_nm;
	}
	public String getIs_valid() {
		return is_valid;
	}
	public void setIs_valid(String is_valid) {
		this.is_valid = is_valid;
	}
	public String getUpdate_date() {
		return update_date;
	}
	public void setUpdate_date(String update_date) {
		this.update_date = update_date;
	}
	public String getUpdate_user_id() {
		return update_user_id;
	}
	public void setUpdate_agency_id(String update_agency_id) {
		this.update_user_id = update_agency_id;
	}
	
	
}
