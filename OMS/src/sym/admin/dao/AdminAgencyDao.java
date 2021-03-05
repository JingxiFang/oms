package sym.admin.dao;

import java.util.HashMap;
import java.util.List;

import sym.admin.bean.AdminAgencyBean;
import sym.admin.bean.AdminCurrencyBean;
import sym.admin.bean.SimpleAdminAgencyBean;
import sym.common.bean.PageInforBean;

public interface AdminAgencyDao {
	/**
	 * ������ʼ��¼����������¼���Լ�������������ȡ��ǰҳ�Ļ�����Ϣ�б�
	 * 
	 * @param fromCount
	 *            ��ʼ��¼��
	 * @param endCount
	 *            ��ֹ��¼��
	 * @param queryInforMap
	 *            ��������
	 * @return List ��ǰҳ�������б�
	 */
	public List getComponentPageList(int fromCount, int endCount, HashMap queryInforMap);

	/**
	 * ���ݼ�����������ȡ���������ļ�¼����
	 * 
	 * @param queryInforMap
	 * @return �ܼ�¼��
	 */
	public int getTotalRecordNumber(HashMap<String, String> queryInforMap);

	/**
	 * ������������Ϣ
	 * 
	 * @param adminCurrencyBean
	 * @return
	 */
	public int insertAgency(AdminAgencyBean adminAgencyBean);

	/**
	 * ���´�������Ϣ
	 * 
	 * @param adminCurrencyBean
	 * @return
	 */
	public int updateAgency(AdminAgencyBean adminAgencyBean);

	/**
	 * �����̱���Ƿ�ʹ��
	 * 
	 * @param currency_cd
	 * @return
	 */
	public int agencyDeleteCheck(String agency_cd);

	/**
	 * ������cd�ظ���֤
	 * 
	 * @param currency_cd
	 * @return
	 */
	public int agencyExistCheck(String agency_cd);

	/**
	 * �õ������̷�ҳ
	 * 
	 * @param fromCount
	 * @param endCount
	 * @param search
	 * @return
	 */
	public PageInforBean<SimpleAdminAgencyBean> getAgencys(int fromCount, int endCount, String usercd, String search);
}
