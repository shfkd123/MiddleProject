package kr.or.ddit.user.handler;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.beanutils.BeanUtils;

import kr.or.ddit.comm.handler.CommandHandler;
import kr.or.ddit.user.service.IOrderService;
import kr.or.ddit.user.service.IUserService;
import kr.or.ddit.user.service.OrderServiceImpl;
import kr.or.ddit.user.service.UserServiceImpl;
import kr.or.ddit.user.vo.OrderVO;
import kr.or.ddit.user.vo.UserVO;

public class OrderHandler implements CommandHandler{
	
	private static final String VIEW_PAGE = "/WEB-INF/view/mypage/myOrder.jsp";
	
	@Override
	public boolean isRedirect(HttpServletRequest req) {
		return false;
	}

	@Override
	public String process(HttpServletRequest req, HttpServletResponse resp) throws Exception {
		HttpSession session = req.getSession();
		UserVO uv = (UserVO) session.getAttribute("userVO");
		
		IOrderService orderService = OrderServiceImpl.getInstance();
		
		OrderVO ov = new OrderVO(); 

		ov.setUserId(req.getParameter("userId"));
		ov.setPjNm(req.getParameter("pjNm"));
		ov.setPjName(req.getParameter("pjName"));
		ov.setOrderPrice(Integer.parseInt(req.getParameter("orderPrice")));
		ov.setPoName(req.getParameter("poName"));
		orderService.makeOrder(ov);
		
		IUserService userService = UserServiceImpl.getInstance();
		UserVO userVO = new UserVO();
		userVO.setUserId(uv.getUserId());
		userVO.setUserMoney(ov.getOrderPrice());
		userService.userPointUpdateRefund(userVO);
		
		List<OrderVO> orderList = orderService.getOrderList(uv.getUserId());
		req.setAttribute("orderList", orderList);
		
		return VIEW_PAGE;
	}
}
