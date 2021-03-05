package sym.common.bean;

/**
 * 用户bean
 * @author guojl
 * @version 2014-08-11
 *
 */
public class SimpleAdminUserBean {
	
	 /** 用户cd */
    private String user_cd;
    /** 用户名 */
	private String user_nm;
    /** 电话 */
    private String user_phone;
    
	public String getUser_cd() {
		return user_cd;
	}
	public void setUser_cd(String user_cd) {
		this.user_cd = user_cd;
	}
	public String getUser_nm() {
		return user_nm;
	}
	public void setUser_nm(String user_nm) {
		this.user_nm = user_nm;
	}
	public String getUser_phone() {
		return user_phone;
	}
	public void setUser_phone(String user_phone) {
		this.user_phone = user_phone;
	}
    
}
