package com.scit6jo.web.controller;

<<<<<<< HEAD
=======
import javax.servlet.http.HttpSession;

>>>>>>> 80812f0b683718742dd892a693fc448feb7478bb
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.scit6jo.web.dao.UserRepository;
import com.scit6jo.web.vo.User;

@Controller
public class UserController {
<<<<<<< HEAD
	@Autowired
	UserRepository Repository;

	@RequestMapping(value = "/registerForm", method = RequestMethod.GET)
	public String registerForm(Model model) {

		return "user/registerForm";
	}
	
	@RequestMapping(value = "/goinsert", method = RequestMethod.GET)
	public String goinsert(User user) {
		
		
		return "user/register";
=======
	
	@Autowired
	UserRepository repository;
	
	@RequestMapping(value = "/goLoginForm", method = RequestMethod.GET)
	public String goLoginForm() {
		System.out.println("going to LoginForm...");
		
		return "user/loginForm";
	}
	
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public String login(User user, HttpSession session, Model model) {
		System.out.println("login");
		
		User u = repository.selectOne(user);
	    
		if(u != null) {
			session.setAttribute("userid", u.getUserid());
			
			repository.attendNum(user); //출석일수
		}
	
		System.out.println(user);
		
		return "redirect:/";
	}
	
	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public String logout(HttpSession session) {
		
		session.invalidate();
		
		return "redirect:/";
>>>>>>> 80812f0b683718742dd892a693fc448feb7478bb
	}
	
}
