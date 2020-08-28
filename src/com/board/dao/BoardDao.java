package com.board.dao;

import com.board.VO.BasketVO;
import com.board.VO.BoardVO;
import com.board.VO.ChoiceVO;
import com.board.VO.ClientVO;
import com.board.VO.ImgVO;
import com.board.VO.OrderingVO;
import com.board.VO.ProductVO;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public abstract interface BoardDao {
	
	public abstract List<ProductVO> list(Map<String, Object> paramMap);

	public abstract int getCount(Map<String, Object> paramMap);

	public abstract void joinconform(ClientVO bean);

	public abstract ClientVO loginconfirm(ClientVO bean);

	public abstract ClientVO findid(HashMap<String, Object> map);

	public abstract ProductVO pro_detail(int pro_no);

	public abstract List<ChoiceVO> choiceone(HashMap<String, Object> map,int pro_no);

	public abstract void addbasket(BasketVO bean);

	public abstract List<BasketVO> basketlist(HashMap<String, Object> map,String client_id);

	public abstract void delbasket(int basket_no);

	public abstract ChoiceVO choice_detail(int choice_no);

	public abstract void pay(OrderingVO bean);

	public abstract ClientVO editinfo(int client_no);

	public abstract void updateinfo(ClientVO bean);

	public abstract List<OrderingVO> orderlist(HashMap<String, Object> map);

	public abstract List<BasketVO> basketlist1(HashMap<String, Object> map,String client_id);

	public abstract List<BasketVO> baskettopay(HashMap<String, Object> map,String[] basket_no);

	public abstract BasketVO detailbasket(String basket_no);

	public abstract void btopay(HashMap<String, Object> map);

	public abstract ClientVO findpw(HashMap<String, Object> map);

	public abstract void minusstock(HashMap<String, Object> map);

	public abstract int duplid(String client_id);

	public abstract int checkinfo(HashMap<String, Object> map);

	public abstract int orderCount(HashMap<String, Object> map);

	public abstract void status(int ordering_status);

	public abstract int checkstock(int choice_no);

	public abstract int checkchoice_no(String basket_no);

	public abstract BasketVO checkcnt(int basno);

	public abstract void updatechk(String string);

	public abstract int ddcheck(int client_no);

	public abstract void updatebasket(HashMap<String, Object> map1);

	public abstract ImgVO getimg(int pro_no);

	public abstract int duplname(ClientVO bean);

	public abstract void ddelbasket(String basket_no);

	public abstract int basketcnt(BasketVO bean);

	public abstract void plusbasket(BasketVO bean);

	public abstract void refund(int ordering_no);

	


	


	


}
