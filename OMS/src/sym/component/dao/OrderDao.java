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
 * 订单数据库操作访问接口
 * 
 * @author gxk
 *
 */

public interface OrderDao {
	/**
	 * 根据用户名和密码，判断用户登陆
	 * 
	 * @param String[]
	 * @return List<OrderBean>
	 */
	public PageInforBean<SimpleOrderBean> getPageInforSimpleOrderBean(int showCount, int currentPage, String sql);
	/**
	 * 根据id得到order对象
	 * @param orders_id
	 * @return
	 */
	public OrderBean showOrderById(int orders_id);
	
	/**
	 * 更新order
	 * @param orderBean
	 */
	public int updateOrder(OrderBean orderBean);
	
	/**
	 * 清除指定orders_id对应的订单明细
	 * @param orders_id
	 */
	public void clearOrderDetails(Connection con, int orders_id) throws SQLException;
	
	/**
	 * 插入订单明细
	 * @param orders_id
	 * @param order_detail_list
	 * @throws SQLException 
	 */
	public void insertOrderDetails(Connection conn, List<OrderDetailBean> order_detail_list, String agency_user_id, String dateStr) throws SQLException;
	
	/**
	 * 新增订单
	 * @param orderBean
	 * @return
	 */
	public int insertOrder(OrderBean orderBean);
	

	/**
	 * 删除订单及明细
	 * @param orders_id
	 * @return
	 */
	public int deleteOrder(int orders_id);
	
	/**
	 * 根据合同号获取所有合同订单
	 * @param contract_cd
	 * @return
	 */
	public List<OrderBean> findOrderVersionList(String contract_cd);
	
	
	
	/**
	 * 订单一览查询sql1
	 * author yzc
	 * @param fromCount
	 * @param endCount
	 * @param queryInforMap
	 * @return
	 */
	public List getComponentPageList(int fromCount, int endCount,
			   HashMap queryInforMap);

	
	
	
	/**
	 * 订单一览总件数查询sql2
	 * @param hashMap
	 * @return
	 */
	public int getTotalNumber(HashMap<String,String> hashMap);
	
	/**
	 * 该订单开具发票总件数sql3
	 * @param contract_no
	 * @return
	 */
	public int findInvoiceCnt(String contract_no);
	
	/**
	 * 是否回款结束查询sql7
	 * @param orders_id
	 * @return
	 */
	public String findReceivedPaymentsFlg(String orders_id);
	
	/**
	 * 删除订单sql4
	 * @param contract_no
	 * @return
	 */
	public int deleteOrder(String contract_no);
	
	/**
	 * 订单版本一览查询sql5
	 * @param contract_no
	 * @return
	 */
	public List<OrderBean> findOrderIDList(String contract_no);
	
	
	/***
	 * 根据contract_no获取版本号最高的订单信息
	 * 修改者 FJXxx
	 * @return 订单列表
	 * @param queryInforMap
	 * @return
	 */
	public List<OrderBean> getOrderInfoList(HashMap queryInforMap); 

	/**
	 * 订单一览查询			
	 * @param hm
	 * @return
	 */
	List<OrderBean>	getCurrPageList	(HashMap<String,String>	hm);
	/**
	 * 修改订单的送电时间/预计回款月/预计回款金额 
	 * 编写人：方静熙
	 * @return 是否成功
	 */
	public boolean updateOrderPro(OrderBean order);

	


}
