package kr.or.ddit.user.service;

import java.sql.SQLException;
import java.util.List;

import com.ibatis.sqlmap.client.SqlMapClient;

import kr.or.ddit.user.vo.UserVO;

public interface IUserService {
	
	/**
	 * ID 중복검사 메서드
	 * @param userId
	 * @return
	 * @throws SQLException
	 */
	public int chkUserId(String userId);
	
	/**
	 * 닉네임 중복검사 메서드
	 * @param userNickName
	 * @return
	 * @throws SQLException
	 */
	public int chkNickName(String userNickName);
	
	/**
	 * 회원가입 메서드
	 * @param uv
	 * @return
	 * @throws SQLException
	 */
	public int signUpUser(UserVO uv);

	/**
	 * 모든 유저 조회 메서드
	 * @return
	 * @throws SQLException
	 */
	public List<UserVO> getUserList();
	
	/**
	 * 한 유저 정보 메서드
	 * @param smc
	 * @param userId
	 * @return
	 * @throws SQLException
	 */
	public UserVO getUser(String userId);
	
	/**
	 * 유저 찾기 메서드
	 * @param userId
	 * @return
	 * @throws SQLException
	 */
	public UserVO findUser(UserVO uv);
	
	/**
	 * 개인정보 변경 메서드
	 * @param uv
	 * @return
	 * @throws SQLException
	 */
	public int updateUser(UserVO uv);
	
	/**
	 * 아이디 찾기 메서드
	 * @param uv
	 * @return
	 * @throws SQLException
	 */
	public String findUserId(UserVO uv);
	
	/**
	 * 비밀번호 찾기 메서드
	 * @param uv
	 * @return
	 * @throws SQLException
	 */
	public String findUserPw(UserVO uv);
	
	/**
	 * 유저 삭제 메서드
	 * @param smc
	 * @param uv
	 * @return
	 * @throws SQLException
	 */
	public int deleteUser(UserVO uv);
	
	/**
	 * 로그인 통과 or 실패
	 * @param uv
	 * @return
	 */
	public int signInUser(UserVO uv);
}
