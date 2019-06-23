package cn.edu.swu.mvcapp.servelet;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import cn.edu.swu.mvcapp.dao.impl.FileUpLoadDAOJdbcImpl;
import cn.edu.swu.mvcapp.domain.FileUploadBean;
import cn.edu.swu.mvcapp.domain.Students;
import cn.edu.swu.mvcapp.fileupload.FileUploadAppProperties;
import cn.edu.swu.mvcapp.fileupload.FileUtils;



public class FileUploadServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;
	
	private static final String FILE_PATH = "/ruanjian/temp";
	
	private static final String TEMP_DIR = "/ruanjian/tempDirectory";
	
	private FileUpLoadDAOJdbcImpl dao = new FileUpLoadDAOJdbcImpl();
	private static String real_path="";
	private static String dirName="";
	private int sid;
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		dirName=request.getParameter("dirName");
		System.out.println("---------fileupload  48");
		Students student=(Students)request.getSession().getAttribute("STUDENT");
		System.out.println("---------fileupload  50");
		if(student.getId()==null) {
			System.out.println("==========getid得到的null");
		}
		sid=student.getId();
		System.out.println("===============sid"+sid);
		System.out.println("==========fileupload  dirName"+dirName);
	    String path = null;
		ServletFileUpload upload = getServletFileUpload();
		real_path=FILE_PATH+"/"+dirName;
		File theDir = new File(real_path);
		if(!theDir.isDirectory()) {
			theDir.mkdir();
		}
		
		try {
			System.out.println("==========fileupload  50");
			List<FileItem> items = upload.parseRequest(request);
			FileItem globalItem=getGlobalItem(items);
			System.out.println("==========fileupload  55");
			Map<String, String>globalItem2=getGlobalItem2(items);
			String desc=globalItem2.get("snumber")+"-"+globalItem2.get("name")+"-"+globalItem2.get("desc");
			FileUploadBean beans = buildFileUploadBeans(items, desc,globalItem,desc);
			System.out.println("==========fileupload  57");
			vaidateExtName(beans);
			System.out.println("==========fileupload  60");
			upload(beans.getFilePath(), globalItem.getInputStream());
			System.out.println("==========fileupload  62");
			saveBeans(beans);
			System.out.println("==========fileupload  64");
			FileUtils.delAllFile(TEMP_DIR);
			System.out.println("==========fileupload  66");
			path = "fileupload.jsp";
			List<FileUploadBean> files=dao.getSinglefile(dirName);
			request.setAttribute("dirName",dirName);
			request.setAttribute("files", files);
			request.setAttribute("flag",true);
			request.setAttribute("flag2",true);
			request.setAttribute("message", "上传成功");
			
		} catch (Exception e) {
			e.printStackTrace();
			path = "fileupload.jsp";
			List<FileUploadBean> files=dao.getSinglefile(dirName);
			request.setAttribute("dirName",dirName);
			request.setAttribute("files", files);
			request.setAttribute("flag",true);
			request.setAttribute("flag2",true);
			request.setAttribute("message", e.getMessage());
		}
		
		request.getRequestDispatcher(path).forward(request, response);
	}
	//https://www.cnblogs.com/liuyangv/p/8298997.html
	/*
	 * 使用Apache文件上传组件处理文件上传步骤：
	 * 
	 */
	private ServletFileUpload getServletFileUpload() {
		System.out.println("==========fileupload  92");
		String fileMaxSize = FileUploadAppProperties.getInstance().getProperty("file.max.size");
		String totalFileMaxSize = FileUploadAppProperties.getInstance().getProperty("total.file.max.size");
		System.out.println("==========fileupload  95"+ totalFileMaxSize);
		//1、设置环境:创建一个DiskFileItemFactory工厂  
		DiskFileItemFactory factory = new DiskFileItemFactory();
		//设置缓冲区大小
		factory.setSizeThreshold(1024 * 500);
		File tempDirectory = new File(TEMP_DIR);
		if(!tempDirectory.isDirectory()) {
			tempDirectory.mkdir();
		}
		//设置上传文件的临时目录
		factory.setRepository(tempDirectory);
		//2、核心操作类:创建一个文件上传解析器。
		ServletFileUpload upload = new ServletFileUpload(factory);
		System.out.println("==========fileupload  105");
		upload.setSizeMax(Integer.parseInt(totalFileMaxSize));
		System.out.println("==========fileupload  107");
		upload.setFileSizeMax(Integer.parseInt(fileMaxSize));
		System.out.println("==========fileupload  108");
		return upload;
	}

	private FileItem getGlobalItem(List<FileItem> items) {
		FileItem item=null;
		for(int i = 0; i < items.size(); i++){
			item = items.get(i);
			 //如果fileitem中封装的是上传文件，得到上传的文件名称， 
			if(!item.isFormField()){
				//普通输入项数据的名
				break;
			}			
		}
		return item;
	}
	private Map<String, String> getGlobalItem2(List<FileItem> items) {
		Map<String, String> descs = new HashMap<String, String>();
		for(int i = 0; i < items.size(); i++){
			//如果fileitem中封装的是普通输入项的数据（输出名、值）
			FileItem item = items.get(i);
			
			if(item.isFormField()){
				//普通输入项数据的名
				String fieldName = item.getFieldName();
				//解决普通输入项的数据的中文乱码问题
				//普通输入项的值
				String desc = null;
				try {
					desc = item.getString("UTF-8");
				} catch (UnsupportedEncodingException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				
				descs.put(fieldName, desc);
			}
		}
		return descs;
	}
	private FileUploadBean buildFileUploadBeans(List<FileItem> items, String desc ,FileItem globalItem,String rename)throws UnsupportedEncodingException {
//		List<FileUploadBean> beans = new ArrayList<>();
		
//		Map<String, String> descs = new HashMap<>();
		System.out.println("items.size()"+items.size());
		FileUploadBean bean = null;
		
	
		for(int i = 0; i < items.size(); i++){
			FileItem item = items.get(i);
			 //如果fileitem中封装的是上传文件，得到上传的文件名称， 
			if(!item.isFormField()){
				//普通输入项数据的名
//				String fieldName = item.getFieldName();
//				String descName = "desc" + fieldName.substring(fieldName.length() - 1);
//				String desc = descs.get(descName); 
				//上传文件的名
				globalItem=item;
				String fileName = item.getName();
				System.out.println("===================179 filename"+fileName);
				String filePath = getFilePath(fileName,rename);
				Date date = new Date(); 
				SimpleDateFormat dateFormat= new SimpleDateFormat("yyyy-MM-dd :hh:mm:ss"); 
				String time=dateFormat.format(date);
				System.out.println(dateFormat.format(date));
				bean = new FileUploadBean(fileName, filePath, desc,dirName,time,sid);
//				beans.add(bean);
				
//				uploadFiles.put(bean.getFilePath(), item);
			}			
		}
		
		return bean;
	}
	private String getFilePath(String fileName,String desc) {
		String extName = fileName.substring(fileName.lastIndexOf("."));
//		Random random = new Random();
		List<FileUploadBean>temps=dao.getFiles();
		String filePath =real_path + "/" +desc + extName;
		for(FileUploadBean temp:temps) {
			if(filePath.equals(temp.getFilePath())) {
				dao.delete(filePath);
			}
		}
		return filePath;
	}
	private void saveBeans(FileUploadBean beans) {
		dao.save(beans); 
	}

//	private void upload(FileItem uploadFile) throws IOException {
//		for(Map.Entry<String, FileItem> uploadFile: uploadFiles.entrySet()){
//			String filePath = uploadFile.getKey();
//			FileItem item = uploadFile.getValue();
//			System.out.println("uploadFile.getValue()"+uploadFile.getValue());
//			System.out.println("item.getInputStream():"+item.getInputStream());
//			upload(filePath, item.getInputStream());
//		}
//	}


	private void upload(String filePath, InputStream inputStream) throws IOException {
		System.out.println("==========fileupload  filePath"+filePath);
		OutputStream out = new FileOutputStream(filePath);
		byte [] buffer = new byte[1024];
		int len = 0;
		
		while((len = inputStream.read(buffer)) != -1){
			System.out.println("len:"+len);
			out.write(buffer, 0, len);
		}
		
		inputStream.close();
		out.close();
		
		System.out.println(filePath); 
	}


	private void vaidateExtName(FileUploadBean bean) {
//		String exts = FileUploadAppProperties.getInstance().getProperty("exts");
//		List<String> extList = Arrays.asList(exts.split(","));
//		System.out.println(extList);
		
		
			String fileName = bean.getFileName();
			System.out.println(fileName.indexOf(".")); 
			
			String extName = fileName.substring(fileName.lastIndexOf(".") + 1);
			System.out.println(extName); 
			
		/*
		 * if(!extList.contains(extName)){ throw new InvalidExtNameException(fileName +
		 * "文件的扩展名不合法"); }
		 */
		
	}



	


}

