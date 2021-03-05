package sym.admin.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import sym.admin.bean.AdminCustomerBean;
import sym.admin.bean.SimpleAdminAgencyBean;
import sym.admin.bean.SimpleAdminCustomerBean;
import sym.admin.dao.AdminCustomerDao;
import sym.common.bean.PageInforBean;
import sym.common.util.ConnectionPool;
import sym.common.util.FieldCheck;

public class AdminCustomerDaoImpl implements AdminCustomerDao {
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	public List getComponentPageList(int fromCount, int endCount,
			HashMap queryInforMap) {
		List<AdminCustomerBean> currList = new ArrayList<AdminCustomerBean>();

		int i;
		String customer_owner =FieldCheck.convertNullToEmpty((String) queryInforMap.get("customer_owner"));
		String customer_owners[] = customer_owner.split(",");
		String sql =" SELECT CUSTOMER_CD,CUSTOMER_NM,ADDRESS,CONNECT_KIND,CUSTOMER_TYPE,IS_VALID "+
				"FROM"+ 
				"(SELECT CUSTOMER_CD,CUSTOMER_NM,ADDRESS,CONNECT_KIND,CUSTOMER_TYPE,IS_VALID,"+
				"ROW_NUMBER() over (order by CUSTOMER_CD) rn "+
				" FROM M_CUSTOMER  "+
				" WHERE  CUSTOMER_NM like ? AND CONNECT_KIND like ? "+ 
				"AND CUSTOMER_TYPE IN (";
		StringBuilder stringBuilder = new StringBuilder(sql);
		
		// 1.获取连接
		conn = ConnectionPool.getConn();
		// 2.创建sql
		
				for(i=0;i<customer_owners.length;i++)
				{
					stringBuilder.append("?,");
				}
				stringBuilder.deleteCharAt(stringBuilder.length()-1);
				 
				stringBuilder.append(")"+
						" AND IS_VALID LIKE ?"+
						" GROUP BY CUSTOMER_CD,CUSTOMER_NM,ADDRESS,CONNECT_KIND,CUSTOMER_TYPE,IS_VALID) as ShowSelect "+
				"	WHERE ShowSelect.rn>=? AND ShowSelect.rn<?");
		/*
		 * hm.put("user_nm", user_nm); hm.put("user_phone", user_phone);
		 * hm.put("user_owner_flg"	, user_owner_flg);
		 * hm.put("is_valid",is_valid);
		 */
		try {
			// 3.给占位符赋值user_nm
			int x;
			pstmt = conn.prepareStatement(stringBuilder.toString());
			pstmt.setString(1,"%"+ FieldCheck.convertNullToEmpty((String) queryInforMap.get("customer_nm")) + "%");
			pstmt.setString(2,"%"+ FieldCheck.convertNullToEmpty((String) queryInforMap.get("connect_kind")) + "%");
			for(x=0;x<customer_owners.length;x++){
				pstmt.setString(x+3,customer_owners[x]);
			}
			
			pstmt.setString(x+3,"%"+ FieldCheck.convertNullToEmpty((String) queryInforMap.get("is_valid")) + "%");
			pstmt.setInt(x+4, fromCount);
			pstmt.setInt(x+5, endCount+1);
			System.out.println(fromCount);
			System.out.println(endCount+1);
			// 4.发送执行sql
			//System.out.println("nishishabi");
			rs = pstmt.executeQuery();
			//System.out.println("nicaishi ");
			
			// 5.从结果集中取数据
			while (rs.next()) {
				System.out.println(rs.getString("CUSTOMER_CD")+"+++++++++++++");
				AdminCustomerBean customer = new AdminCustomerBean();
				customer.setCustomer_cd(rs.getString("CUSTOMER_CD"));
				customer.setCustomer_nm(rs.getString("CUSTOMER_NM"));
				customer.setAddress(rs.getString("ADDRESS"));
				customer.setConnect_kind(rs.getString("CONNECT_KIND"));
				customer.setCustomer_type(rs.getString("CUSTOMER_TYPE"));
				customer.setIs_valid(rs.getString("is_valid"));
				currList.add(customer);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			ConnectionPool.close(pstmt, rs, conn);
		}

		return currList;
	}

	public int getTotalRecordNumber(HashMap<String, String> queryInforMap) {
		int i=0;
		int x;
		String customer_owner =FieldCheck.convertNullToEmpty((String) queryInforMap.get("customer_owner"));
		String customer_owners[] = customer_owner.split(",");
		int totalNum=0;
		//1.获取连接
		conn=ConnectionPool.getConn();
		//2.创建sql
		String sql="SELECT count(*) num  FROM M_CUSTOMER  WHERE CUSTOMER_NM like ? and CONNECT_KIND like ?  and CUSTOMER_TYPE IN (";
		StringBuilder builder = new StringBuilder(sql);
		for(i=0;i<customer_owners.length;i++)
		{
			builder.append("?,");
		}
		builder.deleteCharAt(builder.length()-1);
		
		builder.append(") " +
				" AND is_valid like ? ");
		
		try {
			//3.给占位符赋值
			pstmt=conn.prepareStatement(builder.toString());
			pstmt.setString(1,"%"+ FieldCheck.convertNullToEmpty((String) queryInforMap.get("customer_nm")) + "%");
			pstmt.setString(2,"%"+ FieldCheck.convertNullToEmpty((String) queryInforMap.get("connect_kind")) + "%");
			
			
			for(x=0;x<customer_owners.length;x++){
				pstmt.setString(x+3,customer_owners[x]);
				}
			
			pstmt.setString(x+3,"%"+ FieldCheck.convertNullToEmpty((String) queryInforMap.get("is_valid")) + "%");
			
			//4.发送执行sql
			rs=pstmt.executeQuery();
			//5.从结果集中取数据
			while(rs.next())
			{
				totalNum=rs.getInt("num");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			ConnectionPool.close(pstmt, rs, conn);
		}
		return totalNum;
	}

	public int insertCustomer(AdminCustomerBean adminCustomerBean) {

		String customer_cd=adminCustomerBean.getCustomer_cd();
		String customer_nm=adminCustomerBean.getCustomer_nm();
		String connect_kind=adminCustomerBean.getConnect_kind();
		String address=adminCustomerBean.getAddress();
		String customer_type=adminCustomerBean.getCustomer_type();
		String is_valid=adminCustomerBean.getIs_valid();
		String update_date=adminCustomerBean.getUpdate_date();
		String update_user_id=adminCustomerBean.getUpdate_user_id();
		
		conn=ConnectionPool.getConn();
		//2.创建sql
		//INSERT INTO M_CUSTOMER(customer_cd,customer_nm,start_date,end_date,address, connect_kind, customer_type,is_valid,update_date,update_user_id)VALUES(?,? ,?, NULL,?,?,?,?,?,?)
		String sql="INSERT INTO M_CUSTOMER(customer_cd,customer_nm,start_date,end_date,address, connect_kind, customer_type,is_valid,update_date,update_user_id)" +
				"VALUES(?,? ,?, NULL,?,?,?,?,?,?)";

		try {
			//3.给占位符赋值
			pstmt=conn.prepareStatement(sql);
			
			pstmt.setString(1,customer_cd);
			pstmt.setString(2,customer_nm);
			pstmt.setString(3,update_date);
			pstmt.setString(4,address);
			pstmt.setString(5,connect_kind);
			pstmt.setString(6, customer_type);
			pstmt.setString(7, is_valid);
			pstmt.setString(8, update_date);
			pstmt.setString(9, update_user_id);
			//4.发送执行sql
			pstmt.executeUpdate();
			
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			ConnectionPool.close(pstmt, rs, conn);
		}
		return 0;
		
	}

	public int updateCustomer(AdminCustomerBean adminCustomerBean) {
		String customer_cd=adminCustomerBean.getCustomer_cd();
		String customer_nm=adminCustomerBean.getCustomer_nm();
		String address=adminCustomerBean.getAddress();
		String connect_kind=adminCustomerBean.getConnect_kind();
		String customer_type=adminCustomerBean.getCustomer_type();
		String is_valid=adminCustomerBean.getIs_valid();
		String update_date=adminCustomerBean.getUpdate_date();
		String update_user_id=adminCustomerBean.getUpdate_user_id();
		
		conn=ConnectionPool.getConn();
			String sql="UPDATE M_CUSTOMER SET customer_nm=?,address=?, connect_kind=?, customer_type=?,is_valid=?,update_date=?,update_user_id=?  WHERE customer_cd = ?";

		try {
			pstmt=conn.prepareStatement(sql);
			
			pstmt.setString(1,customer_nm);
			pstmt.setString(2,address);
			pstmt.setString(3,connect_kind);
			pstmt.setString(4,customer_type);
			pstmt.setString(5,is_valid);
			pstmt.setString(6,update_date);
			pstmt.setString(7,update_user_id);
			pstmt.setString(8,customer_cd);
			
			pstmt.executeUpdate();
			
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			ConnectionPool.close(pstmt, rs, conn);
		}
		return 0;
	}

	public int customerDeleteCheck(String customer_cd) {
		int rt_msg=0;
		
		conn=ConnectionPool.getConn();
		String sql="SELECT COUNT(*) num FROM  S_ORDERS  WHERE customer_cd = ? AND RECEIVED_PAYMENTS_FLG = 'F'";

		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1,customer_cd);
			rs=pstmt.executeQuery();
			while(rs.next())
			{
				rt_msg=rs.getInt("num");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			ConnectionPool.close(pstmt, rs, conn);
		}
		return rt_msg;
	}

	public int customerExistCheck(String customer_cd) {
		int rt_msg=0;
		
		conn=ConnectionPool.getConn();
		String sql="SELECT count(*) num FROM M_CUSTOMER  WHERE  customer_cd=?";

		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1,customer_cd);
			rs=pstmt.executeQuery();
			while(rs.next())
			{
				rt_msg=rs.getInt("num");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			ConnectionPool.close(pstmt, rs, conn);
		}
		return rt_msg;
	}

	@Override
	public PageInforBean<SimpleAdminCustomerBean> getCustomers(int fromCount, int endCount, String customerType,
			String search) {
		int i = 0;
		conn = ConnectionPool.getConn();
		PageInforBean<SimpleAdminCustomerBean> pageInforBean = new PageInforBean<SimpleAdminCustomerBean>();

		List<SimpleAdminCustomerBean> list_customer = new ArrayList<SimpleAdminCustomerBean>();
		if(customerType.equals("国网")){
			customerType = "1";
		}else if(customerType.equals("南网")){
			customerType = "2";
		}else if(customerType.equals("地方")){
			customerType = "3";
		}else if(customerType.equals("海外")){
			customerType = "4";
		}
		String sql = "SELECT CUSTOMER_CD,CUSTOMER_NM,CONNECT_KIND FROM M_CUSTOMER WHERE CUSTOMER_TYPE = '"+customerType+"' AND ";
		if (search != null && !search.equals("")) {
			sql += "CUSTOMER_NM LIKE '%" + search + "%' AND ";
		}
		sql += "IS_VALID = 'T' ORDER BY CUSTOMER_CD";
		System.out.println(sql);
		try {
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				i++;
				if (i >= fromCount && i <= endCount) {
					SimpleAdminCustomerBean adminCustomerBean = new SimpleAdminCustomerBean();
					adminCustomerBean.setCustomer_cd(rs.getString(1));
					adminCustomerBean.setCustomer_nm(rs.getString(2));
					adminCustomerBean.setConnect_kind(rs.getString(3));
					list_customer.add(adminCustomerBean);
				}
			}
			pageInforBean.setList(list_customer);
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
