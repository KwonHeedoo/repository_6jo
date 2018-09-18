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
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.RowBounds;
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
import com.scit6jo.web.repository.BoardRepository;
import com.scit6jo.web.repository.DataRepository;
import com.scit6jo.web.util.FileService;
import com.scit6jo.web.util.PageNavigator;
import com.scit6jo.web.util.SpeechToText;
import com.scit6jo.web.vo.Board;
import com.scit6jo.web.vo.IData;
import com.scit6jo.web.vo.IQuestion;
import com.scit6jo.web.vo.Word;

@Controller
public class InterviewController {

	@Autowired
	DataRepository repository;
	@Autowired
	BoardRepository boardRepository;
	
	final int countPerPage=20;
	final int pagePerGroup=5;

	final String video_uploadPath = "c://ES_uploadPath//video";
	final String image_uploadPath = "c://ES_uploadPath//images";

	final String uploadPath = "c://ES_uploadPath";
	
	// 관리자페이지 IQuestionManager로 이동
	@RequestMapping(value = "/goIQuestionManager", method = RequestMethod.GET)
	public String goIQuestionManager(Model model, @RequestParam(value="page", defaultValue="1")int page) {
		System.out.println("going to IQuestionManager...");
		
		int total = repository.getTotal();
		
		// 페이지 계산을 위한 객체 생성
		PageNavigator navi = new PageNavigator(countPerPage, pagePerGroup, page, total);
		
		// 검색어와 시작 위치, 페이지당 글 수를 전달하여 목록
		RowBounds rb = new RowBounds(navi.getStartRecord(), navi.getCountPerPage());

		// 모든 질문 불러오기
		ArrayList<IQuestion> iQuestionList = repository.selectAllQuestion(rb);
		
		model.addAttribute("navi", navi);
		model.addAttribute("iQuestionList", iQuestionList);
		
		return "admin/IQuestionManager";
	}

	// 관리자페이지 IQuestionManager 질문추가 요청
	@RequestMapping(value = "questionAdd", method = RequestMethod.POST)
	public @ResponseBody Integer questionAdd(String question) {
		System.out.println("questionAdd...");
		
		IQuestion iq = new IQuestion();
		iq.setQuestion(question);
		
		System.out.println(iq);
		
		int result = repository.addQuestion(iq);
		
		if(result == 1) return 1;
		else			return 0;
	}
	
	// 관리자페이지 IQuestionManager 업데이트 요청 
	@RequestMapping(value = "questionUpdate", method = RequestMethod.POST)
	public @ResponseBody Integer questionUpdate(@RequestBody IQuestion iq) {
		System.out.println("questionUpdate...");
		
		System.out.println(iq);
		
		int result = repository.updateQuestion(iq);
		
		if(result == 1) return 1;
		else			return 0;
	}
	
	// 마이페이지 IQuestionManager 삭제 요청 
	@RequestMapping(value = "questionDelete", method = RequestMethod.POST)
	public @ResponseBody int questionDelete(int questionNum) {
		System.out.println("questionDelete...");
		System.out.println(questionNum);
		
		IQuestion iq = new IQuestion();
		iq.setQuestionNum(questionNum);
		
		int result = repository.deleteQuestion(iq);
		
		return result;
	}
		
	// 인터뷰 페이지로 이동
	@RequestMapping(value = "/goInterview", method = RequestMethod.GET)
	public String interview(HttpSession session, Model model) {
		return "interview/interviewPractice";
	}

	// 면접질문 list 페이지 이동
	@RequestMapping(value = "/viewQuestions", method = RequestMethod.GET)
	public String goQuestions(Model model) {

		return "interview/interviewQlist";
	}

	@RequestMapping(value = "/goMRoomList", method = RequestMethod.GET)
	public String goMRoomList(Model model) {

		return "interview/mRoomList";
	}

	/*
	 * public String interview(Model model) { ArrayList<IQuestion> result =
	 * repository.selectAllQuestion(); return "interview/interviewPractice"; }
	 */

	// 1:1 매칭 페이지로 이동?
	@RequestMapping(value = "/goMatching", method = RequestMethod.GET)
	public String matchingPractice(HttpSession session, Model model, String roomid) {
		System.out.println("roomid : " + roomid);
		model.addAttribute("roomid", roomid);
		return "interview/matchingPractice";
	}

	// [AJAX] DB로 부터 인터뷰 질문을 가져옴
	@RequestMapping(value = "/getQuestion", method = RequestMethod.POST)
	public @ResponseBody ArrayList<IQuestion> getQuestion() {
		RowBounds rb = new RowBounds();
		ArrayList<IQuestion> result = repository.selectAllQuestion(rb);
		Collections.shuffle(result);
		return result;
	}
	
	@RequestMapping(value = "/getResultIData", method = RequestMethod.POST)
	public @ResponseBody IData getResultIData(String dataNum) {
		IData result = repository.selectOneIData(Integer.parseInt(dataNum));
		System.out.println("getResultIData : " + result);
		return result;
	}

	// [AJAX] DB로 부터 Room List를 가져옴
	@RequestMapping(value = "/getMRoomList", method = RequestMethod.POST)
	public @ResponseBody ArrayList<Board> getMRoomList(HttpSession session) {
		String userid = (String) session.getAttribute("loginId");
		ArrayList<Board> result = boardRepository.roomNumList(userid);
		for(Board a : result) {
			System.out.println("roomnum : " +  a.getRoomNum());
		}
		return result;
	}

	@RequestMapping(value = "/goInterviewData", method = RequestMethod.POST)
	public String getInterviewData(Model model, HttpSession session) {
		String userid = (String)session.getAttribute("loginId");
		System.out.println(userid);
		ArrayList<IData> result = repository.selectAllIData(userid);
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
			data.setConfidence(-1);
			repository.insertIData(data);
			//ArrayList<IData> result = repository.selectAllIData(userid);
			int dataNum = data.getDataNum();
			Thread fcThread = new AudioControlThread(dataNum, saveFile, userid);
			fcThread.start();
			return dataNum + "";
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

	public class AudioControlThread extends Thread {
		private String saveFile;
		private String userid;
		private int dataNum;

		public AudioControlThread(int dataNum, String saveFile, String userid) {
			this.dataNum = dataNum;
			this.saveFile = saveFile;
			this.userid = userid;
		}

		private void test() {
			System.out.println("File is exist");

			//audioPathFile 변환한 audio의 full path
			String audioPathFile = videoToAudio(saveFile, userid);
			Thread pcThread = new PronConfidenceThread(dataNum,audioPathFile);
			pcThread.start();
			
			SpeechToText qss = new SpeechToText();
			String answerToText = "";
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
			System.out.println(data.getConfidence());
			repository.updateAnswer(data);
		}

		@Override
		public void run() {
			test();
		}
	}

	public class PronConfidenceThread extends Thread {
		private String fullPath;
		private int dataNum;

		public PronConfidenceThread(int dataNum, String fullPath) {
			this.dataNum = dataNum;
			this.fullPath = fullPath;
		}

		private void test() {
			String result = apidata(fullPath).get("result");
			int index = result.lastIndexOf("score");
			String temp = result.substring(index+7,result.length()-2);
			System.out.println(temp);
			
			IData data = new IData();
			data.setConfidence(Float.parseFloat(temp));
			data.setDataNum(dataNum);
			repository.updateConfidence(data);
		}

		@Override
		public void run() {
			test();
		}
	}

	// 발음 평가 API
	public Map<String, String> apidata(String fullPath) {
		String openApiURL = "http://aiopen.etri.re.kr:8000/WiseASR/Pronunciation";
		String accessKey = "cd04e541-c278-4c71-b639-e6513ba4e239"; // �߱޹��� Access Key
		String languageCode = "english"; // ��� �ڵ�
		// String script = "welcome to the new york city bus tour center";
		String audioFilePath = fullPath; // ������ ���� ���� ���
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

		Map<String, String> resultmap = new HashMap<>();
		resultmap.put("result", responBody);
		return resultmap;
	}
	
	

}
