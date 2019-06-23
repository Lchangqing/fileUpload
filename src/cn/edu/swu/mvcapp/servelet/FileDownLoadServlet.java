package cn.edu.swu.mvcapp.servelet;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.lang.reflect.Method;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import cn.edu.swu.mvcapp.dao.impl.DirDAOJdbcImpl;
import cn.edu.swu.mvcapp.dao.impl.FileUpLoadDAOJdbcImpl;
import cn.edu.swu.mvcapp.domain.DirBean;
import cn.edu.swu.mvcapp.domain.FileUploadBean;

public class FileDownLoadServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final int  BUFFER_SIZE = 2 * 1024;
	private static final String FILE_PATH = "/ruanjian/temp";
	private DirDAOJdbcImpl dirDao=new DirDAOJdbcImpl();
	FileUpLoadDAOJdbcImpl dao=new FileUpLoadDAOJdbcImpl();
	protected void  doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request,response);
	}
	protected void  doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setCharacterEncoding("UTF-8") ;
		 request.setCharacterEncoding("UTF-8") ;
		 //1.获取servletpath:/edit.do或add.do
		 String servletpath=request.getServletPath();
		 
		 //2.去除/和.do，得到类似于edit或add这样的字符串
		 String methodname=servletpath.substring(1,servletpath.length()-5);
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
			 response.sendRedirect(request.getContextPath()+"/404.jsp");
			e.printStackTrace();
		} 
	}

	private void file(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		System.out.println("==============download ID"+request.getParameter("fileId"));
		int id=Integer.parseInt(request.getParameter("fileId"));
		
		FileUploadBean file=dao.getFileById(id);
		String filePath=file.getFilePath();
		String flieDesc=file.getFileDesc();
		
		String fileName = flieDesc+filePath.substring(filePath.lastIndexOf("."));
		System.out.println("==============download 29"+getServletContext().getMimeType(fileName));
		response.setContentType(getServletContext().getMimeType(fileName));  
		String realFilePath=filePath;
		
		
		System.out.println("==============download realFilePath"+realFilePath);
		System.out.println("==============download fileName"+fileName);
		
		 // 判断浏览器是否是 IE
        String userAgent = request.getHeader("User-Agent");
        
        if (userAgent.contains("MSIE")||userAgent.contains("Edge")) {
            // IE
            // 设置文件的名称
        	response.setHeader("Content-Disposition", "attachment; fileName="
                    + URLEncoder.encode(fileName, "UTF-8"));
        } else {
            // 非IE
        	response.setHeader("Content-Disposition", "attachment; fileName="
                    + new String(fileName.getBytes("UTF-8"), "ISO-8859-1"));
        }

		
		
		OutputStream out = response.getOutputStream();
		
		InputStream in = new FileInputStream(realFilePath);
		
		byte [] buffer = new byte[1024];
		int len = 0;
		while((len = in.read(buffer)) != -1){
			out.write(buffer, 0, len);
		}
		
		in.close();
	}
	private void creatDir(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		File rootDir = new File(FILE_PATH);
		if(!rootDir.isDirectory()) {
			rootDir.mkdir();
		}
		String newDirName=request.getParameter("dirName");
		HttpSession session=request.getSession();
		List<DirBean> dirs=(List<DirBean>)session.getAttribute("DIRS");
		for(DirBean dir:dirs) {
			if(dir.getDirName().equals(newDirName)) {
				request.setAttribute("message","该文件夹已存在");
				request.getRequestDispatcher("file-manage.jsp").forward(request, response);
				return;
			}
		}
		
		File theDir = new File(FILE_PATH+"/"+newDirName);
		if(!theDir.isDirectory()) {
			theDir.mkdir();
		}
		//生成时间
		Date date = new Date(); 
		SimpleDateFormat dateFormat= new SimpleDateFormat("yyyy-MM-dd :hh:mm:ss"); 
		String time=dateFormat.format(date);
		System.out.println(dateFormat.format(date));
		
		DirBean dir=new DirBean(newDirName, time);
//		dirs.add(dir);
		
		//更新session中的数据，以及往数据库写数据
		dirDao.save(dir);
		int id=dirDao.getByName(newDirName);
		dir.setId(id);
		dirs.add(dir);
		session.setAttribute("DIRS", dirs);
		
		 response.sendRedirect(request.getContextPath()+"/file-manage.jsp");
	}

	private void dir(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		System.out.println("==============download 過來了");
		int dirId=Integer.parseInt(request.getParameter("dirId"));
		String dirName_=dirDao.getById(dirId);
		String dirName=dirName_+".zip";
		String realPath=FILE_PATH+"/"+dirName_;
		 response.setContentType("application/zip");
		// 判断浏览器是否是 IE
	        String userAgent = request.getHeader("User-Agent");
	        
	        if (userAgent.contains("MSIE")||userAgent.contains("Edge")) {
	            // IE
	            // 设置文件的名称
	        	response.setHeader("Content-Disposition", "attachment; fileName="
	                    + URLEncoder.encode(dirName, "UTF-8"));
	        } else {
	            // 非IE
	        	response.setHeader("Content-Disposition", "attachment; fileName="
	                    + new String(dirName.getBytes("UTF-8"), "ISO-8859-1"));
	        }
//		 response.setHeader("Content-Disposition", "attachment; filename=excel.zip");
	        toZip(realPath, response.getOutputStream(),true);
	}
	 /**
	     * 压缩成ZIP 方法1
	     * @param srcDir 压缩文件夹路径 
	     * @param out    压缩文件输出流
	     * @param KeepDirStructure  是否保留原来的目录结构,true:保留目录结构; 
	     *                          false:所有文件跑到压缩包根目录下(注意：不保留目录结构可能会出现同名文件,会压缩失败)
	     * @throws RuntimeException 压缩失败会抛出运行时异常
	     */
	    public static void toZip(String srcDir, OutputStream out, boolean KeepDirStructure)
	            throws RuntimeException{
	        
	        long start = System.currentTimeMillis();
	        ZipOutputStream zos = null ;
	        try {
	            zos = new ZipOutputStream(out);
	            File sourceFile = new File(srcDir);
	            compress(sourceFile,zos,sourceFile.getName(),KeepDirStructure);
	            long end = System.currentTimeMillis();
	            System.out.println("压缩完成，耗时：" + (end - start) +" ms");
	        } catch (Exception e) {
	            throw new RuntimeException("zip error from ZipUtils",e);
	        }finally{
	            if(zos != null){
	                try {
	                    zos.close();
	                } catch (IOException e) {
	                    e.printStackTrace();
	                }
	            }
	        }
	        
	    }
	    /**
	         * 递归压缩方法
	         * @param sourceFile 源文件
	         * @param zos        zip输出流
	         * @param name       压缩后的名称
	         * @param KeepDirStructure  是否保留原来的目录结构,true:保留目录结构; 
	         *                          false:所有文件跑到压缩包根目录下(注意：不保留目录结构可能会出现同名文件,会压缩失败)
	         * @throws Exception
	         */
	        private static void compress(File sourceFile, ZipOutputStream zos, String name,
	                boolean KeepDirStructure) throws Exception{
	            byte[] buf = new byte[BUFFER_SIZE];
	            if(sourceFile.isFile()){
	                // 向zip输出流中添加一个zip实体，构造器中name为zip实体的文件的名字
	                zos.putNextEntry(new ZipEntry(name));
	                // copy文件到zip输出流中
	                int len;
	                FileInputStream in = new FileInputStream(sourceFile);
	                while ((len = in.read(buf)) != -1){
	                    zos.write(buf, 0, len);
	                }
	                // Complete the entry
	                zos.closeEntry();
	                in.close();
	            } else {
	                File[] listFiles = sourceFile.listFiles();
	                if(listFiles == null || listFiles.length == 0){
	                    // 需要保留原来的文件结构时,需要对空文件夹进行处理
	                    if(KeepDirStructure){
	                        // 空文件夹的处理
	                        zos.putNextEntry(new ZipEntry(name + "/"));
	                        // 没有文件，不需要文件的copy
	                        zos.closeEntry();
	                    }
	                    
	                }else {
	                    for (File file : listFiles) {
	                        // 判断是否需要保留原来的文件结构
	                        if (KeepDirStructure) {
	                            // 注意：file.getName()前面需要带上父文件夹的名字加一斜杠,
	                            // 不然最后压缩包中就不能保留原来的文件结构,即：所有文件都跑到压缩包根目录下了
	                            compress(file, zos, name + "/" + file.getName(),KeepDirStructure);
	                        } else {
	                            compress(file, zos, file.getName(),KeepDirStructure);
	                        }
	                        
	                    }
	                }
	            }
	        }
}

