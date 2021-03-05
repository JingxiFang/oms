package sym.admin.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import sym.admin.bean.AdminCurrencyBean;

public interface AdminCurrencyService {

	public List getComponentPageList(int fromCount, int endCount,
			HashMap queryInforMap);
	
	public int getTotalRecordNumber(HashMap queryInforMap);
	
	/**
	 * ����������Ϣ
	 * @param adminCurrencyBean
	 * @return
	 */
	public int insertCurrency(AdminCurrencyBean adminCurrencyBean);
	
	/**
	 * �༭������Ϣ
	 * @param adminCurrencyBean
	 * @return
	 */
	public int updateCurrency(AdminCurrencyBean adminCurrencyBean);
	
	/**
	 * ��������Ϣ
	 * @param currency_cd
	 * @return
	 */
	public boolean checkInsert(String currency_cd);
	
	/**
	 * �õ����п��õĻ����б�
	 * @return
	 */
	public Map<String, String> getAllCurrencyValid();
}
