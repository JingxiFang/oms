package sym.admin.service;

import java.util.HashMap;
import java.util.List;

import sym.admin.bean.AdminAgencyBean;
import sym.admin.bean.SimpleAdminAgencyBean;
import sym.common.bean.PageInforBean;

public interface AdminAgencyService {
	//得到list
	public List getComponentPageList(int fromCount, int endCount, HashMap queryInforMap);
	//记录数
	public int getTotalRecordNumber(HashMap queryInforMap);
	//插入agency
	public int insertAgency(AdminAgencyBean adminAgencyBean);
	//更新agency
	public int updateAgency(AdminAgencyBean adminAgencyBean);
	//检查agenc是否存在
	public int agencyExistCheck(String agency_cd);
	//得到page
	public PageInforBean<SimpleAdminAgencyBean> getAgencys(String usercd, String search, int currentPage);
}
