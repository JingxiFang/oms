package sym.common.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import sym.common.bean.AdminUserPasswordBean;
import sym.common.dao.ResetPasswordDao;
import sym.common.util.ConnectionPool;

public class ResetPasswordDaoImpl implements ResetPasswordDao {
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	public int findPassword(AdminUserPasswordBean adminUserPasswordBean) {
		String user_cd=adminUserPasswordBean.getUser_cd();
		String old_pswd=adminUserPasswordBean.getUser_pswd();
		System.out.println(old_pswd);
		int result = 0;
		String user_pswd=new String();
		// 1.获取连接
		conn = ConnectionPool.getConn();
		// 2.创建sql
		String sql = "SELECT  USER_PSWD FROM M_USER WHERE USER_CD = ?";

		try {
			// 3.给占位符赋值
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, user_cd);
			// 4.发送执行sql
			rs = pstmt.executeQuery();

			// 5.从结果集取数据,设置dto对象的属性
			while (rs.next()) {
				user_pswd=rs.getString("USER_PSWD");
				//System.out.println(user_cd);
				if(old_pswd.equals(user_pswd)){
					result=1;
				}
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			// 释放连接
			ConnectionPool.close(pstmt, rs, conn);
		}
		return result;
	}

	public int updatePassword(AdminUserPasswordBean adminUserPasswordBean) {
		int result = 0; // 初始化为0，设定初始情况为用户名或密码不正确
		String user_cd=adminUserPasswordBean.getUser_cd();
		String new_pswd=adminUserPasswordBean.getNew_pswd();
		// 1.创建连接
		conn = ConnectionPool.getConn();

		// 2.创建sql
		String sql = "UPDATE M_USER SET USER_PSWD = ? WHERE USER_CD = ? ";

		try {
			// 3.给占位符赋值
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, new_pswd);
			pstmt.setString(2, user_cd);
			
			pstmt.executeUpdate();
			
			result=1;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			// 释放连接
			ConnectionPool.close(pstmt, rs, conn);
		}

		return result;
	}

}
