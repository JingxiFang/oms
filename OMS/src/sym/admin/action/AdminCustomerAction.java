package sym.admin.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import sym.admin.bean.AdminCustomerBean;
import sym.admin.bean.SimpleAdminAgencyBean;
import sym.admin.bean.SimpleAdminCustomerBean;
import sym.admin.service.AdminAgencyService;
import sym.admin.service.AdminCustomerService;
import sym.admin.service.impl.AdminAgencyServiceImpl;
import sym.admin.service.impl.AdminCustomerServiceImpl;
import sym.admin.service.impl.AdminUserServiceImpl;
import sym.common.bean.AdminUserBean;
import sym.common.bean.PageInforBean;
import sym.common.dto.SessionDto;

public class AdminCustomerAction extends HttpServlet {

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		doPost(request, response);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String method=request.getParameter("method");
		if ("insertCustomer".equals(method)) {
			insertCustomer(request, response);
		} else if ("updateCustomer".equals(method)) {
			updateCustomer(request, response);
		} else if("getCustomers".equals(method)) {
			getCustomers(request,response);
		}else if("checkInsert".equals(method)) {
			checkInsert(request,response);
		}
	}
	
	private void checkInsert(HttpServletRequest request,HttpServletResponse response) 
			throws ServletException, IOException{
		PrintWriter out = response.getWriter();
		String customer_cd = request.getParameter("customer_cd");
		int check=new AdminCustomerServiceImpl().customerExistCheck(customer_cd);
		if(check>0){
			out.println(0);
		}else{
			out.println(1);
		}
		out.flush();
		out.close();
	}

	public void getCustomers(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		PrintWriter out = response.getWriter();
		String search = request.getParameter("search");
		int currentPage = Integer.parseInt(request.getParameter("currentPage"));
		String customerType = request.getParameter("customerType");
		AdminCustomerService adminCustomerService = new AdminCustomerServiceImpl();
		PageInforBean<SimpleAdminCustomerBean> pageInforBean = adminCustomerService.getCustomers(customerType,search, currentPage);
		Gson gson = new Gson();
		String j_str = gson.toJson(pageInforBean);
		out.print(j_str);
		out.flush();
		out.close();
	}

	public void insertCustomer(HttpServletRequest request,HttpServletResponse response) 
			throws ServletException, IOException {
		AdminCustomerBean adminCustomerBean=new AdminCustomerBean();
		String customer_cd=request.getParameter("customer_cd");
		String customer_nm=request.getParameter("customer_name");
		String address=request.getParameter("address");
		String connect_kind=request.getParameter("connected_kind");
		String customer_type=request.getParameter("customer_type");
		String is_valid=request.getParameter("sex");
		
		SimpleDateFormat date = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss.SSS");
		String update_date = date.format(new Date());
		SessionDto dto = (SessionDto) request.getSession()
				.getAttribute("dto");
		String update_user_id = dto.getUser_cd();
		
		adminCustomerBean.setCustomer_cd(customer_cd);
		adminCustomerBean.setCustomer_nm(customer_nm);
		adminCustomerBean.setAddress(address);
		adminCustomerBean.setConnect_kind(connect_kind);
		adminCustomerBean.setCustomer_type(customer_type);
		adminCustomerBean.setIs_valid(is_valid);
		adminCustomerBean.setUpdate_date(update_date);
		adminCustomerBean.setUpdate_user_id(update_user_id);
		
		int check=new AdminCustomerServiceImpl().insertCustomer(adminCustomerBean);
		
		if(check>=1){
			request.getSession().setAttribute("rt_msg", "客户名重复，重新添加");
			
		}
		request.getRequestDispatcher("/adminCustomerPageListAction?method=firstPage").forward(request,
					response);
	}
	
	public void updateCustomer(HttpServletRequest request,HttpServletResponse response) 
			throws ServletException, IOException {
		AdminCustomerBean adminCustomerBean=new AdminCustomerBean();
		String customer_cd=request.getParameter("customer_cd");
		String customer_nm=request.getParameter("customer_name");
		String address=request.getParameter("address");
		String connect_kind=request.getParameter("connected_kind");
		String customer_type=request.getParameter("customer_type");
		String is_valid=request.getParameter("sex");
		
		SimpleDateFormat date = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss.SSS");
		String update_date = date.format(new Date());
		SessionDto dto = (SessionDto) request.getSession().getAttribute("dto");
		String update_user_id = dto.getUser_cd();
		
		adminCustomerBean.setCustomer_cd(customer_cd);
		adminCustomerBean.setCustomer_nm(customer_nm);
		adminCustomerBean.setAddress(address);
		adminCustomerBean.setConnect_kind(connect_kind);
		adminCustomerBean.setCustomer_type(customer_type);
		adminCustomerBean.setIs_valid(is_valid);
		adminCustomerBean.setUpdate_date(update_date);
		adminCustomerBean.setUpdate_user_id(update_user_id);
		
		int check = new AdminCustomerServiceImpl().updateCustomer(adminCustomerBean);
		
		if(check>=1){
			request.getSession().setAttribute("rt_msg", "当前客户有业务，重新添加");
		}
		request.getRequestDispatcher("/adminCustomerPageListAction?method=firstPage").forward(request,
					response);
	}
}
