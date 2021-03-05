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

import sym.admin.bean.AdminAgencyBean;
import sym.admin.bean.AdminCurrencyBean;
import sym.admin.bean.SimpleAdminAgencyBean;
import sym.admin.service.AdminAgencyService;
import sym.admin.service.AdminUserService;
import sym.admin.service.impl.AdminAgencyServiceImpl;
import sym.admin.service.impl.AdminCurrencyServiceImpl;
import sym.admin.service.impl.AdminUserServiceImpl;
import sym.common.bean.AdminUserBean;
import sym.common.bean.PageInforBean;
import sym.common.bean.SimpleAdminUserBean;
import sym.common.dto.SessionDto;

public class AdminAgencyAction extends HttpServlet {

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String method = request.getParameter("method");
		if ("insertAgency".equals(method)) {
			insertAgency(request, response);
		} else if ("updateAgency".equals(method)) {
			updateAgency(request, response);
		} else if ("checkInsert".equals(method)) {
			checkInsert(request,response);
		} else if("getAgencys".equals(method)) {
			getAgencys(request,response);
		}
	}
	private void getAgencys(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		PrintWriter out = response.getWriter();
		String search = request.getParameter("search");
		int currentPage = Integer.parseInt(request.getParameter("currentPage"));
		String usercd = request.getParameter("usercd");
		AdminAgencyService adminAgencyService = new AdminAgencyServiceImpl();
		PageInforBean<SimpleAdminAgencyBean> pageInforBean = adminAgencyService.getAgencys(usercd,search, currentPage);
		Gson gson = new Gson();
		String j_str = gson.toJson(pageInforBean);
		out.print(j_str);
		out.flush();
		out.close();
		
	}
	private void checkInsert(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException{
		PrintWriter out = response.getWriter();
		String agency_cd = request.getParameter("agency_cd");
		int check=new AdminAgencyServiceImpl().agencyExistCheck(agency_cd);
		System.out.println(check);
		if(check>0){
			out.println(0);
		}else{
			out.println(1);
		}
		out.flush();
		out.close();
		
	}
	private void insertAgency(HttpServletRequest request,
			HttpServletResponse response)  throws ServletException, IOException{
		AdminAgencyBean adminAgencyBean = new AdminAgencyBean();
		String agency_cd = request.getParameter("agency_cd");
		String agency_name = request.getParameter("agency_name");
		String agency_user_name = request.getParameter("agency_user_name");
		String is_vaild = request.getParameter("sex");

		SimpleDateFormat date = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss.SSS");
		String update_date = date.format(new Date());
		SessionDto dto =  (SessionDto) request.getSession().getAttribute("dto");
		String update_user_id = dto.getUser_cd();
		
		adminAgencyBean.setAgency_cd(agency_cd);
		adminAgencyBean.setAgency_nm(agency_name);
		adminAgencyBean.setAgency_user_nm(agency_user_name);
		adminAgencyBean.setIs_valid(is_vaild);
		adminAgencyBean.setUpdate_agency_id(update_user_id);
		adminAgencyBean.setUpdate_date(update_date);
		
		new AdminAgencyServiceImpl().insertAgency(adminAgencyBean);
		request.getRequestDispatcher("/adminAgencyPageListAction?method=firstPage").forward(request,
				response);
	}
	
	
	private void updateAgency(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		
		AdminAgencyBean adminAgencyBean = new AdminAgencyBean();
		String agency_cd = request.getParameter("agency_cd");
		String agency_name = request.getParameter("agency_name");
		String agency_user_name = request.getParameter("agency_user_name");
		String is_vaild = request.getParameter("sex");

		System.out.println("agency_cd:"+agency_cd);
		SimpleDateFormat date = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss.SSS");
		String update_date = date.format(new Date());
		SessionDto dto =  (SessionDto) request.getSession().getAttribute("dto");
		String update_user_id = dto.getUser_cd();

		adminAgencyBean.setAgency_cd(agency_cd);
		adminAgencyBean.setAgency_nm(agency_name);
		adminAgencyBean.setAgency_user_nm(agency_user_name);
		adminAgencyBean.setIs_valid(is_vaild);
		adminAgencyBean.setUpdate_agency_id(update_user_id);
		adminAgencyBean.setUpdate_date(update_date);
		
		int rt=new AdminAgencyServiceImpl().updateAgency(adminAgencyBean);
		if(rt==1){
			request.getSession().setAttribute("rt_msg", "正在被使用，无法更新修改");
			
		}
		request.getRequestDispatcher("/adminAgencyPageListAction?method=firstPage").forward(request,
					response);
	}


	public void doGet(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		doPost(request, response);
	}

}
