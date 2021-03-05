package sym.common.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import sym.common.dao.UserDao;
import sym.common.dto.SessionDto;
import sym.common.util.ConnectionPool;

/**
 * 用户操作相关的dao的实现类
 * 
 * @author gxk
 * @version 2018-04-26
 */
public class UserDaoImpl implements UserDao {

	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;

	/**
	 * 根据用户名和密码，判断用户登陆
	 * 
	 * @param user_cd
	 * @param user_pswd
	 * @return result 两种情况 0：用户名或密码不正确 1：正确登陆
	 */
	public int findUser(String user_cd, String user_pswd) {
		int result = 0; // 初始化为0，设定初始情况为用户名或密码不正确
		// 1.创建连接
		conn = ConnectionPool.getConn();

		// 2.创建sql
		String sql = "SELECT count(U.USER_CD) FROM M_USER U WHERE U.IS_VALID = 'T' AND U.USER_CD = ? AND U.USER_PSWD = ?";

		try {
			// 3.给占位符赋值
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, user_cd);
			pstmt.setString(2, user_pswd);
			
			// 4.发送执行sql语句
			rs = pstmt.executeQuery();

			// 5.判断结果
			while (rs.next()) { // 从结果集中取出记录数
				int num = rs.getInt(1);

				// 如果记录数大于0，表示正确登陆，将result置为1
				if (num > 0) {
					result = 1;
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

	/**
	 * 根据用户cd，获取用户基本信息
	 * 
	 * @param user_cd
	 * @return dto
	 */
	public SessionDto findUserDefault(String user_cd) {
		SessionDto dto = new SessionDto();
		// 1.获取连接
		conn = ConnectionPool.getConn();
		// 2.创建sql
		String sql = "SELECT  USER_CD,USER_NM, USER_OWNER_FLG FROM M_USER WHERE USER_CD = ?";

		try {
			// 3.给占位符赋值
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, user_cd);
			// 4.发送执行sql
			rs = pstmt.executeQuery();

			// 5.从结果集取数据,设置dto对象的属性
			while (rs.next()) {
				dto.setUser_cd(rs.getString("USER_CD"));
				dto.setUser_nm(rs.getString("USER_NM"));
				dto.setUser_owner_flg(rs.getString("USER_OWNER_FLG"));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			// 释放连接
			ConnectionPool.close(pstmt, rs, conn);
		}
		return dto;
	}
	
	public String findUserPswd(String user_cd) {
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
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			// 释放连接
			ConnectionPool.close(pstmt, rs, conn);
		}
		return user_pswd;
	}

}
