package sym.common.dao;

import sym.common.dto.SessionDto;

/**
 * 用户数据库操作访问接口
 * @author gxk
 *
 *
 */
public interface UserDao {
	/**
	 * 验证用户名、密码
	 * @param user_cd
	 * @param user_pswd
	 * @return
	 */
    public int findUser(String user_cd,String user_pswd);
    
    /**
     * 根据用户cd获取用户信息
     * @param user_cd
     * @return
     */
    public SessionDto findUserDefault(String user_cd);
    
}
