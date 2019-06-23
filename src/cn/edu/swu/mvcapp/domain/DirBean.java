package cn.edu.swu.mvcapp.domain;

public class DirBean {
	private String dirName;
	private String time;
	private int id;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public DirBean() {
		super();
	}
	public DirBean(String dirName, String time) {
		super();
		this.dirName = dirName;
		this.time = time;
	}
	
	@Override
	public String toString() {
		return "DirBean [dirName=" + dirName + ", time=" + time + ", id=" + id + "]";
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
}
