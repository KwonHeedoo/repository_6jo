package com.scit6jo.web.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.scit6jo.web.repository.UserRepository;
import com.scit6jo.web.vo.User;

public class LoginInterceptor extends HandlerInterceptorAdapter {
	@Autowired
	UserRepository respository;
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		HttpSession session = request.getSession();
				
		String userid = request.getParameter("userid");
		User stopedUser = respository.checkSanction(userid);
		
		// 재제 유저 체크
		if(stopedUser != null) {
			String msg1 = "이용에 불편을 드려 죄송하오나, 해당 계정에서 부적절한 행동 또는 언행 등이 감지되었습니다. "
						+ "English Supporter의 모든 사용자분들이 즐길 수 있는 건전한 환경을 제공해 드리기 위해 "
						+ "해당 계정은 일정 기간동안 정지 되었음을 알려드립니다.";
			String msg2 = "정지 기간 : " + stopedUser.getRegdate() + " ~ " + stopedUser.getLastdate();
			String msg3 = "같은 행위가 반복해서 지속되는 경우, 강제 탈퇴가 진행될 수 있음을 알려드립니다.";
			String msg4 = "English Supporter 드림";
			
			session.setAttribute("msg1", msg1);
			session.setAttribute("msg2", msg2);
			session.setAttribute("msg3", msg3);
			session.setAttribute("msg4", msg4);
			response.sendRedirect(request.getContextPath() + "/");
			return false;
		}else {
			return true;
		}
	}
}
