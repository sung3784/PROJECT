package com.my.cleaner;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.my.cleaner.dao.customerMapper;
import com.my.cleaner.dao.wantedCustomerMapper;
import com.my.cleaner.vo.Customer;
import com.my.cleaner.vo.wantedCustomer;

@Controller
public class CustomerController {
	@Autowired
	SqlSession session;
	@Autowired
	repo repo;

	@RequestMapping(value = "/customerJoin", method = RequestMethod.POST)
	public String home(Customer cust, Model model) {
		customerMapper mapper = session.getMapper(customerMapper.class);
		int result = 0;
		result = mapper.insertCustomer(cust);
		if (result == 0) {
			System.out.println("회원가입 실패");
		} else {
			System.out.println("회원가입 성공");
		}
		return "redirect:/customer";
	}

	@RequestMapping(value = "/customerLogin", method = RequestMethod.POST)
	public String login(Customer cust, Model model, HttpSession hsession) {
		customerMapper mapper = session.getMapper(customerMapper.class);
		Customer customer = null;

		customer = mapper.selectOneCustomer(cust);
		if (customer == null) {
			return "redirect:/customer";
		} else {

			hsession.setAttribute("loginId", customer.getId());
			hsession.setAttribute("customerUniqueNumber", customer.getCustomerNumber());

			return "redirect:/CustomerMainPage";
		}
	}

	@RequestMapping(value = "/CustomerMainPage", method = RequestMethod.GET)
	public String CustomerMainPage(Model model, HttpSession hsession) {
		wantedCustomerMapper mapper = session.getMapper(wantedCustomerMapper.class);
		int customerNumber = 0;
		customerNumber = (Integer) hsession.getAttribute("customerUniqueNumber");
		List<wantedCustomer> list = null;
		list = mapper.selectOneWC(customerNumber);
		model.addAttribute("list", list);

		return "CustomerMainPage";
	}

	@RequestMapping(value = "/cleaningRegist", method = RequestMethod.GET)
	public String cleaningRegist(Model model, HttpSession hsession) {
		customerMapper mapper = session.getMapper(customerMapper.class);
		Customer cust = null;
		int custNum = 0;
		custNum = (Integer) hsession.getAttribute("customerUniqueNumber");

		Customer customer = null;
		customer = mapper.CustomerDetail(custNum);
		/* System.out.println(customer); */
		List<String> address = null;
		address = new ArrayList<String>();

		String[] a = null;
		String[] b = null;
		a = customer.getAddress().split(",");
		b = customer.getAddress2().split(",");
		for (int i = 0; i < a.length; i++) {
			address.add(a[i] + "," + b[i]);
		}
		model.addAttribute("address", address);
		model.addAttribute("customer", customer);

		return "cleaningRegist";
	}

	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public String logout(Model model, HttpSession hsession) {
		customerMapper mapper = session.getMapper(customerMapper.class);
		hsession.invalidate();

		return "redirect:/";
	}

	@RequestMapping(value = "/modifyCustomer", method = RequestMethod.GET)
	public String modifyCustomer(Model model, HttpSession hsession) {
		customerMapper mapper = session.getMapper(customerMapper.class);
		int num = (Integer) hsession.getAttribute("customerUniqueNumber");
		Customer cust = null;
		cust = mapper.CustomerDetail(num);
		List<String> list = new ArrayList<String>();
		String[] a = null;
		String[] b = null;
		a = cust.getAddress().split(",");
		b = cust.getAddress2().split(",");
		for (int i = 0; i < a.length; i++) {
			list.add(a[i] + "," + b[i]);
		}

		model.addAttribute("list", list);
		model.addAttribute("customer", cust);

		return "modifyCustomer";
	}

	@RequestMapping(value = "/modifyFinish", method = RequestMethod.GET)
	public String modifyFinish(Model model, HttpSession hsession, Customer customer) {
		customerMapper mapper = session.getMapper(customerMapper.class);
		System.out.println(customer);
		int num = (Integer) hsession.getAttribute("customerUniqueNumber");
		String address = "";
		address = customer.getAddress();
		String address2 = "";
		address2 = customer.getAddress2();
		String[] total = null;
		if (customer.getTotalAddress() != null) {
			total = customer.getTotalAddress().split(",");

			for (int i = 0; i < total.length; i++) {
				if (i % 2 == 0) {
					address += "," + total[i];
				} else {
					address2 += "," + total[i];
				}

			}
		}

		Customer cust = null;
		cust = new Customer();
		cust.setAddress(address);
		cust.setAddress2(address2);
		cust.setPhone(customer.getPhone());
		cust.setCustomerNumber(num);
		mapper.updateCustomer(cust);
		return "redirect:/CustomerMainPage";
	}

	@RequestMapping(value = "/wantedCustomer", method = RequestMethod.GET)
	public String wantedCustomer(Model model, HttpSession hsession, String address, String wantedTime, int specificTime,
			String details) {
		System.out.println("이까지왓나?");
		System.out.println(address + "," + wantedTime + "," + specificTime + "," + details);
		wantedCustomerMapper mapper = session.getMapper(wantedCustomerMapper.class);
		customerMapper mapper1 = session.getMapper(customerMapper.class);
		String[] a = address.split(",");
		Customer cust = null;
		wantedCustomer wc = null;
		cust = mapper1.CustomerDetail((Integer) hsession.getAttribute("customerUniqueNumber"));

		wc = new wantedCustomer();
		wc.setClientNumber(cust.getCustomerNumber());
		wc.setName(cust.getName());
		wc.setPhone(cust.getPhone());
		wc.setAddress(a[0]);
		wc.setAddress2(a[1]);
		wc.setWantedTime(wantedTime);
		wc.setSpecificTime(specificTime);
		wc.setDetails(details);

		mapper.insertWantedCustomer(wc);

		return "redirect:/CustomerMainPage";
	}

	@RequestMapping(value = "/example", method = RequestMethod.GET)
	public @ResponseBody List<List<String>> home(HttpSession hsession) {

		customerMapper mapper = session.getMapper(customerMapper.class);
		Customer cust = null;
		int custNum = 0;
		custNum = (Integer) hsession.getAttribute("customerUniqueNumber");

		Customer customer = null;
		customer = mapper.CustomerDetail(custNum);
		/* System.out.println(customer); */
		List<String> address = null;
		address = new ArrayList<String>();

		String[] a = null;
		String[] b = null;
		a = customer.getAddress().split(",");
		b = customer.getAddress2().split(",");
		List<String> list = null;
		list = new ArrayList<String>();
		for (int i = 0; i < a.length; i++) {
			list.add(a[i]);
		}
		for (int i = 0; i < a.length; i++) {
			address.add(a[i] + "," + b[i]);
		}
		List<List<String>> list2 = null;
		list2 = new ArrayList<List<String>>();
		list2.add(list);
		list2.add(address);
		return list2;
	}

}
