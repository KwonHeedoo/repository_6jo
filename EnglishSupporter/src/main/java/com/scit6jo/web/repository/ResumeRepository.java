package com.scit6jo.web.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.scit6jo.web.dao.ResumeMapper;
import com.scit6jo.web.vo.resume.Additional_info;
import com.scit6jo.web.vo.resume.Education;
import com.scit6jo.web.vo.resume.Experience;
import com.scit6jo.web.vo.resume.Resume;

@Repository
public class ResumeRepository {

	@Autowired
	SqlSession session;

	public int insertResume(Resume resume) {
		ResumeMapper mapper = session.getMapper(ResumeMapper.class);
		try {
			int cnt = mapper.insertResume(resume);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return 0;
	}

	public int insertEdu(String resume_no, List<Education> education) {
		ResumeMapper mapper = session.getMapper(ResumeMapper.class);
		int cnt =0;
		try {
			 cnt = mapper.insertEdu(resume_no, education);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return cnt;
	}

	public int insertExp(String resume_no, List<Experience> experience) {
		ResumeMapper mapper = session.getMapper(ResumeMapper.class);
		int cnt =0;
		try {
			 cnt = mapper.insertExp(resume_no, experience);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return cnt;
	}

	public int insertInfo(String resume_no, List<Additional_info> additional_info) {
		ResumeMapper mapper = session.getMapper(ResumeMapper.class);
		int cnt =0;
		try {
			 cnt = mapper.insertInfo(resume_no, additional_info);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return cnt;
	}
	
	public String getResumeNo(Resume resume) {
		ResumeMapper mapper = session.getMapper(ResumeMapper.class);
		String no= null;
		try {
			no = mapper.selectResumeNo(resume).getUserid();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return no;
	}

}
