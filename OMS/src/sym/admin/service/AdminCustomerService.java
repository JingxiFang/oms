package sym.admin.service;

import java.util.HashMap;
import java.util.List;

import sym.admin.bean.AdminCustomerBean;
import sym.admin.bean.SimpleAdminAgencyBean;
import sym.admin.bean.SimpleAdminCustomerBean;
import sym.common.bean.PageInforBean;

public interface AdminCustomerService {
	/**
	 * ���ݼ�����������ȡ���������ļ�¼����
	 * @param queryInforMap
	 * @return
	 */
	public int getTotalRecordNumber(HashMap queryInforMap);
	
	
	/**
	 * ������ʼ��¼����������¼���Լ�������������ȡ��ǰҳ�������б�
	 * @param fromCount
	 * @param endCount
	 * @param queryInforMap
	 * @return
	 */
	public List getComponentPageList(int fromCount, int endCount,
			HashMap queryInforMap);
	
	/**
	 * �����ͻ���Ϣ
	 * @param adminCustomerBean
	 * @return
	 */
	public	int	insertCustomer	(AdminCustomerBean adminCustomerBean);	
	
	/**
	 * �༭�ͻ���Ϣ	
	 * @param adminCustomerBean
	 * @return
	 */
	public	int	updateCustomer	(AdminCustomerBean adminCustomerBean);		
	
	/**
	 * �õ�
	 * @param usercd
	 * @param search
	 * @param currentPage
	 * @return
	 */
	public PageInforBean<SimpleAdminCustomerBean> getCustomers(String customerType, String search, int currentPage);
	
	/**
	 * ��������ݿ��з����
	 * @param customer_cd
	 * @return
	 */
	public int customerExistCheck(String customer_cd);

}
