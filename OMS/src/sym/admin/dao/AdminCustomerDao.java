package sym.admin.dao;

import java.util.HashMap;
import java.util.List;

import sym.admin.bean.AdminCustomerBean;
import sym.admin.bean.SimpleAdminAgencyBean;
import sym.admin.bean.SimpleAdminCustomerBean;
import sym.common.bean.PageInforBean;

public interface AdminCustomerDao {

	/**
	 * �ͻ�һ����ѯ
	 * @param fromCount
	 * @param endCount
	 * @param queryInforMap
	 * @return
	 */
	public List getComponentPageList(int fromCount, int endCount,
			   HashMap queryInforMap);
	
	/**
	 * �ͻ�һ���ܼ�����ѯ
	 * @return
	 */
	public int getTotalRecordNumber(HashMap<String,String> queryInforMap);
	
	/**
	 * �����ͻ���Ϣ
	 * @param adminCustomerBean
	 * @return
	 */
	public int	insertCustomer	(AdminCustomerBean adminCustomerBean);	
	
	/**
	 * ���¿ͻ���Ϣ
	 * @param adminCustomerBean
	 * @return
	 */
	public int	updateCustomer	(AdminCustomerBean adminCustomerBean);			
	
	/**
	 * �ͻ��Ƿ���δ�ؿ���ϵĶ���
	 * @param customer_cd
	 * @return
	 */
	public int	customerDeleteCheck	(String customer_cd);
	
	/**
	 * �ͻ�CD�ظ���֤
	 * @param customer_cd
	 * @return
	 */
	public int	customerExistCheck	(String customer_cd);						
	/**
	 * �õ��ͻ���ҳ
	 * 
	 * @param fromCount
	 * @param endCount
	 * @param search
	 * @return
	 */
	public PageInforBean<SimpleAdminCustomerBean> getCustomers(int fromCount, int endCount, String customerType, String search);
}
