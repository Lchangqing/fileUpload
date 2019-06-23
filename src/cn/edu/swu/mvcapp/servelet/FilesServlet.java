package cn.edu.swu.mvcapp.servelet;

import java.io.File;
import java.io.IOException;
import java.lang.reflect.Method;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cn.edu.swu.mvcapp.dao.impl.DirDAOJdbcImpl;
import cn.edu.swu.mvcapp.dao.impl.FileUpLoadDAOJdbcImpl;
import cn.edu.swu.mvcapp.dao.impl.StudentDAOJdbcImpl;
import cn.edu.swu.mvcapp.domain.DirBean;
import cn.edu.swu.mvcapp.domain.FileUploadBean;
import cn.edu.swu.mvcapp.domain.Students;

public class FilesServlet  extends HttpServlet{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private DirDAOJdbcImpl dirdao=new DirDAOJdbcImpl();
	private FileUpLoadDAOJdbcImpl filedao=new FileUpLoadDAOJdbcImpl();
	private StudentDAOJdbcImpl studentdao=new StudentDAOJdbcImpl();
	private static final String FILE_PATH = "/ruanjian/temp";
	private static String DIRNAME="";
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
			 System.out.println("----------36 methodname:"+methodname);
			Method method=getClass().getDeclaredMethod(methodname, HttpServletRequest.class,HttpServletResponse.class);
			//4.利用反射调用对应的方法
			System.out.println("----------36");
			method.invoke(this, request,response);
			System.out.println("----------39");
		 } catch (Exception e) {
			 System.out.println("----------42");
			 response.sendRedirect(request.getContextPath()+"/404.jsp");
			e.printStackTrace();
		} 
	}
	private void query(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		String dirName=request.getParameter("dirName");
		List<FileUploadBean> files=filedao.getSinglefile(dirName);
		request.setAttribute("flag",true);
		request.setAttribute("dirName",dirName);
		request.setAttribute("files", files);
		request.getRequestDispatcher("/fileupload.jsp").forward(request, response);
	}
	private void query2(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		DIRNAME=request.getParameter("dirName");
		if(DIRNAME==null) {
			DIRNAME=(String)request.getSession().getAttribute("DIRNAME");
		}
		List<FileUploadBean> files=filedao.getSinglefile(DIRNAME);
		request.setAttribute("flag2",true);
		request.setAttribute("files", files);
		request.getRequestDispatcher("/file-manage.jsp").forward(request, response);
	}
	private void getauth(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		int index=Integer.parseInt(request.getParameter("index"));
		List<Students> userinfo=(List<Students>)request.getSession().getAttribute("USERINFO");
		Students student=userinfo.get(index);
		request.setAttribute("student", student);
		request.setAttribute("flag", true);
		request.getRequestDispatcher("/authority-manager.jsp").forward(request, response);
	}
	private void updateAuth(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		int id=Integer.parseInt(request.getParameter("id"));
		System.out.println("----------id"+id);
		boolean authone=false;
		boolean authall=false;
		String[] auths=request.getParameterValues("auth");
		if(auths!=null) {
		for(String auth:auths){
			if(auth.equals("authone")) {
				authone=true;
			}
			if(auth.equals("authall")) {
				authall=true;
			}
			System.out.println(auth);    //下面的实例有将取到的数据组合，这个没有
		} }
		System.out.println("----------91");
	  Students student=studentdao.getById(id);
	  student.setAuthone(authone);
	  student.setAuthall(authall);
	  System.out.println("----------95"+student.isAuthone()+student.isAuthall()+student.getId());
	  studentdao.updateAuth(student);
	  System.out.println("----------97");
	  List<Students> userinfo=studentdao.getAll();
	  request.getSession().setAttribute("USERINFO", userinfo);
	  System.out.println("----------100");
	  Students user=(Students)request.getSession().getAttribute("STUDENT");
	  if(id==user.getId()) {
		  user.setAuthone(authone);
		  user.setAuthall(authall);
		  request.getSession().setAttribute("STUDENT", user);
	  }
	  
	 
	  response.sendRedirect(request.getContextPath()+"/authority-manager.jsp");
	}
	
	private void fileDelet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		System.out.println("==============delete ID"+request.getParameter("fileId"));
		int id=Integer.parseInt(request.getParameter("fileId"));
		
		FileUploadBean file=filedao.getFileById(id);
		String filePath=file.getFilePath();
		String realFilePath=filePath;
		System.out.println("==============download realFilePath"+realFilePath);
		
		File file_ = new File(realFilePath);
	      if(file_.delete()){
	          System.out.println("文件删除成功");
	      }else {
	    	  System.out.println("文件删除失败");
	    	  return;
	    	  }
	     
	    //从数据库删除文件
	      filedao.delete(filePath);
	      request.getSession().setAttribute("DIRNAME", DIRNAME);
	      response.sendRedirect(request.getContextPath()+"/query2.go");
	}
	
	private void dirDelet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		System.out.println("==============dirDelete 過來了");
		int dirId=Integer.parseInt(request.getParameter("dirId"));
		String dirName_=dirdao.getById(dirId);
		String realPath=FILE_PATH+"/"+dirName_;
		
		File dir = new File(realPath);
        File[] listFiles = dir.listFiles();
        for(File file : listFiles){
            System.out.println("Deleting "+file.getName());
            file.delete();
        }
        //现在目录为空，所以可以删除它
        System.out.println("Deleting Directory. Success = "+dir.delete());
        
        //删除数据库中记录
        dirdao.delete(dirName_);
        
        //从session中删除记录
        List<DirBean> dirs=(List<DirBean>)request.getSession().getAttribute("DIRS");
        for(DirBean dir_:dirs) {
        	 if (dirName_.equals(dir_.getDirName())) {
        		 dirs.remove(dir_);
            	 System.out.println("session中文件夹删除成功");
            	 break;
        	 }
        }
        request.getSession().setAttribute("DIRS", dirs);
        response.sendRedirect(request.getContextPath()+"/file-manage.jsp");
	}
}

