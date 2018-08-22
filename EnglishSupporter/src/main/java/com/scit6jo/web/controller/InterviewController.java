package com.scit6jo.web.controller;

import java.io.FileInputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.Locale;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.google.gson.JsonObject;
import com.scit6jo.web.dao.DataRepository;
import com.scit6jo.web.dao.WordRepository;
import com.scit6jo.web.util.AudioConverter;
import com.scit6jo.web.util.FileService;
import com.scit6jo.web.util.SpeechToText;
import com.scit6jo.web.vo.IData;
import com.scit6jo.web.vo.IQuestion;

@Controller
public class InterviewController {

	@Autowired
	DataRepository repository;

	final String video_uploadPath = "c://ES_uploadPath//video";
	final String image_uploadPath = "c://ES_uploadPath//images";
	final String uploadPath = "c://ES_uploadPath";

	@RequestMapping(value = "/interview", method = RequestMethod.GET)
	public String interview(Model model) {
		ArrayList<IQuestion> result = repository.selectAllQuestion();
		return "interview/interview";
	}

	@RequestMapping(value = "/getQuestion", method = RequestMethod.POST)
	public @ResponseBody ArrayList<IQuestion> getQuestion() {
		ArrayList<IQuestion> result = repository.selectAllQuestion();
		Collections.shuffle(result);
		return result;
	}

	@RequestMapping(value = "/savedata", method = RequestMethod.POST)
	// public @ResponseBody String senddata(@RequestParam("file") MultipartFile
	// file) {
	public @ResponseBody String senddata(HttpSession session, @RequestParam("file") MultipartFile file,
			@RequestParam("questionNum") int questionNum) {
		String userid = (String) session.getAttribute("loginId");
		System.out.println("업로드 여부 : " + file + " ,파일의 크기 : " + file.getSize() + ", 비어있나? " + file.isEmpty());

		if (!file.isEmpty()) {
			System.out.println("File is exist");
			String saveFile = FileService.saveFile(file, video_uploadPath, userid);
			// String saveFile = FileService.saveFile(file,
			// video_uploadPath,session.get(userid));
			String audioPathFile = videoToAudio(saveFile,userid);
			SpeechToText qss = new SpeechToText();
			String answerToText = "no answer";
			try {
				answerToText = qss.ChangeSTT(audioPathFile);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			System.out.println("answer : " + answerToText);
			
			IData data = new IData();
			data.setQuestionNum(questionNum);
			data.setSaveFile(saveFile);
			data.setUserid(userid);
			data.setAnswer(answerToText);

			System.out.println("saveFile : " + saveFile);
			repository.insertIData(data);
			ArrayList<IData> result = repository.selectAlIData(userid);
			return String.valueOf(result.get(0).getDataNum());
		}

		return "#";
	}

	@RequestMapping(value = "/getdata", method = RequestMethod.GET)
	public String getdata(int dataNum, HttpServletResponse response, HttpSession session) {
		String userid = (String) session.getAttribute("loginId");
		IData result = repository.selectOneIData(dataNum);
		String originalfile = result.getSaveFile();
		String fullPath = video_uploadPath + "/" + userid + "/" + originalfile;

		try {
			response.setHeader("Content-Disposition",
					" attachment;filename=" + URLEncoder.encode(originalfile, "UTF-8"));
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}

		// stream을 통해 실제 다운로드 실시
		FileInputStream fin = null;
		ServletOutputStream fileout = null;

		try {
			fin = new FileInputStream(fullPath); // 경로를 넣어서 스트림을 생성
			fileout = response.getOutputStream(); // outputStream 객체만 생성, 객체만 받아온다. 실제로 값을 뿌리는 것이 아니라
			// 클라이언트가 요청한 것을 서버에서 자료를 보낼 때 reponse를 하는데 response를 할 때 stream타입에 request한 자료를
			// 담아둔다.
			// 긁어오는게 getOutStream의 역할이고, 그걸 SevletOutputStream에 담는다.

			FileCopyUtils.copy(fin, fileout); // 실제 파일을 복사함
			// 원래는 스트림에 넣어서 하나하나 담아서 뿌려야 하는데 FileCopyUtils가 알아서 해준다.

			fin.close(); // 스트림 닫아주기
			fileout.close(); // 스트림 닫아주기

		} catch (Exception e) {
			e.printStackTrace();
		}
		return null; // 다운하고 화면전환같은건 필요없어
	}

	public String videoToAudio(String fileName, String userName) {
		long startingTime = System.currentTimeMillis();
		String audioPathFile = "";
		AudioConverter ac = new AudioConverter(fileName, userName);
		try {
			audioPathFile = ac.convert();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		long endingTime = System.currentTimeMillis();
		System.out.println("* FFMPEG processing time: " + ((endingTime - startingTime) / 1000) + "");
		return audioPathFile;
	}

}
