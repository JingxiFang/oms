package sym.admin.action;

import java.util.HashMap;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import sym.admin.service.impl.AdminCurrencyServiceImpl;
import sym.common.action.PageListBaseServlet;

public class AdminCurrencyPageListAction extends PageListBaseServlet {
    
	
	/**
	 * 1、初始化PageInforBean，封装客户端传递的检索条件信息；
	 * 2、初始化forward和pageInforService；
	 * listBean 和 forward
	 * @param request
	 * @param response
	 * @throws ServletException
	 * @throws java.io.IOException
	 */
	public void initPageInforBean(HttpServletRequest request, HttpServletResponse response) {
		//获取界面中货币名
		String currency_nm=request.getParameter("currency_nm"); 
		//获取货币状态
		String is_valid=request.getParameter("is_valid_all");
		
		//判断"全选"是否选中，选中的话，则匹配所有，未选中的话则获取后面框中的值
		if("ALL".equals(is_valid))
		{
			is_valid="%";  //传递到数据库中进行模糊查询，匹配所有状态	
		}else
		{
			is_valid=request.getParameter("is_valid");
		}
		//将两个参数放到hm中
		HashMap<String ,String> hm=new HashMap<String,String>();
		hm.put("currency_nm", currency_nm);
		hm.put("is_valid",is_valid);
		super.getPageInforBean().setHm(hm);
		super.setPageInforService(new AdminCurrencyServiceImpl());
		super.setForward("/pages/component/admin/currencyMaster.jsp");
	}
  
}
