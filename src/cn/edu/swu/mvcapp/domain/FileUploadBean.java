package cn.edu.swu.mvcapp.domain;

public class FileUploadBean {

	
	private Integer id;
	private String fileName;
	private String filePath;
	private String fileDesc;
	private String dirName;
	private String time;
	private int sid;

	public int getSid() {
		return sid;
	}

	public void setSid(int sid) {
		this.sid = sid;
	}

	public String getDirName() {
		return dirName;
	}

	public void setDirName(String dirName) {
		this.dirName = dirName;
	}

	public String getTime() {
		return time;
	}

	public void setTime(String time) {
		this.time = time;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public String getFilePath() {
		return filePath;
	}

	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}

	public String getFileDesc() {
		return fileDesc;
	}

	public void setFileDesc(String fileDesc) {
		this.fileDesc = fileDesc;
	}



	public FileUploadBean(String fileName, String filePath, String fileDesc, String dirName, String time,int sid) {
		super();
		this.fileName = fileName;
		this.filePath = filePath;
		this.fileDesc = fileDesc;
		this.dirName = dirName;
		this.time = time;
		this.sid=sid;
	}

	public FileUploadBean() {
		// TODO Auto-generated constructor stub
	}
}
