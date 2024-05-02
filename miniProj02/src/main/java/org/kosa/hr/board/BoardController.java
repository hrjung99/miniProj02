package org.kosa.hr.board;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpSession;
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

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@Slf4j
@RequiredArgsConstructor
@RequestMapping("/board")
public class BoardController {

	private final BoardService boardService;
	private final CodeService codeService;

	@RequestMapping("list")
	public String list(@Valid PageRequestVO pageRequestVO, BindingResult bindingResult, Model model, Authentication authentication)
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
		
		
		if (authentication != null) {
			log.info("Principal {} ", authentication.getPrincipal());
		}

		return "board/list";
	}

//	@RequestMapping("view")
//	public String view(BoardVO board, Model model) throws ServletException, IOException {
//		log.info("Controller-view");
//
//		// 2. jsp출력할 값 설정
//		model.addAttribute("board", boardService.view(board));
//
//		return "board/view";
//	}

	@RequestMapping("jsonBoardInfo")
	@ResponseBody
	public Map<String, Object> jsonBoardInfo(@RequestBody BoardVO board) throws ServletException, IOException {
		log.info("json 상세보기 -> {}", board);
		// 1. 처리
		BoardVO resultVO = boardService.view(board);
  
		Map<String, Object> map = new HashMap<>();
		if (resultVO != null) { // 성공
			map.put("status", 0);
			map.put("jsonBoard", resultVO);
		} else {
			map.put("status", -99);
			map.put("statusMessage", "게시물 정보 존재하지 않습니다");
		}

		return map;

	}
	
	@RequestMapping("delete")
	@ResponseBody
	public Map<String, Object> delete(@RequestBody BoardVO board) throws ServletException, IOException {
		log.info("삭제 -> {}", board);
		//1. 처리
		int updated = boardService.delete(board);
		
		Map<String, Object> map = new HashMap<>();
		if (updated == 1) { //성공
			map.put("status", 0);
		} else {
			map.put("status", -99);
			map.put("statusMessage", "게시물 정보 삭제 실패하였습니다");
		}
		
		return map;
	}
	
	
	//insert
	@RequestMapping("insertForm")
	public Object insertForm() throws ServletException, IOException {
		log.info("Controller - insertForm");
		return "board/insertForm";
	}
	
	@RequestMapping("insert")
	@ResponseBody
	public Object insert(@RequestBody BoardVO boardVO, Authentication authentication) throws ServletException, IOException {
		MemberVO loginVO = (MemberVO)authentication.getPrincipal();
		log.info("등록 BoardVO = {}\n loginVO = {}", boardVO, loginVO);
		
		Map<String, Object> map = new HashMap<>();
		map.put("status", -99);
		map.put("statusMessage", "게시물 등록에 실패하였습니다");
		
		//로그인한 사용자를 게시물 작성자로 설정한다 
		boardVO.setMid(loginVO.getMid());
		int updated = boardService.insert(boardVO);
		if (updated == 1) { //성공
			map.put("status", 0);
		}
		
		return map;
	}
	
}