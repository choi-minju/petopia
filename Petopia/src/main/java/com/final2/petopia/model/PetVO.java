package com.final2.petopia.model;

import org.springframework.stereotype.Repository;

@Repository
public class PetVO {

	private int pet_UID;			// 반려동물코드
	private int fk_idx;				// 회원고유번호
	private String pet_name;		// 반려동물이름
	private String pet_type;		// 종류
	private String pet_birthday;	// 반려동물생일
	private String pet_size;		// 사이즈
	private int pet_weight;			// 몸무게
	private int pet_gender;			// 성별
	private int pet_neutral;		// 중성화여부
	private String medical_history;	// 과거병력기재
	private String allergy;			// 알러지내역
	private String pet_profileimg;	// 반려동물사진
	
	public PetVO() {}
	
	public PetVO(int pet_UID, int fk_idx, String pet_name, String pet_type, String pet_birthday, String pet_size,
			int pet_weight, int pet_gender, int pet_neutral, String medical_history, String allergy,
			String pet_profileimg) {
		this.pet_UID = pet_UID;
		this.fk_idx = fk_idx;
		this.pet_name = pet_name;
		this.pet_type = pet_type;
		this.pet_birthday = pet_birthday;
		this.pet_size = pet_size;
		this.pet_weight = pet_weight;
		this.pet_gender = pet_gender;
		this.pet_neutral = pet_neutral;
		this.medical_history = medical_history;
		this.allergy = allergy;
		this.pet_profileimg = pet_profileimg;
	}

	public int getPet_UID() {
		return pet_UID;
	}

	public void setPet_UID(int pet_UID) {
		this.pet_UID = pet_UID;
	}

	public int getFk_idx() {
		return fk_idx;
	}

	public void setFk_idx(int fk_idx) {
		this.fk_idx = fk_idx;
	}

	public String getPet_name() {
		return pet_name;
	}

	public void setPet_name(String pet_name) {
		this.pet_name = pet_name;
	}

	public String getPet_type() {
		return pet_type;
	}

	public void setPet_type(String pet_type) {
		this.pet_type = pet_type;
	}

	public String getPet_birthday() {
		return pet_birthday;
	}

	public void setPet_birthday(String pet_birthday) {
		this.pet_birthday = pet_birthday;
	}

	public String getPet_size() {
		return pet_size;
	}

	public void setPet_size(String pet_size) {
		this.pet_size = pet_size;
	}

	public int getPet_weight() {
		return pet_weight;
	}

	public void setPet_weight(int pet_weight) {
		this.pet_weight = pet_weight;
	}

	public int getPet_gender() {
		return pet_gender;
	}

	public void setPet_gender(int pet_gender) {
		this.pet_gender = pet_gender;
	}

	public int getPet_neutral() {
		return pet_neutral;
	}

	public void setPet_neutral(int pet_neutral) {
		this.pet_neutral = pet_neutral;
	}

	public String getMedical_history() {
		return medical_history;
	}

	public void setMedical_history(String medical_history) {
		this.medical_history = medical_history;
	}

	public String getAllergy() {
		return allergy;
	}

	public void setAllergy(String allergy) {
		this.allergy = allergy;
	}

	public String getPet_profileimg() {
		return pet_profileimg;
	}

	public void setPet_profileimg(String pet_profileimg) {
		this.pet_profileimg = pet_profileimg;
	}
	
} // end of class PetVO
