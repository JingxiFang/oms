package sym.common.service.impl;

import sym.common.bean.AdminUserBean;
import sym.common.dao.impl.UserDaoImpl;
import sym.common.dto.SessionDto;
import sym.common.service.LoginService;

/**
 * 处理用户登录的service类
 * @author guojl
 * @version 2014-08-11
 */
public class LoginServiceImpl implements LoginService{
   
	/**
	 * 验证用户cd、用户密码正确性
	 * @param user_cd
	 * @param user_pswd
	 * @return bool true：表示正确登陆 false:表示用户名或密码错误
	 */
	public boolean findUser(String user_cd,String user_pswd)
	{
		boolean bool=false; //默认为false
		int result=new UserDaoImpl().findUser(user_cd, user_pswd);
		//调用UserDao中的findUser方法，如果返回结果result为1，表示正确登陆，将bool设置为true
		if(result==1)
		{
			bool=true;
		}
		
		return bool;
	}
	
	/**
	 * 根据用户CD获取用户基本信息
	 * @param user_cd
	 * @return adminUserBean对象
	 */
	public AdminUserBean findUserDefault(String user_cd)
	{
		 
		AdminUserBean adminUserBean=new AdminUserBean();
		//调用UserDao类中的方法，获取SessionDto对象dto
		SessionDto dto=new UserDaoImpl().findUserDefault(user_cd);
		//将dto的属性值赋给adminUserBean
		adminUserBean.setUser_cd(dto.getUser_cd());
		adminUserBean.setUser_nm(dto.getUser_nm());
		adminUserBean.setUser_owner_flg(dto.getUser_owner_flg());
		
		//返回adminUserBean对象
		return adminUserBean;
	}

	@Override
	public boolean isUserPassword(String user_cd,String password) {
		boolean b = false;
		String user_pswd =new UserDaoImpl().findUserPswd(user_cd);
		if(user_pswd.equals(password))
			b = true;
		return b;
	}
}
