package cn.edu.swu.mvcapp.dao;

import java.util.List;

import cn.edu.swu.mvcapp.domain.Students;

public interface StudentDAO {
	public List<Students> getAll();
	public void save(String snumber,String passwd);
	public void saveMore(String snumber,String name,String phone,String qq,String email,Integer id);
	public Students get(String snumber);
	public Students getById(int id);
	public void delete(Integer id);
	public void update(Students student);
	public void updatePW(Students student);
	public long getCountWithName(String name);
	public void updateAuth(Students student);
	public long check(String snumber,String passwd); 
	public int getId(String snumber,String passwd); 
}
