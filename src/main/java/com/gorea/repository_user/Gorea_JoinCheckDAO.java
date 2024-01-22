package com.gorea.repository_user;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.gorea.mapper.UserMapper;

@Repository
public class Gorea_JoinCheckDAO {

	@Autowired
	private UserMapper userMapper;
	
	public int checkUsername(String username) {
		
		int result = userMapper.checkUsername(username);
		
        return result;
    }
	
	public int checkUserNickname(String nickname) {
		
		int result = userMapper.checkUserNickname(nickname);
		
        return result;
	}
	
}
