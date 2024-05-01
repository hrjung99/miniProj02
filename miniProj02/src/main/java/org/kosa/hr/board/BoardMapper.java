package org.kosa.hr.board;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.kosa.hr.entity.BoardVO;
import org.kosa.hr.page.PageRequestVO;

@Mapper
public interface BoardMapper {
	
	List<BoardVO> getList(PageRequestVO pageRequestVO);
	int getTotalCount(PageRequestVO pageRequestVO);
	//int incViewCount(BoardVO boardVO);

}
