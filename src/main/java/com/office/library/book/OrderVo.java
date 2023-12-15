package com.office.library.book;

import java.util.List;

public class OrderVo {
	int order_no;
	String order_status;
	String order_date;
	int u_m_no;
	String delivery_name;
	String delivery_address;
	String delivery_phone;
	String order_comment;
	int total_price;
	int cnt;
	
	String u_m_id;
	String u_m_pw;
	String u_m_name;
	String u_m_gender;
	String u_m_mail;
	String u_m_phone;
	String u_m_reg_date;
	String u_m_mod_date;
	String u_m_zipcode;
	String u_m_address;
	String u_m_address_sub;
	
	List<Integer> order_nos;
	List<Integer> order_qtys;
	
	int bm_no;
	String bm_name;
	String bm_author;
	String bm_publisher;
	String bm_isbn;
	int bm_price;
	int bm_quantity;
	String bm_photo0;
	String bm_photo1;
	String bm_photo2;
	
	int order_qty;
	
	
	public int getOrder_no() {
		return order_no;
	}
	public void setOrder_no(int order_no) {
		this.order_no = order_no;
	}
	public String getOrder_status() {
		return order_status;
	}
	public void setOrder_status(String order_status) {
		this.order_status = order_status;
	}
	public String getOrder_date() {
		return order_date;
	}
	public void setOrder_date(String order_date) {
		this.order_date = order_date;
	}
	public int getU_m_no() {
		return u_m_no;
	}
	public void setU_m_no(int u_m_no) {
		this.u_m_no = u_m_no;
	}
	public String getDelivery_name() {
		return delivery_name;
	}
	public void setDelivery_name(String delivery_name) {
		this.delivery_name = delivery_name;
	}
	public String getDelivery_address() {
		return delivery_address;
	}
	public void setDelivery_address(String delivery_address) {
		this.delivery_address = delivery_address;
	}
	public String getDelivery_phone() {
		return delivery_phone;
	}
	public void setDelivery_phone(String delivery_phone) {
		this.delivery_phone = delivery_phone;
	}
	public String getOrder_comment() {
		return order_comment;
	}
	public void setOrder_comment(String order_comment) {
		this.order_comment = order_comment;
	}
	public String getU_m_id() {
		return u_m_id;
	}
	public void setU_m_id(String u_m_id) {
		this.u_m_id = u_m_id;
	}
	public String getU_m_pw() {
		return u_m_pw;
	}
	public void setU_m_pw(String u_m_pw) {
		this.u_m_pw = u_m_pw;
	}
	public String getU_m_name() {
		return u_m_name;
	}
	public void setU_m_name(String u_m_name) {
		this.u_m_name = u_m_name;
	}
	public String getU_m_gender() {
		return u_m_gender;
	}
	public void setU_m_gender(String u_m_gender) {
		this.u_m_gender = u_m_gender;
	}
	public String getU_m_mail() {
		return u_m_mail;
	}
	public void setU_m_mail(String u_m_mail) {
		this.u_m_mail = u_m_mail;
	}
	public String getU_m_phone() {
		return u_m_phone;
	}
	public void setU_m_phone(String u_m_phone) {
		this.u_m_phone = u_m_phone;
	}
	public String getU_m_reg_date() {
		return u_m_reg_date;
	}
	public void setU_m_reg_date(String u_m_reg_date) {
		this.u_m_reg_date = u_m_reg_date;
	}
	public String getU_m_mod_date() {
		return u_m_mod_date;
	}
	public void setU_m_mod_date(String u_m_mod_date) {
		this.u_m_mod_date = u_m_mod_date;
	}
	public String getU_m_zipcode() {
		return u_m_zipcode;
	}
	public void setU_m_zipcode(String u_m_zipcode) {
		this.u_m_zipcode = u_m_zipcode;
	}
	public String getU_m_address() {
		return u_m_address;
	}
	public void setU_m_address(String u_m_address) {
		this.u_m_address = u_m_address;
	}
	public String getU_m_address_sub() {
		return u_m_address_sub;
	}
	public void setU_m_address_sub(String u_m_address_sub) {
		this.u_m_address_sub = u_m_address_sub;
	}
	
	public List<Integer> getOrder_nos() {
		return order_nos;
	}
	public void setOrder_nos(List<Integer> order_nos) {
		this.order_nos = order_nos;
	}
	public List<Integer> getOrder_qtys() {
		return order_qtys;
	}
	public void setOrder_qtys(List<Integer> order_qtys) {
		this.order_qtys = order_qtys;
	}
	public int getBm_no() {
		return bm_no;
	}
	public void setBm_no(int bm_no) {
		this.bm_no = bm_no;
	}
	public String getBm_name() {
		return bm_name;
	}
	public void setBm_name(String bm_name) {
		this.bm_name = bm_name;
	}
	public String getBm_author() {
		return bm_author;
	}
	public void setBm_author(String bm_author) {
		this.bm_author = bm_author;
	}
	public String getBm_publisher() {
		return bm_publisher;
	}
	public void setBm_publisher(String bm_publisher) {
		this.bm_publisher = bm_publisher;
	}
	public String getBm_isbn() {
		return bm_isbn;
	}
	public void setBm_isbn(String bm_isbn) {
		this.bm_isbn = bm_isbn;
	}
	public int getBm_price() {
		return bm_price;
	}
	public void setBm_price(int bm_price) {
		this.bm_price = bm_price;
	}
	public int getBm_quantity() {
		return bm_quantity;
	}
	public void setBm_quantity(int bm_quantity) {
		this.bm_quantity = bm_quantity;
	}
	public String getBm_photo0() {
		return bm_photo0;
	}
	public void setBm_photo0(String bm_photo0) {
		this.bm_photo0 = bm_photo0;
	}
	public String getBm_photo1() {
		return bm_photo1;
	}
	public void setBm_photo1(String bm_photo1) {
		this.bm_photo1 = bm_photo1;
	}
	public String getBm_photo2() {
		return bm_photo2;
	}
	public void setBm_photo2(String bm_photo2) {
		this.bm_photo2 = bm_photo2;
	}
	public int getOrder_qty() {
		return order_qty;
	}
	public void setOrder_qty(int order_qty) {
		this.order_qty = order_qty;
	}
	public int getTotal_price() {
		return total_price;
	}
	public void setTotal_price(int total_price) {
		this.total_price = total_price;
	}
	public int getCnt() {
		return cnt;
	}
	public void setCnt(int cnt) {
		this.cnt = cnt;
	}
	
				
	
	
}
