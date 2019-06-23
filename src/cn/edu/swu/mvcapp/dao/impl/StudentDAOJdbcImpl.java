package cn.edu.swu.mvcapp.dao.impl;

import java.util.List;

import cn.edu.swu.mvcapp.dao.DAO;
import cn.edu.swu.mvcapp.dao.StudentDAO;
import cn.edu.swu.mvcapp.domain.Students;

public class StudentDAOJdbcImpl extends DAO<Students> implements StudentDAO {

	@Override
	public List<Students> getAll() {
		// TODO Auto-generated method stub
		String sql="select id,authone,authall,snumber,name from student";
		return getForList(sql);
	}

	@Override
	public void save(String snumber,String passwd) {
		// TODO Auto-generated method stub
		String sql="insert into student(snumber,passwd) values(?,?)";
		update(sql,snumber,passwd);
		
	}
	@Override
	public void saveMore(String snumber, String name, String phone, String qq, String email,Integer id) {
		String sql="update student set name=?,snmber=?,qq=?,email=?,phone=? where id=?";
		update(sql,name,snumber,qq,email,phone,id);
	}

	@Override
	public Students get(String snumber) {
		// TODO Auto-generated method stub
		String sql="select id,passwd,name,qq,phone,email,snumber,authone,authall from student where snumber=?";
		return get(sql,snumber);
	}

	@Override
	public void delete(Integer id) {
		// TODO Auto-generated method stub
		String sql="delete from student where id=?";
		update(sql,id);
	}

	@Override
	public void update(Students student) {
		// TODO Auto-generated method stub
		String sql="update student set name=?,snumber=?,qq=?,email=?,phone=? where id=?";
		update(sql,student.getEmail(),student.getPhone(),student.getQq(),student.getSnumber(),student.getName(),student.getId());
	}

	@Override
	public long getCountWithName(String snumber) {
		// TODO Auto-generated method stub
		String sql="select count(id) from student where snumber=?";
		return getForValue(sql,snumber);
	}

	@Override
	public void updatePW(Students student) {
		// TODO Auto-generated method stub
		String sql="update student set passwd=? where id=?";
		update(sql,student.getPasswd(),student.getId());
	}

	@Override
	public void updateAuth(Students student) {
		// TODO Auto-generated method stub
		String sql="update student set authone=?,authall=? where id=?";
		update(sql,student.isAuthone(),student.isAuthall(),student.getId());
	}

	@Override
	public long check(String snumber, String passwd) {
		// TODO Auto-generated method stub
		String sql="select count(id) from student where snumber=? and passwd=?";
		return getForValue(sql,snumber,passwd);
	}

	@Override
	public int getId(String snumber, String passwd) {
		String sql="select id from student where snumber=? and passwd=?";
		return getForValue(sql,snumber,passwd);
	}

	@Override
	public Students getById(int id) {
		String sql="select id, authone,authall,snumber,name from student where id=?";
		return get(sql,id);
	}

	
}
