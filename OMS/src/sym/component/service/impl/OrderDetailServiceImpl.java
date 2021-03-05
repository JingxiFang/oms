package sym.component.service.impl;

import java.math.BigDecimal;
import java.util.List;

import sym.component.bean.OrderDetailBean;
import sym.component.dao.OrderDao;
import sym.component.dao.OrderDetailDao;
import sym.component.dao.impl.OrderDetailDaoImpl;
import sym.component.service.OrderDetailService;

public class OrderDetailServiceImpl implements OrderDetailService{
	private OrderDetailDao orderDetailDao = new OrderDetailDaoImpl();
	@Override
	public int orderDetailExistCheck(BigDecimal orderDetail_id) {
		return orderDetailDao.orderDetailExistCheck(orderDetail_id);
	}
	@Override
	public List<OrderDetailBean> getOrderDetailByContactNO(String contactNo) {
		// TODO Auto-generated method stub
		OrderDetailDao orderDetailDao=new OrderDetailDaoImpl();
		return orderDetailDao.getOrderDetailByContactNO(contactNo);
	}	
	
}
