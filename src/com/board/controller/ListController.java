package com.board.controller;

import com.board.VO.BasketVO;
import com.board.VO.BoardVO;
import com.board.VO.ChoiceVO;
import com.board.VO.ClientVO;
import com.board.VO.ImgVO;
import com.board.VO.OrderingVO;
import com.board.VO.ProductVO;
import com.board.dao.BoardDao;
import com.board.paging.Paging;
import com.board.paging.Paging1;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.lang.reflect.Array;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import org.apache.log4j.Logger;
import org.json.simple.JSONObject;
import org.omg.PortableInterceptor.SYSTEM_EXCEPTION;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class ListController {
	@SuppressWarnings("unused")
	private Logger log = Logger.getLogger(getClass());
	private int pageSize = 6;
	private int blockCount = 10;

	@Autowired
	private BoardDao boardDao;

	
	@RequestMapping(value= "/board/list.do")
	public ModelAndView list(
					@RequestParam(value = "pageNum", defaultValue = "1") int currentPage,
					@RequestParam(value = "keyField", defaultValue = "") String keyField,
					@RequestParam(value = "keyWord", defaultValue = "") String keyWord) {
		String pagingHtml = "";
		@SuppressWarnings({ "unchecked", "rawtypes" })
		HashMap<String, Object> map = new HashMap();
		map.put("keyField", keyField);
		map.put("keyWord", keyWord);
		int count = this.boardDao.getCount(map);
		Paging page = new Paging(keyField, keyWord, currentPage, count,
				this.pageSize, this.blockCount, "list.do");

		pagingHtml = page.getPagingHtml().toString();
		
		map.put("start", Integer.valueOf(page.getStartCount()));
		map.put("end", Integer.valueOf(page.getEndCount()));
		
		List<ProductVO> list = null;
		if (count > 0) {
			list = this.boardDao.list(map);
		} else {
			list = Collections.emptyList();
		}
		ModelAndView mav = new ModelAndView();
		mav.setViewName("mallList");
		mav.addObject("list", list);
		mav.addObject("count", Integer.valueOf(count));
		mav.addObject("currentPage", Integer.valueOf(currentPage));
		mav.addObject("pagingHtml", pagingHtml);
		return mav;
	}
	@RequestMapping({ "/board/join.do" })
	public ModelAndView join() {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("join");
		
		return mav;	
	}
	//회원가입
	@RequestMapping(value="/board/joinconfirm.do", method=RequestMethod.POST)
	public String joinconfirm(@ModelAttribute ClientVO bean) throws UnsupportedEncodingException{
		boardDao.joinconform(bean);	
		/*String a=bean.getClient_address();
		String [] charset={"utf-8","euc-kr","ksc5601","iso-8859-1","x-windows-949"};
		
		for(int i=0; i<charset.length; i++){
			for(int j=0; j<charset.length; j++){
				System.out.println("["+charset[i]+","+charset[j]+"]="+new String(a.getBytes(charset[i]),charset[j]));				
			}			
		}*/		
		return "redirect:list.do";
	}
	@RequestMapping({ "/board/duplid.do" })
	public String duplid(@ModelAttribute ClientVO bean, HttpServletResponse response) throws IOException {
		int a=boardDao.duplid(bean.getClient_id());
		
		JSONObject resultJson = new JSONObject();
		resultJson.put("duplnum", a);
		response.setContentType("text/xml;charset=utf-8");
		
		PrintWriter writer = response.getWriter();
        writer.print(resultJson);
        writer.flush();
        writer.close();
		return "join";	
	}
	@RequestMapping({ "/board/duplname.do" })
	public String duplname(@ModelAttribute ClientVO bean, HttpServletResponse response) throws IOException {
		int b=boardDao.duplname(bean);
		JSONObject resultJson = new JSONObject();
		resultJson.put("duplname", b);
		response.setContentType("text/xml;charset=utf-8");
		
		PrintWriter writer = response.getWriter();
        writer.print(resultJson);
        writer.flush();
        writer.close();
		return "join";	
	}
	@RequestMapping({ "/board/login.do" })
	public ModelAndView login() {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("login");
		
		return mav;	
	}	
	//로그인
	@RequestMapping({ "/board/loginconfirm.do" })
	public String loginconfirm(@ModelAttribute ClientVO bean, HttpServletRequest req) {
		
		HttpSession session=req.getSession(true);
		ClientVO login=boardDao.loginconfirm(bean);
		
		if(login ==null){
			session.setAttribute("login", null);		
		}
		else{			
			session.setAttribute("login", login);
		}
		ClientVO clientVO = (ClientVO)session.getAttribute("login");
		boardDao.updatechk(clientVO.getClient_id());
		
		return "redirect:list.do";
	}
	@RequestMapping({ "/board/checkinfo.do" })
	public String checkinfo(@ModelAttribute ClientVO bean, HttpServletResponse response) throws IOException{
			
		HashMap<String, Object> map = new HashMap();
		map.put("client_id", bean.getClient_id());
		map.put("client_pw",bean.getClient_pw());
		int chk=boardDao.checkinfo(map);
		
		JSONObject resultJson = new JSONObject();
		resultJson.put("chk", chk);
		response.setContentType("text/xml;charset=utf-8");
		
		PrintWriter writer = response.getWriter();
        writer.print(resultJson);
        writer.flush();
        writer.close();
		
		return "login";
	}
	@RequestMapping({ "/board/logout.do" })
	public String logout(HttpSession session){
			session.invalidate();
		
		return "redirect:list.do";
	}
	@RequestMapping(value= "/board/editinfo.do", method=RequestMethod.POST)
	public String editinfo(Model model,HttpServletRequest req,@ModelAttribute ClientVO VO){
		System.out.println(VO.getClient_no());
		HttpSession session=req.getSession(true);
		ClientVO clientVO = (ClientVO)session.getAttribute("login");
		int client_chk9=boardDao.ddcheck(clientVO.getClient_no());
		if(clientVO.getClient_chk()!=client_chk9-1){
			session.invalidate();
			return "login";
		}//새로 로그인했을 때 세션번호 체크 후 로그인 페이지로 이동
		
		ClientVO bean=boardDao.editinfo(VO.getClient_no());
		model.addAttribute("bean",bean);
		
		
		return "editinfo";
	}
	@RequestMapping({ "/board/updateinfo.do" })
	public String updateinfo(@ModelAttribute ClientVO bean){
		boardDao.updateinfo(bean);	
		return "redirect:list.do";
	}
	@RequestMapping({ "/board/searchid.do" })
	public ModelAndView searchid() {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("searchid");
		return mav;	
	}
	@RequestMapping({ "/board/findid.do" })
	public String findid(String client_name,String client_phone,HttpServletResponse response) throws IOException {
		try{
		HashMap<String, Object> map = new HashMap();
		map.put("client_name", client_name);
		map.put("client_phone", client_phone);
		ClientVO bean=boardDao.findid(map);
		JSONObject resultJson = new JSONObject();
		resultJson.put("client_id", bean.getClient_id());
		response.setContentType("text/xml;charset=utf-8");
		
		PrintWriter writer = response.getWriter();
        writer.print(resultJson);
        writer.flush();
        writer.close();
		}catch(NullPointerException e){
			System.out.println("nullpoint 무시");
		}finally{
		}
		return "searchid";	
		
	}
	@RequestMapping({ "/board/searchpw.do" })
	public ModelAndView searchpw() {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("searchpw");
		return mav;	
	}
	@RequestMapping({ "/board/findpw.do" })
	public String findpw(String client_name,String client_id,HttpServletResponse response) throws IOException {
		try{
		HashMap<String, Object> map = new HashMap();
		map.put("client_name", client_name);
		map.put("client_id", client_id);
		ClientVO bean=boardDao.findpw(map);
		JSONObject resultJson = new JSONObject();
		resultJson.put("client_pw", bean.getClient_pw());
		response.setContentType("text/xml;charset=utf-8");
		
		PrintWriter writer = response.getWriter();
        writer.print(resultJson);
        writer.flush();
        writer.close();
		}catch(NullPointerException e){
			System.out.println("nullpoint 무시");
		}finally{
		}
		return "searchpw";	
		
	}
	@RequestMapping({ "/board/pro_detail.do" })
	public String detail(Model model,@RequestParam(value="pro_no",required=false) int pro_no) {
		ProductVO bean=boardDao.pro_detail(pro_no);
		ImgVO bean1=boardDao.getimg(pro_no);
		model.addAttribute("bean",bean);
		model.addAttribute("bean1",bean1);
		List<ChoiceVO> list1 = null;
		HashMap<String, Object> map = new HashMap();
		list1 = this.boardDao.choiceone(map,pro_no);
		
		model.addAttribute("list1",list1);
		return "detail";	
	}
	@RequestMapping(value="/board/addbasket.do",method=RequestMethod.POST)
	public String addbasket(@ModelAttribute BasketVO bean,HttpServletRequest req) {
		
		HttpSession session=req.getSession(true);
		ClientVO clientVO = (ClientVO)session.getAttribute("login");
		int client_chk9=boardDao.ddcheck(clientVO.getClient_no());
		if(clientVO.getClient_chk()!=client_chk9-1){
			session.invalidate();
			return "login";
		}
		
		boardDao.addbasket(bean);	
		return "detail";
	}
	
	@RequestMapping(value="/board/checkbasket.do",method=RequestMethod.POST)
	public String checkbasket(@ModelAttribute BasketVO bean,HttpServletRequest req,HttpServletResponse response) throws IOException {
		
		//boardDao.addbasket(bean);	
		int basket_chk=boardDao.basketcnt(bean);
		if(basket_chk!=0){		
			boardDao.plusbasket(bean);
		}
		
		JSONObject resultJson = new JSONObject();
		resultJson.put("chkk", basket_chk);
		response.setContentType("text/xml;charset=utf-8");
		
		PrintWriter writer = response.getWriter();
        writer.print(resultJson);
        writer.flush();
        writer.close();
		return "detail";
	}
	
	
	@RequestMapping(value= "/board/basketlist.do" ,method=RequestMethod.POST)
	public String basketlist(Model model,HttpServletRequest req,@ModelAttribute ClientVO VO) {
		
		HttpSession session=req.getSession(true);
		ClientVO clientVO = (ClientVO)session.getAttribute("login");
		int client_chk9=boardDao.ddcheck(clientVO.getClient_no());
		if(clientVO.getClient_chk()!=client_chk9-1){
			session.invalidate();
			return "login";
		}
		
		List<BasketVO> list = null;
		List<BasketVO> list1 = null;
		HashMap<String, Object> map = new HashMap();
		HashMap<String, Object> map1 = new HashMap();
		list = this.boardDao.basketlist(map,VO.getClient_id());
		list1 = this.boardDao.basketlist1(map1,VO.getClient_id());
		model.addAttribute("list",list);
		model.addAttribute("list1",list1);
		return "basketlist";
	}
	@RequestMapping(value="/board/delbasket.do",method=RequestMethod.POST)
	public String delbasket(int[] basket_no,int cnt,HttpServletRequest req) {
	
		HttpSession session=req.getSession(true);
		ClientVO clientVO = (ClientVO)session.getAttribute("login");
		int client_chk9=boardDao.ddcheck(clientVO.getClient_no());
		if(clientVO.getClient_chk()!=client_chk9-1){
			session.invalidate();
			return "login";
		}
		for(int i=0; i<cnt; i++){
			boardDao.delbasket(basket_no[i]);	
			
		}
		
		return "basketlist";
	}
	@RequestMapping(value="/board/ddelbasket.do",method=RequestMethod.POST)
	public String ddelbasket(String[] basket_no,HttpServletRequest req) {
		
		System.out.println("sdf"+basket_no[1]);
		HttpSession session=req.getSession(true);
		ClientVO clientVO = (ClientVO)session.getAttribute("login");
		int client_chk9=boardDao.ddcheck(clientVO.getClient_no());
		if(clientVO.getClient_chk()!=client_chk9-1){
			session.invalidate();
			return "login";
		}
		for(int i=1; i<basket_no.length; i++){
			boardDao.ddelbasket(basket_no[i]);	
		}
		
		return "basketlist";
	}
	@RequestMapping(value="/board/buy.do",method=RequestMethod.GET)
	public String buy(Model model,@ModelAttribute OrderingVO bean,HttpServletRequest req) {
		
		HttpSession session=req.getSession(true);
		ClientVO clientVO = (ClientVO)session.getAttribute("login");
		int client_chk9=boardDao.ddcheck(clientVO.getClient_no());
		if(clientVO.getClient_chk()!=client_chk9-1){
			session.invalidate();
			return "login";
		}
	
		ProductVO bean1=boardDao.pro_detail(bean.getPro_no());
		ChoiceVO bean2=boardDao.choice_detail(bean.getChoice_no());
		model.addAttribute("bean",bean);
		model.addAttribute("bean1",bean1);
		model.addAttribute("bean2",bean2);
		return "buy";
	}
	@RequestMapping(value="/board/bbuy.do",method=RequestMethod.GET)
	public String buy1(Model model,@RequestParam(value="basket_no",required=false) String[] paychk,@RequestParam(value="numchk",required=false) String[] numchk,HttpServletRequest req) {
		
		String[] basket_no=paychk[0].split(",");
		String[] basket_cnt=numchk[0].split(",");
		
		for(int i=0; i<basket_no.length;i++){
			HashMap<String, Object> map1 = new HashMap();
			map1.put("basket_no",basket_no[i]);
			map1.put("basket_cnt",basket_cnt[i]);
			boardDao.updatebasket(map1);
		}
		
		HashMap<String, Object> map = new HashMap();
		List<BasketVO> list = null;
		
		list = this.boardDao.baskettopay(map,basket_no);
		
		model.addAttribute("list",list);
		
			
		return "bbuy";
	}
	@RequestMapping(value="/board/pay.do",method=RequestMethod.POST)
	public String pay(@ModelAttribute OrderingVO bean,HttpServletRequest req) {
		
		boardDao.pay(bean);
		HashMap<String, Object> map = new HashMap();
		map.put("choice_stock", bean.getOrdering_num());
		map.put("choice_no", bean.getChoice_no());
		boardDao.minusstock(map);
		return "redirect:list.do";
	}
	@RequestMapping(value="/board/bpay.do",method=RequestMethod.POST)
	public String pay(String[] basket_no,String ordering_request, String ordering_payment,HttpServletRequest req) {
		
		for(int i=1; i<basket_no.length; i++){
			BasketVO bean=boardDao.detailbasket(basket_no[i]);
			ProductVO bean1=boardDao.pro_detail(bean.getPro_no());
			HashMap<String, Object> map = new HashMap();
			HashMap<String, Object> map1 = new HashMap();
			map.put("pro_no", bean.getPro_no());
			map.put("choice_no", bean.getChoice_no());
			map.put("ordering_num",bean.getBasket_cnt());
			map.put("ordering_price", bean1.getPro_price());
			map.put("client_id",bean.getClient_id());
			map.put("ordering_request",ordering_request);
			map.put("ordering_payment", ordering_payment);
			map1.put("choice_no", bean.getChoice_no());
			map1.put("choice_stock", bean.getBasket_cnt());
			boardDao.btopay(map);	
			boardDao.minusstock(map1);
		}
		return "redirect:list.do";
	}
	@RequestMapping(value="/board/orderlist.do",method=RequestMethod.GET)
	public String orderlist(Model model,HttpServletRequest req,@RequestParam(value="client_id",required=false) String client_id,
			@RequestParam(value = "pageNum", defaultValue = "1") int currentPage,
			@RequestParam(value = "keyField", defaultValue = "") String keyField,
			@RequestParam(value = "keyWord", defaultValue = "") String keyWord) throws UnsupportedEncodingException {
		System.out.println("con");
		HttpSession session=req.getSession(true);
		ClientVO clientVO = (ClientVO)session.getAttribute("login");
		int client_chk9=boardDao.ddcheck(clientVO.getClient_no());
		if(clientVO.getClient_chk()!=client_chk9-1){
			session.invalidate();
			return "login";
		}
		//System.out.println(keyField);
		//System.out.println(keyWord);
		System.out.println("ddd"+currentPage);
		String pagingHtml = "";
		List<OrderingVO> list9 = null;
		HashMap<String, Object> map = new HashMap();
		map.put("client_id",client_id);
		map.put("keyField", keyField);
		map.put("keyWord", keyWord);
		int count=boardDao.orderCount(map);
		//System.out.println("cp"+PageNum);
		Paging1 page = new Paging1(keyField, keyWord, currentPage, count,
				this.pageSize, this.blockCount, "orderlist.do", client_id);
		
		pagingHtml = page.getPagingHtml().toString();
		map.put("start", Integer.valueOf(page.getStartCount()));
		map.put("end", Integer.valueOf(page.getEndCount()));
	
		list9 = this.boardDao.orderlist(map);
		model.addAttribute("pagingHtml",pagingHtml);
		model.addAttribute("list",list9);
		model.addAttribute("count",count);
		model.addAttribute("currentPage",currentPage);
		return "orderlist";
	}
	@RequestMapping(value="/board/abc.do",method=RequestMethod.POST)
	public String orderlist9(int currentPage) throws UnsupportedEncodingException {
		System.out.println("9999");
		
		System.out.println("cc"+currentPage);
		return"join";
	}
	
	/*@RequestMapping(value="/board/orderlist.do",method=RequestMethod.GET)
	public String orderlist1(Model model,HttpServletRequest req,@RequestParam(value="client_id",required=false) String client_id,
			@RequestParam(value = "pageNum", defaultValue = "1") int currentPage,
			@RequestParam(value = "keyField", defaultValue = "") String keyField,
			@RequestParam(value = "keyWord", defaultValue = "") String keyWord) throws UnsupportedEncodingException {
		
		HttpSession session=req.getSession(true);
		ClientVO clientVO = (ClientVO)session.getAttribute("login");
		int client_chk9=boardDao.ddcheck(clientVO.getClient_no());
		if(clientVO.getClient_chk()!=client_chk9-1){
			session.invalidate();
			return "login";
		}
		String pagingHtml = "";
		List<OrderingVO> list9 = null;
		HashMap<String, Object> map = new HashMap();
		map.put("client_id", client_id);
		map.put("keyField", keyField);
		map.put("keyWord", keyWord);
		int count=boardDao.orderCount(map);
		Paging1 page = new Paging1(keyField, keyWord, currentPage, count,
				this.pageSize, this.blockCount, "orderlist.do", client_id);
		
		pagingHtml = page.getPagingHtml().toString();
		map.put("start", Integer.valueOf(page.getStartCount()));
		map.put("end", Integer.valueOf(page.getEndCount()));
	
		list9 = this.boardDao.orderlist(map);
		model.addAttribute("pagingHtml",pagingHtml);
		model.addAttribute("list",list9);
		model.addAttribute("count",count);
		model.addAttribute("currentPage",currentPage);
		return "orderlist";
	}
	*/
	@RequestMapping(value="/board/confirmstatus.do",method=RequestMethod.POST)
	public String status(int ordering_status,HttpServletRequest req) {
		
		boardDao.status(ordering_status);
		System.out.println();
		
		
		return"orderlist";
	}
	@RequestMapping(value="/board/refundstatus.do",method=RequestMethod.POST)
	public String refund(int ordering_no,HttpServletRequest req) {
		boardDao.refund(ordering_no);
		return"orderlist";
	}
	@RequestMapping({ "/board/checkstock.do" })
	public String checkstock(int choice_no,HttpServletResponse response,HttpServletRequest req) throws IOException {
		
		try{
		
		int stock=boardDao.checkstock(choice_no);
		JSONObject resultJson = new JSONObject();
		resultJson.put("stock", stock);
		response.setContentType("text/xml;charset=utf-8");
		
		PrintWriter writer = response.getWriter();
        writer.print(resultJson);
        writer.flush();
        writer.close();
		}catch(NullPointerException e){
			System.out.println("nullpoint 무시");
		}finally{
		}
		return "buy";	
		
	}
	@RequestMapping({ "/board/ccheckstock.do" })
	public String ccheckstock(int[] chono,int[] basno,HttpServletResponse response,HttpServletRequest req) throws IOException {
		BasketVO bean=null;
		ProductVO bean1=null;
		int stock=0;
		int bbchk=0;
		PrintWriter writer = response.getWriter();
		JSONObject resultJson = new JSONObject();
		
		for(int i=0; i<chono.length; i++){
			stock=boardDao.checkstock(chono[i]);	
			bean=boardDao.checkcnt(basno[i]);
			bean1=boardDao.pro_detail(bean.getPro_no());
			System.out.println("stock"+stock);
			System.out.println("cnt"+bean.getBasket_cnt());
			if(stock>bean.getBasket_cnt()){
				bbchk=0;
			}else{
				bbchk=1;
				break;
			}
		}	
		System.out.println(bbchk);
		resultJson.put("stock", bbchk);
		response.setContentType("text/xml;charset=utf-8");
        writer.print(resultJson);
        writer.flush();
        writer.close();
		return "buy";	
	}
}
	

