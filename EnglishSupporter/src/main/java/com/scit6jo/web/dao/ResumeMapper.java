package com.scit6jo.web.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.scit6jo.web.vo.resume.Additional_info;
import com.scit6jo.web.vo.resume.CoverLetter;
import com.scit6jo.web.vo.resume.Education;
import com.scit6jo.web.vo.resume.Experience;
import com.scit6jo.web.vo.resume.Resume;

public interface ResumeMapper {
	
	/**
	 * 해당 이력서의 학력 삽입
	 * @param resume_no
	 * @param education
	 * @return
	 */
	public int insertEdu(@Param(value="resume_no")String resume_no, @Param(value="education")List<Education> education);
	
	/**
	 * 해당 이력서의 경력 삽입
	 * @param resume_no
	 * @param experience
	 * @return
	 */
	public int insertExp(@Param(value="resume_no")String resume_no, @Param(value="experience")List<Experience> experience);
	
	/**
	 * 해당 이력서의 추가정보 삽입 
	 * @param resume_no
	 * @param additional_info
	 * @return
	 */
	public int insertInfo(@Param(value="resume_no")String resume_no, @Param(value="additional_info")List<Additional_info> additional_info);

	/**
	 * 이력서 table에 기본정보 삽입 
	 * @param resume
	 * @return
	 */
	public int insertResume(Resume resume);
	
	/**
	 * 이력서 번호를 받아오기 위한 select 문 
	 * @param resume
	 * @return
	 */
	public Resume selectResume(Resume resume);
	
	/**
	 * 조인하여 특정 유저의 resume 결과 받아오기 
	 * @param userid
	 * @param title
	 * @return
	 */
	public Resume getResume(@Param(value="userid")String userid,@Param(value="title")String title);
	
	/**
	 * 특정 유저의 작성한 이력서목록 불러오기 (join 없이 불러옴)
	 * @param userid
	 * @return
	 */
	public List<Resume> resumeList(String userid);
	
	/**
	 * 특정 유저의 작성한 커버레터 목록 불러오기 (title만)
	 * @param userid
	 * @return
	 */
	public List<CoverLetter> getCoverletterList(String userid);
	
	/**
	 * 커버레터 꺼내오기 (특정)
	 * @param vo
	 * @return
	 */
	public CoverLetter getCoverletter(CoverLetter vo);
	
	/**
	 * 커버레터 삽입
	 * @param vo
	 * @return
	 */
	public int insertCoverLetter(CoverLetter vo);
	
	/**
	 * 커버레터 삭제 
	 * @param vo
	 * @return
	 */
	public int deleteCoverletter(CoverLetter vo);
	
	
	/**
	 *  이력서 수정 전 학력, 경력, 추가정보 테이블 정리하기
	 * @param resume_no
	 * @return
	 */
	public int clearTables(String resume_no);
	
	/**
	 *  등록된 이력서 및 이력서의 경력, 학력, 추가정보 삭제
	 * @param resume_no
	 * @return
	 */
	public int removeResume(String resume_no);
	
	/**
	 * 이력서 기본정보 수정 
	 * @param resume_no
	 * @return
	 */
	public int updateResume(String resume_no);

}
