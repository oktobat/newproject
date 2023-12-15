package com.office.library.book;

public class PageVo {
	
	private int pgn;
	private int page;
	private int amount;
	private int pageNums;
	private int total_page;
	private int tpgn;
	private int start;
	private int totArticles;
	 
	public PageVo(int pGroup, int pNum, int amount, int pageNums, int totArticles) {
		this.pgn = pGroup;
		this.page = pNum;
		this.amount = amount;
		this.pageNums = pageNums;
		this.totArticles = totArticles;
		this.total_page = (int) Math.ceil(totArticles/(double)amount);
		this.tpgn = (int) Math.ceil((double)this.total_page/pageNums);
		this.start = (pNum-1)*amount;
	}

	public int getPgn() {
		return pgn;
	}

	public void setPgn(int pgn) {
		this.pgn = pgn;
	}

	public int getPage() {
		return page;
	}

	public void setPage(int page) {
		this.page = page;
	}

	public int getAmount() {
		return amount;
	}

	public void setAmount(int amount) {
		this.amount = amount;
	}

	public int getPageNums() {
		return pageNums;
	}

	public void setPageNums(int pageNums) {
		this.pageNums = pageNums;
	}

	public int getTotal_page() {
		return total_page;
	}

	public void setTotal_page(int total_page) {
		this.total_page = total_page;
	}

	public int getTpgn() {
		return tpgn;
	}

	public void setTpgn(int tpgn) {
		this.tpgn = tpgn;
	}

	public int getStart() {
		return start;
	}

	public void setStart(int start) {
		this.start = start;
	}

	public int getTotArticles() {
		return totArticles;
	}

	public void setTotArticles(int totArticles) {
		this.totArticles = totArticles;
	}

	
}
