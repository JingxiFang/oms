package sym.component.service;

import java.util.HashMap;
import java.util.List;

import sym.component.bean.InvoiceBean;
import sym.component.service.impl.OrderServiceImpl;

public interface InvoiceService {
    
	/**
	 * ���ݶ���detail��Ų��ҷ�Ʊ��Ϣ
	 * @param orderDetailID
	 * @return
	 */
	public List<InvoiceBean> getInvoiceInfoByOrderDetailId(int orderDetailID);
	
	
	/**
	 * ���ݷ�Ʊid�޸ķ�Ʊ��Ϣ
	 * @param invoiceInfo
	 * @return
	 */
	public boolean updateInvoice(InvoiceBean invoiceInfo);
	/**
	 * ���ݷ�Ʊidɾ����Ʊ��Ϣ
	 * @param invoiceInfo
	 * @return
	 */
	public boolean deleteInvoice(String invoice);
	/**
	 * ���ӷ�Ʊ��Ϣ
	 * @param invoiceInfo
	 * @return
	 */
	public boolean addInvoice(InvoiceBean invoiceInfo);
	
	
	/**
	 * �鿴��Ʊ����Ƿ��Ѿ�����
	 * @param invoiceNo
	 * @return
	 */
	public boolean isExsitInvoice(String invoiceNo);
}
