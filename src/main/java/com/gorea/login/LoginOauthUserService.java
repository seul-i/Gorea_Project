package com.gorea.login;

import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.oauth2.client.userinfo.DefaultOAuth2UserService;
import org.springframework.security.oauth2.client.userinfo.OAuth2UserRequest;
import org.springframework.security.oauth2.core.OAuth2AuthenticationException;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.stereotype.Service;

import com.gorea.dto_user.Gorea_JoinTO;
import com.gorea.dto_user.Gorea_UserTO;
import com.gorea.mapper.UserMapper;
import com.gorea.repository_user.Gorea_UserDAO_Interface;

@Service
public class LoginOauthUserService extends DefaultOAuth2UserService {
	
	@Autowired
	private UserMapper userMapper;
	@Autowired
	private @Lazy BCryptPasswordEncoder encodePwd;
	@Autowired
	private Gorea_UserDAO_Interface gorea_UserDAO_Interface;

	
	@Override
	public OAuth2User loadUser(OAuth2UserRequest userRequest) throws OAuth2AuthenticationException {
		
		OAuth2User oauth2user = super.loadUser(userRequest);
		
		String provider = userRequest.getClientRegistration().getRegistrationId();
		String username = provider + "_" + oauth2user.getAttribute("sub");
		
		Gorea_UserTO user = userMapper.login(username);
		
		if(user == null) {
			
			UUID uid = UUID.randomUUID();
			String password = encodePwd.encode(uid.toString());
			String Google_mail = oauth2user.getAttribute("email");
			
			Gorea_JoinTO join = new Gorea_JoinTO();
			join.setUsername(username);
			join.setPassword(password);
			join.setUserMail(Google_mail);
			join.setUserNickname(username);
			
			gorea_UserDAO_Interface.join(join);
			
			user = userMapper.login(username);
		}
 		
		LoginService loginService = new LoginService();
		loginService.setGorea_UserTO(user);
		
		return loginService;
	}
}
