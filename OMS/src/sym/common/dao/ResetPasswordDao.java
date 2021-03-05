package sym.common.dao;

import sym.common.bean.AdminUserPasswordBean;

public interface ResetPasswordDao {
	
	public int findPassword(AdminUserPasswordBean adminUserPasswordBean);
	
	public int updatePassword(AdminUserPasswordBean adminUserPasswordBean);
}
