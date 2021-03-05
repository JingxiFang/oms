package sym.common.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import sym.common.bean.AdminUserBean;
import sym.common.dto.SessionDto;
import sym.common.service.impl.LoginServiceImpl;

/**
 * �û���¼�Ŀ��Ʋ㴦��
 * 
 * @author guojl
 * @version 2014-08-07
 */
public class LoginAction extends HttpServlet {
	
	/**
	 * doPost����
	 */
	@Override
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String method = request.getParameter("method");
		if ("login".equals(method)) {
			doLogin(request, response);
		} else if ("logout".equals(method)) {
			doLogout(request, response);
		} else if ("main".equals(method)) {
			doMain(request, response);
		} else if ("resetPassword".equals(method)) {
			doResetPassword(request, response);
		}
	}

	/**
	 * doGet����
	 */
	@Override
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	private void doResetPassword(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		PrintWriter out = response.getWriter();

		SessionDto dto = (SessionDto) request.getSession().getAttribute("dto");
		String password = request.getParameter("password");
		boolean b = new LoginServiceImpl().isUserPassword(dto.getUser_cd(), password);
		out.println(b);
	}

	/**
	 * �û���¼ʱ��֤�û���������
	 * 
	 * @param request
	 * @param response
	 * @throws ServletException
	 * @throws IOException
	 */
	public void doLogin(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// ��ȡ���ύ���û���������
		String user_cd = request.getParameter("user[cd]");
		String user_pswd = request.getParameter("user[password]");

		boolean bool = new LoginServiceImpl().findUser(user_cd, user_pswd);

		if (bool) {
			// boolΪtrue����ʾ�û���������ȷ�������LoginService��findUserDefualt������ȡ�û���Ϣ����ŵ�session�б���
			AdminUserBean adminUserBean = new LoginServiceImpl().findUserDefault(user_cd);

			// ��adminUserBean���󱣴浽session��
			HttpSession session = request.getSession();
			SessionDto dto = new SessionDto();
			//System.out.println(adminUserBean.getUser_cd());
			dto.setUser_cd(adminUserBean.getUser_cd());
			dto.setUser_nm(adminUserBean.getUser_nm());
			String str=adminUserBean.getUser_owner_flg();
			dto.setUser_owner_flg(adminUserBean.getUser_owner_flg());
			session.setAttribute("dto", dto);
			main(dto, request, response);
		} else {
			request.setAttribute("errMsg", "�û������������");
			request.getRequestDispatcher("pages/login.jsp").forward(request, response);
		}

	}

	/**
	 * �ǳ�
	 * @param request
	 * @param response
	 * @throws ServletException
	 * @throws IOException
	 */
	public void doLogout(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession();
		session.invalidate();
		response.sendRedirect("pages/login.jsp");
	}

	/**
	 * �������˵�
	 * @param request
	 * @param response
	 * @throws ServletException
	 * @throws IOException
	 */
	public void doMain(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		HttpSession session = request.getSession();
		SessionDto dto = (SessionDto) session.getAttribute("dto");
		main(dto, request, response);
	}

	/**
	 *  �ж��û�Ȩ�ޣ�ת����Ӧ�����˵�ҳ��
	 * @param dto
	 * @param request
	 * @param response
	 * @throws ServletException
	 * @throws IOException
	 */
	public void main(SessionDto dto, HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		if ("M".equals(dto.getUser_owner_flg())) {
			response.sendRedirect("pages/menu/mainMenuG.jsp");
		} else if ("S".equals(dto.getUser_owner_flg())) {
			response.sendRedirect("pages/menu/mainMenuY.jsp");
		} else if ("F".equals(dto.getUser_owner_flg())) {
			response.sendRedirect("pages/menu/mainMenuC.jsp");
		}
	}
}
