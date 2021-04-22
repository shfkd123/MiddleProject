package kr.or.ddit.user.servlet;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.or.ddit.user.service.SignUpService;
import kr.or.ddit.user.service.UserService;
import kr.or.ddit.user.vo.SignUpVO;
import kr.or.ddit.user.vo.UserVO;

 @WebServlet("/SignUpServlet")
public class SignUpServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doPost(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		boolean chk;
		try {
			SignUpVO sv = new SignUpVO();
			
			sv.setUserId(req.getParameter("userId"));
			sv.setUserPw(req.getParameter("userPw"));
			
			SignUpService service = new SignUpService();
			
			chk = service.signUpUser(sv);
			
			if(chk == true) {
				HttpSession session = req.getSession(true);
				
				UserService userService = new UserService();
				
				UserVO uv = userService.retrieveUser(req.getParameter("userId"));
				
				session.setAttribute("userVO", uv);
				session.setMaxInactiveInterval(60 * 60);

				req.setAttribute("chk", "T");
			}
			else if(chk == false) {
				req.setAttribute("chk", "F");
			}
			RequestDispatcher dispatcher = req.getRequestDispatcher("/html/login/login.jsp");
			dispatcher.forward(req, resp);
			
		} catch (SQLException e) {
			e.printStackTrace();
		} 
	}
}
