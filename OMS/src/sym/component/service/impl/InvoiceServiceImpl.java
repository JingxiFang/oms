package sym.component.service.impl;

import java.util.HashMap;
import java.util.List;

import sym.common.service.PageInforService;
import sym.component.bean.InvoiceBean;
import sym.component.dao.InvoiceDao;
import sym.component.dao.OrderDetailDao;
import sym.component.dao.impl.InvoiceDaoImpl;
import sym.component.dao.impl.OrderDetailDaoImpl;
import sym.component.service.InvoiceService;
import sym.component.service.OrderService;

public class InvoiceServiceImpl extends PageInforService implements InvoiceService {

	@Override
	public int getTotalRecordNumber(HashMap queryInforMap) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public List getComponentPageList(int fromCount, int endCount,
			HashMap queryInforMap) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<InvoiceBean> getInvoiceInfoByOrderDetailId(int orderDetailID) {
		// TODO Auto-generated method stub
		InvoiceDao invoiceDao=new InvoiceDaoImpl();
		return invoiceDao.getInvoiceInfoByOrderDetailId(orderDetailID);
	}

	@Override
	public boolean updateInvoice(InvoiceBean invoiceInfo) {
		// TODO Auto-generated method stub
		InvoiceDao invoiceDao=new InvoiceDaoImpl();
		return invoiceDao.updateInvoice(invoiceInfo)>0;
	}

	@Override
	public boolean deleteInvoice(String invoice) {
		// TODO Auto-generated method stub
		InvoiceDao invoiceDao=new InvoiceDaoImpl();
		return invoiceDao.deleteInvoice(invoice)>0;
	}

	@Override
	public boolean addInvoice(InvoiceBean invoiceInfo) {
		// TODO Auto-generated method stub
		InvoiceDao invoiceDao=new InvoiceDaoImpl();
		return invoiceDao.addInvoice(invoiceInfo)>0;
	}

	@Override
	public boolean isExsitInvoice(String invoiceNo) {
		// TODO Auto-generated method stub
		InvoiceDao invoiceDao=new InvoiceDaoImpl();
		return invoiceDao.isExsitInvoice(invoiceNo)>0;
	}

	

}
