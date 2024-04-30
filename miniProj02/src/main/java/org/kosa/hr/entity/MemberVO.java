package org.kosa.hr.entity;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collection;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class MemberVO implements UserDetails {
	
	private String mid;
	private String mpass;
	private String mname;
	private String mage;
	private String madd;
	private String mpno;
	private String mgender;
	
	private LocalDateTime member_reg_date;
	private String member_roles;
	private String member_account_expired; 
	private String member_account_locked;
	private int    member_login_count;
	private LocalDateTime member_last_login_time;
	
	//비밀번호 검증
	public boolean isEqualsPwd(String pwd) { 
		return this.mpass.equals(pwd);		
	}
	
	
	//회원 권한을 컬렉션으로 리턴
	@Override
	public Collection<? extends GrantedAuthority> getAuthorities() {
		Collection<GrantedAuthority> collections = new ArrayList<GrantedAuthority>();
		Arrays.stream(member_roles.split(",")).forEach(role -> collections.add(new SimpleGrantedAuthority("ROLE_" + role.trim())));
		
		return collections;
	}
	
	@Override
	public String getPassword() {
		return mpass;
	}
	
	@Override
	public String getUsername() {
		return mid;
	}
	
	
	//만료된 계정인지 확인하는 함수
	@Override
	public boolean isAccountNonExpired() {
		return "N".equalsIgnoreCase(member_account_expired); // 대소문자를 구분하지 않고 같은지 확인
	}
	
	//잠긴 계정인지 확인
	@Override
	public boolean isAccountNonLocked() {
		return true;
	}
	
	@Override
	public boolean isCredentialsNonExpired() {
		return true;
	}
	
	@Override
	public boolean isEnabled() {
		return true;
	}
	
}
