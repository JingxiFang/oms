package sym.common.service;

import sym.common.bean.AdminUserPasswordBean;

public interface ResetPasswordService {
	/**
	 * �޸��û���¼����
	 * 
	 * @return
	 */
	public void updatePassword(AdminUserPasswordBean adminUserPasswordBean);
}
