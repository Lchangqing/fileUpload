package cn.edu.swu.mvcapp.dao.impl;

import java.util.List;

import cn.edu.swu.mvcapp.dao.DAO;
import cn.edu.swu.mvcapp.dao.DirDAO;
import cn.edu.swu.mvcapp.domain.DirBean;

public class DirDAOJdbcImpl extends DAO<DirBean> implements DirDAO{

	@Override
	public List<DirBean> getDirs() {
		String sql = "SELECT time,dir_name as dirName ,id FROM upload_dirs";
		return getForList(sql);
	}

	@Override
	public void save(DirBean dir) {
		String sql = "INSERT INTO upload_dirs (dir_name, time) VALUES (?, ?)";
		update(sql, dir.getDirName(),dir.getTime());
	}

	@Override
	public void delete(String dirName) {
		String sql="delete from upload_dirs  where dir_name=?";
		update(sql,dirName);
	}

	@Override
	public String getById(int id) {
		String sql = "SELECT dir_name as dirName  FROM upload_dirs where id=?";
		return getForValue(sql, id);
	}

	@Override
	public int getByName(String dirName) {
		String sql = "SELECT  id  FROM upload_dirs where dir_name=?";
		return getForValue(sql, dirName);
	}
	
}
