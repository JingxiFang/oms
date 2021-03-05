package sym.common.service.impl;

import sym.common.bean.AdminUserPasswordBean;
import sym.common.dao.ResetPasswordDao;
import sym.common.dao.impl.ResetPasswordDaoImpl;
import sym.common.service.ResetPasswordService;

public class ResetPasswordServiceImpl implements ResetPasswordService{

	
	public void updatePassword(AdminUserPasswordBean adminUserPasswordBean) {
		ResetPasswordDao dao=new ResetPasswordDaoImpl();
		int count =dao.findPassword(adminUserPasswordBean);
		if (count > 0) {
		  dao.updatePassword(adminUserPasswordBean);
		}
	}	
	
}
