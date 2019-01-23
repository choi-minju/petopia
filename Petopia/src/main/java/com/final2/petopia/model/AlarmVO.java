package com.final2.petopia.model;

public class AlarmVO {
	
	private int not_UID;
	private int fk_idx;
	private String not_type;
	private String not_message;
	private String not_date;
	private int not_readcheck;
	
	public AlarmVO() {}
	
	public AlarmVO(int not_UID, int fk_idx, String not_type, String not_message, String not_date, int not_readcheck) {
		
		this.not_UID = not_UID;
		this.fk_idx = fk_idx;
		this.not_type = not_type;
		this.not_message = not_message;
		this.not_date = not_date;
		this.not_readcheck = not_readcheck;
	}

	public int getNot_UID() {
		return not_UID;
	}

	public void setNot_UID(int not_UID) {
		this.not_UID = not_UID;
	}

	public int getFk_idx() {
		return fk_idx;
	}

	public void setFk_idx(int fk_idx) {
		this.fk_idx = fk_idx;
	}

	public String getNot_type() {
		return not_type;
	}

	public void setNot_type(String not_type) {
		this.not_type = not_type;
	}

	public String getNot_message() {
		return not_message;
	}

	public void setNot_message(String not_message) {
		this.not_message = not_message;
	}

	public String getNot_date() {
		return not_date;
	}

	public void setNot_date(String not_date) {
		this.not_date = not_date;
	}

	public int getNot_readcheck() {
		return not_readcheck;
	}

	public void setNot_readcheck(int not_readcheck) {
		this.not_readcheck = not_readcheck;
	}
	
}
