package sym.admin.service.impl;

import java.util.HashMap;
import java.util.List;

import sym.admin.bean.AdminCustomerBean;
import sym.admin.bean.SimpleAdminAgencyBean;
import sym.admin.bean.SimpleAdminCustomerBean;
import sym.admin.dao.AdminAgencyDao;
import sym.admin.dao.AdminCustomerDao;
import sym.admin.dao.impl.AdminAgencyDaoImpl;
import sym.admin.dao.impl.AdminCustomerDaoImpl;
import sym.admin.service.AdminCustomerService;
import sym.admin.service.AdminUserService;
import sym.common.bean.PageInforBean;
import sym.common.service.PageInforService;

public class AdminCustomerServiceImpl extends PageInforService implements  AdminCustomerService{

	AdminCustomerDao adminCustomerDao=new AdminCustomerDaoImpl();
	public int getTotalRecordNumber(HashMap queryInforMap) {
		return adminCustomerDao.getTotalRecordNumber(queryInforMap);
	}


	public List getComponentPageList(int fromCount, int endCount,
			HashMap queryInforMap) {
		return adminCustomerDao.getComponentPageList(fromCount, endCount, queryInforMap);
	}


	public int insertCustomer(AdminCustomerBean adminCustomerBean) {
		String  customer_cd=adminCustomerBean.getCustomer_cd();
		int rt=adminCustomerDao.customerExistCheck(customer_cd);
		if(rt >= 1){
			return rt;
		}else{
			adminCustomerDao.insertCustomer(adminCustomerBean);
			return 0;
		}
	}


	public int updateCustomer(AdminCustomerBean adminCustomerBean) {
		String  customer_cd=adminCustomerBean.getCustomer_cd();
		int rt=adminCustomerDao.customerDeleteCheck(customer_cd);
		if(rt >= 1){
			return rt;
		}else{
			adminCustomerDao.updateCustomer(adminCustomerBean);
			return 0;
		}
	}


	@Override
	public PageInforBean<SimpleAdminCustomerBean> getCustomers(String customerType, String search, int currentPage) {
		int fromCount = (currentPage - 1) * 10 + 1;
		int endCount = currentPage * 10;
		PageInforBean<SimpleAdminCustomerBean> pageInforBean = adminCustomerDao.getCustomers(fromCount, endCount, customerType, search);
		pageInforBean.setCurrentPage(currentPage);
		return pageInforBean;
	}


	@Override
	public int customerExistCheck(String customer_cd) {
		AdminCustomerDao adminCustomerDao=new AdminCustomerDaoImpl();
		int rt=adminCustomerDao.customerExistCheck(customer_cd);
		return rt;
	}

}
