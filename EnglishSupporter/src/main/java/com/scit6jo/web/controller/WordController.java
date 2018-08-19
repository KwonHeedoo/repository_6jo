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
	
	@RequestMapping(value = "/goWordtest", method = RequestMethod.GET)
	public String home(Model model, @RequestParam(value="wordlevel", defaultValue="1")String wordlevel
			,String userid) {
		
		return "word/wordpractice";
	}

	
	@RequestMapping(value = "/getMyWords", method = RequestMethod.POST)
	public @ResponseBody List<Word> getMyWords(@RequestParam(value="wordlevel", defaultValue="1")String wordlevel, HttpSession session) {
		List<Word> wList=null;
		System.out.println(wordlevel);
		String userid = "aaa";
		//String userid = (String) session.getAttribute("userid");
		//로그인과 합쳐져야 해서 세션의 로그인 
		if(wordlevel.equals("0")) {
			wList = repository.getMyWords(userid);
			//System.out.println("0인경우 내단어장 불러오기");
			//System.out.println(wList);
		}else {
			wList=repository.getWordList(wordlevel, userid);
			//System.out.println("내단어장 아닌거 불러오기");
		}
		return wList;
	}
	
	@RequestMapping(value = "/controlMyWords", method = RequestMethod.POST)
	public @ResponseBody boolean deleteMyWords(Word word, String command, HttpSession session) {
		boolean result =false;
		
		//본래 세션의 아이디를 가져와서 사용
		word.setUserid("aaa");

		System.out.println(word);
		System.out.println(command);
		
		if(command.equals("insert")) {
			result =repository.insertMyWord(word);
		}else {
			result =repository.deleteMyWord(word);
		}
		
		
		return result;
	}
	
	
	
}
