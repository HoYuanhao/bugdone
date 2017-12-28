package com.qcit.model;

public class IndexNumberStat {
private int createProjectNumber;
private int joinProjectNumber;
private int waitToSolveProblemNumber;
private int solveProblemNumber;
private int createProblemNumber;
public int getCreateProjectNumber() {
	return createProjectNumber;
}
public void setCreateProjectNumber(int createProjectNumber) {
	this.createProjectNumber = createProjectNumber;
}
public int getJoinProjectNumber() {
	return joinProjectNumber;
}
public void setJoinProjectNumber(int joinProjectNumber) {
	this.joinProjectNumber = joinProjectNumber;
}
public int getWaitToSolveProblemNumber() {
	return waitToSolveProblemNumber;
}
public void setWaitToSolveProblemNumber(int waitToSolveProblemNumber) {
	this.waitToSolveProblemNumber = waitToSolveProblemNumber;
}
public int getSolveProblemNumber() {
	return solveProblemNumber;
}
public void setSolveProblemNumber(int solveProblemNumber) {
	this.solveProblemNumber = solveProblemNumber;
}
public int getCreateProblemNumber() {
	return createProblemNumber;
}
public void setCreateProblemNumber(int createProblemNumber) {
	this.createProblemNumber = createProblemNumber;
}
@Override
public String toString() {
	return "IndexNumberStat [createProjectNumber=" + createProjectNumber + ", joinProjectNumber=" + joinProjectNumber
			+ ", waitToSolveProblemNumber=" + waitToSolveProblemNumber + ", solveProblemNumber=" + solveProblemNumber
			+ ", createProblemNumber=" + createProblemNumber + "]";
}


}
