package sym.common.bean;

/**
 * �û�bean
 * @author guojl
 * @version 2014-08-11
 *
 */
public class SimpleAdminUserBean {
	
	 /** �û�cd */
    private String user_cd;
    /** �û��� */
	private String user_nm;
    /** �绰 */
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
