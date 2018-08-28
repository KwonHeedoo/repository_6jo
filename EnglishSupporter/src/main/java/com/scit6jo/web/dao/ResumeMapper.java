package com.scit6jo.web.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.scit6jo.web.vo.resume.Additional_info;
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
	 * 이력서 삽입 
	 * @param resume
	 * @return
	 */
	public int insertResume(Resume resume);
	
	/**
	 * 이력서 번호를 받아오기 위한 select 문 
	 * @param resume
	 * @return
	 */
	public Resume selectResumeNo(Resume resume);
	
	/**
	 * 조인하여 resume 결과 받아오기 
	 * @param userid
	 * @param title
	 * @return
	 */
	public Resume selectResume(@Param(value="userid")String userid,@Param(value="title")String title);

}
