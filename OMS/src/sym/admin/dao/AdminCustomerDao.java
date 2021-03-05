package sym.admin.dao;

import java.util.HashMap;
import java.util.List;

import sym.admin.bean.AdminCustomerBean;
import sym.admin.bean.SimpleAdminAgencyBean;
import sym.admin.bean.SimpleAdminCustomerBean;
import sym.common.bean.PageInforBean;

public interface AdminCustomerDao {

	/**
	 * 客户一览查询
	 * @param fromCount
	 * @param endCount
	 * @param queryInforMap
	 * @return
	 */
	public List getComponentPageList(int fromCount, int endCount,
			   HashMap queryInforMap);
	
	/**
	 * 客户一览总件数查询
	 * @return
	 */
	public int getTotalRecordNumber(HashMap<String,String> queryInforMap);
	
	/**
	 * 新增客户信息
	 * @param adminCustomerBean
	 * @return
	 */
	public int	insertCustomer	(AdminCustomerBean adminCustomerBean);	
	
	/**
	 * 更新客户信息
	 * @param adminCustomerBean
	 * @return
	 */
	public int	updateCustomer	(AdminCustomerBean adminCustomerBean);			
	
	/**
	 * 客户是否有未回款完毕的订单
	 * @param customer_cd
	 * @return
	 */
	public int	customerDeleteCheck	(String customer_cd);
	
	/**
	 * 客户CD重复验证
	 * @param customer_cd
	 * @return
	 */
	public int	customerExistCheck	(String customer_cd);						
	/**
	 * 得到客户分页
	 * 
	 * @param fromCount
	 * @param endCount
	 * @param search
	 * @return
	 */
	public PageInforBean<SimpleAdminCustomerBean> getCustomers(int fromCount, int endCount, String customerType, String search);
}
