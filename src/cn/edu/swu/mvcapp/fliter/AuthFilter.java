package cn.edu.swu.mvcapp.fliter;

import java.io.IOException;
import java.util.Arrays;
import java.util.List;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cn.edu.swu.mvcapp.domain.Students;

public class AuthFilter extends HttpFilter {
	@Override
	public void doFilter(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain)
			throws IOException, ServletException {
		
		//1.获取请求的url
		String servletPath=request.getServletPath();
		Students student=(Students)request.getSession().getAttribute("STUDENT");
		boolean authall=student.isAuthall();
		boolean authone=student.isAuthone();
		System.out.println(servletPath);
		if(servletPath.equals("/authority-manager.jsp")) {
		if(authall==true) {
			filterChain.doFilter(request, response);
		}else {
			response.sendRedirect(request.getContextPath()+"/authority-manager2.jsp");
		}}else {
			if(authone==true || authall==true) {
				filterChain.doFilter(request, response);
			}else {
				response.sendRedirect(request.getContextPath()+"/file-manage2.jsp");
			}
		}
			
	}

}
