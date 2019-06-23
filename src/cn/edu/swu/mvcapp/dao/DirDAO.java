package cn.edu.swu.mvcapp.dao;

import java.util.List;

import cn.edu.swu.mvcapp.domain.DirBean;

public interface DirDAO {
	public List<DirBean> getDirs();
	public void save(DirBean dir);
	public void delete(String dirName);
	public String getById(int id);
	public int getByName(String dirName);
}
