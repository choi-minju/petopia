package com.final2.petopia.model;

public class ReservationVO {

	int reservation_UID;       // 예약코드
	int fk_idx;                //회원고유번호
	int fk_schedule_UID;       // 스케쥴코드
	int fk_pet_UID;            // 반려동물코드
	String bookingdate ;          // 예약완료일시
	String reservation_DATE;     // 방문예정일
	int reservation_status;   // 예약진행상태 1 예약완료/ 2 결제완료 / 3 진료완료 / 4 취소 / 5 no show
	int reservation_type;     // 예약타입 1 진료 / 2 예방접종 / 3 수술/ 4 호텔링
	public int getReservation_UID() {
		return reservation_UID;
	}
	public void setReservation_UID(int reservation_UID) {
		this.reservation_UID = reservation_UID;
	}
	public int getFk_idx() {
		return fk_idx;
	}
	public void setFk_idx(int fk_idx) {
		this.fk_idx = fk_idx;
	}
	public int getFk_schedule_UID() {
		return fk_schedule_UID;
	}
	public void setFk_schedule_UID(int fk_schedule_UID) {
		this.fk_schedule_UID = fk_schedule_UID;
	}
	public int getFk_pet_UID() {
		return fk_pet_UID;
	}
	public void setFk_pet_UID(int fk_pet_UID) {
		this.fk_pet_UID = fk_pet_UID;
	}
	public String getBookingdate() {
		return bookingdate;
	}
	public void setBookingdate(String bookingdate) {
		this.bookingdate = bookingdate;
	}
	public String getReservation_DATE() {
		return reservation_DATE;
	}
	public void setReservation_DATE(String reservation_DATE) {
		this.reservation_DATE = reservation_DATE;
	}
	public int getReservation_status() {
		return reservation_status;
	}
	public void setReservation_status(int reservation_status) {
		this.reservation_status = reservation_status;
	}
	public int getReservation_type() {
		return reservation_type;
	}
	public void setReservation_type(int reservation_type) {
		this.reservation_type = reservation_type;
	}
	public ReservationVO() {}
	public ReservationVO(int reservation_UID, int fk_idx, int fk_schedule_UID, int fk_pet_UID, String bookingdate,
			String reservation_DATE, int reservation_status, int reservation_type) {
		super();
		this.reservation_UID = reservation_UID;
		this.fk_idx = fk_idx;
		this.fk_schedule_UID = fk_schedule_UID;
		this.fk_pet_UID = fk_pet_UID;
		this.bookingdate = bookingdate;
		this.reservation_DATE = reservation_DATE;
		this.reservation_status = reservation_status;
		this.reservation_type = reservation_type;
	}
	
	
}
