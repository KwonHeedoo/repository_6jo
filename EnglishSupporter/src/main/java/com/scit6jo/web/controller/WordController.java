package com.scit6jo.web.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.scit6jo.web.dao.WordRepository;
import com.scit6jo.web.vo.Word;

@Controller
public class WordController {
	@Autowired
	WordRepository repository;
	
	/*@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Model model) {
		
		return "home";
	}*/
	
	@RequestMapping(value = "/wordtest", method = RequestMethod.GET)
	public String home(Model model, @RequestParam(value="wordlevel", defaultValue="1")String wordlevel
			,String userid) {
		
		List<Word> wList=repository.getWordList(wordlevel,userid);
		
		model.addAttribute("wordlist", wList);
		return "wordpractice";
	}

	
	@RequestMapping(value = "/getMyWords", method = RequestMethod.POST)
	public @ResponseBody List<Word> home(@RequestParam(value="wordlevel", defaultValue="1")String wordlevel, HttpSession session) {
		List<Word> wList=null;
		String userid = "aaa";
		//String userid = (String) session.getAttribute("userid");
		//로그인과 합쳐져야 해서 세션의 로그인 
		if(!wordlevel.equals("0")) {
			wList = repository.getMyWords(userid);
		}else {
			wList=repository.getWordList(wordlevel, userid);
		}
		return wList;
	}
	
	
	
}
