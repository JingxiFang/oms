package sym.common.service;

import sym.common.bean.AdminUserBean;

/**
 * 用户登陆操作service类
 * 
 * @author gxk
 *
 */
public interface LoginService {
	/**
	 * 判断用户CD、密码是否正确
	 * 
	 * @param user_cd
	 * @param user_pswd
	 * @return
	 */
	public boolean findUser(String user_cd, String user_pswd);

	/**
	 * 根据用户CD获取用户信息
	 * 
	 * @param user_cd
	 * @return
	 */
	public AdminUserBean findUserDefault(String user_cd);

	/**
	 * 通过用户cd获取密码
	 */
	public boolean isUserPassword(String user_cd, String password);
}
