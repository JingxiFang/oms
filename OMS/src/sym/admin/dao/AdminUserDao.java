package sym.admin.dao;

import java.util.HashMap;
import java.util.List;

import sym.common.bean.AdminUserBean;
import sym.common.bean.PageInforBean;
import sym.common.bean.SimpleAdminUserBean;

public interface AdminUserDao {
	/**
	 * �û�һ����ѯ
	 * @param fromCount
	 * @param endCount
	 * @param queryInforMap
	 * @return
	 */
	public List getComponentPageList(int fromCount, int endCount,
			   HashMap queryInforMap);
	
	/**
	 * �û�һ���ܼ�����ѯ
	 * @return
	 */
	public int getTotalRecordNumber(HashMap<String,String> queryInforMap);
	
	/**
	 * �����û���Ϣ
	 * @param adminUserBean
	 * @return
	 */
	public int insertUser(AdminUserBean adminUserBean);
	/**
	 * �����û���Ϣ
	 * @param adminUserBean
	 * @return
	 */
	public int updateUser(AdminUserBean adminUserBean);
	/**
	 * �û��Ƿ��е�����ҵ��
	 * @param user_cd
	 * @return
	 */
	public int userDeleteCheck(String user_cd);
	/**
	 * �û�CD�ظ���֤
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
