package sym.admin.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import sym.admin.bean.AdminCurrencyBean;

public interface AdminCurrencyDao {
	/**
	 * 根据起始记录数、结束记录数以及检索条件，获取当前页的货币信息列表
	 * @param fromCount 起始记录数
	 * @param endCount 截止记录数
	 * @param queryInforMap 检索条件
	 * @return List 当前页的数据列表
	 */
	public List getComponentPageList(int fromCount, int endCount,
			HashMap queryInforMap);
	/**
	 * 根据检索条件，获取满足条件的记录总数
	 * @param queryInforMap
	 * @return 总记录数
	 */
	public int getTotalRecordNumber(HashMap<String,String> queryInforMap);
	
	/**
	 * 新增货币信息
	 * @param adminCurrencyBean
	 * @return
	 */
	public int insertCurrency(AdminCurrencyBean adminCurrencyBean);
	
	/**
	 * 更新货币信息
	 * @param adminCurrencyBean
	 * @return
	 */
	public int updateCurrency(AdminCurrencyBean adminCurrencyBean);
	
	/**
	 * 货币是否被使用
	 * @param currency_cd
	 * @return
	 */
	public int currencyDeleteCheck(String currency_cd);
	
	/**
	 * 货币cd重复验证
	 * @param currency_cd
	 * @return
	 */
	public int currencyExistCheck(String currency_cd);
	
	/**
	 * 得到所有可用货币的列表
	 * @return
	 */
	public Map<String,String> getAllCurrencyValid();
}
