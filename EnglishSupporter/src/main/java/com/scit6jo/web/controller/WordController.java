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

import com.scit6jo.web.repository.WordRepository;
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
	public String goWordtest() {
		
		return "word/wordpractice";
	}
	
	@RequestMapping(value = "/insertword", method = RequestMethod.GET)
	public String insertword() {
		
		return "word/insertNewWord";
	}
	
	// 내단어장 화면 요청 
	@RequestMapping(value = "/goMyWords", method = RequestMethod.GET)
	public String goMyWords(HttpSession session, Model model) {
		System.out.println("going to MyWords...");
		
		// 세션의 loginId로 내단어장 목록 가져오기  
		String userid = (String) session.getAttribute("loginId");
		List<Word> wordlist = repository.getMyWords(userid);
		
		model.addAttribute("wordlist", wordlist);	
		
		return "mypage/myWords";
	}

	// 내단어장 업데이트 요청 
	@RequestMapping(value = "mywordUpdate", method = RequestMethod.POST)
	public @ResponseBody Integer mywordUpdate(@RequestBody Word word, HttpSession session) {
		System.out.println("mywordUpdate...");
		
		String userid = (String) session.getAttribute("loginId");
		word.setUserid(userid);
		
		System.out.println(word);
		
		int result = repository.updateMyWord(word);
		
		if(result == 1) return 1;
		else			return 0;
	}
	
	// 내단어장 삭제 요청 
	@RequestMapping(value = "mywordDelete", method = RequestMethod.POST)
	public @ResponseBody boolean mywordDelete(String myword_no, HttpSession session) {
		System.out.println("mywordDelete...");
		System.out.println(myword_no);
		
		String userid = (String) session.getAttribute("loginId");
		Word word = new Word();
		word.setUserid(userid);
		word.setMyword_no(myword_no);
		
		
		boolean result = repository.deleteMyWord(word);
		
		return result;
	}
	
	@RequestMapping(value = "/getMyWords", method = RequestMethod.POST)
	public @ResponseBody List<Word> getMyWords(@RequestParam(value="wordlevel", defaultValue="1")String wordlevel, HttpSession session) {
		List<Word> wList=null;
		//System.out.println(wordlevel);
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
	public @ResponseBody boolean controlMyWords(Word word, String command, HttpSession session) {
		boolean result =false;
		
		//본래 세션의 아이디를 가져와서 사용
		word.setUserid("aaa");
		
/*		System.out.println(word);
		System.out.println(command);
		System.out.println("wordtype"+word.getWordtype());
*/		
		if(command.equals("insert")) {
			if(word.getWordtype().equals("")) {
				word.setWordtype("star");
				System.out.println("일반단어 별찍기 in");
			}
			result =repository.insertMyWord(word);
		}else {
			result =repository.deleteMyWord(word);
		}
		return result;
	}
	
	
	
	
}
