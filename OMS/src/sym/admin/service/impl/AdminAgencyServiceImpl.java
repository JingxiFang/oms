package sym.admin.service.impl;

import java.util.HashMap;
import java.util.List;

import sym.admin.bean.AdminAgencyBean;
import sym.admin.bean.AdminCurrencyBean;
import sym.admin.bean.SimpleAdminAgencyBean;
import sym.admin.dao.AdminAgencyDao;
import sym.admin.dao.AdminCurrencyDao;
import sym.admin.dao.AdminUserDao;
import sym.admin.dao.impl.AdminAgencyDaoImpl;
import sym.admin.dao.impl.AdminCurrencyDaoImpl;
import sym.admin.dao.impl.AdminUserDaoImpl;
import sym.admin.service.AdminAgencyService;
import sym.common.bean.PageInforBean;
import sym.common.service.PageInforService;

public class AdminAgencyServiceImpl extends PageInforService implements AdminAgencyService {

	@Override
	public List getComponentPageList(int fromCount, int endCount, HashMap queryInforMap) {
		AdminAgencyDao adminAgencyDao = new AdminAgencyDaoImpl();
		return adminAgencyDao.getComponentPageList(fromCount, endCount, queryInforMap);
	}

	@Override
	public int getTotalRecordNumber(HashMap queryInforMap) {
		AdminAgencyDao adminAgencyDao = new AdminAgencyDaoImpl();
		return adminAgencyDao.getTotalRecordNumber(queryInforMap);
	}
	@Override
	public int insertAgency(AdminAgencyBean adminAgencyBean) {
		AdminAgencyDao adminAgencyDao = new AdminAgencyDaoImpl();

		return adminAgencyDao.insertAgency(adminAgencyBean);
	}
	@Override
	public int updateAgency(AdminAgencyBean adminAgencyBean) {
		int rt = 0;
		AdminAgencyDao adminAgencyDao = new AdminAgencyDaoImpl();
		String agency_cd = adminAgencyBean.getAgency_cd();
		int agencyDeleteCheck = adminAgencyDao.agencyDeleteCheck(agency_cd);
		if (agencyDeleteCheck != 0) {
			rt = 1;
		} else {
			rt = adminAgencyDao.updateAgency(adminAgencyBean);
		}
		return rt;
	}
	@Override
	public int agencyExistCheck(String agency_cd){
		AdminAgencyDao adminAgencyDao = new AdminAgencyDaoImpl();
		int rt=adminAgencyDao.agencyExistCheck(agency_cd);
		return rt;
	}

	@Override
	public PageInforBean<SimpleAdminAgencyBean> getAgencys(String usercd, String search, int currentPage) {
		AdminAgencyDao adminUserDao = new AdminAgencyDaoImpl();
		int fromCount = (currentPage - 1) * 10 + 1;
		int endCount = currentPage * 10;
		PageInforBean<SimpleAdminAgencyBean> pageInforBean = adminUserDao.getAgencys(fromCount, endCount, usercd, search);
		pageInforBean.setCurrentPage(currentPage);
		return pageInforBean;
	}
}
