package com.scit6jo.web.controller;

import java.io.FileInputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.Locale;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.scit6jo.web.dao.DataRepository;
import com.scit6jo.web.dao.WordRepository;
import com.scit6jo.web.util.FileService;
import com.scit6jo.web.vo.InterviewData;

@Controller
public class InterviewController {
	
	@Autowired
	DataRepository repository;
	
	final String video_uploadPath = "/ES_uploadPath/video";
	final String image_uploadPath = "/ES_uploadPath/images";
	
	@RequestMapping(value = "/interview", method = RequestMethod.GET)
	public String interview(Locale locale, Model model) {
		
		return "interview/webRTC_Test";
	}
	@RequestMapping(value = "/savedata", method = RequestMethod.POST)
	//public @ResponseBody String senddata(@RequestParam("file") MultipartFile file) {
	public @ResponseBody String senddata(@RequestParam("file") MultipartFile file, HttpSession session) {
		String userid = (String)session.getAttribute("loginId");
		System.out.println("업로드 여부 : " + file + " ,파일의 크기 : " + file.getSize() + ", 비어있나? " + file.isEmpty());
		
		if (!file.isEmpty()) {
			System.out.println("File is exist");
			String saveFile = FileService.saveFile(file, video_uploadPath,userid);
			//String saveFile = FileService.saveFile(file, video_uploadPath,session.get(userid));
			InterviewData data = new InterviewData();
			data.setQuestionNum(1);
			data.setSaveFile(saveFile);
			data.setUserid(userid);
			data.setAnswer("test_answer");
				
			System.out.println("saveFile : " +saveFile);
		}

		return "#";
	}
	
}
