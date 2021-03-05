package sym.component.dao;

import java.util.HashMap;
import java.util.List;

import sym.component.bean.InvoiceBean;

public interface InvoiceDao {

	/***
	 * 根据业务员的编号获取订单信息
	 * @param fromCount 
	 * @param endCount
	 * @param queryInforMap
	 * @return
	 */
	public List getComponentPageList(int fromCount, int endCount,
			   HashMap queryInforMap);
	/***
	 * 获取发票信息
	 * @param ORDERS_DETAIL_ID 
	 * @return
	 */
	public List getInvoiceInfoList(String ORDERS_DETAIL_ID);
	
	/**
	 * 根据订单detail编号获取发票信息
	 * @param orderDetailID
	 * @return
	 */
	public List<InvoiceBean> getInvoiceInfoByOrderDetailId(int orderDetailID);
	
	/**
	 * 根据发票id修改发票信息
	 * @param invoiceInfo
	 * @return
	 */
	public int updateInvoice(InvoiceBean invoiceInfo);
	/**
	 * 根据发票id删除发票信息
	 * @param invoiceInfo
	 * @return
	 */
	public int deleteInvoice(String invoice);
	/**
	 * 增加发票信息
	 * @param invoiceInfo
	 * @return
	 */
	public int addInvoice(InvoiceBean invoiceInfo);
	/**
	 * 查看发票编号是否已经存在
	 * @param invoiceNo
	 * @return
	 */
	public int isExsitInvoice(String invoiceNo);
}
