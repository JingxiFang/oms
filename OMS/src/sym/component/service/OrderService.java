package sym.component.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import sym.common.bean.PageInforBean;
import sym.component.bean.OrderBean;
import sym.component.bean.OrderForm;
import sym.component.bean.SimpleOrderBean;

/**
 * ��������service��
 * 
 * @author gxk
 *
 */
public interface OrderService {
	/**
	 * order��ѯ
	 * @param showCount
	 * @param currentPage
	 * @param orderBy
	 * @param order
	 * @param contract_no
	 * @param agency_user_nm
	 * @param customer_nm
	 * @param project_nm
	 * @param types
	 * @param back_sections
	 * @return
	 */
	public PageInforBean<SimpleOrderBean> getPageInforSimpleOrderBean(int showCount,int currentPage, String orderBy, String order, String contract_no, String agency_user_nm, String customer_nm,
			String project_nm, List<String> types, List<String> back_sections);
	
	/**
	 * ����id�õ�order����
	 * @param orders_id
	 * @return
	 */
	public OrderBean showOrderById(int orders_id);
	
	/**
	 * ���¶�����������ϸ
	 * @param orderBean
	 */
	public int updateOrder(OrderBean orderBean);

	/**
	 * ���Ӷ�����������ϸ
	 * @param orderBean
	 * @return
	 */
	public int insertOrder(OrderBean orderBean);

	/**
	 * ɾ������
	 * @param orders_id
	 * @return
	 */
	public int deleteOrder(int orders_id);
	
	/**
	 * ���ݺ�ͬ�Ż�ȡ���к�ͬ����
	 * @param contract_no
	 * @return
	 */
	public List<OrderBean> findOrderVersionList(String contract_no);
	/**
	 * ����ɾ��
	 * @param orderForm
	 * @return
	 */
	public Map<?, ?> deleteOrder(OrderBean orderForm);
	
	/**
	 * ������ѯ������ڴ���
	 * @param orderForm
	 * @return
	 */
	public Map<?, ?> orderSearchIndex(OrderBean orderForm);
	
	
	/**
	 * ��Ϣ��֤
	 */
	public Map<?, ?> validate(OrderForm orderForm);
	
	/**
	 * ��֤������ϸ��Ϣ
	 */
	public Map<?, ?> validateOrderDetail(OrderForm orderForm);
	
	
	/**
	 * ��ȡ����ȫ����Ϣ
	 * @param queryInforMap
	 * @return
	 */
	public List getOrderInfoList(HashMap queryInforMap);

	List getComponentPageList(int fromCount, int endCount, HashMap queryInforMap);

	int getTotalRecordNumber(HashMap queryInforMap);
	/**
	 * �޸Ķ������͵�ʱ��/Ԥ�ƻؿ���/Ԥ�ƻؿ���
	 * @return �Ƿ�ɹ�
	 */
	 public boolean updateOrderPro(OrderBean order);
}
