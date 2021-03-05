package sym.component.dao;

import java.math.BigDecimal;
import java.util.List;

import sym.component.bean.OrderDetailBean;

public interface OrderDetailDao {
	//��֤id�Ƿ����
	public int orderDetailExistCheck(BigDecimal orderDetail_id);
	/**
	 * ɾ��������ϸ��Ϣsql6
	 * @param orders_id
	 * @return
	 */
	public int deleteOrderDetail(String orders_id); 

	/**
	 * ���ݺ�ͬ�Ų�ѯ����detail����
	 * @param contactNo
	 * @return
	 */
	public List<OrderDetailBean>  getOrderDetailByContactNO(String contactNo );
	
	
}
