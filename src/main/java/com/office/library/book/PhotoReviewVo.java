package com.office.library.book;

import java.util.List;

public class PhotoReviewVo {

	int pr_no;
	int u_m_no;
	String pr_name;
	String pr_author;
	String pr_publisher;
	String pr_photo0;
	String pr_photo1;
	String pr_photo2;
	List<String> pr_photo;
	int pr_hit;
	
	public int getPr_no() {
		return pr_no;
	}
	public void setPr_no(int pr_no) {
		this.pr_no = pr_no;
	}
	public int getU_m_no() {
		return u_m_no;
	}
	public void setU_m_no(int u_m_no) {
		this.u_m_no = u_m_no;
	}
	public String getPr_name() {
		return pr_name;
	}
	public void setPr_name(String pr_name) {
		this.pr_name = pr_name;
	}
	public String getPr_author() {
		return pr_author;
	}
	public void setPr_author(String pr_author) {
		this.pr_author = pr_author;
	}
	public String getPr_publisher() {
		return pr_publisher;
	}
	public void setPr_publisher(String pr_publisher) {
		this.pr_publisher = pr_publisher;
	}
	public List<String> getPr_photo() {
		return pr_photo;
	}
	public void setPr_photo(List<String> pr_photo) {
		this.pr_photo = pr_photo;
	}
	public String getPr_photo0() {
		return pr_photo0;
	}
	public void setPr_photo0(String pr_photo0) {
		this.pr_photo0 = pr_photo0;
	}
	public String getPr_photo1() {
		return pr_photo1;
	}
	public void setPr_photo1(String pr_photo1) {
		this.pr_photo1 = pr_photo1;
	}
	public String getPr_photo2() {
		return pr_photo2;
	}
	public void setPr_photo2(String pr_photo2) {
		this.pr_photo2 = pr_photo2;
	}
	public int getPr_hit() {
		return pr_hit;
	}
	public void setPr_hit(int pr_hit) {
		this.pr_hit = pr_hit;
	}
	
	
	
}
