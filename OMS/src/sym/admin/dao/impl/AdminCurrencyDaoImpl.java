package sym.admin.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import sym.admin.bean.AdminCurrencyBean;
import sym.admin.dao.AdminCurrencyDao;
import sym.common.util.ConnectionPool;
import sym.common.util.FieldCheck;

public class AdminCurrencyDaoImpl implements AdminCurrencyDao {
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;

	public List getComponentPageList(int fromCount, int endCount, HashMap queryInforMap) {
		List<AdminCurrencyBean> currList = new ArrayList<AdminCurrencyBean>();
		conn = ConnectionPool.getConn();
		String sql = "SELECT currency_cd,currency_nm,is_valid "
				+ "FROM (SELECT currency_cd,currency_nm,is_valid,ROW_NUMBER()OVER(ORDER BY currency_cd) as rn "
				+ "FROM m_currency WHERE  currency_nm like ? AND is_valid like ?) as temp "
				+ "WHERE rn between ? AND ?";

		try {

			pstmt = conn.prepareStatement(sql);

			String currency_nm = FieldCheck.convertNullToEmpty((String) queryInforMap.get("currency_nm"));
			String is_valid = FieldCheck.convertNullToEmpty((String) queryInforMap.get("is_valid"));
			pstmt.setString(1, "%" + currency_nm + "%");
			pstmt.setString(2, "%" + is_valid + "%");
			pstmt.setInt(3, fromCount);
			pstmt.setInt(4, endCount);
			// 4.发送执行sql
			rs = pstmt.executeQuery();
			// 5.从结果集中取数据
			while (rs.next()) {
				AdminCurrencyBean currency = new AdminCurrencyBean();
				currency.setCurrency_cd(rs.getString("currency_cd"));
				currency.setCurrency_nm(rs.getString("currency_nm"));
				currency.setIs_valid(rs.getString("is_valid"));
				currList.add(currency);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			ConnectionPool.close(pstmt, rs, conn);
		}

		return currList;
	}

	public int getTotalRecordNumber(HashMap<String, String> queryInforMap) {
		int totalNum = 0;
		conn = ConnectionPool.getConn();
		String sql = "SELECT count(*) num FROM m_currency WHERE  currency_nm like ? AND is_valid like ?";

		try {
			pstmt = conn.prepareStatement(sql);

			String currency_nm = FieldCheck.convertNullToEmpty((String) queryInforMap.get("currency_nm"));
			String is_valid = FieldCheck.convertNullToEmpty((String) queryInforMap.get("is_valid"));
			pstmt.setString(1, "%" + currency_nm + "%");
			pstmt.setString(2, "%" + is_valid + "%");

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

	public int insertCurrency(AdminCurrencyBean adminCurrencyBean) {
		int rt_msg = 0;

		String currency_cd = adminCurrencyBean.getCurrency_cd();
		String currency_name = adminCurrencyBean.getCurrency_nm();
		String is_valid = adminCurrencyBean.getIs_valid();
		String update_user_id = adminCurrencyBean.getUpdate_user_id();
		String update_date = adminCurrencyBean.getUpdate_date();

		conn = ConnectionPool.getConn();
		String sql = "insert into M_CURRENCY (CURRENCY_CD, CURRENCY_NM, IS_VALID, UPDATE_DATE, UPDATE_USER_ID)"
				+ "values (?,?,?, cast( ? as datetime), ? )";

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, currency_cd);
			pstmt.setString(2, currency_name);
			pstmt.setString(3, is_valid);
			pstmt.setString(4, update_date);
			pstmt.setString(5, update_user_id);

			// 4.发送执行sql
			pstmt.executeUpdate();

			rt_msg = 1;

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			ConnectionPool.close(pstmt, rs, conn);
		}

		return rt_msg;
	}

	public int updateCurrency(AdminCurrencyBean adminCurrencyBean) {

		String currency_cd = adminCurrencyBean.getCurrency_cd();
		String currency_name = adminCurrencyBean.getCurrency_nm();
		String is_valid = adminCurrencyBean.getIs_valid();
		String update_user_id = adminCurrencyBean.getUpdate_user_id();
		String update_date = adminCurrencyBean.getUpdate_date();

		conn = ConnectionPool.getConn();
		String sql = "UPDATE M_CURRENCY SET CURRENCY_NM = ?,IS_VALID =?,UPDATE_DATE=?, UPDATE_USER_ID =? WHERE CURRENCY_CD = ?";

		try {
			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, currency_name);
			pstmt.setString(2, is_valid);
			pstmt.setString(3, update_date);
			pstmt.setString(4, update_user_id);
			pstmt.setString(5, currency_cd);

			pstmt.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			ConnectionPool.close(pstmt, rs, conn);
		}
		return 0;
	}

	public int currencyDeleteCheck(String currency_cd) {
		int rt_msg = 0;

		conn = ConnectionPool.getConn();
		String sql = "SELECT COUNT(*) num FROM S_ORDERS WHERE BID_CURRENCY_CD = ?";

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, currency_cd);
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

	public int currencyExistCheck(String currency_cd) {
		int rt_msg = 0;

		conn = ConnectionPool.getConn();
		// 2.创建sql
		// String sql="SELECT count(*) num FROM m_currency WHERE currency_nm
		// like '%'||?||'%' AND is_valid like '%'||?||'%'";
		String sql = "SELECT count(*) num FROM m_currency WHERE  currency_cd=?";

		try {
			// 3.给占位符赋值
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, currency_cd);
			// 4.发送执行sql
			rs = pstmt.executeQuery();
			// 5.从结果集中取数据
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
	public Map<String, String> getAllCurrencyValid() {
		Map<String, String> currency_map = new HashMap<String, String>();

		conn = ConnectionPool.getConn();
		String sql = "SELECT CURRENCY_CD,CURRENCY_NM FROM M_CURRENCY WHERE IS_VALID='T'";

		try {
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				currency_map.put(rs.getString(1), rs.getString(2));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			ConnectionPool.close(pstmt, rs, conn);
		}
		return currency_map;
	}

}
