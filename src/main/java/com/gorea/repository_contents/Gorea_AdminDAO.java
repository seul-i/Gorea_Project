package com.gorea.repository_contents;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.gorea.dto_user.Gorea_UserTO;
import com.gorea.mapper.UserMapper;

@Repository
public class Gorea_AdminDAO {

	@Autowired
	private UserMapper userMapper;
	
	public List<Gorea_UserTO> userList(int offset, int pageSize) {
		List<Gorea_UserTO> lists = userMapper.userList(offset, pageSize);
		return lists;
	}
	
	public List<Gorea_UserTO> adminSearchUserList(String searchType, String searchKeyword, int offset, int pageSize) {
		return userMapper.searchUserList(searchType, searchKeyword, offset, pageSize);
	}
	
	public int adminUserTotalCount(String searchType, String searchKeyword) {
		int totalRowCount = userMapper.countSearchUser(searchType, searchKeyword);
		return totalRowCount;
	}
	
	public int getTotalRowCount() {
	    int totalRowCount = userMapper.getUserTotalCount();
	    return totalRowCount;
	}
	
	public int user_Delete_Ok(Gorea_UserTO uto) {
		int flag = 2;
		int result = userMapper.userDelete(uto);
			
		if ( result == 1 ) {
			flag = 0;
		} else if ( result == 0 ) {
			flag = 1;
		}
		
		return flag;
	}
}
