package sym.admin.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import sym.admin.dao.AdminUserDao;
import sym.common.bean.AdminUserBean;
import sym.common.bean.PageInforBean;
import sym.common.bean.SimpleAdminUserBean;
import sym.common.util.ConnectionPool;
import sym.common.util.FieldCheck;

public class AdminUserDaoImpl implements AdminUserDao {

	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;

	public List getComponentPageList(int fromCount, int endCount, HashMap queryInforMap) {
		int i;
		String user_owner = FieldCheck.convertNullToEmpty((String) queryInforMap.get("user_owner"));
		String user_owners[] = user_owner.split(",");
		String sql = " SELECT USER_CD,USER_NM,USER_PHONE,USER_OWNER_FLG,IS_VALID " + "FROM"
				+ "(SELECT USER_CD,USER_NM,USER_PHONE,USER_OWNER_FLG,IS_VALID,"
				+ "		ROW_NUMBER() over (order by USER_CD) rn " + " FROM M_USER  "
				+ " WHERE USER_NM like ? AND USER_PHONE like ? " + "       AND USER_OWNER_FLG IN (";
		StringBuilder stringBuilder = new StringBuilder(sql);

		List<AdminUserBean> currList = new ArrayList<AdminUserBean>();
		conn = ConnectionPool.getConn();

		for (i = 0; i < user_owners.length; i++) {
			stringBuilder.append("?,");
		}
		stringBuilder.deleteCharAt(stringBuilder.length() - 1);

		stringBuilder.append(")" + "		AND IS_VALID LIKE ?"
				+ " GROUP BY USER_CD,USER_NM,USER_PHONE,USER_OWNER_FLG,IS_VALID) as ShowSelect "
				+ "	WHERE ShowSelect.rn>=? AND ShowSelect.rn<?");
		
		try {
			int x;

			pstmt = conn.prepareStatement(stringBuilder.toString());
			pstmt.setString(1, "%" + FieldCheck.convertNullToEmpty((String) queryInforMap.get("user_nm")) + "%");
			pstmt.setString(2, "%" + FieldCheck.convertNullToEmpty((String) queryInforMap.get("user_phone")) + "%");
			for (x = 0; x < user_owners.length; x++) {
				pstmt.setString(x + 3, user_owners[x]);
			}
		
			pstmt.setString(x + 3, "%" + FieldCheck.convertNullToEmpty((String) queryInforMap.get("is_valid")) + "%");
			pstmt.setInt(x + 4, fromCount);
			pstmt.setInt(x + 5, endCount + 1);
			
			rs = pstmt.executeQuery();
		
			while (rs.next()) {
				AdminUserBean user = new AdminUserBean();
				user.setUser_cd(rs.getString("USER_CD"));
				user.setUser_nm(rs.getString("user_nm"));

				user.setUser_phone(rs.getString("user_phone"));
				user.setUser_owner_flg(rs.getString("user_owner_flg"));
				user.setIs_valid(rs.getString("is_valid"));
				currList.add(user);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			ConnectionPool.close(pstmt, rs, conn);
		}

		return currList;
	}

	public int getTotalRecordNumber(HashMap<String, String> queryInforMap) {
		int i = 0;
		int x;
		String user_owner = FieldCheck.convertNullToEmpty((String) queryInforMap.get("user_owner"));
		String user_owners[] = user_owner.split(",");
		int totalNum = 0;
		conn = ConnectionPool.getConn();
		String sql = "SELECT count(*) num  FROM M_USER  WHERE USER_NM like ? and USER_PHONE like ?  and USER_OWNER_FLG IN (";
		StringBuilder builder = new StringBuilder(sql);
		for (i = 0; i < user_owners.length; i++) {
			builder.append("?,");
		}
		builder.deleteCharAt(builder.length() - 1);

		builder.append(") " + " AND is_valid like ? ");

		try {
			pstmt = conn.prepareStatement(builder.toString());
			pstmt.setString(1, "%" + FieldCheck.convertNullToEmpty((String) queryInforMap.get("user_nm")) + "%");
			pstmt.setString(2, "%" + FieldCheck.convertNullToEmpty((String) queryInforMap.get("user_phone")) + "%");

			for (x = 0; x < user_owners.length; x++) {
				pstmt.setString(x + 3, user_owners[x]);
			}

			pstmt.setString(x + 3, "%" + FieldCheck.convertNullToEmpty((String) queryInforMap.get("is_valid")) + "%");

			rs = pstmt.executeQuery();
			while (rs.next()) {
				totalNum = rs.getInt("num");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			ConnectionPool.close(pstmt, rs, conn);
		}
		return totalNum;
	}

	public int insertUser(AdminUserBean adminUserBean) {

		String user_cd = adminUserBean.getUser_cd();
		String user_name = adminUserBean.getUser_nm();
		String user_phone = adminUserBean.getUser_phone();
		String user_flg = adminUserBean.getUser_owner_flg();
		String is_valid = adminUserBean.getIs_valid();
		String update_date = adminUserBean.getUpdate_date();
		String update_user_id = adminUserBean.getUpdate_user_id();

		conn = ConnectionPool.getConn();
		String sql = "insert into M_USER (USER_CD, USER_NM, USER_PSWD, USER_PHONE, USER_OWNER_FLG, IS_VALID, UPDATE_DATE, UPDATE_USER_ID) "
				+ "values (?, ?, '111', ?,? , ?, cast(? as datetime), ?)";

		try {
			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, user_cd);
			pstmt.setString(2, user_name);
			pstmt.setString(3, user_phone);
			pstmt.setString(4, user_flg);
			pstmt.setString(5, is_valid);
			pstmt.setString(6, update_date);
			pstmt.setString(7, update_user_id);
			pstmt.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			ConnectionPool.close(pstmt, rs, conn);
		}
		return 0;
	}

	public int updateUser(AdminUserBean adminUserBean) {
		String user_cd = adminUserBean.getUser_cd();
		String user_name = adminUserBean.getUser_nm();
		String user_phone = adminUserBean.getUser_phone();
		String user_flg = adminUserBean.getUser_owner_flg();
		String is_valid = adminUserBean.getIs_valid();
		String update_date = adminUserBean.getUpdate_date();
		String update_user_id = adminUserBean.getUpdate_user_id();

		conn = ConnectionPool.getConn();
		String sql = "UPDATE M_USER SET USER_NM=?, USER_PHONE =?, USER_OWNER_FLG =?, IS_VALID=?, UPDATE_DATE=?,UPDATE_USER_ID =?  WHERE USER_CD = ?";

		try {
			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, user_name);
			pstmt.setString(2, user_phone);
			pstmt.setString(3, user_flg);
			pstmt.setString(4, is_valid);
			pstmt.setString(5, update_date);
			pstmt.setString(6, update_user_id);
			pstmt.setString(7, user_cd);
			pstmt.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			ConnectionPool.close(pstmt, rs, conn);
		}
		return 0;
	}

	public int userDeleteCheck(String user_cd) {
		int rt_msg = 0;

		conn = ConnectionPool.getConn();
		String sql = "SELECT COUNT(*) num FROM M_AGENCY WHERE AGENCY_USER_CD = ? AND is_valid = 'T'";

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, user_cd);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				rt_msg = rs.getInt("num");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			ConnectionPool.close(pstmt, rs, conn);
		}
		return rt_msg;
	}

	public int userExistCheck(String user_cd) {
		int rt_msg = 0;

		conn = ConnectionPool.getConn();
		String sql = "SELECT count(*) num FROM M_USER WHERE  user_cd=?";

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, user_cd);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				rt_msg = rs.getInt("num");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			ConnectionPool.close(pstmt, rs, conn);
		}
		return rt_msg;
	}

	@Override
	public PageInforBean<SimpleAdminUserBean> getAgencyUsers(int fromCount, int endCount, String search) {
		int i = 0;
		conn = ConnectionPool.getConn();
		PageInforBean<SimpleAdminUserBean> pageInforBean = new PageInforBean<SimpleAdminUserBean>();
		
		List<SimpleAdminUserBean> list_agency = new ArrayList<SimpleAdminUserBean>();
		String sql = "SELECT USER_CD,USER_NM,USER_PHONE FROM M_USER WHERE ";
		if(search!=null && !search.equals("")){
			sql += "USER_NM LIKE '%"+ search +"%' AND is_valid = 'T'";
		}else{
			sql += "is_valid = 'T' AND USER_OWNER_FLG='S' ORDER BY USER_CD";
		}
		System.out.println(sql);
		try {
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				i++;
				if(i>=fromCount && i<=endCount){
					SimpleAdminUserBean adminUserBean = new SimpleAdminUserBean();
					adminUserBean.setUser_cd(rs.getString(1));
					adminUserBean.setUser_nm(rs.getString(2));
					adminUserBean.setUser_phone(rs.getString(3));
					list_agency.add(adminUserBean);
				}
			}
			pageInforBean.setList(list_agency);
			pageInforBean.setFromCount(fromCount);
			pageInforBean.setTotalNumber(i);
			pageInforBean.setTotalPage(i / 10 + 1);
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			ConnectionPool.close(pstmt, rs, conn);
		}
		return pageInforBean;
	}
}
