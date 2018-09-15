package com.scit6jo.web.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.RowBounds;
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

import com.scit6jo.web.util.PageNavigator;


@Controller
public class WordController {
	
	@Autowired
	WordRepository repository;
	
	final int countPerPage=20;
	final int pagePerGroup=5;
	
	@RequestMapping(value = "/goWordtest", method = RequestMethod.GET)
	public String goWordtest() {
		
		return "word/wordpractice";
	}
	
	@RequestMapping(value = "/insertword", method = RequestMethod.GET)
	public String insertword() {
		
		return "word/insertNewWord";
	}
	
	// 관리자페이지 wordManager 화면 요청
	@RequestMapping(value = "/goWordManager", method = RequestMethod.GET)
	public String goWordManager(Model model, @RequestParam(value="page", defaultValue="1")int page, 
			@RequestParam(value="wordlevel", defaultValue="1")String wordlevel) {
		
		System.out.println("going to WordManager...");
		
		int total = repository.getTotal();
		
		// 페이지 계산을 위한 객체 생성
		PageNavigator navi = new PageNavigator(countPerPage, pagePerGroup, page, total);
		
		// 검색어와 시작 위치, 페이지당 글 수를 전달하여 목록
		RowBounds rb = new RowBounds(navi.getStartRecord(), navi.getCountPerPage());
		
		// 모든 단어 불러오기
		List<Word> wordlist = repository.selectAll(rb, wordlevel);
		
		model.addAttribute("wordlist", wordlist);
		model.addAttribute("navi", navi);
		model.addAttribute("wordlevel",	wordlevel);
		
		return "admin/wordManager";
	}
	
	// 관리자페이지 wordManager 단어추가 요청 
	@RequestMapping(value = "wordAdd", method = RequestMethod.POST)
	public @ResponseBody Integer wordAdd(@RequestBody Word word) {
		System.out.println("wordAdd...");
		
		System.out.println(word);
		
		int result = repository.addWord(word);
		
		if(result == 1) return 1;
		else			return 0;
	}
	
	// 관리자페이지 wordManager 업데이트 요청 
	@RequestMapping(value = "wordUpdate", method = RequestMethod.POST)
	public @ResponseBody Integer wordUpdate(@RequestBody Word word) {
		System.out.println("wordUpdate...");
		
		System.out.println(word);
		
		int result = repository.updateWord(word);
		
		if(result == 1) return 1;
		else			return 0;
	}
	
	// 관리자페이지 wordManager 삭제 요청 
	@RequestMapping(value = "wordDelete", method = RequestMethod.POST)
	public @ResponseBody int wordDelete(int wordNum) {
		System.out.println("wordDelete...");
		System.out.println(wordNum);
		
		Word word = new Word();
		word.setWordNum(wordNum);
		
		int result = repository.deleteWord(word);
		
		return result;
	}
	
	// 마이페이지 myWords 화면 요청 
	@RequestMapping(value = "/goMyWords", method = RequestMethod.GET)
	public String goMyWords(HttpSession session, Model model, @RequestParam(value="page", defaultValue="1")int page) {
		System.out.println("going to MyWords...");
		
		int total = repository.getMyTotal();
		
		// 페이지 계산을 위한 객체 생성
		PageNavigator navi = new PageNavigator(countPerPage, pagePerGroup, page, total);
		
		// 검색어와 시작 위치, 페이지당 글 수를 전달하여 목록
		RowBounds rb = new RowBounds(navi.getStartRecord(), navi.getCountPerPage());
				
		// 세션의 loginId로 내단어장 목록 가져오기  
		String userid = (String) session.getAttribute("loginId");
		List<Word> wordlist = repository.getMyWords(rb, userid);
		
		model.addAttribute("wordlist", wordlist);
		model.addAttribute("navi", navi);
		
		return "mypage/myWords";
	}

	// 마이페이지 myWords 단어추가 요청 
	@RequestMapping(value = "mywordAdd", method = RequestMethod.POST)
	public @ResponseBody boolean mywordAdd(@RequestBody Word word, HttpSession session) {
		System.out.println("mywordAdd...");
		
		String userid = (String) session.getAttribute("loginId");
		word.setUserid(userid);
		word.setWordtype("user");
		
		System.out.println(word);
		
		boolean result = repository.insertMyWord(word);
		
		return result;
	}
		
	// 마이페이지 myWords 업데이트 요청 
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
	
	// 마이페이지 myWords 삭제 요청 
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
		RowBounds rb = new RowBounds();
		//System.out.println(wordlevel);
		//String userid = "aaa";
		String userid = (String) session.getAttribute("loginId");
		//로그인과 합쳐져야 해서 세션의 로그인 
		if(wordlevel.equals("0")) {
			wList = repository.getMyWords(rb, userid);
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
//		word.setUserid("aaa");
		String userid = (String) session.getAttribute("loginId");
		word.setUserid(userid);
/*		System.out.println(word);
		System.out.println(command);
		System.out.println("wordtype"+word.getWordtype());
*/		
		System.out.println(word);
		
		if(command.equals("insert")) {
			if(word.getWordtype().equals("")) {
				word.setWordtype("star");
				System.out.println("일반단어 별찍기 in");
			}
			result =repository.insertMyWord(word);
		}else {
			System.out.println("삭제");
			word.setMyword_no(null);
			result =repository.deleteMyWord(word);
		}
		return result;
	}
	
}
