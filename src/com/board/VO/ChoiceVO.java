package com.board.VO;

public class ChoiceVO {

	private int choice_no;
	private String choice_size;
	private String choice_color;
	private int choice_stock;
	private int pro_no;
	
	private OrderingVO OrderingVO;
	private ProductVO ProductVO;
	
	
	public int getChoice_no() {
		return choice_no;
	}
	public OrderingVO getOrderingVO() {
		return OrderingVO;
	}
	public void setOrderingVO(OrderingVO orderingVO) {
		OrderingVO = orderingVO;
	}
	public ProductVO getProductVO() {
		return ProductVO;
	}
	public void setProductVO(ProductVO productVO) {
		ProductVO = productVO;
	}
	public void setChoice_no(int choice_no) {
		this.choice_no = choice_no;
	}
	public String getChoice_size() {
		return choice_size;
	}
	public void setChoice_size(String choice_size) {
		this.choice_size = choice_size;
	}
	public String getChoice_color() {
		return choice_color;
	}
	public void setChoice_color(String choice_color) {
		this.choice_color = choice_color;
	}
	public int getChoice_stock() {
		return choice_stock;
	}
	public void setChoice_stock(int choice_stock) {
		this.choice_stock = choice_stock;
	}
	public int getPro_no() {
		return pro_no;
	}
	public void setPro_no(int pro_no) {
		this.pro_no = pro_no;
	}
	
	
	
}
