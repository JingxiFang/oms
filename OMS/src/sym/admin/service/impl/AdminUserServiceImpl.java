package sym.admin.service.impl;

import java.util.HashMap;
import java.util.List;

import sym.admin.dao.AdminUserDao;
import sym.admin.dao.impl.AdminUserDaoImpl;
import sym.admin.service.AdminCurrencyService;
import sym.admin.service.AdminUserService;
import sym.common.bean.AdminUserBean;
import sym.common.bean.PageInforBean;
import sym.common.bean.SimpleAdminUserBean;
import sym.common.service.PageInforService;

public class AdminUserServiceImpl extends PageInforService implements  AdminUserService{

	public int getTotalRecordNumber(HashMap queryInforMap) {
		//取得用户一览总件数
		AdminUserDao adminUserDao = new AdminUserDaoImpl(); 
		return adminUserDao.getTotalRecordNumber(queryInforMap);
	}

	public List getComponentPageList(int fromCount, int endCount,
			HashMap queryInforMap) {
		AdminUserDao adminUserDao = new AdminUserDaoImpl(); 
		return adminUserDao.getComponentPageList(fromCount, endCount, queryInforMap);
	}


	public int insertUser(AdminUserBean adminUserBean) {
		AdminUserDao adminUserDao=new AdminUserDaoImpl();
		String user_cd=adminUserBean.getUser_cd();
		int rt=adminUserDao.userExistCheck(user_cd);
		if(rt >= 1){
			return rt;
		}else{
			adminUserDao.insertUser(adminUserBean);
			return 0;
		}
	}

	public int updateUser(AdminUserBean adminUserBean) {
		AdminUserDao adminUserDao=new AdminUserDaoImpl();
		String user_cd=adminUserBean.getUser_cd();
		int rt=adminUserDao.userDeleteCheck(user_cd);
		if(rt >= 1){
			return rt;
		}else{
			adminUserDao.updateUser(adminUserBean);
			return 0;
		}
	}

	public int userExistCheck(String user_cd){
		AdminUserDao adminUserDao=new AdminUserDaoImpl();
		int rt=adminUserDao.userExistCheck(user_cd);
		return rt;
	}

	@Override
	public PageInforBean<SimpleAdminUserBean> getAgencyUsers(String search, int currentPage) {
		AdminUserDao adminUserDao = new AdminUserDaoImpl(); 
		int fromCount = (currentPage-1) * 10 + 1;
		int endCount = currentPage * 10;
		PageInforBean<SimpleAdminUserBean> pageInforBean = adminUserDao.getAgencyUsers(fromCount, endCount, search);
		pageInforBean.setCurrentPage(currentPage);
		return pageInforBean;
	}
}
