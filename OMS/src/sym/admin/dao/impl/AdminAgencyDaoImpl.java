package sym.admin.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import sym.admin.bean.AdminAgencyBean;
import sym.admin.bean.SimpleAdminAgencyBean;
import sym.admin.dao.AdminAgencyDao;
import sym.common.bean.PageInforBean;
import sym.common.util.ConnectionPool;
import sym.common.util.FieldCheck;

public class AdminAgencyDaoImpl implements AdminAgencyDao {
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;

	public List getComponentPageList(int fromCount, int endCount, HashMap queryInforMap) {
		List<AdminAgencyBean> agencyBeans = new ArrayList<AdminAgencyBean>();
		conn = ConnectionPool.getConn();
		String sql = "SELECT AGENCY_CD,AGENCY_NM,AGENCY_USER_NM,AGENCY_STAET " + " FROM (SELECT AGENCY_CD,AGENCY_NM,"
				+ " US.USER_NM as AGENCY_USER_NM,MG.IS_VALID AS AGENCY_STAET,"
				+ " ROW_NUMBER() over (order by AGENCY_CD ASC) rn  " + " FROM M_AGENCY MG,M_USER US  "
				+ " WHERE  AGENCY_NM like ? AND US.USER_NM LIKE ? " + " AND MG.IS_VALID like ? "
				+ " AND MG.AGENCY_USER_CD = US.USER_CD "
				+ " GROUP BY AGENCY_CD,AGENCY_NM,US.USER_NM,MG.IS_VALID) as ShowSelect "
				+ " WHERE ShowSelect.rn>=? AND ShowSelect.rn<?";

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, "%" + FieldCheck.convertNullToEmpty((String) queryInforMap.get("agency_nm")) + "%");
			pstmt.setString(2, "%" + FieldCheck.convertNullToEmpty((String) queryInforMap.get("agency_user_nm")) + "%");
			pstmt.setString(3, "%" + FieldCheck.convertNullToEmpty((String) queryInforMap.get("is_valid")) + "%");
			pstmt.setInt(4, fromCount);
			pstmt.setInt(5, endCount + 1);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				AdminAgencyBean agencyBean = new AdminAgencyBean();
				agencyBean.setAgency_cd(rs.getString("AGENCY_CD"));
				System.out.println(rs.getString("AGENCY_CD") + "=============");
				agencyBean.setAgency_nm(rs.getString("AGENCY_NM"));
				agencyBean.setAgency_user_nm(rs.getString("AGENCY_USER_NM"));
				agencyBean.setIs_valid(rs.getString("AGENCY_STAET"));
				agencyBeans.add(agencyBean);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			ConnectionPool.close(pstmt, rs, conn);
		}
		return agencyBeans;
	}

	public int getTotalRecordNumber(HashMap<String, String> queryInforMap) {
		int totalNum = 0;
		conn = ConnectionPool.getConn();
		String sql = "SELECT count(*) num " + " FROM M_AGENCY MG,M_USER US "
				+ " WHERE  AGENCY_NM like ? AND US.USER_NM LIKE ? " + " AND MG.IS_VALID like ?"
				+ " AND MG.AGENCY_USER_CD = US.USER_CD ";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, "%" + FieldCheck.convertNullToEmpty((String) queryInforMap.get("agency_nm")) + "%");
			pstmt.setString(2, "%" + FieldCheck.convertNullToEmpty((String) queryInforMap.get("agency_user_nm")) + "%");
			pstmt.setString(3, "%" + FieldCheck.convertNullToEmpty((String) queryInforMap.get("is_valid")) + "%");
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

	public int insertAgency(AdminAgencyBean adminAgencyBean) {
		int rt_msg = 0;

		String agency_cd = adminAgencyBean.getAgency_cd();
		String agency_name = adminAgencyBean.getAgency_nm();
		String agency_user_name = adminAgencyBean.getAgency_user_nm();
		String is_valid = adminAgencyBean.getIs_valid();
		String update_user_id = adminAgencyBean.getUpdate_user_id();
		String update_date = adminAgencyBean.getUpdate_date();

		String agency_user_cd = selectUser_cd(agency_user_name);
		conn = ConnectionPool.getConn();
		String sql = "insert into M_AGENCY (AGENCY_CD, AGENCY_NM,AGENCY_USER_CD, IS_VALID, UPDATE_DATE, UPDATE_USER_ID)"
				+ "values (?,?,?,?, cast( ? as datetime), ? )";

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, agency_cd);
			pstmt.setString(2, agency_name);
			pstmt.setString(3, agency_user_cd);
			pstmt.setString(4, is_valid);
			pstmt.setString(5, update_date);
			pstmt.setString(6, update_user_id);

			pstmt.executeUpdate();

			rt_msg = 1;

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			ConnectionPool.close(pstmt, rs, conn);
		}

		return rt_msg;
	}

	public String selectUser_cd(String agency_user_name) {

		conn = ConnectionPool.getConn();
		String sql = "SELECT user_cd from M_USER WHERE user_nm=? ";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, agency_user_name);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				agency_user_name = rs.getString("user_cd");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			ConnectionPool.close(pstmt, rs, conn);
		}
		return agency_user_name;
	}

	public int updateAgency(AdminAgencyBean adminAgencyBean) {
		String agency_cd = adminAgencyBean.getAgency_cd();
		String agency_name = adminAgencyBean.getAgency_nm();
		String agency_user_name = adminAgencyBean.getAgency_user_nm();
		String is_valid = adminAgencyBean.getIs_valid();
		String update_user_id = adminAgencyBean.getUpdate_user_id();
		String update_date = adminAgencyBean.getUpdate_date();

		String agency_user_cd = selectUser_cd(agency_user_name);

		conn = ConnectionPool.getConn();
		String sql = "UPDATE M_AGENCY SET AGENCY_NM = ?,AGENCY_USER_cd = ?,IS_VALID =?,UPDATE_DATE=?, UPDATE_USER_ID =? WHERE AGENCY_CD = ?";

		try {
			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, agency_name);
			pstmt.setString(2, agency_user_cd);
			pstmt.setString(3, is_valid);
			pstmt.setString(4, update_date);
			pstmt.setString(5, update_user_id);
			pstmt.setString(6, agency_cd);

			pstmt.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			ConnectionPool.close(pstmt, rs, conn);
		}
		return 0;
	}

	public int agencyDeleteCheck(String agency_cd) {
		int rt_msg = 0;

		conn = ConnectionPool.getConn();
		String sql = "SELECT COUNT(*) num FROM S_ORDERS WHERE agency_CD = ? AND RECEIVED_PAYMENTS_FLG = 'F' ";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, agency_cd);
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

	public int agencyExistCheck(String agency_cd) {
		int rt_msg = 0;

		conn = ConnectionPool.getConn();
		String sql = "SELECT count(*) num FROM m_agency WHERE  agency_cd=?";

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, agency_cd);
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
	public PageInforBean<SimpleAdminAgencyBean> getAgencys(int fromCount, int endCount, String usercd, String search) {
		int i = 0;
		conn = ConnectionPool.getConn();
		PageInforBean<SimpleAdminAgencyBean> pageInforBean = new PageInforBean<SimpleAdminAgencyBean>();

		List<SimpleAdminAgencyBean> list_agency = new ArrayList<SimpleAdminAgencyBean>();
		String sql = "SELECT AGENCY_CD,AGENCY_NM,USER_NM FROM M_AGENCY a, M_USER u WHERE a.AGENCY_USER_CD = u.USER_CD AND USER_CD = '" + usercd +"' AND ";
		if (search != null && !search.equals("")) {
			sql += "AGENCY_NM LIKE '%" + search + "%' AND ";
		}
		sql += "a.IS_VALID = 'T' ORDER BY AGENCY_CD";
		try {
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				i++;
				if (i >= fromCount && i <= endCount) {
					SimpleAdminAgencyBean adminAgencyBean = new SimpleAdminAgencyBean();
					adminAgencyBean.setAgency_cd(rs.getString(1));
					adminAgencyBean.setAgency_nm(rs.getString(2));
					adminAgencyBean.setAgency_user_nm(rs.getString(3));
					list_agency.add(adminAgencyBean);
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
