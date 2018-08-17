package com.scit6jo.web.util;

import java.util.ArrayList;
import java.util.List;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

public class CrawlingWord {
	public List<List<String>> crawling(List<String> wordList) throws Exception {
		List<List<String>> synonymList = new ArrayList<>();
		
		for(String word : wordList) {
			// 엔드포인트 설정
			Document doc = Jsoup.connect("https://endic.naver.com/search.nhn?sLn=kr&searchOption=thesaurus&query=" + word).header("User-Agent",
					"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36")
					.header("Accept-Language", "ko-KR,ko;q=0.9,en-US;q=0.8,en;q=0.7")
					.header("Accept-Encoding", "gzip, deflate, br").get();
			
			System.out.println(doc);
			
			// 페이지 안에서 div 이름 container에서 ul태그 중에 class 이름이 word_num_nobor
			Elements dl = doc.select("container").select("word_num_nobor").select("list_e3 list_e3x");
			
			System.out.println("dl : "+dl);
			
			String a = doc.select("header").select("Ngnb_inner").select("a").select("span").text();
			System.out.println(a);
			// ul안에 있는 li선택
			//Elements lisInUl = ul.select("li");
			
			List<String> synonym = new ArrayList<>();
			
			/*for (Element li : lisInUl) {
				System.out.println("들어옴?");
				System.out.println(li);
				System.out.println(li.select("span").select("a").attr("class"));
				if (li.select("span").select("a").attr("class").equals("css-3kshty etbu2a31")) {
					System.out.println("여기 옴?2");
					String synonymWord = li.select("span").select("a").text();
					System.out.println(synonymWord);
					synonym.add(synonymWord);
				}// if
			}// for
*/			
			System.out.println("synonymList : " + synonymList);
			synonymList.add(synonym);
		}

		return synonymList;
	}
	
	/*public List<List<String>> crawling(List<String> wordList) throws Exception {
		List<List<String>> synonymList = new ArrayList<>();
		
		for(String word : wordList) {
			// 엔드포인트 설정
			Document doc = Jsoup.connect("https://www.thesaurus.com/browse/" + word + "?s=t").header("User-Agent",
					"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36")
					.header("Accept-Language", "ko-KR,ko;q=0.9,en-US;q=0.8,en;q=0.7")
					.header("Accept-Encoding", "gzip, deflate, br").get();
			
			// 페이지 안에서 div 이름 loadingContainer에서 ul태그 중에 class 이름이css-1lc0dpe et6tpn80
			//Elements ul = doc.select(".css-1lc0dpe et6tpn80");
			Elements ul = doc.select("css-1lc0dpe et6tpn80");
			System.out.println("ul : "+ul);
			// ul안에 있는 li선택
			Elements lisInUl = ul.select("li");
			
			List<String> synonym = new ArrayList<>();
			
			for (Element li : lisInUl) {
				System.out.println("들어옴?");
				System.out.println(li);
				System.out.println(li.select("span").select("a").attr("class"));
				if (li.select("span").select("a").attr("class").equals("css-3kshty etbu2a31")) {
					System.out.println("여기 옴?2");
					String synonymWord = li.select("span").select("a").text();
					System.out.println(synonymWord);
					synonym.add(synonymWord);
				}// if
			}// for
			
			System.out.println("synonymList : " + synonymList);
			synonymList.add(synonym);
		}

		return synonymList;
	}*/

	// DB에 영화 저장
	/*public ArrayList<Movie> crawlingDetail(List<String> links) throws Exception {
		
		for (int i = 0; i < links.size(); i++) {
			Document doc = Jsoup.connect("https://movie.naver.com" + links.get(i)).header("User-Agent",
					"Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/67.0.3396.99 Safari/537.36 NetHelper70")
					.header("Accept-Language", "ko-KR,ko;q=0.8,en-US;q=0.5,en;q=0.3")
					.header("Accept-Encoding", "gzip, deflate, br").get();

			int idx = doc.select(".h_movie").select("a").attr("href").indexOf("=");
			String movieCode = doc.select(".h_movie").select("a").attr("href").substring(idx + 1);
			String title = doc.select("h3.h_movie").select("a").get(0).text();

			Elements dd = doc.select("dl.info_spec").select("dd");
			String director = "";
			String actor = "";
			String role = "";
			String grade = "";
			String genre = "";

			String runtime = dd.get(0).select("span").get(2).text();
			String openDate = dd.get(0).select("span").get(3).select("a").get(0).text()
					+ dd.get(0).select("span").get(3).select("a").get(1).text();
			for (int k = 0; k < dd.get(0).select("span").get(0).select("a").size(); k++) {
				genre += (dd.get(0).select("span").get(0).select("a").size() - 1 != k)
						? dd.get(0).select("span").get(0).select("a").get(k).text().replace("/", ", ") + ", "
						: dd.get(0).select("span").get(0).select("a").get(k).text().replace("/", ", ");
			}
			for (int k = 0; k < dd.get(1).select("a").size(); k++) {
				director += (dd.get(1).select("a").size() - 1 != k) ? dd.get(1).select("a").get(k).text() + ", "
						: dd.get(1).select("a").get(k).text();
			}
			if (doc.select("dl.info_spec").select("dt").hasClass("step3")) {
				grade = dd.get(3).select("a").get(0).text();
			} else {
				grade = dd.get(2).select("a").get(0).text();
			}
			String story = doc.select(".story_area").text();

			Elements ul = doc.select("div.people").select("ul");
			Elements lisInUl = ul.select("li");
			ArrayList<String> actorList = new ArrayList<>();
			ArrayList<String> roleList = new ArrayList<>();
			for (Element li : lisInUl) {
				actorList.add(li.select("a").text() + "[" + li.select("dl.staff").select("dt").text() + "배우]");
				if(li.select("dl.staff").select("dd").hasText()) {
					roleList.add("[" + li.select("dl.staff").select("dt").text() + "배우]" + li.select("dl.staff").select("dd").text());
				}
			}
			for (int j = 0; j < actorList.size(); j++) {
				if (actorList.get(j).contains("[주연배우]")) {
					String mainActor = actorList.get(j).replaceAll("\\[주연배우\\]", "");
					actor += mainActor + ", ";
				}
			}
			if(actor.length() != 0) actor = actor.substring(0, actor.length() - 2);
			
			for(int j = 0; j < roleList.size(); j++) {
				if (roleList.get(j).contains("[주연배우]")) {
					String mainRole = roleList.get(j).replaceAll("\\[주연배우\\]", "");
					mainRole = mainRole.replaceAll("목소리 ...", "역");
					mainRole = mainRole.replaceAll("목소...", "역");
					role += mainRole + ", ";
				}
			}
			if(role.length() != 0) role = role.substring(0, role.length() - 2);
			
		}
		return result;
	}*/

}
