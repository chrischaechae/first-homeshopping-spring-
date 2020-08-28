package com.board.VO;

import java.sql.Date;

public class OorderingVO {

	private int ordering_no;
	private int ordering_num;
	private int ordering_price;
	private String pro_name;
	private String pro_img;
	private String choice_size;
	private Date ordering_date;
	private int ordering_confirm;
	private String ordering_request;
	private String ordering_payment;
	
	
	
	public String getOrdering_request() {
		return ordering_request;
	}
	public void setOrdering_request(String ordering_request) {
		this.ordering_request = ordering_request;
	}
	public String getOrdering_payment() {
		return ordering_payment;
	}
	public void setOrdering_payment(String ordering_payment) {
		this.ordering_payment = ordering_payment;
	}
	public int getOrdering_confirm() {
		return ordering_confirm;
	}
	public void setOrdering_confirm(int ordering_confirm) {
		this.ordering_confirm = ordering_confirm;
	}
	private String ordering_status;
	private String choice_color;
	
	private ProductVO ProductVO;
	private ChoiceVO ChoiceVO;
	
	
	public int getOrdering_no() {
		return ordering_no;
	}
	public void setOrdering_no(int ordering_no) {
		this.ordering_no = ordering_no;
	}
	public ProductVO getProductVO() {
		return ProductVO;
	}
	public void setProductVO(ProductVO productVO) {
		ProductVO = productVO;
	}
	public ChoiceVO getChoiceVO() {
		return ChoiceVO;
	}
	public void setChoiceVO(ChoiceVO choiceVO) {
		ChoiceVO = choiceVO;
	}
	public int getOrdering_num() {
		return ordering_num;
	}
	public void setOrdering_num(int ordering_num) {
		this.ordering_num = ordering_num;
	}
	public int getOrdering_price() {
		return ordering_price;
	}
	public void setOrdering_price(int ordering_price) {
		this.ordering_price = ordering_price;
	}
	public String getPro_name() {
		return pro_name;
	}
	public void setPro_name(String pro_name) {
		this.pro_name = pro_name;
	}
	public String getPro_img() {
		return pro_img;
	}
	public void setPro_img(String pro_img) {
		this.pro_img = pro_img;
	}
	public String getChoice_size() {
		return choice_size;
	}
	public void setChoice_size(String choice_size) {
		this.choice_size = choice_size;
	}
	public Date getOrdering_date() {
		return ordering_date;
	}
	public void setOrdering_date(Date ordering_date) {
		this.ordering_date = ordering_date;
	}
	public String getOrdering_status() {
		return ordering_status;
	}
	public void setOrdering_status(String ordering_status) {
		this.ordering_status = ordering_status;
	}
	public String getChoice_color() {
		return choice_color;
	}
	public void setChoice_color(String choice_color) {
		this.choice_color = choice_color;
	}
	
	
	
}
