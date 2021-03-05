package sym.admin.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import sym.admin.bean.AdminCurrencyBean;

public interface AdminCurrencyDao {
	/**
	 * ������ʼ��¼����������¼���Լ�������������ȡ��ǰҳ�Ļ�����Ϣ�б�
	 * @param fromCount ��ʼ��¼��
	 * @param endCount ��ֹ��¼��
	 * @param queryInforMap ��������
	 * @return List ��ǰҳ�������б�
	 */
	public List getComponentPageList(int fromCount, int endCount,
			HashMap queryInforMap);
	/**
	 * ���ݼ�����������ȡ���������ļ�¼����
	 * @param queryInforMap
	 * @return �ܼ�¼��
	 */
	public int getTotalRecordNumber(HashMap<String,String> queryInforMap);
	
	/**
	 * ����������Ϣ
	 * @param adminCurrencyBean
	 * @return
	 */
	public int insertCurrency(AdminCurrencyBean adminCurrencyBean);
	
	/**
	 * ���»�����Ϣ
	 * @param adminCurrencyBean
	 * @return
	 */
	public int updateCurrency(AdminCurrencyBean adminCurrencyBean);
	
	/**
	 * �����Ƿ�ʹ��
	 * @param currency_cd
	 * @return
	 */
	public int currencyDeleteCheck(String currency_cd);
	
	/**
	 * ����cd�ظ���֤
	 * @param currency_cd
	 * @return
	 */
	public int currencyExistCheck(String currency_cd);
	
	/**
	 * �õ����п��û��ҵ��б�
	 * @return
	 */
	public Map<String,String> getAllCurrencyValid();
}
