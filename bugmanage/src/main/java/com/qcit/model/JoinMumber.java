package com.qcit.model;

import java.util.Date;

public class JoinMumber {
private int id;
private String email;
private String username;
private String pic;
private Date joindate;
private int isadmin;
@Override
public String toString() {
	return "JoinMumber [id=" + id + ", email=" + email + ", username=" + username + ", pic=" + pic + ", joindate="
			+ joindate + ", isadmin=" + isadmin + "]";
}
public int getId() {
	return id;
}
public void setId(int id) {
	this.id = id;
}
public String getEmail() {
	return email;
}
public void setEmail(String email) {
	this.email = email;
}
public String getUsername() {
	return username;
}
public void setUsername(String username) {
	this.username = username;
}
public String getPic() {
	return pic;
}
public void setPic(String pic) {
	this.pic = pic;
}
public Date getJoindate() {
	return joindate;
}
public void setJoindate(Date joindate) {
	this.joindate = joindate;
}
public int getIsadmin() {
	return isadmin;
}
public void setIsadmin(int isadmin) {
	this.isadmin = isadmin;
}


}
