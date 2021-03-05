package sym.admin.service;

import java.util.HashMap;
import java.util.List;

import sym.common.bean.AdminUserBean;
import sym.common.bean.PageInforBean;
import sym.common.bean.SimpleAdminUserBean;

public interface AdminUserService {
	/**
	 * 根据检索条件，获取满足条件的记录总数
	 * @param queryInforMap
	 * @return
	 */
	public int getTotalRecordNumber(HashMap queryInforMap);
	
	/**
	 *根据起始记录数、结束记录数以及检索条件，获取当前页的数据列表 
	 * @param fromCount
	 * @param endCount
	 * @param queryInforMap
	 * @return
	 */
	public List getComponentPageList(int fromCount, int endCount,
			   HashMap queryInforMap);
	/**
	 * 新增用户信息
	 * @param adminUserBean
	 * @return
	 */
	public int	insertUser	(AdminUserBean adminUserBean);
	
	/**
	 * 更新用户信息
	 * @param adminUserBean
	 * @return
	 */
	public int	updateUser	(AdminUserBean adminUserBean);

	/**
	 * 检查是数据库中否存在
	 * @param user_cd
	 * @return
	 */
	public int userExistCheck(String user_cd);
	
	/**
	 * 根据检索条件和当前页得到用户列表(默认一页10个)
	 * @param search
	 * @param currentPage
	 * @return
	 */
	public PageInforBean<SimpleAdminUserBean> getAgencyUsers(String search,int currentPage);
}
