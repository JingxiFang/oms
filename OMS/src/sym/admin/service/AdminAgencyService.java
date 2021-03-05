package sym.admin.service;

import java.util.HashMap;
import java.util.List;

import sym.admin.bean.AdminAgencyBean;
import sym.admin.bean.SimpleAdminAgencyBean;
import sym.common.bean.PageInforBean;

public interface AdminAgencyService {
	//�õ�list
	public List getComponentPageList(int fromCount, int endCount, HashMap queryInforMap);
	//��¼��
	public int getTotalRecordNumber(HashMap queryInforMap);
	//����agency
	public int insertAgency(AdminAgencyBean adminAgencyBean);
	//����agency
	public int updateAgency(AdminAgencyBean adminAgencyBean);
	//���agenc�Ƿ����
	public int agencyExistCheck(String agency_cd);
	//�õ�page
	public PageInforBean<SimpleAdminAgencyBean> getAgencys(String usercd, String search, int currentPage);
}
