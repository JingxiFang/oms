package sym.common.filters;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
/**
 * ?????ַ????뼯??????
 * @author guojl
 *
 */
public class CharacterEncodingFilter implements Filter {

	private String encoding = null;
	
	public void destroy() {
		

	}

	public void doFilter(ServletRequest request, ServletResponse response,
			FilterChain chain) throws IOException, ServletException {
		
		if(encoding != null)
		{
			request.setCharacterEncoding(encoding);
			response.setCharacterEncoding(encoding);
		}
		
		chain.doFilter(request, response);

	}

	public void init(FilterConfig config) throws ServletException {
		
		encoding = config.getInitParameter("encoding");

	}

}
