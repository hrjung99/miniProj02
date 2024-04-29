package org.kosa.hr.page;

import java.util.List;
import lombok.Builder;

public class PageResponseVO<E> {

	private int pageNo;
	private int size;
	private int total;

	private int start;
	private int end;

	private boolean prev;
	private boolean next;

	private List<E> list;

	@Builder(builderMethodName = "withAll")
	public PageResponseVO(List<E> list, int total, int pageNo, int size) {

		this.pageNo = pageNo;
		this.size = size;

		this.total = total;
		this.list = list;

		this.end = (int) (Math.ceil(this.pageNo / 10.0)) * 10;

		this.start = this.end - 9;

		int last = (int) (Math.ceil((total / (double) size)));

		this.end = end > last ? last : end;

		this.prev = this.start > 1;

		this.next = total > this.end * this.size;

	}
}
