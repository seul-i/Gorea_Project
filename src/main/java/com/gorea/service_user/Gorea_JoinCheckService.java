package com.gorea.service_user;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.gorea.repository_user.Gorea_JoinCheckDAO;


@Service
public class Gorea_JoinCheckService {

	@Autowired
	private Gorea_JoinCheckDAO gorea_JoinCheckDAO;
	
	// username (id) 검사 
	public int checkUsername(String username) {
        
        int result = gorea_JoinCheckDAO.checkUsername(username);
        
        return result;
    }
	
	// username (id) 검사 
	public int checkUserNickname(String nickname) {
	        
		int result = gorea_JoinCheckDAO.checkUserNickname(nickname);
	        
		return result;
	}
	
}
