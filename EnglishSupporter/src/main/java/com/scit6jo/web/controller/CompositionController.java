package com.scit6jo.web.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.scit6jo.web.repository.WordRepository;
import com.scit6jo.web.util.CrawlingWord;
import com.scit6jo.web.vo.Word;

@Controller
public class CompositionController {
	@Autowired
	WordRepository repository;
	
	// 작문 작성 페이지 요청
	@RequestMapping(value = "/goComposition", method = RequestMethod.GET)
	public String goComposition() {
		System.out.println("going to Composition...");
		
		return "composition/composition";
	}
	
	// 작문 체크 페이지 요청
	@RequestMapping(value = "/goConfirmed", method = RequestMethod.POST)
	public String goConfirmed(String composition, String confirm, Model model) {
		System.out.println("going to Confirmed...");
		
		model.addAttribute("composition", composition);
		model.addAttribute("confirm", confirm);
		
		return "composition/confirmed";
	}
	
	// 중복 단어 및 유의어 체크
	@RequestMapping(value = "/repetitionCheck", method = RequestMethod.POST)
	public @ResponseBody List<Word> repetitionCheck(String composition, String confirm) {
		CrawlingWord cw = new CrawlingWord();
		
		List<Word> wordList = new ArrayList<Word>();
		
		// 중복단어 선별 및 유의어 찾기
		if(confirm.contains("repetition")) {
			String rep = "";
			rep = composition.replace(".", " ");
			rep = rep.replace(",", " ");
			rep = rep.replace("\n", " ");
			rep = rep.replace("\t", " ");
			rep = rep.replace("\r", "");
			rep = rep.replace("  ", " ");
			rep = rep.replace("   ", " ");
			
			String[] list = rep.split(" ");
			
			// 중복단어 및 갯수 선별
			Map<String, Integer> repMap = new HashMap<String, Integer>();
			for (String temp : list) {
				Integer count = repMap.get(temp);
				repMap.put(temp, (count == null) ? 1 : count + 1);
			}
			
			// wordList에 중복단어 추가
			wordList = selectWord(repMap);
			
			// 유의어 찾기
			try {
				wordList = cw.crawling(wordList);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		return wordList;
	}
	
	// 중복 단어 추가
	public List<Word> selectWord(Map<String, Integer> repMap){
		List<Word> wordList = new ArrayList<Word>();
		
		// 예외 단어 리스트 요청
		List<String> exceptionWord = repository.exceptionWord();
		
		for (Map.Entry<String, Integer> entry : repMap.entrySet()) {
			boolean check = false;
	        System.out.println("Element : " + entry.getKey() + " Count : " + entry.getValue());
	        // 중복단어가 3개 이상이면 추가
	        if(entry.getValue() > 2) {
	        	// 예외 단어 대조
	        	for(String word : exceptionWord) {
	        		if(entry.getKey().toLowerCase().equals(word)) {
	        			check = true;
	        			break;
	        		}// if
	        	}// for
	        	// 예외 단어가 아니면 추가
	        	if(check == false) wordList.add(new Word(entry.getKey()));
	        }// if
	    }// for
		
		return wordList;
	}// method
	
	// STT 새창 페이지 요청
	@RequestMapping(value = "/goSpeakingText", method = RequestMethod.GET)
	public String goSpeakingText() {
		System.out.println("going to SpeakingText...");
		
		return "composition/speakingText";
	}
	
}
