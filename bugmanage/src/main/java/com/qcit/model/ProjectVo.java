package com.qcit.model;

import java.io.Serializable;
import java.util.List;

public class ProjectVo implements Serializable{
/**
	 * 
	 */
	private static final long serialVersionUID = 847244664801723982L;
private int sumproblem;//问题总和
private int resolved;//已解决
private int unsolved;//未解决
private int audit;//审核中
private int closed;//已关闭
private int  rejected;//已拒绝
private int postponed;//已延期
private List<SimpleProblemVo> list;
public int getSumproblem() {
	return sumproblem;
}
public void setSumproblem(int sumproblem) {
	this.sumproblem = sumproblem;
}
public int getResolved() {
	return resolved;
}
public void setResolved(int resolved) {
	this.resolved = resolved;
}
public int getUnsolved() {
	return unsolved;
}
public void setUnsolved(int unsolved) {
	this.unsolved = unsolved;
}
public int getAudit() {
	return audit;
}
public void setAudit(int audit) {
	this.audit = audit;
}
public int getClosed() {
	return closed;
}
public void setClosed(int closed) {
	this.closed = closed;
}
public int getRejected() {
	return rejected;
}
public void setRejected(int rejected) {
	this.rejected = rejected;
}
public int getPostponed() {
	return postponed;
}
public void setPostponed(int postponed) {
	this.postponed = postponed;
}
public List<SimpleProblemVo> getList() {
	return list;
}
public void setList(List<SimpleProblemVo> list) {
	this.list = list;
}
@Override
public int hashCode() {
	final int prime = 31;
	int result = 1;
	result = prime * result + audit;
	result = prime * result + closed;
	result = prime * result + ((list == null) ? 0 : list.hashCode());
	result = prime * result + postponed;
	result = prime * result + rejected;
	result = prime * result + resolved;
	result = prime * result + sumproblem;
	result = prime * result + unsolved;
	return result;
}
@Override
public boolean equals(Object obj) {
	if (this == obj)
		return true;
	if (obj == null)
		return false;
	if (getClass() != obj.getClass())
		return false;
	ProjectVo other = (ProjectVo) obj;
	if (audit != other.audit)
		return false;
	if (closed != other.closed)
		return false;
	if (list == null) {
		if (other.list != null)
			return false;
	} else if (!list.equals(other.list))
		return false;
	if (postponed != other.postponed)
		return false;
	if (rejected != other.rejected)
		return false;
	if (resolved != other.resolved)
		return false;
	if (sumproblem != other.sumproblem)
		return false;
	if (unsolved != other.unsolved)
		return false;
	return true;
}
}
