package com.scit6jo.web.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

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
	public String home(Model model, @RequestParam(value="wordlevel", defaultValue="1")String wordlevel) {
		
		List<Word> wList=repository.getWordList(wordlevel);
		
		
		model.addAttribute("wordlist", wList);
		return "wordpractice";
	}
	
}
