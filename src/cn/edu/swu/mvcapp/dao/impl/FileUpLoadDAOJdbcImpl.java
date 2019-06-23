package cn.edu.swu.mvcapp.dao.impl;

import java.util.List;

import cn.edu.swu.mvcapp.dao.DAO;
import cn.edu.swu.mvcapp.dao.FileUpLoadDAO;
import cn.edu.swu.mvcapp.domain.FileUploadBean;

public class FileUpLoadDAOJdbcImpl extends DAO<FileUploadBean> implements FileUpLoadDAO {

	@Override
	public List<FileUploadBean> getFiles() {
		String sql = "SELECT id, file_name  fileName, file_path filePath, " +
				"file_desc fileDesc,time,dir_name dirName FROM upload_files";
		return getForList(sql);
	}

	@Override
	public void save(FileUploadBean file) {
		String sql = "INSERT INTO upload_files (file_name, file_path, file_desc,dir_name,time,sid) VALUES (?, ?, ?,?,?,?)";
//		for(FileUploadBean file: uploadFiles){
//			update(sql, file.getFileName(), file.getFilePath(), file.getFileDesc());
//		}
		System.out.println("file.getDirName()"+file.getTime());
		update(sql, file.getFileName(), file.getFilePath(), file.getFileDesc(),file.getDirName(),file.getTime(),file.getSid());
	}

	@Override
	public void delete(String fileName) {
		// TODO Auto-generated method stub
		String sql="delete from upload_files  where file_path=?";
		update(sql,fileName);
	}

	@Override
	public List<FileUploadBean> getSinglefile(String dir) {
		String sql = "SELECT id, file_name  fileName, file_path filePath, " +
				"file_desc fileDesc,time,dir_name dirName FROM upload_files where dir_name=?";
		return getForList(sql,dir);
	}

	@Override
	public FileUploadBean getFileById(int id) {
		String sql = "SELECT  file_path filePath, file_desc fileDesc FROM upload_files where id=?";
		return get(sql,id);
	}
	public List<FileUploadBean> getBySid(int id) {
		String sql = "SELECT id, file_desc fileDesc,time,dir_name dirName ,sid FROM upload_files where sid=?";
		return getForList(sql,id);
	}
	
}
