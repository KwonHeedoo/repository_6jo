package com.scit6jo.web.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class CompositionController {
	@RequestMapping(value = "/compositionForm", method = RequestMethod.GET)
	public String compositionForm() {
		System.out.println("going to CompositionForm...");
		
		return "composition/compositionForm";
	}
	
	@RequestMapping(value = "/confirm", method = RequestMethod.POST)
	public String confirm(String composition, String confirm, Model model) {
		String rep = "";
		String c = composition;
		rep = c.replace(".", " ");
		rep = rep.replace(",", " ");
		rep = rep.replace("\n", "");
		rep = rep.replace("\r", "");
		rep = rep.replace("  ", " ");
		rep = rep.replace("   ", " ");
		
		String[] list = rep.split(" ");
		
		Map<String, Integer> map = new HashMap<>();
			for (String temp : list) {
				Integer count = map.get(temp);
				map.put(temp, (count == null) ? 1 : count + 1);
			}
		printMap(map);
		
		model.addAttribute("composition", composition);
		model.addAttribute("map", map);
		
		return "composition/confirmedForm";
	}
	
	public List<String> makeArray(String key, Integer value){
	    List<String> firstStrings = new ArrayList<>();
	    for (int i = 0; i < value; i++) {
	        firstStrings.add(key);
	    }
	    return firstStrings;
	}
	
	public void printMap(Map<String, Integer> map){
	    List<List<String>> secondStrings = new ArrayList<>();
	    for (Map.Entry<String, Integer> entry : map.entrySet()) {
	        System.out.println("Element : " + entry.getKey() + " Count : " + entry.getValue());
	        secondStrings.add(makeArray(entry.getKey(), entry.getValue()));
	    }
	    System.out.println(secondStrings.toString());
	}

	@RequestMapping(value = "/confirmed", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> confirmed() {
		Map<String, Object> map = new HashMap<>();
		
		return map;
	}
}
