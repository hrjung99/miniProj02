package org.kosa.hr.member;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.validation.Valid;

import org.kosa.hr.code.CodeService;
import org.kosa.hr.entity.BoardVO;
import org.kosa.hr.entity.MemberVO;
import org.kosa.hr.page.PageRequestVO;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequiredArgsConstructor
@RequestMapping("/member")
public class MemberController {

	private final MemberService memberService;
	private final CodeService codeService;

	// list
	@RequestMapping("list")
	public String list(@Valid PageRequestVO pageRequestVO, BindingResult bindingResult, Model model,
			Authentication authentication) throws ServletException, IOException {
		log.info("Member Controller-list");

		log.info(pageRequestVO.toString());

		if (bindingResult.hasErrors()) {
			pageRequestVO = PageRequestVO.builder().build();
		}

		// 2. jsp출력할 값 설정
		model.addAttribute("pageResponseVO", memberService.getList(pageRequestVO));
		// model.addAttribute("sizes", new int[] {10, 20, 50, 100});
		model.addAttribute("sizes", codeService.getList());
//		model.addAttribute("sizes", "10,20,50,100");

		if (authentication != null) {
			log.info("Principal {} ", authentication.getPrincipal());
		}

		return "member/list";
	}

	@RequestMapping("view")
	@ResponseBody
	public Map<String, Object> view(@RequestBody MemberVO member) throws ServletException, IOException {
		log.info("json 상세보기 -> {}", member);

		MemberVO resultVO = memberService.view(member);

		Map<String, Object> map = new HashMap<>();
		if (resultVO != null) { // 성공
			map.put("status", 0);
		} else {
			map.put("status", -99);
			map.put("statusMessage", "회원 정보가 존재하지 않습니다");
		}

		return map;
	}

}