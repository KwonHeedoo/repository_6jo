package com.scit6jo.web.repository;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.scit6jo.web.dao.DataMapper;
import com.scit6jo.web.dao.WordMapper;
import com.scit6jo.web.vo.IData;
import com.scit6jo.web.vo.IQuestion;

@Repository
public class DataRepository {

	@Autowired
	SqlSession session;

	/**
	 * 회원 가입 처리
	 * @param Member 사용자가 입력한 가입 정보
	 */
	public int insertIData(IData iData) {
		DataMapper mapper = session.getMapper(DataMapper.class);

		int result = 0;
		try {
			result = mapper.insertIData(iData);
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	public int updateAnswer(IData iData) {
		DataMapper mapper = session.getMapper(DataMapper.class);

		int result = 0;
		try {
			result = mapper.updateAnswer(iData);
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	public int updateConfidence(IData iData) {
		DataMapper mapper = session.getMapper(DataMapper.class);

		int result = 0;
		try {
			result = mapper.updateConfidence(iData);
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	/*public ArrayList<IQuestion> selectAllQuestion() {
		DataMapper mapper = session.getMapper(DataMapper.class);

		ArrayList<IQuestion> result = null;
		try {
			result = mapper.selectAllQuestion();
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}*/
	
	// 페이징처리용 
	public ArrayList<IQuestion> selectAllQuestion(RowBounds rb) {
		DataMapper mapper = session.getMapper(DataMapper.class);

		ArrayList<IQuestion> result = null;
		try {
			result = mapper.selectAllQuestion(rb);
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	public IQuestion selectOneQuestion(int questionNum) {
		DataMapper mapper = session.getMapper(DataMapper.class);

		IQuestion result = null;
		try {
			result = mapper.selectOneQuestion(questionNum);
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	public IData selectOneIData(int dataNum) {
		DataMapper mapper = session.getMapper(DataMapper.class);

		IData result = null;
		try {
			result = mapper.selectOneIData(dataNum);
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	public ArrayList<IData> selectAllIData(String userid) {
		DataMapper mapper = session.getMapper(DataMapper.class);

		ArrayList<IData> result = null;
		try {
			result = mapper.selectAllIData(userid);
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	// 관리자페이지 IQuestionManager에 띄울 모든 단어 개수 (페이징처리)
	public int getTotal() {
		DataMapper mapper= session.getMapper(DataMapper.class);
		int total = 0;
		
		try {
			total = mapper.getTotal();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return total;
	}

	// 관리자페이지 IQuestionManager 질문추가 요청
	public int addQuestion(IQuestion iq) {
		DataMapper mapper= session.getMapper(DataMapper.class);
		int result = mapper.addQuestion(iq);
		
		if(result == 1) return 1;
		else			return 0;
	}

	// 관리자페이지 IQuestionManager 업데이트 요청
	public int updateQuestion(IQuestion iq) {
		DataMapper mapper= session.getMapper(DataMapper.class);
		int result = mapper.updateQuestion(iq);
		
		if(result == 1) return 1;
		else			return 0;
	}

	// 관리자페이지 IQuestionManager 삭제 요청
	public int deleteQuestion(IQuestion iq) {
		DataMapper mapper= session.getMapper(DataMapper.class);
		int result = mapper.deleteQuestion(iq);
		
		if(result == 1) return 1;
		else			return 0;
	}
}

