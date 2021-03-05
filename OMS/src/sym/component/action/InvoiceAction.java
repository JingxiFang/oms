package sym.component.action;

import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.alibaba.fastjson.JSON;




import sym.common.dto.SessionDto;
import sym.component.bean.InvoiceBean;
import sym.component.bean.OrderBean;
import sym.component.service.InvoiceService;
import sym.component.service.OrderService;
import sym.component.service.impl.InvoiceServiceImpl;
import sym.component.service.impl.OrderServiceImpl;
import sym.admin.bean.AdminUserBean;;
public class InvoiceAction extends HttpServlet {

	/**
	 * The doGet method of the servlet. <br>
	 *
	 * This method is called when a form has its tag value method equals to get.
	 * 
	 * @param request the request send by the client to the server
	 * @param response the response send by the server to the client
	 * @throws ServletException if an error occurred
	 * @throws IOException if an error occurred
	 */
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		doPost(request,response);
	}

	/**
	 * The doPost method of the servlet. <br>
	 *
	 * This method is called when a form has its tag value method equals to post.
	 * 
	 * @param request the request send by the client to the server
	 * @param response the response send by the server to the client
	 * @throws ServletException if an error occurred
	 * @throws IOException if an error occurred
	 */
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		
		//序列化
	    String jsonStr="";
		if(request.getParameter("action").equals("getInvoiceList")){
			jsonStr = getInvoiceList(request);
			response.setContentLength(jsonStr.getBytes("UTF-8").length);
			response.setContentType("application/x-json;charset=utf-8");
		    OutputStream output=response.getOutputStream();
		    output.write(jsonStr.getBytes("UTF-8"));
		    output.flush();
		}
		else if(request.getParameter("action").equals("update")){
			response.setContentType("text/plain");
			PrintWriter out=response.getWriter();
			if( updateInvoice(request)){
				out.print("1");
			}
			else{
				out.print("0");
			}
			out.flush();
			out.close();
		}
		else if(request.getParameter("action").equals("add")){
			
		}
		else if(request.getParameter("action").equals("delete")){
			response.setContentType("text/plain");
			PrintWriter out=response.getWriter();
			String invoice=request.getParameter("invoiceno");
			InvoiceService invoiceSerevice=new InvoiceServiceImpl();
			if(invoiceSerevice.deleteInvoice(invoice)){
				out.print("1");
			}
			else{
				out.print("0");
			}
			out.flush();
			out.close();
		}
		else if(request.getParameter("action").equals("save")){
			response.setContentType("text/plain");
			PrintWriter out=response.getWriter();
			//保存订单信息
			OrderBean order=new OrderBean();
			order.setEnergize_date(request.getParameter("date_power"));
			order.setExpected_payments_date2(request.getParameter("expected_payments_date2"));
			order.setExpected_payments_date3(request.getParameter("expected_payments_date3"));
			order.setExpected_payments_date4(request.getParameter("expected_payments_date4"));
			order.setExpected_payments_date5(request.getParameter("expected_payments_date5"));
			order.setExpected_payments_date6(request.getParameter("expected_payments_date6"));
			order.setExpected_payments_sum2(Double.valueOf( request.getParameter("expected_payments_sum2")));
			order.setExpected_payments_sum3(Double.valueOf( request.getParameter("expected_payments_sum3")));
			order.setExpected_payments_sum4(Double.valueOf( request.getParameter("expected_payments_sum4")));
			order.setExpected_payments_sum5(Double.valueOf( request.getParameter("expected_payments_sum5")));
			order.setExpected_payments_sum6(Double.valueOf( request.getParameter("expected_payments_sum6")));
			order.setContract_no(request.getParameter("contract_no"));
			String orderversion=request.getParameter("orders_version");
			order.setOrders_version(request.getParameter("orders_version"));
			order.setUpdate_user_id(((SessionDto)(request.getSession().getAttribute("dto"))).getUser_cd());
			OrderService orderService=new OrderServiceImpl();
			if(orderService.updateOrderPro(order)){
				out.print("1");
			}
			else{
				out.print("0");
			}
			out.flush();
			out.close();
			
		}
		else if("isExist".equals(request.getParameter("action"))){
			response.setContentType("text/plain");
			PrintWriter out=response.getWriter();
			InvoiceService invoiceService=new InvoiceServiceImpl();
			if(invoiceService.isExsitInvoice(request.getParameter("invoiceNo"))){
				out.print("1");
			}
			else{
				out.print("0");
			}
			out.flush();
			out.close();
		}
		
		
		
	}

	/**
	 * 更新发票信息
	 * @param request
	 * @return
	 */
	private boolean updateInvoice(HttpServletRequest request) {
		
		InvoiceBean invoice=new InvoiceBean();
		//获取参数信息
		invoice.setInvoice_no(request.getParameter("dialog_invoice_no"));
		invoice.setSend_date(request.getParameter("dialog_delivery_date"));
		invoice.setInvoice_date(request.getParameter("dialog_invoice_date"));
		invoice.setInvoice_unit_price(request.getParameter("dialog_invoice_unit_price"));
		invoice.setInvoice_price(request.getParameter("dialog_invoice_sunprice"));
		invoice.setInvoice_quanitity(request.getParameter("dialog_invoice_quanitity"));
		invoice.setInvoice_id(request.getParameter("invoiceID"));
		//获取当前时间
		SimpleDateFormat df=new  SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		invoice.setUpdate_date(df.format(new Date()));
		//获取更改人cd
		invoice.setUpdate_user_id(((SessionDto)request.getSession().getAttribute("dto")).getUser_cd());
		
		
		InvoiceService invoiceSerevice=new InvoiceServiceImpl();
		return invoiceSerevice.updateInvoice(invoice);
		
	}

	/**
	 * 获取每个订单详情下的发票
	 * @param request
	 * @return
	 */
	private String getInvoiceList(HttpServletRequest request) {
		String jsonStr;
		//获取
		InvoiceService invoiceSerevice=new InvoiceServiceImpl();
		String in=request.getParameter("detailID");

		List<InvoiceBean> invoiceList=invoiceSerevice.getInvoiceInfoByOrderDetailId(Integer.valueOf(request.getParameter("detailID")));
		
		
		//序列化
		jsonStr=JSON.toJSONString(invoiceList);
		return jsonStr;
	}

}
