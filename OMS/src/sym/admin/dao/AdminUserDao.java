package sym.admin.dao;

import java.util.HashMap;
import java.util.List;

import sym.common.bean.AdminUserBean;
import sym.common.bean.PageInforBean;
import sym.common.bean.SimpleAdminUserBean;

public interface AdminUserDao {
	/**
	 * 用户一览查询
	 * @param fromCount
	 * @param endCount
	 * @param queryInforMap
	 * @return
	 */
	public List getComponentPageList(int fromCount, int endCount,
			   HashMap queryInforMap);
	
	/**
	 * 用户一览总件数查询
	 * @return
	 */
	public int getTotalRecordNumber(HashMap<String,String> queryInforMap);
	
	/**
	 * 新增用户信息
	 * @param adminUserBean
	 * @return
	 */
	public int insertUser(AdminUserBean adminUserBean);
	/**
	 * 更新用户信息
	 * @param adminUserBean
	 * @return
	 */
	public int updateUser(AdminUserBean adminUserBean);
	/**
	 * 用户是否有担当的业务
	 * @param user_cd
	 * @return
	 */
	public int userDeleteCheck(String user_cd);
	/**
	 * 用户CD重复验证
	 * @param user_cd
	 * @return
	 */
	public int userExistCheck(String user_cd);
	/**
	 * 
	 * @param fromCount
	 * @param endCount
	 * @param search
	 * @return
	 */
	public PageInforBean<SimpleAdminUserBean> getAgencyUsers(int fromCount, int endCount, String search);
}
