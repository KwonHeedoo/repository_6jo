package com.scit6jo.web.util;

import java.util.List;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.select.Elements;

import com.scit6jo.web.vo.Word;

public class CrawlingWord {
	public List<Word> crawling(List<Word> wordList) throws Exception {
		for(Word word : wordList) {
			// 엔드포인트 설정
			Document doc = Jsoup.connect("https://endic.naver.com/search.nhn?sLn=kr&searchOption=thesaurus&query=" + word.getWord()).header("User-Agent",
					"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36")
					.header("Accept-Language", "ko-KR,ko;q=0.9,en-US;q=0.8,en;q=0.7")
					.header("Accept-Encoding", "gzip, deflate, br").get();
			
			String synonym = "";
			
			// 페이지 안에서 div 이름 container에서 div태그 중에 class 이름이 word_num_nobor
			Elements div = doc.select(".word_num_nobor");
			Elements dl = doc.select(".list_e3x");
			
			// 유의어가 있는 경우에만 실행
			if(dl.size() != 0) {
				for(int i = 1; i <= dl.size(); i++) {
					// 유의어 품사 종류 추가
					synonym += "[" + div.select("h3").get(i).attr("id") + "] ";
					for(int j = 0; j < dl.get(i-1).select("dd").size(); j++) {
						// 유의어인 경우면 추가
						if(dl.get(i-1).select("dd").get(j).select("p").get(0).select("span").get(0).text().equals("[유의어]")) {
							// 유의어 추가
							synonym += dl.get(i-1).select("dd").get(j).select("p").get(0).select("span").get(1).select("a").text() + ", ";
						}// if
					}// for
					// 마지막 ", " 지우기
					if(synonym.length() != 0) synonym = synonym.substring(0, synonym.length() - 2);
					synonym += "<br/>";
				}// for
				
				word.setMeaningK(synonym);
			}// if
		}// for

		return wordList;
	}// method
}// class
