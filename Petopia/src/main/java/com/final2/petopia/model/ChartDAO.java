package com.final2.petopia.model;

<<<<<<< HEAD
import java.util.HashMap;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

	@Repository
	public  class ChartDAO implements InterChartDAO {
		// ===== #33. 의존 객체 주입하기 (DIL Dependency Injection) =====
			@Autowired
			private SqlSessionTemplate sqlsession;

			@Override
			public int insertmychart(HashMap<String, String> mychartmap) {
				int n =sqlsession.insert("chart.insertmychart",mychartmap);
				return n;
			}
           //회원번호로 petuid 가져오기 
			@Override
			public int selectpetuid(String idx) {
				
				int n = sqlsession.selectOne("chart.selectpetuid", idx);
				
				return n;
			}
			//펫uid로 펫정보 가져오기 
			@Override
			public PetVO selectpetinfo(String pet_uid) {
				PetVO petinfo = sqlsession.selectOne("chart.selectpetinfo",pet_uid);
				
				return petinfo;
			}
			//회원번호로 병원 이름 가져오기 
			@Override
			public String selectnickname(String idx) {
				String nickname = sqlsession.selectOne("chart.selectnickname", idx);
				System.out.println("nickname C" +nickname);
				return nickname;
			}
			//회원번호로 예약날짜 알아오기 
			@Override
			public ReservationVO selectreservedate(String idx) {
				ReservationVO reservedate = sqlsession.selectOne("chart.selectreservedate",idx);
				return reservedate;
			}
			
			


			
	}

=======
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class ChartDAO {
	// ===== #33. 의존 객체 주입하기 (DIL Dependency Injection) =====
		@Autowired
		private SqlSessionTemplate sqlsession;

		public int insertchartinfo(ReservationVO rvo) {
			// TODO Auto-generated method stub
			return 0;
		}
}
>>>>>>> refs/remotes/origin/hyunjae
