package kr.or.ddit.user.handler;

import java.lang.reflect.InvocationTargetException;
import java.sql.SQLException;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.beanutils.BeanUtils;

import kr.or.ddit.comm.handler.CommandHandler;
import kr.or.ddit.user.service.UserService;
import kr.or.ddit.user.vo.UserVO;

public class UserHandler implements CommandHandler {

	@Override
	public boolean isRedirect(HttpServletRequest req) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public String process(HttpServletRequest req, HttpServletResponse resp) throws Exception {
		String flag = req.getParameter("flag");
		
		try {
			if("CHKID".equals(flag)) { // 유저 중복 검사
				UserVO uv = checkedUserId(req);
				int resultCnt = 0;
				if(uv != null) {
					resultCnt = 1;
				}
				req.setAttribute("resultCnt", resultCnt);
				
				return "/html/common/userChkResult.jsp";
				
			} else if("C".equals(flag)) { // 유저 생성
				createUser(req);
				
				req.setAttribute("resultCnt", 1);
				
				return "/html/common/userChkResult.jsp";
				
			} else if("U".equals(flag)) { // 유저 정보 수정
				 UserVO uv = new UserVO();
				 
				 BeanUtils.populate(uv, req.getParameterMap());
				 
				 UserService service = new UserService();
				 
				 service.updateUser(uv);
				 
				 return null;
			} else if("D".equals(flag)) { // 유저 삭제
				UserVO uv = new UserVO();
				uv.setUserId(req.getParameter("userId"));
				
				UserService service = new UserService();
				
				service.updateUser(uv);
				
				return null;
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return null;
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
