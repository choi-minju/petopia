package com.final2.petopia.model;

import org.springframework.stereotype.Repository;

@Repository
public class CareVO {

	private String care_UID;
	private String fk_pet_UID;
	private String fk_caretype_UID;
	private String care_contents;
	private String care_memo;
	private String care_start;
	private String care_end;
	private String care_alarm;
	private String care_date;
	
}
