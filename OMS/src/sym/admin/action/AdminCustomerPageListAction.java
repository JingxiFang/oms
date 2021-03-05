package sym.admin.action;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import sym.admin.service.impl.AdminCustomerServiceImpl;
import sym.common.action.PageListBaseServlet;

public class AdminCustomerPageListAction extends PageListBaseServlet{

	@Override
	public void initPageInforBean(HttpServletRequest request,
			HttpServletResponse response) {
		// TODO 自动生成的方法存根
		StringBuilder builder = new StringBuilder();
		//获取界面中客户名
		
		String customer_nm=request.getParameter("customer_nm"); 
	
		//获取联系电话
		String connect_kind=request.getParameter("connect_kind");
		//获取客户状态
		String is_valid=request.getParameter("is_valid_all");
		//获取客户类别
		System.out.println(customer_nm+","+connect_kind+","+is_valid);
		String[] customer_type_list = request.getParameterValues("customer_type_list");
		String customer_type_all = request.getParameter("customer_type_all");
		String customer_owner="";
		
		if(customer_type_all=="ALL"){
			builder.append("1,2,3,4");
		}
		if(customer_type_list!=null)
		{
			for(String S:customer_type_list){
				builder.append(S);
				builder.append(",");
			}
			builder.deleteCharAt(builder.length()-1);
			
		}else{
			builder.append("1,2,3,4");
		}
		
		customer_owner = builder.toString();
		
		//user_ownerF.matches(regex);
		//部门状态
	
	
		//判断"全选"是否选中，选中的话，则匹配所有，未选中的话则获取后面框中的值
		if("ALL".equals(is_valid))
		{
			is_valid="%";  //传递到数据库中进行模糊查询，匹配所有状态	
		}else 
		{
			
				is_valid=request.getParameter("is_valid");
			
		}
		//将四个参数放到hm中
		HashMap<String ,String> hm=new HashMap<String,String>();
		hm.put("customer_nm", customer_nm);
		hm.put("connect_kind", connect_kind);
		hm.put("customer_owner", customer_owner);
		
		hm.put("is_valid",is_valid);
		super.getPageInforBean().setHm(hm);
		super.setPageInforService(new AdminCustomerServiceImpl());
		super.setForward("/pages/component/admin/customerMaster.jsp");
	}
	}

