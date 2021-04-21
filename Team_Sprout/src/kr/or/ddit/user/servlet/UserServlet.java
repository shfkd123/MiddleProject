package kr.or.ddit.user.servlet;

import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.beanutils.BeanUtils;

import kr.or.ddit.user.service.UserService;
import kr.or.ddit.user.vo.UserVO;

@WebServlet("/UserServlet")
public class UserServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		super.doGet(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		String flag = req.getParameter("flag");
		
		try {
			
			if("CHKID".equals(flag)) { // 유저 중복 검사
				UserVO uv = checkedUserId(req);
				int resultCnt = 0;
				if(uv != null) {
					resultCnt = 1;
				}
				req.setAttribute("resultCnt", resultCnt);
				
				RequestDispatcher dispatcher = req.getRequestDispatcher("/html/common/userChkResult.jsp");
				dispatcher.forward(req, resp);
			} else if("C".equals(flag)) { // 유저 생성
				createUser(req);
				
				req.setAttribute("resultCnt", 1);
				
				RequestDispatcher dispatcher = req.getRequestDispatcher("/html/common/userChkResult.jsp");
				dispatcher.forward(req, resp);
			} else if("U".equals(flag)) { // 유저 정보 수정
				 UserVO uv = new UserVO();
				 
				 BeanUtils.populate(uv, req.getParameterMap());
				 
				 UserService service = new UserService();
				 
				 service.updateUser(uv);
			} else if("D".equals(flag)) { // 유저 삭제
				UserVO uv = new UserVO();
				uv.setUserId(req.getParameter("userId"));
				
				UserService service = new UserService();
				
				service.updateUser(uv);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	private void createUser(HttpServletRequest req) throws IllegalAccessException, InvocationTargetException, SQLException {
		UserVO uv = new UserVO();
		BeanUtils.populate(uv, req.getParameterMap());
		
		UserService service = new UserService();
		
		service.insertUser(uv);
	}

	private UserVO checkedUserId(HttpServletRequest req) throws SQLException {
		String userId = req.getParameter("userId");
		
		UserService service = new UserService();
		
		UserVO uv = service.retrieveUser(userId);
		
		return uv;
	}
}
