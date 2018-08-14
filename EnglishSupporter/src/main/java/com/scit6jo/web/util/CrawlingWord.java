package com.scit6jo.web.util;

import java.util.ArrayList;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

public class CrawlingWord {
	public String crawling() throws Exception {

		// 엔드포인트 설정
		Document doc = Jsoup.connect("https://movie.naver.com/movie/running/current.nhn#").header("User-Agent",
				"Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/67.0.3396.99 Safari/537.36 NetHelper70")
				.header("Accept-Language", "ko-KR,ko;q=0.8,en-US;q=0.5,en;q=0.3")
				.header("Accept-Encoding", "gzip, deflate, br").get();

		// 페이지 안에서 div 이름 container에서 ul태그 중에 class 이름이 ul.lst_detail_t1
		Elements ul = doc.select("ul.lst_detail_t1");
		// 그리고 ul안에 있는 li들을 찾고 안의 a태그를 찾아서 주소 저장
		Elements lisInUl = ul.select("li");
		ArrayList<String> links = new ArrayList<String>();

		for (Element li : lisInUl) {
			// 청소년 유해물 제외, 상영시간 및 개봉일자 누락 영화 제외
			if (!li.select("dl.lst_dsc").select("dt.tit").select("span").text().contains("유해물")
					&& li.select("dl.lst_dsc").select("dl.info_txt1").select("dd").get(0).text().contains("분")
					&& li.select("dl.lst_dsc").select("dl.info_txt1").select("dd").get(0).text().contains("개봉")) {
				// 영화가 아닌 공연 제외
				if (!li.select("dl.lst_dsc").select("dd").select("dl.info_txt1").select("dd").get(0).select(".link_txt")
						.select("a").text().contains("공연")) {
					// DB에 영화 존재여부 확인 후 link저장(이미 존재하는 영화는 Crawling하지 않는다.)
					int idx = li.select("a").attr("href").indexOf("=");
					String movieCode = li.select("a").attr("href").substring(idx + 1);
					/*if (!movieList.contains(movieCode)) {
						links.add(li.select("a").attr("href"));
					}// if*/
				}// if
			}// if
		}// for


		return "redirect:/movieList";
	}

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
