package sym.admin.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import sym.admin.bean.AdminCurrencyBean;
import sym.admin.dao.AdminCurrencyDao;
import sym.admin.dao.impl.AdminCurrencyDaoImpl;
import sym.admin.service.AdminCurrencyService;
import sym.common.service.PageInforService;

public class AdminCurrencyServiceImpl extends PageInforService implements  AdminCurrencyService{


	@Override
	public List getComponentPageList(int fromCount, int endCount,
			HashMap queryInforMap) {
		 AdminCurrencyDao  adminCurrencyDao = new  AdminCurrencyDaoImpl();
		return adminCurrencyDao.getComponentPageList(fromCount, endCount, queryInforMap);
	}

	@Override
	public int getTotalRecordNumber(HashMap queryInforMap) {
		AdminCurrencyDao  adminCurrencyDao = new  AdminCurrencyDaoImpl();
		
		return adminCurrencyDao.getTotalRecordNumber(queryInforMap);
	}

	public int insertCurrency(AdminCurrencyBean adminCurrencyBean) {
		AdminCurrencyDao adminCurrencyDao=new AdminCurrencyDaoImpl();
		
		return adminCurrencyDao.insertCurrency(adminCurrencyBean);
	}

	public int updateCurrency(AdminCurrencyBean adminCurrencyBean) {
		int rt=0;
		AdminCurrencyDao adminCurrencyDao=new AdminCurrencyDaoImpl();
		String currency_cd=adminCurrencyBean.getCurrency_cd();
		int currencyDeleteCheck=adminCurrencyDao.currencyDeleteCheck(currency_cd);
		if(currencyDeleteCheck!=0){
			rt=1;
		}else{
			rt=adminCurrencyDao.updateCurrency(adminCurrencyBean);
		}
		return rt;
	}

	public boolean checkInsert(String currency_cd) {
		boolean result = true;
		int currencyExistCheck=new AdminCurrencyDaoImpl().currencyExistCheck(currency_cd);
		if(currencyExistCheck!=0){
			result = false;
		}
		return result;
	}

	@Override
	public Map<String, String> getAllCurrencyValid() {
		Map<String, String> currency_map = new AdminCurrencyDaoImpl().getAllCurrencyValid();
		return currency_map;
	}
  
}
