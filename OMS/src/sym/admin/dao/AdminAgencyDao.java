package sym.admin.dao;

import java.util.HashMap;
import java.util.List;

import sym.admin.bean.AdminAgencyBean;
import sym.admin.bean.AdminCurrencyBean;
import sym.admin.bean.SimpleAdminAgencyBean;
import sym.common.bean.PageInforBean;

public interface AdminAgencyDao {
	/**
	 * 根据起始记录数、结束记录数以及检索条件，获取当前页的货币信息列表
	 * 
	 * @param fromCount
	 *            起始记录数
	 * @param endCount
	 *            截止记录数
	 * @param queryInforMap
	 *            检索条件
	 * @return List 当前页的数据列表
	 */
	public List getComponentPageList(int fromCount, int endCount, HashMap queryInforMap);

	/**
	 * 根据检索条件，获取满足条件的记录总数
	 * 
	 * @param queryInforMap
	 * @return 总记录数
	 */
	public int getTotalRecordNumber(HashMap<String, String> queryInforMap);

	/**
	 * 新增代理商信息
	 * 
	 * @param adminCurrencyBean
	 * @return
	 */
	public int insertAgency(AdminAgencyBean adminAgencyBean);

	/**
	 * 更新代理商信息
	 * 
	 * @param adminCurrencyBean
	 * @return
	 */
	public int updateAgency(AdminAgencyBean adminAgencyBean);

	/**
	 * 代理商编号是否被使用
	 * 
	 * @param currency_cd
	 * @return
	 */
	public int agencyDeleteCheck(String agency_cd);

	/**
	 * 代理商cd重复验证
	 * 
	 * @param currency_cd
	 * @return
	 */
	public int agencyExistCheck(String agency_cd);

	/**
	 * 得到代理商分页
	 * 
	 * @param fromCount
	 * @param endCount
	 * @param search
	 * @return
	 */
	public PageInforBean<SimpleAdminAgencyBean> getAgencys(int fromCount, int endCount, String usercd, String search);
}
