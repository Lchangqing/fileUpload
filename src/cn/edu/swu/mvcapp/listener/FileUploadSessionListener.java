package cn.edu.swu.mvcapp.listener;

import java.util.List;

import javax.servlet.annotation.WebListener;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

import cn.edu.swu.mvcapp.dao.impl.DirDAOJdbcImpl;
import cn.edu.swu.mvcapp.domain.DirBean;

/**
 * Application Lifecycle Listener implementation class FileUploadSessionListener
 *
 */
@WebListener
public class FileUploadSessionListener implements HttpSessionListener {
	private DirDAOJdbcImpl dirdao=new DirDAOJdbcImpl();
	 private static int activeSessions = 0;
    public void sessionCreated(HttpSessionEvent se)  { 
    	System.out.println("创建了session");
         // TODO Auto-generated method stub
    	HttpSession session=se.getSession();
    	List<DirBean> dirs=dirdao.getDirs();
    	for(DirBean dir:dirs) {
    		System.out.println(dir.getTime()+dir.getDirName());
    	}
    	session.setAttribute("DIRS", dirs);
    	activeSessions++;
    }

    public void sessionDestroyed(HttpSessionEvent se)  { 
         // TODO Auto-generated method stub
    	activeSessions--;
    }
    public static int getActiveSessions() {
        return activeSessions;
    }
	
}
