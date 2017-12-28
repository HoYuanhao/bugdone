package com.qcit.model;

import java.io.Serializable;
import java.util.Date;

public class SimpleProblemVo implements Serializable{
	private static final long serialVersionUID = -7758262576505224012L;
private int id;
private int type;
private String headline;
private String product;
private int state;
private int priority;
private String handlerName;
private Date createtime;
private Date updatetime;

@Override
public String toString() {
	return "SimpleProblemVo [id=" + id + ", type=" + type + ", headline=" + headline + ", product=" + product
			+ ", state=" + state + ", priority=" + priority + ", handlerName=" + handlerName + ", createtime="
			+ createtime + ", updatetime=" + updatetime + "]";
}
public int getId() {
	return id;
}
public void setId(int id) {
	this.id = id;
}
public int getType() {
	return type;
}
public void setType(int type) {
	this.type = type;
}
public String getHeadline() {
	return headline;
}
public void setHeadline(String headline) {
	this.headline = headline;
}
public String getProduct() {
	return product;
}
public void setProduct(String product) {
	this.product = product;
}
public int getState() {
	return state;
}
public void setState(int state) {
	this.state = state;
}
public int getPriority() {
	return priority;
}
public void setPriority(int priority) {
	this.priority = priority;
}
public String getHandlerName() {
	return handlerName;
}
public void setHandlerName(String handlerName) {
	this.handlerName = handlerName;
}
public Date getCreatetime() {
	return createtime;
}
public void setCreatetime(Date createtime) {
	this.createtime = createtime;
}
public Date getUpdatetime() {
	return updatetime;
}
public void setUpdatetime(Date updatetime) {
	this.updatetime = updatetime;
}
@Override
public int hashCode() {
	final int prime = 31;
	int result = 1;
	result = prime * result + ((createtime == null) ? 0 : createtime.hashCode());
	result = prime * result + ((handlerName == null) ? 0 : handlerName.hashCode());
	result = prime * result + ((headline == null) ? 0 : headline.hashCode());
	result = prime * result + id;
	result = prime * result + priority;
	result = prime * result + ((product == null) ? 0 : product.hashCode());
	result = prime * result + state;
	result = prime * result + type;
	result = prime * result + ((updatetime == null) ? 0 : updatetime.hashCode());
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
	SimpleProblemVo other = (SimpleProblemVo) obj;
	if (createtime == null) {
		if (other.createtime != null)
			return false;
	} else if (!createtime.equals(other.createtime))
		return false;
	if (handlerName == null) {
		if (other.handlerName != null)
			return false;
	} else if (!handlerName.equals(other.handlerName))
		return false;
	if (headline == null) {
		if (other.headline != null)
			return false;
	} else if (!headline.equals(other.headline))
		return false;
	if (id != other.id)
		return false;
	if (priority != other.priority)
		return false;
	if (product == null) {
		if (other.product != null)
			return false;
	} else if (!product.equals(other.product))
		return false;
	if (state != other.state)
		return false;
	if (type != other.type)
		return false;
	if (updatetime == null) {
		if (other.updatetime != null)
			return false;
	} else if (!updatetime.equals(other.updatetime))
		return false;
	return true;
}


}
