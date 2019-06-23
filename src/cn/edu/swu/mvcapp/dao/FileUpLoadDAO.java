package cn.edu.swu.mvcapp.dao;

import java.util.List;

import cn.edu.swu.mvcapp.domain.FileUploadBean;


public interface FileUpLoadDAO {
	public List<FileUploadBean> getFiles();
	public void save(FileUploadBean file);
	public void delete(String fileName);
	public List<FileUploadBean> getSinglefile(String dir);
	public FileUploadBean getFileById(int id);
	public List<FileUploadBean> getBySid(int id);
}
