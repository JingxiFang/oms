package sym.admin.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import sym.admin.service.AdminUserService;
import sym.admin.service.impl.AdminUserServiceImpl;
import sym.common.bean.AdminUserBean;
import sym.common.bean.PageInforBean;
import sym.common.bean.SimpleAdminUserBean;
import sym.common.dto.SessionDto;

public class AdminUserAction extends HttpServlet {

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
			String method = request.getParameter("method");
			if ("insertUser".equals(method)) {
				insertUser(request, response);
			} else if ("updateUser".equals(method)) {
				updateUser(request, response);
			} else if ("checkInsert".equals(method)) {
				checkInsert(request,response);
			} else if("getAgencyUsers".equals(method)) {
				getAgencyUsers(request,response);
			}
	}
	


	public void doGet(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		doPost(request, response);
	}
	
	public void getAgencyUsers(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		PrintWriter out = response.getWriter();
		String search = request.getParameter("search");
		int currentPage = Integer.parseInt(request.getParameter("currentPage"));
		AdminUserService adminUserService = new AdminUserServiceImpl();
		PageInforBean<SimpleAdminUserBean> pageInforBean = adminUserService.getAgencyUsers(search, currentPage);
		Gson gson = new Gson();
		String j_str = gson.toJson(pageInforBean);
		out.print(j_str);
		out.flush();
		out.close();
	}
	
	public void checkInsert(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		PrintWriter out = response.getWriter();
		String user_cd = request.getParameter("user_cd");
		int check=new AdminUserServiceImpl().userExistCheck(user_cd);
		if(check>0){
			out.println(0);
		}else{
			out.println(1);
		}
		out.flush();
		out.close();
	}

	public void insertUser(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException{
		AdminUserBean adminUserBean=new AdminUserBean();
		String user_cd=request.getParameter("user_cd");
		String user_name=request.getParameter("user_name");
		String user_telephone=request.getParameter("user_telephone");
		String flg=request.getParameter("flg");
		String is_valid=request.getParameter("sex");
		
		SimpleDateFormat date = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss.SSS");
		String update_date = date.format(new Date());
		SessionDto dto = (SessionDto) request.getSession()
				.getAttribute("dto");
		String update_user_id = dto.getUser_cd();
		
		adminUserBean.setUser_cd(user_cd);
		adminUserBean.setUser_nm(user_name);
		adminUserBean.setUser_phone(user_telephone);
		adminUserBean.setUser_owner_flg(flg);
		adminUserBean.setIs_valid(is_valid);
		adminUserBean.setUpdate_date(update_date);
		adminUserBean.setUpdate_user_id(update_user_id);
		
		int check=new AdminUserServiceImpl().insertUser(adminUserBean);
		
		if(check>=1){
			request.getSession().setAttribute("rt_msg", "用户名重复，重新添加");
			
		}
		request.getRequestDispatcher("/adminUserPageListAction?method=firstPage").forward(request,
					response);
	}
	
	public void updateUser(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException{
		AdminUserBean adminUserBean=new AdminUserBean();
		String user_cd=request.getParameter("user_cd");
		String user_name=request.getParameter("user_name");
		String user_telephone=request.getParameter("user_telephone");
		String flg=request.getParameter("flg");
		String is_valid=request.getParameter("sex");
		
		SimpleDateFormat date = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss.SSS");
		String update_date = date.format(new Date());
		SessionDto dto = (SessionDto) request.getSession()
				.getAttribute("dto");
		String update_user_id = dto.getUser_cd();
		
		adminUserBean.setUser_cd(user_cd);
		adminUserBean.setUser_nm(user_name);
		adminUserBean.setUser_phone(user_telephone);
		adminUserBean.setUser_owner_flg(flg);
		adminUserBean.setIs_valid(is_valid);
		adminUserBean.setUpdate_date(update_date);
		adminUserBean.setUpdate_user_id(update_user_id);
		
		int check =new AdminUserServiceImpl().updateUser(adminUserBean);
		
		if(check>=1){
			request.getSession().setAttribute("rt_msg", "用户正在使用中，不能编辑");
			
		}
		request.getRequestDispatcher("/adminUserPageListAction?method=firstPage").forward(request,
					response);
	}

}
