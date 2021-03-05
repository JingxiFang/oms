package sym.component.dao;

import java.util.HashMap;
import java.util.List;

import sym.component.bean.InvoiceBean;

public interface InvoiceDao {

	/***
	 * ����ҵ��Ա�ı�Ż�ȡ������Ϣ
	 * @param fromCount 
	 * @param endCount
	 * @param queryInforMap
	 * @return
	 */
	public List getComponentPageList(int fromCount, int endCount,
			   HashMap queryInforMap);
	/***
	 * ��ȡ��Ʊ��Ϣ
	 * @param ORDERS_DETAIL_ID 
	 * @return
	 */
	public List getInvoiceInfoList(String ORDERS_DETAIL_ID);
	
	/**
	 * ���ݶ���detail��Ż�ȡ��Ʊ��Ϣ
	 * @param orderDetailID
	 * @return
	 */
	public List<InvoiceBean> getInvoiceInfoByOrderDetailId(int orderDetailID);
	
	/**
	 * ���ݷ�Ʊid�޸ķ�Ʊ��Ϣ
	 * @param invoiceInfo
	 * @return
	 */
	public int updateInvoice(InvoiceBean invoiceInfo);
	/**
	 * ���ݷ�Ʊidɾ����Ʊ��Ϣ
	 * @param invoiceInfo
	 * @return
	 */
	public int deleteInvoice(String invoice);
	/**
	 * ���ӷ�Ʊ��Ϣ
	 * @param invoiceInfo
	 * @return
	 */
	public int addInvoice(InvoiceBean invoiceInfo);
	/**
	 * �鿴��Ʊ����Ƿ��Ѿ�����
	 * @param invoiceNo
	 * @return
	 */
	public int isExsitInvoice(String invoiceNo);
}
