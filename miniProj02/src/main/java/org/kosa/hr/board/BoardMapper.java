package org.kosa.hr.board;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.kosa.hr.entity.BoardVO;
import org.kosa.hr.page.PageRequestVO;

@Mapper
public interface BoardMapper {
	
	List<BoardVO> getList(PageRequestVO pageRequestVO);
	int getTotalCount(PageRequestVO pageRequestVO);


	BoardVO view(BoardVO boardVO);
	int incViewCount(BoardVO boardVO);
	
	int delete(BoardVO boardVO);
	int insert(BoardVO boardVO);
	
	int update(BoardVO boardVO);




}
