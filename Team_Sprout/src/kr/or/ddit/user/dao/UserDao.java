package kr.or.ddit.user.dao;

import java.sql.SQLException;
import java.util.List;

import com.ibatis.sqlmap.client.SqlMapClient;

import kr.or.ddit.base.dao.BaseDao;
import kr.or.ddit.user.vo.UserVO;

public class UserDao extends BaseDao {
	private SqlMapClient smc;
	
	public UserDao() {
		smc = super.getSqlMapClient();
	}
	/**
	 * 유저목록 리스트를 가져오는 메서드
	 * @param  uv
	 * @return List<UserVO>
	 * @throws SQLException
	 */
	public List<UserVO> retrieveUserList(UserVO uv) throws SQLException {
		return smc.queryForList("user.retrieveUserList", uv);
	}
	
	/**
	 * 한 유저의 정보를 가져오는 메서드
	 * @param  userId
	 * @return UserVO
	 * @throws SQLException
	 */
	public UserVO retrieveUser(String userId) throws SQLException {
		return (UserVO) smc.queryForObject("user.retrieveUser", userId);
	}
	
	/**
	 * 회원가입 된 유저를 DB에 저장하는 메서드
	 * @param  uv
	 * @throws SQLException
	 */
	public void insertUser(UserVO uv) throws SQLException {
		smc.insert("user.createUser", uv);
	}
	
	/**
	 * 유저 정보를 수정하는 메서드
	 * @param  uv
	 * @throws SQLException
	 */
	public void updateUser(UserVO uv) throws SQLException {
		smc.update("user.updateUser", uv);
	}
	
	/**
	 * 유저 정보를 삭제하는 메서드
	 * @param  uv
	 * @throws SQLException
	 */
	public void deleteUSer(UserVO uv) throws SQLException {
		smc.delete("user.deleteUser", uv);
	}
}
