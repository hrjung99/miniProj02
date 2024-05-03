package org.kosa.hr.entity;

import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.annotation.JsonIgnore;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class BoardVO {
	
	private String bno;
	private String btitle;
	private String bcontent;
	private String mid;
	private String bdate;
	private String view_count;
	private String bwriter;
	
	//업로드 파일
	@JsonIgnore
		private MultipartFile file;

		//첨부파일 
		private BoardFileVO boardFileVO; 
		

}
