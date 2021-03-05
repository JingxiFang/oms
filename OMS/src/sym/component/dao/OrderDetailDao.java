package sym.component.dao;

import java.math.BigDecimal;
import java.util.List;

import sym.component.bean.OrderDetailBean;

public interface OrderDetailDao {
	//验证id是否存在
	public int orderDetailExistCheck(BigDecimal orderDetail_id);
	/**
	 * 删除订单明细信息sql6
	 * @param orders_id
	 * @return
	 */
	public int deleteOrderDetail(String orders_id); 

	/**
	 * 根据合同号查询订单detail详情
	 * @param contactNo
	 * @return
	 */
	public List<OrderDetailBean>  getOrderDetailByContactNO(String contactNo );
	
	
}
