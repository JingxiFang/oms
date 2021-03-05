package sym.admin.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import sym.admin.service.impl.AdminAgencyServiceImpl;
import sym.admin.service.impl.AdminCurrencyServiceImpl;
import sym.common.action.PageListBaseServlet;

public class AdminAgencyPageListAction extends PageListBaseServlet {

	@Override
	public void initPageInforBean(HttpServletRequest request,
			HttpServletResponse response) {
		System.out.println("AdminAgencyPageListAction+++++++++++++");
				//获取界面中代理商名
				String agency_nm=request.getParameter("agency_nm"); 
				//获取业务员名
				String agency_user_nm = request.getParameter("agency_user_nm");
				//获取代理商状态
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
				hm.put("agency_nm", agency_nm);
				hm.put("agency_user_nm", agency_user_nm);
				hm.put("is_valid",is_valid);
				super.getPageInforBean().setHm(hm);
				super.setPageInforService(new AdminAgencyServiceImpl());
				super.setForward("/pages/component/admin/agencyMaster.jsp");
		
	}

}
