package com.scit6jo.web.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.scit6jo.web.repository.UserRepository;
import com.scit6jo.web.vo.User;

public class SanctionInterceptor extends HandlerInterceptorAdapter {
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
			String msg1 = "We apologize for any inconvenience, but we have detected inappropriate behavior from your account. "
						+ "In order to provide clean environment for all users of English Supporter, "
						+ "this account will be suspended for a period of time.";
			String msg2 = "Suspension period : " + stopedUser.getRegdate() + " ~ " + stopedUser.getLastdate();
			String msg3 = "If the same act repeatedly detected, your account may be blocked without any attention.";
			String msg4 = "From English Supporter";
			
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
