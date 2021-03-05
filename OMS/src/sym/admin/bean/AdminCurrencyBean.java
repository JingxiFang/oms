package sym.admin.bean;

public class AdminCurrencyBean {
	private String currency_cd;//货币CD
	private String currency_nm;//货币名
	private String is_valid;//是否有效	
	private String update_date;//更新时间
	private String update_user_id;//更新者
	
	public String getCurrency_cd() {
		return currency_cd;
	}
	public void setCurrency_cd(String currency_cd) {
		this.currency_cd = currency_cd;
	}
	public String getCurrency_nm() {
		return currency_nm;
	}
	public void setCurrency_nm(String currency_nm) {
		this.currency_nm = currency_nm;
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
	public void setUpdate_user_id(String update_user_id) {
		this.update_user_id = update_user_id;
	}
	
}
