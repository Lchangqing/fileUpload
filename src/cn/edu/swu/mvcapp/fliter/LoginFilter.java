package cn.edu.swu.mvcapp.fliter;

import java.io.IOException;
import java.util.Arrays;
import java.util.List;

import javax.servlet.FilterChain;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet Filter implementation class LoginFilter
 */
@WebFilter("/LoginFilter")
public class LoginFilter extends HttpFilter {
	private String redirectUrl;
	private String uncheckedUrls;
	private String sessionKey;
	@Override
		protected void init() {
			// TODO Auto-generated method stub
			ServletContext servletContext=getFilterConfig().getServletContext();
			redirectUrl=servletContext.getInitParameter("rediretPage");
			uncheckedUrls=servletContext.getInitParameter("uncheckedUrls");
			sessionKey=servletContext.getInitParameter("userSessionKey");
		}
	@Override
	public void doFilter(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain)
			throws IOException, ServletException {
		// TODO Auto-generated method stub
		System.out.println("-----34 dofilter-----------");
		//1.获取请求的url
		String servletPath=request.getServletPath();
		//2.检查获取的servletpath是否为不需要检查的url的一部分，若是则直接放行，方法结束
		List<String> urls=Arrays.asList(uncheckedUrls.split(","));
		if(urls.contains(servletPath)) {
			filterChain.doFilter(request, response);
			return;
		}
		//3.获取sessionid对比，若不一样则重定向到redirecturl
		Object sessionid=request.getSession().getAttribute(sessionKey);
		System.out.println("--------------sessionkey:"+sessionid);
		System.out.println("--------------sessionid:"+request.getSession().getId());
		if(sessionid!=request.getSession().getId()) {
			response.sendRedirect( request.getContextPath()+redirectUrl);
			return;
		}
		//4.若sessionid相同则放行，允许访问
		filterChain.doFilter(request, response);
	}

    
}
