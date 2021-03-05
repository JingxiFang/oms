package sym.common.bean;

/**
 * 用户bean
 * @author guojl
 * @version 2014-08-11
 *
 */
public class AdminUserBean {
	
	 /** 用户cd */
    private String user_cd;
    /** 用户名 */
	private String user_nm;
    /** 密码 */
    private String user_pswd;
    /** 电话 */
    private String user_phone;
    /** 权限 */
    private String user_owner_flg;
    /** 是否有效 */
    private String is_valid;
    /** 更新日 */
    private String update_date;
    /** 更新者 */
    private String update_user_id;

	/**
	 * @return 用户CD
	 */
	public String getUser_cd() {
		return user_cd;
	}
	/**
	 * @param  用户CD
	 */
	public void setUser_cd(String user_cd) {
		this.user_cd = user_cd;
	}
	/**
	 * @return 用户名
	 */
	public String getUser_nm() {
		return user_nm;
	}
	/**
	 * @param 用户名 要设置的 user_nm user_nm
	 */
	public void setUser_nm(String user_nm) {
		this.user_nm = user_nm;
	}
	/**
	 * @return 用户密码
	 */
	public String getUser_pswd() {
		return user_pswd;
	}
	/**
	 * @param 用户密码 要设置的 user_pswd user_pswd
	 */
	public void setUser_pswd(String user_pswd) {
		this.user_pswd = user_pswd;
	}
	/**
	 * @return 用户电话
	 */
	public String getUser_phone() {
		return user_phone;
	}
	/**
	 * @param 用户电话 要设置的 user_phone 
	 */
	public void setUser_phone(String user_phone) {
		this.user_phone = user_phone;
	}
	/**
	 * @return 用户所属部门
	 */
	public String getUser_owner_flg() {
		return user_owner_flg;
	}
	/**
	 * @param 用户所属部门 要设置的  user_owner_flg
	 */
	public void setUser_owner_flg(String user_owner_flg) {
		this.user_owner_flg = user_owner_flg;
	}
	/**
	 * @return 是否有效
	 */
	public String getIs_valid() {
		return is_valid;
	}
	/**
	 * @param 是否有效 要设置的 is_valid
	 */
	public void setIs_valid(String is_valid) {
		this.is_valid = is_valid;
	}
	/**
	 * @return 更新时间
	 */
	public String getUpdate_date() {
		return update_date;
	}
	/**
	 * @param 更新时间 要设置的update_date
	 */
	public void setUpdate_date(String update_date) {
		this.update_date = update_date;
	}
	/**
	 * @return 更新者id
	 */
	public String getUpdate_user_id() {
		return update_user_id;
	}
	/**
	 * @param 更新者id 要设置的 update_user_id
	 */
	public void setUpdate_user_id(String update_user_id) {
		this.update_user_id = update_user_id;
	}


}
