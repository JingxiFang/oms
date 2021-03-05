package sym.component.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import sym.common.bean.PageInforBean;
import sym.component.bean.OrderBean;
import sym.component.bean.OrderForm;
import sym.component.bean.SimpleOrderBean;

/**
 * 订单操作service类
 * 
 * @author gxk
 *
 */
public interface OrderService {
	/**
	 * order查询
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
	 * 根据id得到order对象
	 * @param orders_id
	 * @return
	 */
	public OrderBean showOrderById(int orders_id);
	
	/**
	 * 更新订单及订单明细
	 * @param orderBean
	 */
	public int updateOrder(OrderBean orderBean);

	/**
	 * 增加订单及订单明细
	 * @param orderBean
	 * @return
	 */
	public int insertOrder(OrderBean orderBean);

	/**
	 * 删除订单
	 * @param orders_id
	 * @return
	 */
	public int deleteOrder(int orders_id);
	
	/**
	 * 根据合同号获取所有合同订单
	 * @param contract_no
	 * @return
	 */
	public List<OrderBean> findOrderVersionList(String contract_no);
	/**
	 * 订单删除
	 * @param orderForm
	 * @return
	 */
	public Map<?, ?> deleteOrder(OrderBean orderForm);
	
	/**
	 * 订单查询画面初期处理
	 * @param orderForm
	 * @return
	 */
	public Map<?, ?> orderSearchIndex(OrderBean orderForm);
	
	
	/**
	 * 信息验证
	 */
	public Map<?, ?> validate(OrderForm orderForm);
	
	/**
	 * 验证订单明细信息
	 */
	public Map<?, ?> validateOrderDetail(OrderForm orderForm);
	
	
	/**
	 * 获取订单全部信息
	 * @param queryInforMap
	 * @return
	 */
	public List getOrderInfoList(HashMap queryInforMap);

	List getComponentPageList(int fromCount, int endCount, HashMap queryInforMap);

	int getTotalRecordNumber(HashMap queryInforMap);
	/**
	 * 修改订单的送电时间/预计回款月/预计回款金额
	 * @return 是否成功
	 */
	 public boolean updateOrderPro(OrderBean order);
}
