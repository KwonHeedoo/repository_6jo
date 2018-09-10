package com.scit6jo.web.controller;

import java.io.DataOutputStream;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLEncoder;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.Base64;
import java.util.Collections;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletOutputStream;
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

import com.google.gson.Gson;
import com.scit6jo.web.util.AudioConverter;
import com.scit6jo.web.repository.DataRepository;
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

	// 인터뷰 페이지로 이동
	@RequestMapping(value = "/goInterview", method = RequestMethod.GET)
	public String interview(HttpSession session, Model model) {
		session.setAttribute("loginId", "aaa");
		session.setAttribute("loginNick", "aaa");
		session.setAttribute("loginType", "user");
		return "interview/interviewPractice";
	}
	
	// 면접질문 list 페이지 이동
	@RequestMapping(value = "/viewQuestions", method = RequestMethod.GET)
	public String goQuestions(Model model) {
		
		return "interview/interviewQlist";
	}
	
	/*
	 * public String interview(Model model) { ArrayList<IQuestion> result =
	 * repository.selectAllQuestion(); return "interview/interviewPractice"; }
	 */

	// 1:1 매칭 페이지로 이동?
	@RequestMapping(value = "/goMatching", method = RequestMethod.GET)
	public String matchingPractice(HttpSession session, Model model) {
		model.addAttribute("roomid","abc");
		return "interview/matchingPractice";
	}

	// [AJAX] DB로 부터 인터뷰 질문을 가져옴
	@RequestMapping(value = "/getQuestion", method = RequestMethod.POST)
	public @ResponseBody ArrayList<IQuestion> getQuestion() {
		ArrayList<IQuestion> result = repository.selectAllQuestion();
		Collections.shuffle(result);
		return result;
	}
	
	@RequestMapping(value = "/goInterviewData", method = RequestMethod.POST)
	public String getInterviewData(String userid,Model model) {
		System.out.println("????");
		ArrayList<IData> result = repository.selectAlIData(userid);
		model.addAttribute("dataList", result);
		return "interview/interviewDataList";
	}
	
	

	// [AJAX] 인터뷰 질문이 끝나면 동영상 파일 서버로 전송
	@RequestMapping(value = "/savedata", method = RequestMethod.POST)
	// public @ResponseBody String senddata(@RequestParam("file") MultipartFile
	// file) {
	public @ResponseBody String senddata(HttpSession session, @RequestParam("file") MultipartFile file,
			@RequestParam("questionNum") int questionNum) {

		String userid = (String) session.getAttribute("loginId");
		System.out.println("업로드 여부 : " + file + " ,파일의 크기 : " + file.getSize() + ", 비어있나? " + file.isEmpty());

		if (!file.isEmpty()) {
			String saveFile = FileService.saveFile(file, video_uploadPath, userid);
			IData data = new IData();
			data.setQuestionNum(questionNum);
			data.setSaveFile(saveFile);
			data.setUserid(userid);
			repository.insertIData(data);
			ArrayList<IData> result = repository.selectAlIData(userid);
			int dataNum = result.get(0).getDataNum();
			Thread fcThread = new AudioControlThread(dataNum,saveFile,userid);
			fcThread.start();
			return dataNum+"";
		}
		return "#";
	}

	// Video 태그에 인터뷰가 끝난후 자기 영상을 확인용..
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

	// ffmpeg 를 이용해 비디오 -> 오디오 변경
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

	// 발음 평가 API
	public Map<String, Integer> apidata() {
		String openApiURL = "http://aiopen.etri.re.kr:8000/WiseASR/Pronunciation";
		String accessKey = "cd04e541-c278-4c71-b639-e6513ba4e239"; // �߱޹��� Access Key
		String languageCode = "english"; // ��� �ڵ�
		// String script = "welcome to the new york city bus tour center";
		String audioFilePath = "C:\\ES_uploadPath\\audio\\aaa\\aaa_20180822084223.wav"; // ������ ���� ���� ���
		String audioContents = null;

		Gson gson = new Gson();

		Map<String, Object> request = new HashMap<>();
		Map<String, String> argument = new HashMap<>();

		try {
			Path path = Paths.get(audioFilePath);
			byte[] audioBytes = Files.readAllBytes(path);
			audioContents = Base64.getEncoder().encodeToString(audioBytes);
		} catch (IOException e) {
			e.printStackTrace();
		}

		argument.put("language_code", languageCode);
		// argument.put("script", script);
		argument.put("audio", audioContents);

		request.put("access_key", accessKey);
		request.put("argument", argument);

		URL url;
		Integer responseCode = null;
		String responBody = null;
		try {
			url = new URL(openApiURL);
			HttpURLConnection con = (HttpURLConnection) url.openConnection();
			con.setRequestMethod("POST");
			con.setDoOutput(true);

			DataOutputStream wr = new DataOutputStream(con.getOutputStream());
			wr.write(gson.toJson(request).getBytes("UTF-8"));
			wr.flush();
			wr.close();

			responseCode = con.getResponseCode();
			InputStream is = con.getInputStream();
			byte[] buffer = new byte[is.available()];
			int byteRead = is.read(buffer);
			responBody = new String(buffer);

			System.out.println("[responseCode] " + responseCode);
			System.out.println("[responBody]");
			System.out.println(responBody);

		} catch (MalformedURLException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}

		Map<String, Integer> resultmap = new HashMap<>();
		resultmap.put(responBody, responseCode);
		return resultmap;
	}
	
	public class AudioControlThread extends Thread {
		private String saveFile;
		private String userid;
		private int dataNum;
		
		public AudioControlThread(int dataNum,String saveFile, String userid) {
			this.dataNum = dataNum;
			this.saveFile = saveFile;
			this.userid = userid;
		}

		private void test() {
			System.out.println("File is exist");
			
			// String saveFile = FileService.saveFile(file,
			// video_uploadPath,session.get(userid));
			String audioPathFile = videoToAudio(saveFile, userid);
			SpeechToText qss = new SpeechToText();
			String answerToText = "no answer";
			try {
				answerToText = qss.ChangeSTT(audioPathFile);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			System.out.println("answer : " + answerToText);
			if (answerToText == "") {
				answerToText = "no answer";
			}
			IData data = new IData();
			data.setDataNum(dataNum);
			data.setAnswer(answerToText);
			repository.updateIData(data);
		}
		@Override
		public void run() {
			test();
		}
	}
	
	
	

}
