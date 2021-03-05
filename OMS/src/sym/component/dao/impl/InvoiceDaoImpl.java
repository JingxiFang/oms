package sym.component.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import sym.common.util.ConnectionPool;
import sym.common.util.FieldCheck;
import sym.component.bean.InvoiceBean;
import sym.component.bean.OrderBean;
import sym.component.dao.InvoiceDao;

public class InvoiceDaoImpl implements InvoiceDao {
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	@Override
	public List getComponentPageList(int fromCount, int endCount,
			HashMap queryInforMap) {
		return null;
		
	}

	@Override
	public List getInvoiceInfoList(String ORDERS_DETAIL_ID) {
		// TODO Auto-generated method stub
		return null;
	}
	@Override
	public List<InvoiceBean> getInvoiceInfoByOrderDetailId(int orderDetailID) {
		// TODO Auto-generated method stub
		conn = ConnectionPool.getConn();
		
		
		List<InvoiceBean> detailInfoList=new ArrayList<InvoiceBean>();
		
		if(!"".equals(orderDetailID)){
			try{
				String sql="select INVOICE_ID, SEND_DATE, INVOICE_NO, INVOICE_TYPE," //
						+" INVOICE_DATE, INVOICE_UNIT_PRICE, INVOICE_QUANITITY, INVOICE_PRICE" //
						+" from S_INVOICE where ORDERS_DETAIL_ID=?";
				
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, orderDetailID );
				
				rs = pstmt.executeQuery();
				while (rs.next()) {
					InvoiceBean invoiceInfo=new InvoiceBean();
					invoiceInfo.setInvoice_id(rs.getString("INVOICE_ID"));
					invoiceInfo.setSend_date(rs.getString("SEND_DATE"));
					invoiceInfo.setInvoice_no(rs.getString("INVOICE_NO"));
					invoiceInfo.setInvoice_type(rs.getString("INVOICE_TYPE"));
					invoiceInfo.setInvoice_date(rs.getString("INVOICE_DATE"));
					invoiceInfo.setInvoice_unit_price(rs.getString("INVOICE_UNIT_PRICE"));
					invoiceInfo.setInvoice_quanitity(rs.getString("INVOICE_QUANITITY"));
					invoiceInfo.setInvoice_price(rs.getString("INVOICE_PRICE"));
					detailInfoList.add(invoiceInfo);
				}

			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				ConnectionPool.close(pstmt, rs, conn);
			}
		}
		return detailInfoList;
	}

	@Override
	public int updateInvoice(InvoiceBean invoiceInfo) {
		// TODO Auto-generated method stub
		
		conn = ConnectionPool.getConn();
		int result=0;
		try{
			String sql="update S_INVOICE set INVOICE_NO=?,SEND_DATE=?,INVOICE_DATE=?, INVOICE_UNIT_PRICE=?," //
					+"INVOICE_QUANITITY=?,INVOICE_PRICE=?,UPDATE_DATE=?,UPDATE_USER_ID=? where INVOICE_ID=?";
			
			pstmt = conn.prepareStatement(sql);
			//填充占位符
			pstmt.setString(1, invoiceInfo.getInvoice_no());
			pstmt.setString(2, invoiceInfo.getSend_date());
			pstmt.setString(3, invoiceInfo.getInvoice_date());
			pstmt.setString(4, invoiceInfo.getInvoice_unit_price());
			pstmt.setString(5,invoiceInfo.getInvoice_quanitity() );
			pstmt.setString(6, invoiceInfo.getInvoice_price());
			pstmt.setString(7, invoiceInfo.getUpdate_date());
			pstmt.setString(8, invoiceInfo.getUpdate_user_id());
			pstmt.setString(9, invoiceInfo.getInvoice_id());
			
			result = pstmt.executeUpdate();//执行成功将返回大于0的数
		
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			ConnectionPool.close(pstmt, rs, conn);
		}
		
		return result;
		
		
	}

	@Override
	public int deleteInvoice(String invoice) {
		// TODO Auto-generated method stub
		conn = ConnectionPool.getConn();
		int result=0;
		try{
			String sql=" delete from S_INVOICE where INVOICE_NO=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, Integer.valueOf(invoice));//填充占位符
				
			result = pstmt.executeUpdate();//执行成功将返回大于0的数
		
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			ConnectionPool.close(pstmt, rs, conn);
		}
		
		return result;
	}

	@Override
	public int addInvoice(InvoiceBean invoiceInfo) {
		// TODO Auto-generated method stub
		
		conn = ConnectionPool.getConn();
		int result=0;
		try{
			String sql="insert into S_INVOICE (ORDERS_DETAIL_ID, SEND_DATE, INVOICE_NO, INVOICE_TYPE, " +
					"INVOICE_DATE, INVOICE_UNIT_PRICE, INVOICE_QUANITITY, INVOICE_PRICE) value(?,?,?,1,?,?,?,?)";
			
			pstmt = conn.prepareStatement(sql);
			//填充占位符
			pstmt.setInt(1, invoiceInfo.getOrder_detail_id());
			pstmt.setString(2, invoiceInfo.getSend_date());
			pstmt.setString(3, invoiceInfo.getInvoice_no());
			pstmt.setString(4, invoiceInfo.getInvoice_date());
			pstmt.setString(5, invoiceInfo.getInvoice_unit_price());
			pstmt.setString(6,invoiceInfo.getInvoice_quanitity() );
			pstmt.setString(7, invoiceInfo.getInvoice_price());
	
			result = pstmt.executeUpdate();//执行成功将返回大于0的数
		
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			ConnectionPool.close(pstmt, rs, conn);
		}
		
		return result;
		
	}
	
	public int isExsitInvoice(String invoiceNo){

		int count=0;
		try{
			conn = ConnectionPool.getConn();
		
			String sql="select count(*) as con from S_INVOICE where INVOICE_NO=?";
			pstmt = conn.prepareStatement(sql);
			//填充占位符
			pstmt.setString(1, invoiceNo);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				count=rs.getInt("con");
			}
		
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			ConnectionPool.close(pstmt, rs, conn);
		}
		return count;
	
	}
}