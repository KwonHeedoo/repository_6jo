package com.scit6jo.web.repository;

import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.scit6jo.web.dao.MypageMapper;
import com.scit6jo.web.dao.ResumeMapper;
import com.scit6jo.web.vo.Schedule;
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
		int cnt =0;
		try {
			cnt = mapper.insertResume(resume);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return cnt;
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
	
	public Resume getResume(String resume_no) {
		ResumeMapper mapper = session.getMapper(ResumeMapper.class);
		Resume vo= null;
		try {
			vo = mapper.getResume(resume_no);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return vo;
		
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

	public List<Resume> resumeList(String userid, RowBounds rbR) {
		ResumeMapper mapper = session.getMapper(ResumeMapper.class);
		List<Resume> result = null;
		try {
			result = mapper.resumeList(userid,rbR);
		} catch (Exception e) {
			e.printStackTrace();
		}
		// TODO Auto-generated method stub
		return result;
	}

	public List<CoverLetter> coverletterList(String userid, RowBounds rbC) {
		ResumeMapper mapper = session.getMapper(ResumeMapper.class);
		List<CoverLetter> result = null;
		try {
			result = mapper.getCoverletterList(userid,rbC);
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
	
	public int updateResume(Resume resume) {
		ResumeMapper mapper = session.getMapper(ResumeMapper.class);
		 int cnt =0;
		 int cnt2 =0;
		 int result =0;
		 try {
		 cnt =mapper.clearTables(resume.getResume_no());
		 cnt2 =mapper.updateResume(resume);
		 }catch (Exception e) {
			e.printStackTrace();
		}
		 System.out.println("기타테이블 삭제결과"+cnt+"/이력서 본문 수정"+cnt2);
		 if(cnt!=0&&cnt2>0) {
			 result=1;
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

	// 페이징 용 
	public int getTotal(String type, String userid) {
		ResumeMapper mapper = session.getMapper(ResumeMapper.class);
		int result = 0;
		try {
			result = mapper.getTotal(type,userid);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	public int updateCoverletter(CoverLetter vo) {
		ResumeMapper mapper = session.getMapper(ResumeMapper.class);
		int result = 0;
		try {
			result = mapper.updateCoverLetter(vo);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	//이력서 데드라인 일정에 표시해 주기 
	public int insertResumeScedule(Resume vo) {
		MypageMapper mapper = session.getMapper(MypageMapper.class);
		String title = vo.getTitle() +"Resume Deadline";

		Schedule resume = new Schedule(vo.getUserid(), title, "true", vo.getDeadline());
		int result = 0;
		try {
			System.out.println(resume);
			result = mapper.saveSchedule(resume);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	public int removeRschedule(String title, String userid) {
		MypageMapper mapper = session.getMapper(MypageMapper.class);
		int result = 0;
		try {
			Schedule ss = new Schedule();
			title = title +"Resume Deadline";
			ss.setUserid(userid);
			ss.setTitle(title);
			System.out.println(ss);
			result = mapper.removeSchedule(ss);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	//이력서 삭제시 일정표에서도 삭제하기 
	//public 
	
	
}
