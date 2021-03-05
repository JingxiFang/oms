package sym.component.service;

import java.math.BigDecimal;
import java.util.List;

import sym.component.bean.OrderDetailBean;

public interface OrderDetailService {
	//检查id是否存在
	public int orderDetailExistCheck(BigDecimal orderDetail_id);
	
	/**
	 * 根据合同号查询订单detail详情
	 * @param contactNo
	 * @return
	 */
	public List<OrderDetailBean>  getOrderDetailByContactNO(String contactNo );

}
