package cn.edu.swu.mvcapp.domain;

public class Students {
	private Integer id;
	private String name;
	private String passwd;
	
	private String phone;
	private String email;
	private String qq;
	private String snumber;
	
	private boolean authall;
	private boolean authone;
	public Students() {
		super();
	}
	public Students( String name, String passwd, String username, String phone, String email, String qq,
			String snumber) {
		super();
		this.name = name;
		this.passwd = passwd;
		this.phone = phone;
		this.email = email;
		this.qq = qq;
		this.snumber = snumber;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPasswd() {
		return passwd;
	}
	public void setPasswd(String passwd) {
		this.passwd = passwd;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getQq() {
		return qq;
	}
	public void setQq(String qq) {
		this.qq = qq;
	}
	public String getSnumber() {
		return snumber;
	}
	public void setSnumber(String snumber) {
		this.snumber = snumber;
	}
	public boolean isAuthall() {
		return authall;
	}
	public void setAuthall(boolean authall) {
		this.authall = authall;
	}
	public boolean isAuthone() {
		return authone;
	}
	public void setAuthone(boolean authone) {
		this.authone = authone;
	}
	
}
