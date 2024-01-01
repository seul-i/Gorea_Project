package com.gorea.repository_user;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.gorea.dto_user.Gorea_JoinTO;
import com.gorea.mapper.UserMapper;

@Repository
public class Gorea_UserDAO implements Gorea_UserDAO_Interface {
	
	@Autowired
	private UserMapper userMapper;

	@Override
	public void join(Gorea_JoinTO gorea_JoinTO) {
		
		int result = userMapper.join(gorea_JoinTO);
		
		if(result == 1) {
			System.out.println("회원가입 성공");
			
		}
	}
}
