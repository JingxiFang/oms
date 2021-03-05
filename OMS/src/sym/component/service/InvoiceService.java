package sym.component.service;

import java.util.HashMap;
import java.util.List;

import sym.component.bean.InvoiceBean;
import sym.component.service.impl.OrderServiceImpl;

public interface InvoiceService {
    
	/**
	 * 根据订单detail编号查找发票信息
	 * @param orderDetailID
	 * @return
	 */
	public List<InvoiceBean> getInvoiceInfoByOrderDetailId(int orderDetailID);
	
	
	/**
	 * 根据发票id修改发票信息
	 * @param invoiceInfo
	 * @return
	 */
	public boolean updateInvoice(InvoiceBean invoiceInfo);
	/**
	 * 根据发票id删除发票信息
	 * @param invoiceInfo
	 * @return
	 */
	public boolean deleteInvoice(String invoice);
	/**
	 * 增加发票信息
	 * @param invoiceInfo
	 * @return
	 */
	public boolean addInvoice(InvoiceBean invoiceInfo);
	
	
	/**
	 * 查看发票编号是否已经存在
	 * @param invoiceNo
	 * @return
	 */
	public boolean isExsitInvoice(String invoiceNo);
}
