package com.board.dao;

import com.board.VO.BasketVO;
import com.board.VO.BoardVO;
import com.board.VO.ChoiceVO;
import com.board.VO.ClientVO;
import com.board.VO.ImgVO;
import com.board.VO.OrderingVO;
import com.board.VO.ProductVO;
import com.board.dao.BoardDao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.stereotype.Component;

@Component
public class BoardDaoImpl extends SqlSessionDaoSupport implements BoardDao {
	
	public List<ProductVO> list(Map<String, Object> map) {
		List<ProductVO> list = getSqlSession().selectList("boardList", map);
		return list;
	}

	public int getCount(Map<String, Object> map) {
		return ((Integer) getSqlSession().selectOne("boardCount", map)).intValue();
	}

	@Override
	public void joinconform(ClientVO bean) {
		getSqlSession().insert("joinconfirm", bean);
		
	}

	@Override
	public ClientVO loginconfirm(ClientVO bean) {
		ClientVO login=getSqlSession().selectOne("loginconfirm", bean);
		
		return login;
	}

	@Override
	public ClientVO findid(HashMap<String, Object> map) {
		ClientVO bean = getSqlSession().selectOne("findid", map);
		return bean;
	}

	@Override
	public ProductVO pro_detail(int pro_no) {
		ProductVO bean=getSqlSession().selectOne("pro_detail", pro_no);
		return bean;
	}

	@Override
	public List<ChoiceVO> choiceone(HashMap<String, Object> map, int pro_no) {
		List<ChoiceVO> list1 = getSqlSession().selectList("choiceone", pro_no);
		return list1;
	}

	@Override
	public void addbasket(BasketVO bean) {
		getSqlSession().insert("addbasket", bean);
		
	}

	@Override
	public List<BasketVO> basketlist(HashMap<String, Object> map,String client_id) {
		List<BasketVO> list = getSqlSession().selectList("basketlist", client_id);
		return list;
	}

	@Override
	public void delbasket(int basket_no) {
		getSqlSession().delete("delbasket", basket_no);
		
	}

	@Override
	public ChoiceVO choice_detail(int choice_no) {
		ChoiceVO bean2=getSqlSession().selectOne("choice_detail", choice_no);
		return bean2;
	}

	@Override
	public void pay(OrderingVO bean) {
		getSqlSession().insert("pay", bean);
		
	}

	@Override
	public ClientVO editinfo(int client_no) {
		ClientVO bean = getSqlSession().selectOne("editinfo", client_no);
		return bean;
	}

	@Override
	public void updateinfo(ClientVO bean) {
		getSqlSession().update("updateinfo", bean);
		
	}

	@Override
	public List<OrderingVO> orderlist(HashMap<String, Object> map) {
		/*System.out.println(map.get("keyWord"));
		System.out.println(map.get("keyField"));
		System.out.println(map.get("client_id"));*/
		List<OrderingVO> list9 = getSqlSession().selectList("orderlist1", map);
		return list9;
	}

	@Override
	public List<BasketVO> basketlist1(HashMap<String, Object> map,String client_id) {
		List<BasketVO> list1 = getSqlSession().selectList("basketlist1", client_id);
		return list1;
	}

	@Override
	public List<BasketVO> baskettopay(HashMap<String, Object> map,String[] basket_no) {
		List<BasketVO> list = getSqlSession().selectList("bastkettopay", basket_no);
		return list;
	}

	@Override
	public BasketVO detailbasket(String basket_no) {
		BasketVO bean = getSqlSession().selectOne("detailbasket", basket_no);
		return bean;
	}

	@Override
	public void btopay(HashMap<String, Object> map) {
		getSqlSession().insert("btopay", map);
		
	}

	@Override
	public ClientVO findpw(HashMap<String, Object> map) {
		ClientVO bean = getSqlSession().selectOne("findpw", map);
		return bean;
	}

	@Override
	public void minusstock(HashMap<String, Object> map) {
		getSqlSession().update("minusstock", map);
		
	}

	@Override
	public int duplid(String client_id) {
		int a=getSqlSession().selectOne("duplid",client_id);
		return a;
	}

	@Override
	public int checkinfo(HashMap<String, Object> map) {
		int chk=getSqlSession().selectOne("checkinfo",map);
		return chk;
	}

	@Override
	public int orderCount(HashMap<String, Object> map) {
		int count=getSqlSession().selectOne("orderCount",map);
		return count;
	}

	@Override
	public void status(int ordering_status) {
		getSqlSession().update("status", ordering_status);
		
	}

	@Override
	public int checkstock(int choice_no) {
		int stock=getSqlSession().selectOne("checkstock",choice_no);
		return stock;
	}

	@Override
	public int checkchoice_no(String basket_no) {
		int a=getSqlSession().selectOne("checkchoice_no",basket_no);
		return a;
	}

	@Override
	public BasketVO checkcnt(int basno) {
		BasketVO bean=getSqlSession().selectOne("checkcnt",basno);
		return bean;
	}

	@Override
	public void updatechk(String client_no) {
		getSqlSession().update("updatechk",client_no);
		
	}

	@Override
	public int ddcheck(int client_no) {
		int client_chk9=getSqlSession().selectOne("ddcheck",client_no);
		return client_chk9;
	}

	@Override
	public void updatebasket(HashMap<String, Object> map1) {
		getSqlSession().update("updatebasket",map1);
		
	}

	@Override
	public ImgVO getimg(int pro_no) {
		ImgVO bean1=getSqlSession().selectOne("getimg",pro_no);
		return bean1;
	}

	@Override
	public int duplname(ClientVO bean) {
		int b=getSqlSession().selectOne("duplname",bean);
		return b;
	}

	@Override
	public void ddelbasket(String basket_no) {
		getSqlSession().delete("ddelbasket", basket_no);
		
	}

	@Override
	public int basketcnt(BasketVO bean) {
		int basket_chk=getSqlSession().selectOne("basketcnt",bean);
		return basket_chk;
	}

	@Override
	public void plusbasket(BasketVO bean) {
		getSqlSession().update("plusbasket",bean);
		
	}

	@Override
	public void refund(int ordering_no) {
		getSqlSession().update("refund",ordering_no);
		
	}

	
}
