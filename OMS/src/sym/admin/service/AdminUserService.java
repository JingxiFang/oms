package sym.admin.service;

import java.util.HashMap;
import java.util.List;

import sym.common.bean.AdminUserBean;
import sym.common.bean.PageInforBean;
import sym.common.bean.SimpleAdminUserBean;

public interface AdminUserService {
	/**
	 * ���ݼ�����������ȡ���������ļ�¼����
	 * @param queryInforMap
	 * @return
	 */
	public int getTotalRecordNumber(HashMap queryInforMap);
	
	/**
	 *������ʼ��¼����������¼���Լ�������������ȡ��ǰҳ�������б� 
	 * @param fromCount
	 * @param endCount
	 * @param queryInforMap
	 * @return
	 */
	public List getComponentPageList(int fromCount, int endCount,
			   HashMap queryInforMap);
	/**
	 * �����û���Ϣ
	 * @param adminUserBean
	 * @return
	 */
	public int	insertUser	(AdminUserBean adminUserBean);
	
	/**
	 * �����û���Ϣ
	 * @param adminUserBean
	 * @return
	 */
	public int	updateUser	(AdminUserBean adminUserBean);

	/**
	 * ��������ݿ��з����
	 * @param user_cd
	 * @return
	 */
	public int userExistCheck(String user_cd);
	
	/**
	 * ���ݼ��������͵�ǰҳ�õ��û��б�(Ĭ��һҳ10��)
	 * @param search
	 * @param currentPage
	 * @return
	 */
	public PageInforBean<SimpleAdminUserBean> getAgencyUsers(String search,int currentPage);
}
