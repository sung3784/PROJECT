package com.my.cleaner;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.my.cleaner.dao.cleanerMapper;
import com.my.cleaner.dao.wantedCustomerMapper;
import com.my.cleaner.util.PageNavigator;
import com.my.cleaner.vo.Cleaner;
import com.my.cleaner.vo.wantedCustomer;

@Controller
public class CleanerController {
	final int countPerPage = 5;
	final int pagePerGroup = 5;
	
	@Autowired
	SqlSession session;
	
	@RequestMapping(value = "/cleanerJoin", method = RequestMethod.POST)
	public String cleanerJOIN(Cleaner cleaner, Model model) {
		cleanerMapper mapper=session.getMapper(cleanerMapper.class);
		int result=0;
		result=mapper.insertCleaner(cleaner);
		if(result==1){
			System.out.println("가입성공");
		}else {
			System.out.println("가입 실패");
		}
		return "redirect:/cleaner";
	}
	
	@RequestMapping(value = "/cleanerLogin", method = RequestMethod.POST)
	public String cleanerLOGIN(Cleaner cleaner, Model model,HttpSession hsession) {
		cleanerMapper mapper=session.getMapper(cleanerMapper.class);
		System.out.println(cleaner);
		Cleaner cl=null;
		cl=mapper.selectOneCleaner(cleaner);
		if(cl==null) {
			System.out.println("로그인 정보없음.");
			return "redirect:/cleaner";
		}else {
			hsession.setAttribute("cloginId", cl.getId());
			hsession.setAttribute("uniqueNumber", cl.getCleanerNumber());	
			return "redirect:/cleanerMainPage";
		}
	}
	
	@RequestMapping(value = "/cleanerlogout", method = RequestMethod.GET)
	public String cleanerlogout( Model model,HttpSession hsession) {
		cleanerMapper mapper=session.getMapper(cleanerMapper.class);
		hsession.invalidate();
		
		
		return "redirect:/";
	}
	/*@RequestMapping(value = "/WCdetail", method = RequestMethod.GET)
	public String WCdetail( Model model,HttpSession hsession,int seqwc) {
		wantedCustomerMapper mapper=session.getMapper(wantedCustomerMapper.class);
		System.out.println("넘버넘버"+seqwc);
		
		
		return "wcDetail";
	}*/
	
	@RequestMapping(value = "/boardDetail", method = RequestMethod.GET)
	public String boardDetail( Model model,HttpSession hsession,int number) {
		wantedCustomerMapper mapper=session.getMapper(wantedCustomerMapper.class);
		wantedCustomer wc=null;		
		wc=mapper.boardDetail(number);
		
		model.addAttribute("wc", wc);
		return "boardDetail";
	}
	
	
	@RequestMapping(value = "/cleanerMainPage", method = RequestMethod.GET)
	public String cleanerMainPage(@RequestParam(value="page", defaultValue="1") int page,
									@RequestParam(value="search", defaultValue="") String search,Model model) {
		wantedCustomerMapper mapper=session.getMapper(wantedCustomerMapper.class);
		List<wantedCustomer> list=null;
		int result=0;
		// 게시글 전체 개수 조회
		int total = mapper.getTotal(search);
		//페이지 계산을 위한 객체 생성
		PageNavigator navi = new PageNavigator(countPerPage, pagePerGroup, page, total);
		
		//검색어와 시작 위치, 페이지당 글 수를 전달하여 목록 읽기
		RowBounds rb = new RowBounds(navi.getStartRecord(), navi.getCountPerPage());//RowBounds :: 어디서부터 어디 까지 가져오라는 객체
		list=mapper.SelectAllwcwc(rb, search);
		
		model.addAttribute("list", list);
		model.addAttribute("navi", navi);
		return "cleanerMainPage";
	}
	
	/*@RequestBody String aa 이거  파라미터 안에 넣어야함.*/
	@RequestMapping(value="/MapForCleaner", method=RequestMethod.GET)
	public @ResponseBody List<wantedCustomer> CleanerMap(
			@RequestParam(value="search", defaultValue="") String search){
		
		System.out.println("여기로 들어오냐 닝럼나ㅣ어리ㅏㅁㄴ어ㅏㅣ러");
		System.out.println("search:::"+search);
		wantedCustomerMapper mapper=session.getMapper(wantedCustomerMapper.class);
		List<wantedCustomer> list=null;
		int result=0;
		
		
	
		list=mapper.SelectAllforMap(search);
		System.out.println("리스트 사이즈"+list.size());
		/*for(wantedCustomer h : list) {
			System.out.println(h);
		}*/
		
	
		
		return list;
	}
}
