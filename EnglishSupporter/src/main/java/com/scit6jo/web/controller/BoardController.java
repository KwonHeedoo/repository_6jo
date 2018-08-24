package com.scit6jo.web.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.scit6jo.web.dao.BoardRepository;
import com.scit6jo.web.util.PageNavigator;
import com.scit6jo.web.vo.Board;

@Controller
public class BoardController {
	@Autowired
	BoardRepository repository;
	
	private static final String UPLOADPATH = "파일경로";
	private static final int countPerPage = 15;
	private static final int pagePerGroup = 5;
	
	/*
	 * 게시판(글 목록) 요청
	 * @param page 현재 페이지. 없으면 1로 처리
	 * @param searchText 검색어, 없으면 ""처리
	 */ 
	@RequestMapping(value="/boardList", method=RequestMethod.GET)
	public String boardList(@RequestParam(value="page", defaultValue="1") int page, Model model, String boardType,
							@RequestParam(value="searchItem", defaultValue="title") String searchItem,
							@RequestParam(value="searchText", defaultValue="") String searchText) {
		//특정 조건 검색시 searchItem, searchText전달
		//parameter 값 map으로 전달
		Map<String, String> map = new HashMap<>();
		map.put("searchItem", searchItem);
		map.put("searchText", searchText);
		map.put("boardType", boardType);
				
		// 게시글 전체 개수 조회
		int total = repository.getTotal(map);
		
		//페이지 계산을 위한 객체 생성
		PageNavigator navi = new PageNavigator(countPerPage, pagePerGroup, page, total);
		
		//검색어와 시작 위치, 페이지당 글 수를 전달하여 목록 읽기
		RowBounds rb = new RowBounds(navi.getStartRecord(), navi.getCountPerPage());//RowBounds :: 어디서부터 어디 까지 가져오라는 객체
		
		ArrayList<Board> boardList = repository.boardList(rb, map);
		
		model.addAttribute("boardList", boardList);
		model.addAttribute("navi", navi);
		model.addAttribute("searchItem", searchItem);
		model.addAttribute("searchText", searchText);
		
		if(boardType.equals("matching")) {
			System.out.println("going to MatchingBoardList...");
			return "interview/matchingBoardList";
		}else {
			return "interview/matchingBoardList";
		}
	}
	
	//게시물 보기
	@RequestMapping(value="/detailBoard", method=RequestMethod.GET)
	public String detailBoard(HttpSession session, Model model, String boardNum, int page, 
								String boardType, boolean back, String searchItem, String searchText) {
		String loginId = (String)session.getAttribute("loginId");
		
		Map<String, Object> map = new HashMap<>();
		map.put("boardNum", Integer.parseInt(boardNum));
		map.put("boardType", boardType);
		
		Board board = repository.selectOne(map);
		
		//조회수 증가
		if(loginId != null && back == false) {
			int result = repository.updateHitcount(map);
		}
		
		model.addAttribute("board", board);
		model.addAttribute("page", page);
		model.addAttribute("searchItem", searchItem);
		model.addAttribute("searchText", searchText);
		
		if(boardType.equals("matching")) {
			return "interview/matchingBoardDetail";
		}else {
			return "interview/matchingBoardDetail";
		}
	}
	
	//게시글 쓰기 폼 요청
	@RequestMapping(value="/writeBoardForm", method=RequestMethod.GET)
	public String writeBoardForm(Model model, int page, String boardType) {
		model.addAttribute("page", page);
		
		if(boardType.equals("matching")) {
			System.out.println("going to WriteMatchingBoardForm...");
			return "interview/writeMatchingBoardForm";
		}else {
			return "interview/writeMatchingBoardForm";
		}
	}
	
	//게시글 쓰기 처리
	@RequestMapping(value="/writeBoard", method=RequestMethod.POST)
	public String writeBoard(HttpSession session, Board board, String boardType, MultipartFile uploadfile) {
		String userid = (String)session.getAttribute("loginId");
		board.setUserid(userid);
		
		if(uploadfile != null) {
			if(uploadfile.getOriginalFilename() != "") {
				String savedFileName = saveFile(uploadfile);
				
				board.setOriginalfile(uploadfile.getOriginalFilename());
				board.setSavedfile(savedFileName);
			}
		}
		
		Map<String, Object> map = new HashMap<>();
		map.put("board", board);
		map.put("boardType", boardType);
		
		int result = repository.writeBoard(map);
		
		if(boardType.equals("matching")) {
			return "redirect:/boardList?boardType=matching";
		}else {
			return "redirect:/boardList?boardType=matching";
		}
	}
	
	//게시글 파일 업로드
	public String saveFile(MultipartFile uploadfile) {
		UUID uuid = UUID.randomUUID();
		String savedFileName = uuid + "_" + uploadfile.getOriginalFilename();
		
		File file = new File(UPLOADPATH, savedFileName);
		
		try {
			uploadfile.transferTo(file);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return savedFileName;
	}
	
	//게시글 삭제 처리
	@RequestMapping(value="/deleteBoard", method=RequestMethod.GET)
	public String deleteBoard(String boardNum, String boardType) {
		Map<String, Object> map = new HashMap<>();
		map.put("boardNum", boardNum);
		map.put("boardType", boardType);
		
		if(boardType.equals("appraise")) {
			deleteFile(map);
		}
		
		int result = repository.deleteBoard(map);
		
		if(boardType.equals("matching")) {
			return "redirect:/boardList?boardType=matching";
		}else {
			return "redirect:/boardList?boardType=matching";
		}
	}
	
	//게시글 파일 삭제
	@RequestMapping(value="/deleteFile", method=RequestMethod.GET)
	public String deleteFile(Model model, String boardNum, String boardType, int page) {
		Map<String, Object> map = new HashMap<>();
		map.put("boardNum", boardNum);
		map.put("boardType", boardType);
		
		if(boardType.equals("appraise")) {
			deleteFile(map);
			int result = repository.deleteFile(Integer.parseInt(boardNum));
		}
		Board board = repository.selectOne(map);
		model.addAttribute("board", board);
		model.addAttribute("page", page);
		
		if(boardType.equals("matching")) {
			return "interview/updateMatchingBoardForm";
		}else {
			return "interview/updateMatchingBoardForm";
		}
	}
	
	//게시글 파일 삭제 메소드
	public void deleteFile(Map<String, Object> map) {
		Board board = repository.selectOne(map);
		
		if(board != null) {
			File file = new File(UPLOADPATH + board.getSavedfile());
			
			if(file.exists()) {
				file.delete();
			}
		}
	}

	//게시글 수정 폼 요청
	@RequestMapping(value="/updateBoardForm", method=RequestMethod.GET)
	public String updateBoardForm(Model model, String boardNum, String boardType, 
									int page, String searchItem, String searchText) {
		Map<String, Object> map = new HashMap<>();
		map.put("boardNum", boardNum);
		map.put("boardType", boardType);
		
		Board board = repository.selectOne(map);
		
		model.addAttribute("board", board);
		model.addAttribute("page", page);
		model.addAttribute("searchItem", searchItem);
		model.addAttribute("searchText", searchText);
		
		if(boardType.equals("matching")) {
			System.out.println("Going to UpdateMatchingBoardForm...");
			return "interview/updateMatchingBoardForm";
		}else {
			return "interview/updateMatchingBoardForm";
		}
	}
	
	//게시글 수정 처리
	@RequestMapping(value="/updateBoard", method=RequestMethod.POST)
	public String updateBoard(Model model, Board board, String boardType, MultipartFile uploadfile, 
								int page, String searchItem, String searchText) {
		
		if(uploadfile.getOriginalFilename() != "") {
			String savedFileName = saveFile(uploadfile);
			
			board.setOriginalfile(uploadfile.getOriginalFilename());
			board.setSavedfile(savedFileName);
		}
		
		Map<String, Object> map = new HashMap<>();
		map.put("board", board);
		map.put("boardType", boardType);
		
		int result = repository.updateBoard(map);
		
		model.addAttribute("board", board);
		model.addAttribute("page", page);
		model.addAttribute("searchItem", searchItem);
		model.addAttribute("searchText", searchText);
		
		
		if(boardType.equals("matching")) {
			return "interview/matchingBoardDetail";
		}else {
			return "interview/matchingBoardDetail";
		}
	}
}
