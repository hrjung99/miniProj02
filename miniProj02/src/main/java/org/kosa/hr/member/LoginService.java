package org.kosa.hr.member;

import org.kosa.hr.entity.MemberVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class LoginService implements UserDetailsService {
	@Autowired
	private MemberMapper memberMapper;
	
	public static void main(String [] args) {
		BCryptPasswordEncoder bCryptPasswordEncoder = new BCryptPasswordEncoder();
		System.out.println(bCryptPasswordEncoder.encode("1004")); //1004의 암호화된 값 확인
	}
	
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		log.info("mid = [{}]", username);
		MemberVO resultVO = memberMapper.login(MemberVO.builder().mid(username).build());
		log.info("resultVO" + resultVO);
		if (resultVO == null) {
			log.info(username + " 사용자가 존재하지 않습니다");
			throw new UsernameNotFoundException(username + " 사용자가 존재하지 않습니다");
		}
		
		//로그인 횟수를 카운트 한다
		memberMapper.loginCountInc(resultVO);
		
		return resultVO;
	}

}
