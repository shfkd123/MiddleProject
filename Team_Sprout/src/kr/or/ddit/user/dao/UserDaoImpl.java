package kr.or.ddit.user.dao;

import java.sql.SQLException;
import java.util.List;

import com.ibatis.sqlmap.client.SqlMapClient;

import kr.or.ddit.user.vo.UserVO;
import kr.or.ddit.util.SqlMapClientUtil;

public class UserDaoImpl implements IUserDao {

	private static IUserDao ud;
	
	public UserDaoImpl() {
		SqlMapClientUtil.getInstance();
	}
	
	public static IUserDao getInstance() {
		if(ud == null) {
			ud = new UserDaoImpl();
		}
		return ud;
	}

	@Override
	public int signUpUser(SqlMapClient smc, UserVO uv) throws SQLException {
		int cnt = 0;
		Object obj = smc.insert("user.signUpUser", uv);
		if(obj != null) {
			cnt = 1;
		}
		return cnt;
	}

	@Override
	public int chkUserId(SqlMapClient smc, String userId) throws SQLException {
		return (int) smc.queryForObject("user.chkUserId", userId);
	}
	
	@Override
	public int chkNickName(SqlMapClient smc, String userNickName) throws SQLException {
		return (int) smc.queryForObject("user.chkNickName", userNickName);
	}
	
	@Override
	public List<UserVO> getUserList(SqlMapClient smc) throws SQLException {
		return smc.queryForList("user.getUserList");
	}

	@Override
	public UserVO findUser(SqlMapClient smc, UserVO uv) throws SQLException {
		return (UserVO) smc.queryForObject("user.selectUser", uv);
	}

	@Override
	public int updateUser(SqlMapClient smc, UserVO uv) throws SQLException {
		return smc.update("user.updateUser", uv);
	}

	@Override
	public String findUserId(SqlMapClient smc, UserVO uv) throws SQLException {
		return (String) smc.queryForObject("user.selectUserId", uv);
	}

	@Override
	public String findUserPw(SqlMapClient smc, UserVO uv) throws SQLException {
		return (String) smc.queryForObject("user.selectUserPw", uv);
	}

	@Override
	public int deleteUser(SqlMapClient smc, UserVO uv) throws SQLException {
		return smc.delete("user.deleteUser", uv.getUserId());
	}

	@Override
	public UserVO getUser(SqlMapClient smc, String userId) throws SQLException {
		return (UserVO) smc.queryForObject("user.getUser", userId);
	}

	@Override
	public int signInUser(SqlMapClient smc, UserVO uv) throws SQLException {
		return (int) smc.queryForObject("user.signInUser", uv);
	}

	
}
