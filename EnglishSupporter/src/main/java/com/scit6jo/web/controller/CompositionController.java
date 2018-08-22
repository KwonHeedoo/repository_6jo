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

import com.scit6jo.web.dao.WordRepository;
import com.scit6jo.web.util.CrawlingWord;

@Controller
public class CompositionController {
	@Autowired
	WordRepository repository;
	
	CrawlingWord cw = new CrawlingWord();
	
	@RequestMapping(value = "/goComposition", method = RequestMethod.GET)
	public String goComposition() {
		System.out.println("going to Composition...");
		
		return "composition/composition";
	}
	
	@RequestMapping(value = "/goConfirmed", method = RequestMethod.POST)
	public String goConfirmed(String composition, String confirm, Model model) {
		model.addAttribute("composition", composition);
		model.addAttribute("confirm", confirm);
		
		return "composition/confirmed";
	}

	@RequestMapping(value = "/repetitionCheck", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> repetitionCheck(String composition, String confirm) {
		Map<String, Object> map = new HashMap<>();
		
		// 중복단어 뽑기
		if(confirm.contains("repetition")) {
			String rep = "";
			rep = composition.replace(".", " ");
			rep = rep.replace(",", " ");
			rep = rep.replace("\n", " ");
			rep = rep.replace("\r", "");
			rep = rep.replace("  ", " ");
			rep = rep.replace("   ", " ");
			
			String[] list = rep.split(" ");
			
			Map<String, Integer> repMap = new HashMap<>();
			for (String temp : list) {
				Integer count = repMap.get(temp);
				repMap.put(temp, (count == null) ? 1 : count + 1);
			}
			//printMap(repMap);
			List<String> wordList = selectWord(repMap);
			map.put("wordList", wordList);
			
			// 유의어 찾기
			List<List<String>> synonymList = new ArrayList<>();
			try {
				synonymList = cw.crawling(wordList);
			} catch (Exception e) {
				e.printStackTrace();
			}
			map.put("synonymList", synonymList);
		}
		
		return map;
	}
	
	/*public List<String> makeArray(String key, Integer value){
	    List<String> firstStrings = new ArrayList<>();
	    for (int i = 0; i < value; i++) {
	        firstStrings.add(key);
	    }
	    return firstStrings;
	}
	
	public void printMap(Map<String, Integer> repMap){
	    List<List<String>> secondStrings = new ArrayList<>();
	    for (Map.Entry<String, Integer> entry : repMap.entrySet()) {
	        System.out.println("Element : " + entry.getKey() + " Count : " + entry.getValue());
	        secondStrings.add(makeArray(entry.getKey(), entry.getValue()));
	    }
	    System.out.println(secondStrings.toString());
	}*/
	
	public List<String> selectWord(Map<String, Integer> repMap){
		List<String> wordList = new ArrayList<>();
		
		// 예외 단어 리스트 요청
		List<String> exceptionWord = repository.exceptionWord();
		
		for (Map.Entry<String, Integer> entry : repMap.entrySet()) {
			boolean check = false;
	        System.out.println("Element : " + entry.getKey() + " Count : " + entry.getValue());
	        // 중복단어가 3개 이상이면 선택
	        if(entry.getValue() > 2) {
	        	// 예외 단어가 아니면 선택
	        	for(String word : exceptionWord) {
	        		if(entry.getKey().toLowerCase().equals(word)) check = true; break;
	        	}// for
	        	if(check == false) wordList.add(entry.getKey());
	        }// if
	    }// for
		
		return wordList;
	}
	
}
