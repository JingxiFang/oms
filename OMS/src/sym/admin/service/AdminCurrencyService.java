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
	 * 新增货币信息
	 * @param adminCurrencyBean
	 * @return
	 */
	public int insertCurrency(AdminCurrencyBean adminCurrencyBean);
	
	/**
	 * 编辑货币信息
	 * @param adminCurrencyBean
	 * @return
	 */
	public int updateCurrency(AdminCurrencyBean adminCurrencyBean);
	
	/**
	 * 检查插入信息
	 * @param currency_cd
	 * @return
	 */
	public boolean checkInsert(String currency_cd);
	
	/**
	 * 得到所有可用的货币列表
	 * @return
	 */
	public Map<String, String> getAllCurrencyValid();
}
