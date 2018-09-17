package com.scit6jo.web.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class AdminInterceptor extends HandlerInterceptorAdapter {
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		HttpSession session = request.getSession();
		
		String contextPath = request.getContextPath();
		String loginId = (String) session.getAttribute("loginId");
		String loginType = (String) session.getAttribute("loginType");
		
		/*String requestURI = request.getRequestURI();
		String uri = requestURI.substring(requestURI.lastIndexOf("/")+1);
		
		// 관리자만 가능한 요청목록
		String adminURI = "goAdminPage goDashboard goReportManager goUserManager goWordManager goIQuestionManager";
		// 유저만 가능한 요청목록
		String userURI = "goInfoUpdate goPwdChange goUnregister detailBoard writeBoardForm updateBoardForm "
					   + "goInterview viewQuestions goMRoomList goMatching goInterviewData goMypage goMyschedule "
					   + "goResumeForm goCoverletter goMyDocs goUpdateResume viewMyResume viewMyCoverletter "
					   + "updateMyCoverletter goSendMsgBox goReceiveMsgBox goMessageList goReportBox";*/
		
		if(loginId == null) {
			session.setAttribute("msg", "비회원은 해당 작업을 할 수 없습니다. 로그인 해 주세요.");
			response.sendRedirect(contextPath + "/goLoginForm");  // 주소 표시줄 확인
			
			return false;
		}else{
			if(loginType.equals("user")) {
				session.setAttribute("msg", "일반회원은 해당 작업을 할 수 없습니다. 다시 로그인 해 주세요.");
				response.sendRedirect(contextPath + "/goLoginForm"); 
					
				return false;
			} else {
				return true;
			}
		}
	}
}
