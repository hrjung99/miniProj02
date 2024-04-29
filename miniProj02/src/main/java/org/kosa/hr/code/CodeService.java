package org.kosa.hr.code;

import java.util.List;

import org.kosa.hr.entity.CodeVO;
import org.springframework.stereotype.Service;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
@RequiredArgsConstructor
public class CodeService {
	
	private static final long serialVersionUID = 1L;
	
	private final CodeMapper codeMapper;
	
	public List<CodeVO> getList(){
		return codeMapper.getList();
	}

}
