package org.kosa.hr.member;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.kosa.hr.entity.MemberVO;
import org.kosa.hr.page.PageRequestVO;

@Mapper
public interface MemberMapper {
	
	MemberVO login(MemberVO boardVO);
	
	//마지막 로그인 시간 변경
	int updateMemberLastLogin(String email);
	
	//비밀번호 틀린횟수 1 증가
	void loginCountInc(MemberVO member);
	
	//로그인 성공시 비밀번호 틀린 횟수 초기화
	void loginCountClear(String email);
	
	//list
	List<MemberVO> getList(PageRequestVO pageRequestVO);
	//paging
	int getTotalCount(PageRequestVO pageRequestVO);
	
	//view
	MemberVO view(MemberVO memberVO);

}
