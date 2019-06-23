package cn.edu.swu.mvcapp.servelet;

import java.io.IOException;
import java.lang.reflect.Method;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import cn.edu.swu.mvcapp.dao.StudentDAO;
import cn.edu.swu.mvcapp.dao.impl.DirDAOJdbcImpl;
import cn.edu.swu.mvcapp.dao.impl.StudentDAOJdbcImpl;
import cn.edu.swu.mvcapp.domain.DirBean;
import cn.edu.swu.mvcapp.domain.Students;

public class StudentServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private StudentDAO studentdao=new StudentDAOJdbcImpl();
	private DirDAOJdbcImpl dirdao=new DirDAOJdbcImpl();
	protected void  doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request,response);
	}
	protected void  doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setCharacterEncoding("UTF-8") ;
		 request.setCharacterEncoding("UTF-8") ;
		 //1.获取servletpath:/edit.do或add.do
		 String servletpath=request.getServletPath();
		 
		 //2.去除/和.do，得到类似于edit或add这样的字符串
		 String methodname=servletpath.substring(1,servletpath.length()-3);
		 try {
			 //3.利用放射获取methodName对应大方法
			 System.out.println("----------34");
			Method method=getClass().getDeclaredMethod(methodname, HttpServletRequest.class,HttpServletResponse.class);
			//4.利用反射调用对应的方法
			System.out.println("----------36 methodname:"+method);
			method.invoke(this, request,response);
			System.out.println("----------39");
		 } catch (Exception e) {
			 System.out.println("----------42");
			 response.sendRedirect("404.jsp");
			e.printStackTrace();
		} 
	}
	private void gohome(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		//1. 获取请求参数: CHECK_CODE_PARAM_NAME
		String paramCode = request.getParameter("CHECK_CODE_PARAM_NAME");
		System.out.println("----------53");		
		//2. 获取 session 中的 CHECK_CODE_KEY 属性值
		String sessionCode = (String)request.getSession().getAttribute("CHECK_CODE_KEY");
		System.out.println(paramCode);
		System.out.println(sessionCode); 
		System.out.println("----------58");
		String snumber=request.getParameter("snumber");
		String passwd=request.getParameter("passwd");
		if(studentdao==null) {System.out.println("空的");}
		long lenth=studentdao.check(snumber, passwd);
		if(!(paramCode != null && paramCode.equals(sessionCode)))
		{
			System.out.println("----------63");
			request.getSession().setAttribute("message",null);
			request.getSession().setAttribute("msg2", "验证码输入错误!");
			response.sendRedirect(request.getContextPath() + "/index.jsp");
			System.out.println("----------66");
			return;
		}else {
		if(lenth==1) {
			System.out.println("----------69");
			
			request.getSession().setAttribute(request.getServletContext().getInitParameter("userSessionKey"), request.getSession().getId());
			/*登录后获取用户文件夹相关信息放session*/
			HttpSession session=request.getSession();
			List<DirBean> dirs=dirdao.getDirs();
	    	session.setAttribute("DIRS", dirs);
	    	
	       //登录后获取用户相关信息放session
	    	Students student=studentdao.get(snumber);
	    	session.setAttribute("STUDENT", student);
	    	
	    	
	    	boolean authone=student.isAuthone();
			boolean authall=student.isAuthall();
			System.out.println("=================authfilter authone" +authone);
			System.out.println("=================authfilter authall" +authall);
			if(authall==true) {
				List<Students> userinfo=studentdao.getAll();
				session.setAttribute("USERINFO", userinfo);
			}
	    	
			request.getSession().setAttribute(request.getServletContext().getInitParameter("userSessionKey"), request.getSession().getId());
			response.sendRedirect("home-page.jsp");
		}else {System.out.println("----------72");
		    request.getSession().setAttribute("msg2",null);
			request.getSession().setAttribute("message", "密码或学号输入有误");
			response.sendRedirect(request.getContextPath() + "/index.jsp");
		}
		}
		
	}
	private void save(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		String snumber=request.getParameter("snumber");
		String passwd=request.getParameter("passwd");
		System.out.println("------snumber"+snumber);
		System.out.println("------passwd"+passwd);
		if(passwd!=null && !passwd.equals("")&&!passwd.equals("null")&&snumber!=null && !snumber.equals("")&&!snumber.equals("null")) {
			System.out.println("------69 进if");
					long count=studentdao.getCountWithName(snumber);
					System.out.println("------111 count"+count);
					if(count>0) {
						request.setAttribute("message", "用户 "+snumber+" 已经被注册，请重新选择");
						request.getRequestDispatcher("/register.jsp").forward(request, response);
						return;
					}
				
				studentdao.save(snumber, passwd);
				request.setAttribute("message", "用户 "+snumber+" 创建成功");
				request.getRequestDispatcher("/register.jsp").forward(request, response);
		}
		else {
			System.out.println("------82 进else");
			request.setAttribute("message", "用户名或密码不能为空");
			request.getRequestDispatcher("/register.jsp").forward(request, response);
		}
	}
	private void savemore(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		String snumber=removespace(request.getParameter("snumber"));
		long count=studentdao.getCountWithName(snumber);
		String oldsnumber=(String)request.getParameter("oldsnumber");
		if(count>0 && !oldsnumber.equals(snumber)) {
			
			request.setAttribute("message", "该学号"+snumber+" 已经被使用");
			request.getRequestDispatcher("userinfo.jsp").forward(request, response);
			return;
		}
		System.out.println("----------Studentservlet 126");
		String name=removespace(request.getParameter("name"));
		String phone=removespace(request.getParameter("phone"));
		String qq=removespace(request.getParameter("qq"));
		String email=removespace(request.getParameter("email"));
		Students student=(Students)request.getSession().getAttribute("STUDENT");
		studentdao.saveMore(snumber, name, phone, qq, email, student.getId());
		//更新session
		student.setEmail(email);
		student.setName(name);
		student.setPhone(phone);
		student.setQq(qq);
		student.setSnumber(snumber);
    	request.getSession().setAttribute("STUDENT", student);
    	request.setAttribute("message", "信息修改成功");
		request.getRequestDispatcher("userinfo.jsp").forward(request, response);
	}
	private String removespace(String word) {
		String temp=word.trim();
		while (temp.startsWith("　")) {//这里判断是不是全角空格
			temp = temp.substring(1, temp.length()).trim();
			}
		while (temp.endsWith("　")) {
			temp = temp.substring(0, temp.length() - 1).trim();
		}
		return temp;
	}
	
	private void updatepw(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		String sourcepw=removespace(request.getParameter("sourcepw"));
		Students student=(Students)request.getSession().getAttribute("STUDENT");
		long lenth=studentdao.check(student.getSnumber(), sourcepw);
		if(lenth==0) {
			request.setAttribute("message", "原密码错误");
			request.getRequestDispatcher("passwd-manage.jsp").forward(request, response);
			return;
		}
		String newpw=removespace(request.getParameter("newpw"));
		student.setPasswd(newpw);
		studentdao.updatePW(student);
		request.setAttribute("message", "密码修改成功!");
		request.getRequestDispatcher("passwd-manage.jsp").forward(request, response);
	}
}
