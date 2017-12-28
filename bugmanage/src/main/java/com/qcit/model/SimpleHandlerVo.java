package com.qcit.model;

public class SimpleHandlerVo {
	private int uid;
	private String username;
	private String email;
	private String pic;
	public int getUid() {
		return uid;
	}
	public void setUid(int uid) {
		this.uid = uid;
	}
	public String getUsername() {
		return username;
	}
	@Override
	public String toString() {
		return "SimpleHandlerVo [uid=" + uid + ", username=" + username + ", email=" + email + ", pic=" + pic + "]";
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPic() {
		return pic;
	}
	public void setPic(String pic) {
		this.pic = pic;
	}
	

}
