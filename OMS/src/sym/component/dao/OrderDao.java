package sym.component.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;

import sym.common.bean.PageInforBean;
import sym.component.bean.OrderBean;
import sym.component.bean.OrderDetailBean;
import sym.component.bean.SimpleOrderBean;

/**
 * �������ݿ�������ʽӿ�
 * 
 * @author gxk
 *
 */

public interface OrderDao {
	/**
	 * �����û��������룬�ж��û���½
	 * 
	 * @param String[]
	 * @return List<OrderBean>
	 */
	public PageInforBean<SimpleOrderBean> getPageInforSimpleOrderBean(int showCount, int currentPage, String sql);
	/**
	 * ����id�õ�order����
	 * @param orders_id
	 * @return
	 */
	public OrderBean showOrderById(int orders_id);
	
	/**
	 * ����order
	 * @param orderBean
	 */
	public int updateOrder(OrderBean orderBean);
	
	/**
	 * ���ָ��orders_id��Ӧ�Ķ�����ϸ
	 * @param orders_id
	 */
	public void clearOrderDetails(Connection con, int orders_id) throws SQLException;
	
	/**
	 * ���붩����ϸ
	 * @param orders_id
	 * @param order_detail_list
	 * @throws SQLException 
	 */
	public void insertOrderDetails(Connection conn, List<OrderDetailBean> order_detail_list, String agency_user_id, String dateStr) throws SQLException;
	
	/**
	 * ��������
	 * @param orderBean
	 * @return
	 */
	public int insertOrder(OrderBean orderBean);
	

	/**
	 * ɾ����������ϸ
	 * @param orders_id
	 * @return
	 */
	public int deleteOrder(int orders_id);
	
	/**
	 * ���ݺ�ͬ�Ż�ȡ���к�ͬ����
	 * @param contract_cd
	 * @return
	 */
	public List<OrderBean> findOrderVersionList(String contract_cd);
	
	
	
	/**
	 * ����һ����ѯsql1
	 * author yzc
	 * @param fromCount
	 * @param endCount
	 * @param queryInforMap
	 * @return
	 */
	public List getComponentPageList(int fromCount, int endCount,
			   HashMap queryInforMap);

	
	
	
	/**
	 * ����һ���ܼ�����ѯsql2
	 * @param hashMap
	 * @return
	 */
	public int getTotalNumber(HashMap<String,String> hashMap);
	
	/**
	 * �ö������߷�Ʊ�ܼ���sql3
	 * @param contract_no
	 * @return
	 */
	public int findInvoiceCnt(String contract_no);
	
	/**
	 * �Ƿ�ؿ������ѯsql7
	 * @param orders_id
	 * @return
	 */
	public String findReceivedPaymentsFlg(String orders_id);
	
	/**
	 * ɾ������sql4
	 * @param contract_no
	 * @return
	 */
	public int deleteOrder(String contract_no);
	
	/**
	 * �����汾һ����ѯsql5
	 * @param contract_no
	 * @return
	 */
	public List<OrderBean> findOrderIDList(String contract_no);
	
	
	/***
	 * ����contract_no��ȡ�汾����ߵĶ�����Ϣ
	 * �޸��� FJXxx
	 * @return �����б�
	 * @param queryInforMap
	 * @return
	 */
	public List<OrderBean> getOrderInfoList(HashMap queryInforMap); 

	/**
	 * ����һ����ѯ			
	 * @param hm
	 * @return
	 */
	List<OrderBean>	getCurrPageList	(HashMap<String,String>	hm);
	/**
	 * �޸Ķ������͵�ʱ��/Ԥ�ƻؿ���/Ԥ�ƻؿ��� 
	 * ��д�ˣ�������
	 * @return �Ƿ�ɹ�
	 */
	public boolean updateOrderPro(OrderBean order);

	


}
