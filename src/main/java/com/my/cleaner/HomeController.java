package com.my.cleaner;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;



/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	@Autowired
	SqlSession session;
	@Autowired
	repo repo;
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home( Model model) {
		repo.updateDB();
		return "home";
	}
	
	@RequestMapping(value = "/customer", method = RequestMethod.GET)
	public String customerIndex( Model model) {

		return "customerIndex";
	}
	
	@RequestMapping(value = "/cleaner", method = RequestMethod.GET)
	public String cleanerIndex( Model model) {

		return "cleanerIndex";
		
	}
	//아 데이터에 아무것도 안쓴 상태로 파라미터로 멀 받을려니 에러뜨네;; 자바랑 같군;;
	@RequestMapping(value = "/updateDB", method = RequestMethod.GET)
	public @ResponseBody String updateDb() {
		repo.updateDB();		
	System.out.println("오고있니?");
		
		
		return "SUCCESS";
	}
	

	
}
