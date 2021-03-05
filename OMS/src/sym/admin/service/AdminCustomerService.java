package sym.admin.service;

import java.util.HashMap;
import java.util.List;

import sym.admin.bean.AdminCustomerBean;
import sym.admin.bean.SimpleAdminAgencyBean;
import sym.admin.bean.SimpleAdminCustomerBean;
import sym.common.bean.PageInforBean;

public interface AdminCustomerService {
	/**
	 * 根据检索条件，获取满足条件的记录总数
	 * @param queryInforMap
	 * @return
	 */
	public int getTotalRecordNumber(HashMap queryInforMap);
	
	
	/**
	 * 根据起始记录数、结束记录数以及检索条件，获取当前页的数据列表
	 * @param fromCount
	 * @param endCount
	 * @param queryInforMap
	 * @return
	 */
	public List getComponentPageList(int fromCount, int endCount,
			HashMap queryInforMap);
	
	/**
	 * 新增客户信息
	 * @param adminCustomerBean
	 * @return
	 */
	public	int	insertCustomer	(AdminCustomerBean adminCustomerBean);	
	
	/**
	 * 编辑客户信息	
	 * @param adminCustomerBean
	 * @return
	 */
	public	int	updateCustomer	(AdminCustomerBean adminCustomerBean);		
	
	/**
	 * 得到
	 * @param usercd
	 * @param search
	 * @param currentPage
	 * @return
	 */
	public PageInforBean<SimpleAdminCustomerBean> getCustomers(String customerType, String search, int currentPage);
	
	/**
	 * 检查是数据库中否存在
	 * @param customer_cd
	 * @return
	 */
	public int customerExistCheck(String customer_cd);

}
