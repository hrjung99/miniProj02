package org.kosa.hr.code;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.kosa.hr.entity.CodeVO;
import org.springframework.stereotype.Repository;

@Mapper
@Repository
public interface CodeMapper {
	List<CodeVO> getList();
}
