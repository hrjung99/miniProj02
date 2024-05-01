package org.kosa.hr.board;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.validation.Valid;

import org.kosa.hr.code.CodeService;
import org.kosa.hr.page.PageRequestVO;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@Slf4j
@RequiredArgsConstructor
@RequestMapping("/board")
public class BoardController {

	private final BoardService boardService;
	private final CodeService codeService;

	@RequestMapping("list")
	public String list(@Valid PageRequestVO pageRequestVO, BindingResult bindingResult, Model model)
			throws ServletException, IOException {
		log.info("Controller-list");

		log.info(pageRequestVO.toString());

		if (bindingResult.hasErrors()) {
			pageRequestVO = PageRequestVO.builder().build();
		}

		// 2. jsp출력할 값 설정
		model.addAttribute("pageResponseVO", boardService.getList(pageRequestVO));
		// model.addAttribute("sizes", new int[] {10, 20, 50, 100});
		model.addAttribute("sizes", codeService.getList());
//		model.addAttribute("sizes", "10,20,50,100");

		return "board/list";
	}

}
