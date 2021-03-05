package sym.common.dto;
/**
 * 将需要的用户信息封装到SessionDto对象中，保存在session中使用
 * 
 * @author guojl
 * @version 2014-08-11
 */
public class SessionDto  {
	/** 用户CD **/
	private String user_cd;
	
	/** 用户名 **/
	private String user_nm;
	
    /** 用户权限    M：管理；S：业务；F：财务**/
	private String user_owner_flg;

	public void reset() {

	}

	/**
	 * @return CD
	 */
	public String getUser_cd() {
		return user_cd;
	}

	/**
	 * @param CD 
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
	 * @param user_nm
	 */
	public void setUser_nm(String user_nm) {
		this.user_nm = user_nm;
	}

	/**
	 * @return user_owner_flg 用户权限
	 */
	public String getUser_owner_flg() {
		return user_owner_flg;
	}

	/**
	 * @param user_owner_flg  
	 */
	public void setUser_owner_flg(String user_owner_flg) {
		this.user_owner_flg = user_owner_flg;
	}



}
