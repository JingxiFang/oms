package sym.common.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import sym.common.bean.AdminUserBean;
import sym.common.bean.AdminUserPasswordBean;
import sym.common.dto.SessionDto;
import sym.common.service.ResetPasswordService;
import sym.common.service.impl.LoginServiceImpl;
import sym.common.service.impl.ResetPasswordServiceImpl;

public class ResetPasswordAction extends HttpServlet {

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request, response);
	}

	
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session=request.getSession();
		SessionDto dto=(SessionDto)session.getAttribute("dto");
		String user_cd=dto.getUser_cd();
		String user_pswd=request.getParameter("password_old");
		String new_pswd=request.getParameter("password_2");
		
	
		AdminUserPasswordBean adminUserPasswordBean=new AdminUserPasswordBean();
		adminUserPasswordBean.setUser_cd(user_cd);
		adminUserPasswordBean.setUser_pswd(user_pswd);
		adminUserPasswordBean.setNew_pswd(new_pswd);
		new ResetPasswordServiceImpl().updatePassword(adminUserPasswordBean);
		
		response.sendRedirect("loginAction?method=logout");
	}
	
}
