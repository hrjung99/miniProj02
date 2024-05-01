package org.kosa.hr.board;

import java.util.List;

import org.kosa.hr.entity.BoardVO;
import org.kosa.hr.page.PageRequestVO;
import org.kosa.hr.page.PageResponseVO;
import org.springframework.stereotype.Service;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
@RequiredArgsConstructor
public class BoardService {
	private static final long serialVersionUID = 1L;
	
	private final BoardMapper boardMapper;
	
	public PageResponseVO<BoardVO> getList(PageRequestVO pageRequestVO){
		List<BoardVO> list = boardMapper.getList(pageRequestVO);
		int total = boardMapper.getTotalCount(pageRequestVO);
		
		log.info("service - list {}", list);
		log.info("total = {}", total);
		
		PageResponseVO<BoardVO> pageResponseVO = new PageResponseVO<BoardVO>(
				list,
				total,
				pageRequestVO.getSize(),
				pageRequestVO.getPageNo()
				);
		
		return pageResponseVO;
	}

}
