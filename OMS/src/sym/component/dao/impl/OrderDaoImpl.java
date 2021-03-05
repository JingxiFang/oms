package sym.component.dao.impl;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import sym.common.bean.PageInforBean;
import sym.common.util.ConnectionPool;
import sym.common.util.FieldCheck;
import sym.component.bean.OrderBean;
import sym.component.bean.OrderDetailBean;
import sym.component.bean.SimpleOrderBean;
import sym.component.dao.OrderDao;

/**
 * 订单操作相关的dao的实现类
 * 
 * @author gxk
 * @version 2018-04-26
 */
public class OrderDaoImpl implements OrderDao {

	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String sql = null;

	@Override
	public PageInforBean<SimpleOrderBean> getPageInforSimpleOrderBean(int showCount, int currentPage, String sql) {
		int totalNumber = 0;
		int fromCount = showCount * (currentPage - 1) + 1;
		PageInforBean<SimpleOrderBean> PageInforSimpleOrderBean = new PageInforBean<SimpleOrderBean>();
		conn = ConnectionPool.getConn();
		List<SimpleOrderBean> orders = new ArrayList<SimpleOrderBean>();
		try {
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				totalNumber++;
				if (totalNumber >= fromCount && totalNumber < fromCount + showCount) {
					SimpleOrderBean order = new SimpleOrderBean();
					order.setOrders_id(rs.getInt(1));
					order.setAgency_user_nm(rs.getString(2));
					order.setContract_no(rs.getString(3));
					order.setCustomer_nm(rs.getString(4));
					order.setProject_nm(rs.getString(5));
					order.setReceived_payments_flg(rs.getString(6));
					orders.add(order);
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			ConnectionPool.close(pstmt, rs, conn);
		}
		PageInforSimpleOrderBean.setShowCount(showCount);
		PageInforSimpleOrderBean.setFromCount(fromCount);
		PageInforSimpleOrderBean.setTotalNumber(totalNumber);
		int totalPage = totalNumber / showCount;
		if (totalPage * showCount != totalNumber) {
			totalPage++;
		}
		PageInforSimpleOrderBean.setTotalPage(totalPage);
		PageInforSimpleOrderBean.setCurrentPage(currentPage);
		PageInforSimpleOrderBean.setList(orders);
		return PageInforSimpleOrderBean;
	}

	
	
	@Override
	public OrderBean showOrderById(int orders_id) {
		conn = ConnectionPool.getConn();
		OrderBean order = new OrderBean();
		List<OrderDetailBean> order_detail_list = new ArrayList<OrderDetailBean>();
		String sql1 = "SELECT CONTRACT_NO, ORDERS_VERSION, o.AGENCY_USER_CD, USER_NM, o.AGENCY_CD, AGENCY_NM, o.CUSTOMER_TYPE, "
				+ "o.CUSTOMER_CD,CUSTOMER_NM, PROJECT_NM, EXPECTED_SEND_MONTH, EXPECTED_ENERGIZE_MONTH, SHELF_MONTHS, "
				+ "BID_CU_PRICE, BID_SUM_MONEY, c2.CURRENCY_CD, CURRENCY_NM, CONTRACT_SUM_MONEY, PROPORTION, COMMISSION, "
				+ "PAYMENTS_PROPORTION1, PAYMENTS_PROPORTION2, PAYMENTS_PROPORTION3, PAYMENTS_PROPORTION4, PAYMENTS_PROPORTION5, PAYMENTS_PROPORTION6,"
				+ "EXPECTED_PAYMENTS_DATE1, EXPECTED_PAYMENTS_DATE2, EXPECTED_PAYMENTS_DATE3, EXPECTED_PAYMENTS_DATE4, EXPECTED_PAYMENTS_DATE5, EXPECTED_PAYMENTS_DATE6,"
				+ "EXPECTED_PAYMENTS_SUM1,EXPECTED_PAYMENTS_SUM2,EXPECTED_PAYMENTS_SUM3,EXPECTED_PAYMENTS_SUM4,EXPECTED_PAYMENTS_SUM5,EXPECTED_PAYMENTS_SUM6"
				+ " FROM S_ORDERS o,M_USER u,M_AGENCY a,M_CUSTOMER c1,M_CURRENCY c2 WHERE o.AGENCY_USER_CD = u.USER_CD AND o.AGENCY_CD = a.AGENCY_CD"
				+ " AND o.CUSTOMER_CD = c1.CUSTOMER_CD AND o.BID_CURRENCY_CD = c2.CURRENCY_CD AND ORDERS_ID = ?";

		String sql2 = "SELECT ORDERS_DETAIL_ID, PRODUCT_CATEGORY, SPECIFICATION_TYPE, VOLTAGE, CONTRACT_QUANTITY, CONTRACT_UNIT_PRICE, CONTRACT_PRICE, REMARK "
				+ "	FROM S_ORDERS_DETAIL WHERE ORDERS_ID = ?";

		try {
			pstmt = conn.prepareStatement(sql1);
			pstmt.setInt(1, orders_id);

			rs = pstmt.executeQuery();

			while (rs.next()) { // 从结果集中取出记录数
				order.setOrders_id(orders_id);
				order.setContract_no(rs.getString(1));
				order.setOrders_version(rs.getString(2));
				order.setAgency_user_cd(rs.getString(3));
				order.setAgency_user_nm(rs.getString(4));
				order.setAgency_cd(rs.getString(5));
				order.setAgency_nm(rs.getString(6));
				String customer_type = rs.getString(7);
				if (customer_type.equals("1"))
					customer_type = "国网";
				else if (customer_type.equals("2"))
					customer_type = "南网";
				else if (customer_type.equals("3"))
					customer_type = "海外";
				else if (customer_type.equals("4"))
					customer_type = "地方";
				order.setCustomer_type(customer_type);
				order.setCustomer_cd(rs.getString(8));
				order.setCustomer_nm(rs.getString(9));
				order.setProject_nm(rs.getString(10));
				order.setExpected_send_month(rs.getString(11));
				order.setExpected_energize_month(rs.getString(12));
				order.setShelf_months(rs.getInt(13));
				order.setBid_cu_price(rs.getDouble(14));
				order.setBid_sum_money(rs.getDouble(15));
				order.setCurrency_cd(rs.getString(16));
				order.setCurrency_nm(rs.getString(17));
				order.setContract_sum_money(rs.getBigDecimal(18));
				order.setProportion(rs.getDouble(19));
				order.setCommission(rs.getBigDecimal(20));
				order.setPayments_proportion1(rs.getDouble(21));
				order.setPayments_proportion2(rs.getDouble(22));
				order.setPayments_proportion3(rs.getDouble(23));
				order.setPayments_proportion4(rs.getDouble(24));
				order.setPayments_proportion5(rs.getDouble(25));
				order.setPayments_proportion6(rs.getDouble(26));
				order.setExpected_payments_date1(rs.getString(27));
				order.setExpected_payments_date2(rs.getString(28));
				order.setExpected_payments_date3(rs.getString(29));
				order.setExpected_payments_date4(rs.getString(30));
				order.setExpected_payments_date5(rs.getString(31));
				order.setExpected_payments_date6(rs.getString(32));
				order.setExpected_payments_sum1(rs.getDouble(33));
				order.setExpected_payments_sum2(rs.getDouble(34));
				order.setExpected_payments_sum3(rs.getDouble(35));
				order.setExpected_payments_sum4(rs.getDouble(36));
				order.setExpected_payments_sum5(rs.getDouble(37));
				order.setExpected_payments_sum6(rs.getDouble(38));
			}

			pstmt = conn.prepareStatement(sql2);
			pstmt.setInt(1, orders_id);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				OrderDetailBean orderDetailBean = new OrderDetailBean();
				orderDetailBean.setOrder_detail_id(rs.getInt(1));
				orderDetailBean.setProduct_category(rs.getString(2));
				orderDetailBean.setSpecification_type(rs.getString(3));
				orderDetailBean.setVoltage(rs.getString(4));
				orderDetailBean.setContract_quantity(rs.getDouble(5));
				orderDetailBean.setContract_unit_price(rs.getDouble(6));
				orderDetailBean.setContract_price(rs.getDouble(7));
				orderDetailBean.setRemark(rs.getString(8));
				order_detail_list.add(orderDetailBean);
			}

			order.setOrder_detail_list(order_detail_list);

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			// 释放连接
			ConnectionPool.close(pstmt, rs, conn);
		}

		return order;
	}

	@Override
	public int updateOrder(OrderBean orderBean) {
		int result = 0;
		conn = ConnectionPool.getConn();

		String sql = "UPDATE S_ORDERS SET CONTRACT_NO=?, ORDERS_VERSION =?, AGENCY_USER_CD =?, AGENCY_CD=?, CUSTOMER_TYPE=?,"
				+ "CUSTOMER_CD=?, PROJECT_NM=?, EXPECTED_SEND_MONTH=?, EXPECTED_ENERGIZE_MONTH=?, SHELF_MONTHS=?,"
				+ "BID_CURRENCY_CD=?, BID_CU_PRICE=?, BID_SUM_MONEY=?, CONTRACT_SUM_MONEY=?, PROPORTION=?,"
				+ "COMMISSION=?, PAYMENTS_PROPORTION1=?, PAYMENTS_PROPORTION2=?, PAYMENTS_PROPORTION3=?, PAYMENTS_PROPORTION4=?,"
				+ "PAYMENTS_PROPORTION5=?, PAYMENTS_PROPORTION6=?, EXPECTED_PAYMENTS_DATE1=?, EXPECTED_PAYMENTS_DATE2=?, EXPECTED_PAYMENTS_DATE3=?,"
				+ "EXPECTED_PAYMENTS_DATE4=?, EXPECTED_PAYMENTS_DATE5=?, EXPECTED_PAYMENTS_DATE6=?, EXPECTED_PAYMENTS_SUM1=?, EXPECTED_PAYMENTS_SUM2=?,"
				+ "EXPECTED_PAYMENTS_SUM3=?,EXPECTED_PAYMENTS_SUM4=?,EXPECTED_PAYMENTS_SUM5=?,EXPECTED_PAYMENTS_SUM6=?,UPDATE_DATE=?,"
				+ "UPDATE_USER_ID=? " + "WHERE ORDERS_ID=?";
		try {
			conn.setAutoCommit(false);
			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, orderBean.getContract_no());
			pstmt.setString(2, orderBean.getOrders_version());
			pstmt.setString(3, orderBean.getAgency_user_cd());
			pstmt.setString(4, orderBean.getAgency_cd());
			String customer_type = orderBean.getCustomer_type();
			if (customer_type.equals("国网")) {
				customer_type = "1";
			} else if (customer_type.equals("南网")) {
				customer_type = "2";
			} else if (customer_type.equals("海外")) {
				customer_type = "3";
			} else if (customer_type.equals("地方")) {
				customer_type = "4";
			}
			pstmt.setString(5, customer_type);
			pstmt.setString(6, orderBean.getCustomer_cd());
			pstmt.setString(7, orderBean.getProject_nm());
			pstmt.setString(8, orderBean.getExpected_send_month());
			pstmt.setString(9, orderBean.getExpected_energize_month());
			pstmt.setInt(10, orderBean.getShelf_months());
			pstmt.setString(11, orderBean.getCurrency_cd());
			pstmt.setDouble(12, orderBean.getBid_cu_price());
			pstmt.setDouble(13, orderBean.getBid_sum_money());
			pstmt.setBigDecimal(14, orderBean.getContract_sum_money());
			pstmt.setDouble(15, orderBean.getProportion()/100);
			pstmt.setBigDecimal(16, orderBean.getCommission());
			pstmt.setDouble(17, orderBean.getPayments_proportion1());
			pstmt.setDouble(18, orderBean.getPayments_proportion2());
			pstmt.setDouble(19, orderBean.getPayments_proportion3());
			pstmt.setDouble(20, orderBean.getPayments_proportion4());
			pstmt.setDouble(21, orderBean.getPayments_proportion5());
			pstmt.setDouble(22, orderBean.getPayments_proportion6());
			pstmt.setString(23, orderBean.getExpected_payments_date1());
			pstmt.setString(24, orderBean.getExpected_payments_date2());
			pstmt.setString(25, orderBean.getExpected_payments_date3());
			pstmt.setString(26, orderBean.getExpected_payments_date4());
			pstmt.setString(27, orderBean.getExpected_payments_date5());
			pstmt.setString(28, orderBean.getExpected_payments_date6());
			pstmt.setDouble(29, orderBean.getExpected_payments_sum1());
			pstmt.setDouble(30, orderBean.getExpected_payments_sum2());
			pstmt.setDouble(31, orderBean.getExpected_payments_sum3());
			pstmt.setDouble(32, orderBean.getExpected_payments_sum4());
			pstmt.setDouble(33, orderBean.getExpected_payments_sum5());
			pstmt.setDouble(34, orderBean.getExpected_payments_sum6());
			SimpleDateFormat f = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
			String dateStr = f.format(orderBean.getUpdate_date());
			pstmt.setString(35, dateStr);
			pstmt.setString(36, orderBean.getUpdate_user_id());
			pstmt.setInt(37, orderBean.getOrders_id());
			
			
			result = pstmt.executeUpdate();
			clearOrderDetails(conn, orderBean.getOrders_id());
			insertOrderDetails(conn, orderBean.getOrder_detail_list(), orderBean.getAgency_user_cd(), dateStr);
			conn.commit();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			ConnectionPool.close(pstmt, rs, conn);
		}
		return result;
	}
	

	@Override
	public void clearOrderDetails(Connection conn, int orders_id) throws SQLException {
		String sql = "DELETE FROM S_ORDERS_DETAIL WHERE ORDERS_ID=?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, orders_id);
		pstmt.executeUpdate();
	}

	@Override
	public void insertOrderDetails(Connection conn, List<OrderDetailBean> order_detail_list, String agency_user_id,
			String dateStr) throws SQLException {
		for (OrderDetailBean bean : order_detail_list) {
			String sql = "INSERT INTO S_ORDERS_DETAIL(ORDERS_DETAIL_ID, ORDERS_ID, PRODUCT_CATEGORY,"
					+ "SPECIFICATION_TYPE, VOLTAGE, CONTRACT_QUANTITY, CONTRACT_UNIT_PRICE, CONTRACT_PRICE,"
					+ "REMARK, UPDATE_DATE, UPDATE_USER_ID)" + " VALUES(?,?,?,?,?,?,?,?,?,?,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, bean.getOrder_detail_id());
			pstmt.setInt(2, bean.getOrders_id());
			pstmt.setString(3, bean.getProduct_category());
			pstmt.setString(4, bean.getSpecification_type());
			pstmt.setString(5, bean.getVoltage());
			pstmt.setDouble(6, bean.getContract_quantity());
			pstmt.setDouble(7, bean.getContract_unit_price());
			pstmt.setDouble(8, bean.getContract_price());
			pstmt.setString(9, bean.getRemark());
			pstmt.setString(10, dateStr);
			pstmt.setString(11, agency_user_id);
			pstmt.executeUpdate();
		}
	}



	@Override
	public int insertOrder(OrderBean orderBean) {
		int result = 0;
		int orders_id = 0;
		conn = ConnectionPool.getConn();

		String sql = "INSERT INTO S_ORDERS(CONTRACT_NO, ORDERS_VERSION, AGENCY_USER_CD, AGENCY_CD,"
				+ "CUSTOMER_TYPE, CUSTOMER_CD, PROJECT_NM, EXPECTED_SEND_MONTH, EXPECTED_ENERGIZE_MONTH, "
				+ "SHELF_MONTHS, BID_CURRENCY_CD, BID_CU_PRICE, "
				+ "BID_SUM_MONEY, CONTRACT_SUM_MONEY, PROPORTION, COMMISSION,"
				+ "PAYMENTS_PROPORTION1, PAYMENTS_PROPORTION2, PAYMENTS_PROPORTION3, "
				+ "PAYMENTS_PROPORTION4, PAYMENTS_PROPORTION5, PAYMENTS_PROPORTION6,"
				+ "EXPECTED_PAYMENTS_DATE1, EXPECTED_PAYMENTS_DATE2, EXPECTED_PAYMENTS_DATE3,"
				+ "EXPECTED_PAYMENTS_DATE4, EXPECTED_PAYMENTS_DATE5, EXPECTED_PAYMENTS_DATE6,"
				+ "EXPECTED_PAYMENTS_SUM1, EXPECTED_PAYMENTS_SUM2, EXPECTED_PAYMENTS_SUM3, "
				+ "EXPECTED_PAYMENTS_SUM4, EXPECTED_PAYMENTS_SUM5, EXPECTED_PAYMENTS_SUM6,"
				+ "UPDATE_DATE, UPDATE_USER_ID) "
				+ "VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
		try {
			conn.setAutoCommit(false);
			pstmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);

			pstmt.setString(1, orderBean.getContract_no());
			pstmt.setString(2, orderBean.getOrders_version());
			pstmt.setString(3, orderBean.getAgency_user_cd());
			pstmt.setString(4, orderBean.getAgency_cd());
			String customer_type = orderBean.getCustomer_type();
			if (customer_type.equals("国网")) {
				customer_type = "1";
			} else if (customer_type.equals("南网")) {
				customer_type = "2";
			} else if (customer_type.equals("海外")) {
				customer_type = "3";
			} else if (customer_type.equals("地方")) {
				customer_type = "4";
			}
			pstmt.setString(5, customer_type);
			pstmt.setString(6, orderBean.getCustomer_cd());
			pstmt.setString(7, orderBean.getProject_nm());
			pstmt.setString(8, orderBean.getExpected_send_month());
			pstmt.setString(9, orderBean.getExpected_energize_month());
			pstmt.setInt(10, orderBean.getShelf_months());
			pstmt.setString(11, orderBean.getCurrency_cd());
			pstmt.setDouble(12, orderBean.getBid_cu_price());
			pstmt.setDouble(13, orderBean.getBid_sum_money());
			pstmt.setBigDecimal(14, orderBean.getContract_sum_money());
			pstmt.setDouble(15, orderBean.getProportion()/100);
			pstmt.setBigDecimal(16, orderBean.getCommission());
			pstmt.setDouble(17, orderBean.getPayments_proportion1());
			pstmt.setDouble(18, orderBean.getPayments_proportion2());
			pstmt.setDouble(19, orderBean.getPayments_proportion3());
			pstmt.setDouble(20, orderBean.getPayments_proportion4());
			pstmt.setDouble(21, orderBean.getPayments_proportion5());
			pstmt.setDouble(22, orderBean.getPayments_proportion6());
			pstmt.setString(23, orderBean.getExpected_payments_date1());
			pstmt.setString(24, orderBean.getExpected_payments_date2());
			pstmt.setString(25, orderBean.getExpected_payments_date3());
			pstmt.setString(26, orderBean.getExpected_payments_date4());
			pstmt.setString(27, orderBean.getExpected_payments_date5());
			pstmt.setString(28, orderBean.getExpected_payments_date6());
			pstmt.setDouble(29, orderBean.getExpected_payments_sum1());
			pstmt.setDouble(30, orderBean.getExpected_payments_sum2());
			pstmt.setDouble(31, orderBean.getExpected_payments_sum3());
			pstmt.setDouble(32, orderBean.getExpected_payments_sum4());
			pstmt.setDouble(33, orderBean.getExpected_payments_sum5());
			pstmt.setDouble(34, orderBean.getExpected_payments_sum6());
			SimpleDateFormat f = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
			String dateStr = f.format(orderBean.getUpdate_date());
			pstmt.setString(35, dateStr);
			pstmt.setString(36, orderBean.getUpdate_user_id());
			
			result = pstmt.executeUpdate();
			ResultSet rs = pstmt.getGeneratedKeys();
			rs.next();
	        orders_id = rs.getInt(1);
	        List<OrderDetailBean> order_detail_list = orderBean.getOrder_detail_list();
	        for(OrderDetailBean bean : order_detail_list){
	        	bean.setOrders_id(orders_id);
	        }
			insertOrderDetails(conn, order_detail_list, orderBean.getAgency_user_cd(), dateStr);
			conn.commit();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			ConnectionPool.close(pstmt, rs, conn);
		}
		return result;
	}



	@Override
	public int deleteOrder(int orders_id) {
		conn = ConnectionPool.getConn();
	
		int result = 0;
		String sql = "DELETE FROM S_ORDERS WHERE ORDERS_ID = ?";
		try {
			conn.setAutoCommit(false);
			clearOrderDetails(conn, orders_id);
			pstmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
			pstmt.setInt(1, orders_id);
			result = pstmt.executeUpdate();
			conn.commit();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			ConnectionPool.close(pstmt, rs, conn);
		}
		return result;
	}
	
	@Override
	public List<OrderBean> findOrderVersionList(String contract_cd) {
		conn = ConnectionPool.getConn();
		
		List<OrderBean> order_version_list = new ArrayList<OrderBean>();
		String sql1 = "SELECT ORDERS_ID, ORDERS_VERSION, u1.USER_NM, o.UPDATE_DATE, u2.USER_NM " +
				"FROM  S_ORDERS o, M_USER u1, M_USER u2 WHERE o.AGENCY_USER_CD = u1.USER_CD and o.UPDATE_USER_ID = u2.USER_CD " +
				"and CONTRACT_NO = ? ORDER BY ORDERS_ID  ASC";
		try {
			pstmt = conn.prepareStatement(sql1);
			pstmt.setString(1, contract_cd);

			rs = pstmt.executeQuery();

			while (rs.next()) { // 从结果集中取出记录数
				OrderBean order = new OrderBean();
				order.setOrders_id(rs.getInt(1));
				order.setOrders_version(rs.getString(2));
				order.setAgency_user_nm(rs.getString(3));
				String update_date=rs.getString(4);
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				
				order.setUpdate_date(sdf.parse(update_date));
				order.setUpdate_user_nm(rs.getString(5));
				order_version_list.add(order);
			}	
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			// 释放连接
			ConnectionPool.close(pstmt, rs, conn);
		}

		return order_version_list;
	}
	
	/**
	 * 原作者 YZC
	 * 修改者 FJX 2018/06/15
	 */
	@Override
	public List getComponentPageList(int fromCount, int endCount,
			HashMap queryInforMap) {
		// TODO Auto-generated method stub
		List<OrderBean> orderList = new ArrayList<OrderBean>();
		try {
			// 获取连接
			conn = ConnectionPool.getConn();
			String sql ="";
			//获取参数信息
			String flg = FieldCheck.convertNullToEmpty((String) queryInforMap.get("flg"));
			//获取参数信息
			String contract_num = FieldCheck.convertNullToEmpty((String) queryInforMap.get("contract_num"));
			String customer_nm = FieldCheck.convertNullToEmpty((String) queryInforMap.get("customer_nm"));
			String projecct_nm = FieldCheck.convertNullToEmpty((String) queryInforMap.get("projecct_nm"));
			String is_back = FieldCheck.convertNullToEmpty((String) queryInforMap.get("is_back"));
			String category = FieldCheck.convertNullToEmpty((String) queryInforMap.get("category"));
			//FJX
			String orderBy= FieldCheck
					.convertNullToEmpty((String) queryInforMap
							.get("orderBy"));
			String sc = FieldCheck
					.convertNullToEmpty((String) queryInforMap
							.get("sc"));
			String salesman_nm ="";
			String salesman_cd="";
			if("S".equals(flg)){
				//业务员，根据编号查找
				salesman_cd = FieldCheck.convertNullToEmpty((String) queryInforMap.get("salesman_cd"));
				
				// 创建sql
				sql = "select * from " +
						"(select mu.USER_NM,CONTRACT_NO,mc.CUSTOMER_NM,PROJECT_NM," +
						" RECEIVED_PAYMENTS_FLG ,ROW_NUMBER() OVER(ORDER BY " + orderBy+ " "+ sc+ ") as r "+
						" from S_ORDERS sos " +
						" inner join M_USER mu on sos.AGENCY_USER_CD=mu.USER_CD " +
						" inner join M_CUSTOMER mc on sos.CUSTOMER_CD=mc.CUSTOMER_CD " +
						" where mu.USER_OWNER_FLG='S' and CONTRACT_NO like ? " +
						" and mu.USER_cd =? and mc.CUSTOMER_NM like ? " +
						" and PROJECT_NM like ? and RECEIVED_PAYMENTS_FLG like ? and mc.CUSTOMER_TYPE ";
				if(category.indexOf("%")!=-1){
					sql+=" like '%%' ";
				}else{
					sql+=" in ("+category+") ";
				}
				sql+=") temp where r between ? and ?";
				
			}
			else if("M".equals(flg)){
				//管理员，根据姓名模糊查找
				salesman_nm = FieldCheck.convertNullToEmpty((String) queryInforMap.get("salesman_nm"));
				
				// 创建sql
				sql = "select * from " +
						"(select mu.USER_NM,CONTRACT_NO,mc.CUSTOMER_NM,PROJECT_NM," +
						" RECEIVED_PAYMENTS_FLG ,ROW_NUMBER() OVER(ORDER BY " + orderBy+ " "+ sc+ ") as r "+
						" from S_ORDERS sos " +
						" inner join M_USER mu on sos.AGENCY_USER_CD=mu.USER_CD " +
						" inner join M_CUSTOMER mc on sos.CUSTOMER_CD=mc.CUSTOMER_CD " +
						" where mu.USER_OWNER_FLG='S' and CONTRACT_NO like ? " +
						" and mu.USER_NM like ? and mc.CUSTOMER_NM like ? " +
						" and PROJECT_NM like ? and RECEIVED_PAYMENTS_FLG like ? and mc.CUSTOMER_TYPE ";
				if(category.indexOf("%")!=-1){
					sql+=" like '%%' ";
				}else{
					sql+=" in ("+category+") ";
				}
				sql+=") temp where r between ? and ?";

			}
				
			// 给占位符赋值
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, "%" + contract_num + "%");
			if("S".equals(flg)){
				//业务员	
				pstmt.setString(2, salesman_cd);
			}
			else if("M".equals(flg)){
				//管理员
				pstmt.setString(2, "%"+salesman_nm+"%");	
			}
			pstmt.setString(3, "%" + customer_nm + "%");
			pstmt.setString(4, "%" + projecct_nm + "%");
			pstmt.setString(5, "%" + is_back + "%");
			pstmt.setInt(6, fromCount);
			pstmt.setInt(7, endCount);
		
			// 发送执行sql
			rs = pstmt.executeQuery();
			
			// 从结果集中取数据
			while (rs.next()) {
				OrderBean order = toOrderBean();
				orderList.add(order);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			ConnectionPool.close(pstmt, rs, conn);
		}

		return orderList;
	}

	private OrderBean toOrderBean() throws SQLException {
		OrderBean order = new OrderBean();
		//order.setCustomer_type(rs.getString("CUSTOMER_TYPE"));
		order.setAgency_user_nm(rs.getString("USER_NM"));
		order.setContract_no(rs.getString("CONTRACT_NO"));
		order.setCustomer_nm(rs.getString("CUSTOMER_NM"));
		order.setProject_nm(rs.getString("PROJECT_NM"));
		order.setReceived_payments_flg(rs.getString("RECEIVED_PAYMENTS_FLG"));
		return order;
	}

	@Override
	/**
	 * 修改 FJX 20180616
	 */
	public int getTotalNumber(HashMap<String, String> queryInforMap) {
		// TODO Auto-generated method stub
		int totalNum=0;
		
		//1.获取连接
		conn=ConnectionPool.getConn();
		//存放sql语句
		String sql="";
		
		String contract_num = FieldCheck
				.convertNullToEmpty((String) queryInforMap
						.get("contract_num"));
		String salesman_nm = "";
		String salesman_cd = "";
		String customer_nm = FieldCheck.convertNullToEmpty((String) queryInforMap.get("customer_nm"));
		String projecct_nm = FieldCheck.convertNullToEmpty((String) queryInforMap.get("projecct_nm"));
		String is_back = FieldCheck.convertNullToEmpty((String) queryInforMap.get("is_back"));
	
		
		//获取当前用户的权限 FJX
		String flg = FieldCheck.convertNullToEmpty((String) queryInforMap.get("flg"));
		
		//2.创建sql
		if("M".equals(flg)){
			salesman_nm = FieldCheck.convertNullToEmpty((String) queryInforMap.get("salesman_nm"));
			sql= "select count(*) as num " //
					+ "from S_ORDERS so " //
					+ "inner join M_USER mu on so.AGENCY_USER_CD=mu.USER_CD " //
					+ "inner join M_CUSTOMER mc on so.CUSTOMER_CD=mc.CUSTOMER_CD " //
					+ "where mu.USER_OWNER_FLG='S' " //
					+ "and CONTRACT_NO like ? " //
					+ "and mu.USER_NM like ? " //
					+ "and mc.CUSTOMER_NM like ? " //
					+ "and PROJECT_NM like ? " //
					+ "and RECEIVED_PAYMENTS_FLG like ? "; //
		}
		else if("S".equals(flg)){
			salesman_cd=FieldCheck.convertNullToEmpty((String) queryInforMap.get("salesman_cd"));
			sql= "select count(*) as num " //
					+ "from S_ORDERS so " //
					+ "inner join M_USER mu on so.AGENCY_USER_CD=mu.USER_CD " //
					+ "inner join M_CUSTOMER mc on so.CUSTOMER_CD=mc.CUSTOMER_CD " //
					+ "where mu.USER_OWNER_FLG='S' " //
					+ "and CONTRACT_NO like ? " //
					+ "and mu.USER_CD=? " //
					+ "and mc.CUSTOMER_NM like ? " //
					+ "and PROJECT_NM like ? " //
					+ "and RECEIVED_PAYMENTS_FLG like ? "; //
			
		}
		
		//+ "and mc.CUSTOMER_TYPE in(?) " //;
		try {
			
			
							
			//3.给占位符赋值
			pstmt=conn.prepareStatement(sql);
			
			pstmt.setString(1, "%" + contract_num + "%");
			if("M".equals(flg)){
				pstmt.setString(2, "%" + salesman_nm + "%");
			}
			else if("S".equals(flg)){
				pstmt.setString(2,salesman_cd );
			}
			pstmt.setString(3, "%" + customer_nm + "%");
			pstmt.setString(4, "%" + projecct_nm + "%");
			pstmt.setString(5, "%" + is_back + "%");
			//pstmt.setString(6, category);
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
		//System.out.println(totalNum);
		return totalNum;
	}

	@Override
	public int findInvoiceCnt(String contract_no) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public String findReceivedPaymentsFlg(String orders_id) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int deleteOrder(String contract_no) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public List<OrderBean> findOrderIDList(String contract_no) {
		// TODO Auto-generated method stub
		return null;
	}

	/***
	 * 修改者：FJXxx
	 * 修改时间：2018-06-18
	 */
	@Override
	public List<OrderBean> getOrderInfoList(HashMap queryInforMap) {
		// TODO Auto-generated method stub
		List<OrderBean> orderList = new ArrayList<OrderBean>();
		// 1.获取连接
		conn = ConnectionPool.getConn();
		String contract_no=FieldCheck.convertNullToEmpty((String) queryInforMap.get("contract_num"));
		// 2.创建sql
		String sql = "select CONTRACT_NO,ORDERS_VERSION, " //合同
				+ "mu.USER_NM,ma.AGENCY_NM, " //业务员 代理商 
				+ "mc.CUSTOMER_TYPE,mc.CUSTOMER_NM, " //客户类别 客户名称
				+ "PROJECT_NM, " //项目名
				+ "EXPECTED_SEND_MONTH,EXPECTED_ENERGIZE_MONTH, " //预计发货月 预计送电月
				+ "SHELF_MONTHS, " //通电后保证月数
				+ "BID_CU_PRICE,BID_SUM_MONEY,CONTRACT_SUM_MONEY,BID_CURRENCY_CD, " //投标_铜价 投标_金额 合同总价 投标货币
				+ "PROPORTION,COMMISSION, " //佣金率 佣金金额
				+ "PAYMENTS_PROPORTION1,PAYMENTS_PROPORTION2,PAYMENTS_PROPORTION3, " //回收比率1 回收比率2 回收比率3
				+ "PAYMENTS_PROPORTION4,PAYMENTS_PROPORTION5,PAYMENTS_PROPORTION6, " //回收比率4 回收比率5 回收比率6
				+ "EXPECTED_PAYMENTS_DATE1,EXPECTED_PAYMENTS_DATE2,EXPECTED_PAYMENTS_DATE3, " //回收预定月1 回收预定月2 回收预定月3
				+ "EXPECTED_PAYMENTS_DATE4,EXPECTED_PAYMENTS_DATE5,EXPECTED_PAYMENTS_DATE6, " //回收预定月4 回收预定月5 回收预定月6
				+ "EXPECTED_PAYMENTS_SUM1,EXPECTED_PAYMENTS_SUM2,EXPECTED_PAYMENTS_SUM3, " //回收预定金额1 回收预定金额2 回收预定金额3
				+ "EXPECTED_PAYMENTS_SUM4,EXPECTED_PAYMENTS_SUM5,EXPECTED_PAYMENTS_SUM6 " //回收预定金额4 回收预定金额5 回收预定金额6
				+ "from S_ORDERS sos " //
				+ "inner join M_USER mu on sos.AGENCY_USER_CD=mu.USER_CD " //
				+ "inner join M_CUSTOMER mc on sos.CUSTOMER_CD=mc.CUSTOMER_CD " //
				+ "inner join M_AGENCY ma on sos.AGENCY_CD=ma.AGENCY_CD " //
				+ "where mu.USER_OWNER_FLG='S' " //
				+ "and CONTRACT_NO like ? "
				+"and ORDERS_VERSION=(select max(ORDERS_VERSION) ORDERS_VERSION from S_ORDERS where CONTRACT_NO like ? )";

		try {
			
			//System.out.println(contract_no);
			
			// 3.给占位符赋值
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, "%" + contract_no + "%");
			pstmt.setString(2, "%" + contract_no + "%");
			
			// 4.发送执行sql
			rs = pstmt.executeQuery();
			// 5.从结果集中取数据
			while (rs.next()) {
				OrderBean order = toOrderInfoAll();
				
				orderList.add(order);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			ConnectionPool.close(pstmt, rs, conn);
		}

		
		return orderList;
	}

	private OrderBean toOrderInfoAll() throws SQLException {
		OrderBean order = new OrderBean();
		order.setContract_no(rs.getString("CONTRACT_NO"));
		order.setOrders_version(rs.getString("ORDERS_VERSION"));
		
		order.setAgency_user_nm(rs.getString("USER_NM"));
		order.setAgency_nm(rs.getString("AGENCY_NM"));
		
		order.setCustomer_type(rs.getString("CUSTOMER_TYPE"));
		order.setCustomer_nm(rs.getString("CUSTOMER_NM"));
		order.setProject_nm(rs.getString("PROJECT_NM"));
		
		order.setExpected_send_month(rs.getString("EXPECTED_SEND_MONTH"));
		order.setExpected_energize_month(rs.getString("EXPECTED_ENERGIZE_MONTH"));
		order.setShelf_months(Integer.valueOf(rs.getString("SHELF_MONTHS")));
		
		order.setBid_cu_price(Double.valueOf( rs.getString("BID_CU_PRICE")));
		order.setBid_sum_money(Double.valueOf(rs.getString("BID_SUM_MONEY")));
		order.setContract_sum_money(BigDecimal.valueOf(Double.valueOf(rs.getString("CONTRACT_SUM_MONEY"))));
		order.setCurrency_cd(rs.getString("BID_CURRENCY_CD"));
		
		order.setProportion(Double.valueOf(rs.getString("PROPORTION")));
		order.setCommission(BigDecimal.valueOf(Double.valueOf(rs.getString("COMMISSION"))));
		
		order.setPayments_proportion1(Double.valueOf(rs.getString("PAYMENTS_PROPORTION1")));
		order.setPayments_proportion2(Double.valueOf(rs.getString("PAYMENTS_PROPORTION2")));
		order.setPayments_proportion3(Double.valueOf(rs.getString("PAYMENTS_PROPORTION3")));
		order.setPayments_proportion4(Double.valueOf(rs.getString("PAYMENTS_PROPORTION4")));
		order.setPayments_proportion5(Double.valueOf(rs.getString("PAYMENTS_PROPORTION5")));
		order.setPayments_proportion6(Double.valueOf(rs.getString("PAYMENTS_PROPORTION6")));
		
		order.setExpected_payments_date1(rs.getString("EXPECTED_PAYMENTS_DATE1"));
		order.setExpected_payments_date2(rs.getString("EXPECTED_PAYMENTS_DATE2"));
		order.setExpected_payments_date3(rs.getString("EXPECTED_PAYMENTS_DATE3"));
		order.setExpected_payments_date4(rs.getString("EXPECTED_PAYMENTS_DATE4"));
		order.setExpected_payments_date5(rs.getString("EXPECTED_PAYMENTS_DATE5"));
		order.setExpected_payments_date6(rs.getString("EXPECTED_PAYMENTS_DATE6"));
		
		order.setExpected_payments_sum1(Double.valueOf(rs.getString("EXPECTED_PAYMENTS_SUM1")));
		order.setExpected_payments_sum2(Double.valueOf(rs.getString("EXPECTED_PAYMENTS_SUM2")));
		order.setExpected_payments_sum3(Double.valueOf(rs.getString("EXPECTED_PAYMENTS_SUM3")));
		order.setExpected_payments_sum4(Double.valueOf(rs.getString("EXPECTED_PAYMENTS_SUM4")));
		order.setExpected_payments_sum5(Double.valueOf(rs.getString("EXPECTED_PAYMENTS_SUM5")));
		order.setExpected_payments_sum6(Double.valueOf(rs.getString("EXPECTED_PAYMENTS_SUM6")));
		return order;
	}



	@Override
	public List<OrderBean> getCurrPageList(HashMap<String, String> hm) {
		// TODO Auto-generated method stub
		return null;
	}



	@Override
	public boolean updateOrderPro(OrderBean order) {
		int result=0;
		String sql="update S_ORDERS set ENERGIZE_DATE=?,  EXPECTED_PAYMENTS_DATE2=?, " +
				"EXPECTED_PAYMENTS_DATE3=?, EXPECTED_PAYMENTS_DATE4=?, EXPECTED_PAYMENTS_DATE5=?," +
				" EXPECTED_PAYMENTS_DATE6=?, EXPECTED_PAYMENTS_SUM2=?, EXPECTED_PAYMENTS_SUM3=?," +
				" EXPECTED_PAYMENTS_SUM4=?, EXPECTED_PAYMENTS_SUM5=?, EXPECTED_PAYMENTS_SUM6=?, " +
				"UPDATE_DATE=GETDATE(), UPDATE_USER_ID=? where CONTRACT_NO=? and ORDERS_VERSION=?";
		try {
			conn = ConnectionPool.getConn();
			// 3.给占位符赋值
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, order.getEnergize_date());
			pstmt.setString(2, order.getExpected_payments_date2());
			pstmt.setString(3, order.getExpected_payments_date3());
			pstmt.setString(4, order.getExpected_payments_date4());
			pstmt.setString(5, order.getExpected_payments_date5());
			pstmt.setString(6, order.getExpected_payments_date6());
			pstmt.setDouble(7, order.getExpected_payments_sum2());
			pstmt.setDouble(8, order.getExpected_payments_sum3());
			pstmt.setDouble(9, order.getExpected_payments_sum4());
			pstmt.setDouble(10, order.getExpected_payments_sum5());
			pstmt.setDouble(11, order.getExpected_payments_sum6());
			pstmt.setInt(12,Integer.valueOf(order.getUpdate_user_id()));
			pstmt.setString(13, order.getContract_no());
			pstmt.setInt(14, Integer.valueOf(order.getOrders_version()));
			// 4.发送执行sql
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			ConnectionPool.close(pstmt, rs, conn);
		}
		return result>0;
	}

	

	
}
