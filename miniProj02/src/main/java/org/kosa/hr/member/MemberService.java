package org.kosa.hr.member;

import java.util.List;

import org.kosa.hr.member.MemberMapper;
import org.kosa.hr.entity.MemberVO;
import org.kosa.hr.page.PageRequestVO;
import org.kosa.hr.page.PageResponseVO;
import org.springframework.stereotype.Service;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
@RequiredArgsConstructor
public class MemberService {
	private static final long serialVersionUID = 1L;
	private final MemberMapper memberMapper;
	
	public PageResponseVO<MemberVO> getList(PageRequestVO pageRequestVO) {
		List<MemberVO> list = memberMapper.getList(pageRequestVO);
		int total = memberMapper.getTotalCount(pageRequestVO);

		log.info("service - list {}", list);
		log.info("total = {}", total);

		PageResponseVO<MemberVO> pageResponseVO = new PageResponseVO<MemberVO>(list, total, pageRequestVO.getSize(),
				pageRequestVO.getPageNo());

		return pageResponseVO;
	}

	
	
	
}