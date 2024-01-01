package com.gorea.service_user;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gorea.dto_user.Gorea_JoinTO;
import com.gorea.repository_user.Gorea_UserDAO_Interface;

@Service
public class Gorea_UserService implements Gorea_UserService_Interface {

	@Autowired
	private Gorea_UserDAO_Interface gorea_UserDAO_Interface;
	
	// 로그인 
	@Override
	public void join(Gorea_JoinTO gorea_JoinTO) {
		gorea_UserDAO_Interface.join(gorea_JoinTO);

	}

}
