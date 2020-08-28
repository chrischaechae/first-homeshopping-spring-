package com.board.VO;

public class BasketVO {

	private int basket_no;
	private String client_id;
	private int pro_no;
	private int choice_no;
	private int basket_cnt;
	
	private ProductVO ProductVO;
	private ChoiceVO ChoiceVO;
	
	
	public int getBasket_cnt() {
		return basket_cnt;
	}
	public void setBasket_cnt(int basket_cnt) {
		this.basket_cnt = basket_cnt;
	}
	public ChoiceVO getChoiceVO() {
		return ChoiceVO;
	}
	public void setChoiceVO(ChoiceVO choiceVO) {
		ChoiceVO = choiceVO;
	}
	public ProductVO getProductVO() {
		return ProductVO;
	}
	public void setProductVO(ProductVO productVO) {
		ProductVO = productVO;
	}
	public int getBasket_no() {
		return basket_no;
	}
	public void setBasket_no(int basket_no) {
		this.basket_no = basket_no;
	}
	public String getClient_id() {
		return client_id;
	}
	public void setClient_id(String client_id) {
		this.client_id = client_id;
	}
	public int getPro_no() {
		return pro_no;
	}
	public void setPro_no(int pro_no) {
		this.pro_no = pro_no;
	}
	public int getChoice_no() {
		return choice_no;
	}
	public void setChoice_no(int choice_no) {
		this.choice_no = choice_no;
	}
	
	
}
