package com.scit6jo.web.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.scit6jo.web.dao.ResumeMapper;
import com.scit6jo.web.vo.resume.Additional_info;
import com.scit6jo.web.vo.resume.CoverLetter;
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
			Resume rr = mapper.selectResume(resume);
			no = rr.getResume_no();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return no;
	}
	
	public Resume getResume(Resume resume) {
		ResumeMapper mapper = session.getMapper(ResumeMapper.class);
		Resume vo= null;
		try {
			vo = mapper.selectResume(resume);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return vo;
		
	}
	
	
	public Resume selectResume(String userid, String title) {
		ResumeMapper mapper = session.getMapper(ResumeMapper.class);
		Resume result=null;
		try {
			result = mapper.getResume(userid, title);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	public CoverLetter getCoverletter(CoverLetter vo) {
		ResumeMapper mapper = session.getMapper(ResumeMapper.class);
		CoverLetter result = null;
		try {
			result = mapper.getCoverletter(vo);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return result;
	}
	
	public int insertCoverLetter(CoverLetter vo) {
		ResumeMapper mapper = session.getMapper(ResumeMapper.class);
		int result = 0;
		try {
			result = mapper.insertCoverLetter(vo);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return result;
	}

	public List<Resume> resumeList(String userid) {
		ResumeMapper mapper = session.getMapper(ResumeMapper.class);
		List<Resume> result = null;
		try {
			result = mapper.resumeList(userid);
		} catch (Exception e) {
			e.printStackTrace();
		}
		// TODO Auto-generated method stub
		return result;
	}

	public List<CoverLetter> coverletterList(String userid) {
		ResumeMapper mapper = session.getMapper(ResumeMapper.class);
		List<CoverLetter> result = null;
		try {
			result = mapper.getCoverletterList(userid);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	public int removeResumes(String resume_no) {
		ResumeMapper mapper = session.getMapper(ResumeMapper.class);
		int result = 0;
		try {
			result = mapper.removeResume(resume_no);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return result;
	}

	public int removeCoverLetter(CoverLetter vo) {
		ResumeMapper mapper = session.getMapper(ResumeMapper.class);
		int result = 0;
		try {
			result = mapper.deleteCoverletter(vo);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
}
