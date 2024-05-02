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
	
	
	public BoardVO view(BoardVO board)  {
		//view Count의 값을 증가한다. 
		//만약 값을 증가 하지 못하면 게시물이 존재하지 않는 경우임  
		if (0 == boardMapper.incViewCount(board)) {
			return null; 
		}
		//view Count의 값이 증가된 객체를 얻는다
		BoardVO resultVO = boardMapper.view(board);
		return resultVO;
	}
	
	
	//delete
	public int delete(BoardVO board)  {
		return boardMapper.delete(board);
	}
	

}
