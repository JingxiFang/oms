package sym.component.dao.impl;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import sym.common.util.ConnectionPool;
import sym.common.util.FieldCheck;
import sym.component.bean.OrderDetailBean;
import sym.component.dao.OrderDetailDao;

public class OrderDetailDaoImpl implements OrderDetailDao {
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String sql = null;
	
	@Override
	public int orderDetailExistCheck(BigDecimal orderDetail_id) {
		int rt_msg = 0;

		conn = ConnectionPool.getConn();
		String sql = "SELECT count(*) num FROM S_ORDERS_DETAIL WHERE ORDERS_DETAIL_ID=?";

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setBigDecimal(1, orderDetail_id);
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
	public int deleteOrderDetail(String orders_id) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public List<OrderDetailBean> getOrderDetailByContactNO(String contactNo) {
		conn = ConnectionPool.getConn();
		List<OrderDetailBean> detailInfoList=new ArrayList<OrderDetailBean>();
		String contract_no=FieldCheck.convertNullToEmpty(contactNo);
		if(!"".equals(contract_no)){
			try{
				String sql="select ORDERS_DETAIL_ID,PRODUCT_CATEGORY, SPECIFICATION_TYPE, VOLTAGE, CONTRACT_QUANTITY," //
						+" CONTRACT_UNIT_PRICE, CONTRACT_PRICE  from S_ORDERS_DETAIL where ORDERS_ID in " //
							+"(select ORDERS_ID from S_ORDERS where CONTRACT_NO=?)";
	
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, contract_no );
				
				rs = pstmt.executeQuery();
				while (rs.next()) {
					OrderDetailBean orderDetail = toOrderDetail();
					detailInfoList.add(orderDetail);
				}

			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				ConnectionPool.close(pstmt, rs, conn);
			}
		
		}
		return detailInfoList;
	}

	private OrderDetailBean toOrderDetail() throws SQLException {
		OrderDetailBean orderDetail=new OrderDetailBean();
		orderDetail.setOrder_detail_id(Integer.valueOf( rs.getString("ORDERS_DETAIL_ID")));
		orderDetail.setProduct_category(rs.getString("PRODUCT_CATEGORY"));
		orderDetail.setSpecification_type(rs.getString("SPECIFICATION_TYPE"));
		orderDetail.setVoltage(rs.getString("VOLTAGE"));
		orderDetail.setContract_quantity(Double.valueOf(rs.getString("CONTRACT_QUANTITY")));
		orderDetail.setContract_unit_price(Double.valueOf(rs.getString("CONTRACT_UNIT_PRICE")));
		orderDetail.setContract_price(Double.valueOf(rs.getString("CONTRACT_PRICE")));
		return orderDetail;
	}
	
}
