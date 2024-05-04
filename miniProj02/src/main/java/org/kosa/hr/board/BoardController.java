package org.kosa.hr.board;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.kosa.hr.code.CodeService;
import org.kosa.hr.entity.BoardFileVO;
import org.kosa.hr.entity.BoardVO;
import org.kosa.hr.entity.MemberVO;
import org.kosa.hr.page.PageRequestVO;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
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
			log.info("json 상세보기 -> {}", resultVO);

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
	public Object insert(BoardVO boardVO, Authentication authentication) throws ServletException, IOException {
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
	
	@GetMapping("fileDownload/{board_file_no}")
	public void downloadFile(@PathVariable("board_file_no") int board_file_no, HttpServletResponse response) throws Exception{
		OutputStream out = response.getOutputStream();
		
		BoardFileVO boardFileVO = boardService.getBoardFile(board_file_no);
		
		if (boardFileVO == null) {
			response.setStatus(404);
		} else {
			
			String originName = boardFileVO.getOriginal_filename();
			originName = URLEncoder.encode(originName, "UTF-8");
			//다운로드 할 때 헤더 설정
			response.setHeader("Cache-Control", "no-cache");
			response.addHeader("Content-disposition", "attachment; fileName="+originName);
			response.setContentLength((int)boardFileVO.getSize());
			response.setContentType(boardFileVO.getContent_type());
			
			//파일을 바이너리로 바꿔서 담아 놓고 responseOutputStream에 담아서 보낸다.
			FileInputStream input = new FileInputStream(new File(boardFileVO.getReal_filename()));
			
			//outputStream에 8k씩 전달
	        byte[] buffer = new byte[1024*8];
	        
	        while(true) {
	        	int count = input.read(buffer);
	        	if(count<0)break;
	        	out.write(buffer,0,count);
	        }
	        input.close();
	        out.close();
		}
	} 
	
	
	@GetMapping("updateForm/{bno}")
	public Object updateForm(@PathVariable("bno") String bno, BoardVO board, Model model) throws ServletException, IOException {
		log.info("수정화면");
		
		// BoardVO 객체 생성 및 bno 설정
	    board = new BoardVO();
	    board.setBno(bno);

	    // 서비스에서 게시글 정보를 가져오기
	    BoardVO boardDetails = boardService.view(board);
	    if (boardDetails == null) {
	        log.info("게시글 정보를 찾을 수 없습니다.");
	        return "redirect:/errorPage";  // 오류 페이지 또는 적절한 리디렉션 경로로 변경
	    }

	    // 모델에 게시글 정보 추가
	    model.addAttribute("board", boardDetails);
	    	
		return "board/updateForm";
	}


	
	@PostMapping("/update")
	public Object  update(BoardVO board) throws ServletException, IOException {
		log.info("수정 board => {}", board);
		
		//1. 처리
		int updated = boardService.update(board);
		
		Map<String, Object> map = new HashMap<>();
		if (updated == 1) { //성공
			map.put("status", 0);
		} else {
			map.put("status", -99);
			map.put("statusMessage", "게시물 정보 수정 실패하였습니다");
		}
		
		return "redirect:/board/list";
	}
	
	
	
}