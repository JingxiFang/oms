package sym.component.service;

import java.math.BigDecimal;
import java.util.List;

import sym.component.bean.OrderDetailBean;

public interface OrderDetailService {
	//���id�Ƿ����
	public int orderDetailExistCheck(BigDecimal orderDetail_id);
	
	/**
	 * ���ݺ�ͬ�Ų�ѯ����detail����
	 * @param contactNo
	 * @return
	 */
	public List<OrderDetailBean>  getOrderDetailByContactNO(String contactNo );

}
