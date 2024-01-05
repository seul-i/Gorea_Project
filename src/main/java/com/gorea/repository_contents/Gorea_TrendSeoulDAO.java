package com.gorea.repository_contents;

import java.util.ArrayList;
import java.util.Map;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.gorea.dto_board.Gorea_TrendSeoul_BoardTO;
import com.gorea.mapper.TrendMapperInter;

@Repository
public class Gorea_TrendSeoulDAO {

	@Autowired
	private TrendMapperInter mapper;
	
	@Autowired
	private Geocoding geocoding;
	
	public ArrayList<Gorea_TrendSeoul_BoardTO> trendSeoul_List() {
		ArrayList<Gorea_TrendSeoul_BoardTO> lists = new ArrayList<Gorea_TrendSeoul_BoardTO>();
		lists = mapper.trendSeoul_List();
		
		 return lists;
	}
	
	public void trendSeoul_Write() {}
	
	public int trendSeoul_Write_Ok(Gorea_TrendSeoul_BoardTO to) {
		int flag = 1;
		int result = mapper.trendSeoul_Write_Ok(to);
		
		if( result == 1 ) {
			flag = 0;
		}
		return flag;
		
	}
	
	public Gorea_TrendSeoul_BoardTO trendSeoul_View(Gorea_TrendSeoul_BoardTO to) {
		
		int hitResult = mapper.TrendHit(to);
		to = mapper.trendSeoul_View(to);
		
		 // 주소 정보 추출
        String address = to.getAddress();
        
        // 주소를 이용하여 지오코딩 수행
        Map<String, Double> coordinates = geocoding.getLatLongByAddress(address);

        // 위도와 경도 추출
        Double latitude = coordinates.get("lat");
        Double longitude = coordinates.get("lng");

        // 위도와 경도를 TO 객체에 추가
        to.setLatitude(latitude);
        to.setLongitude(longitude);

		return to;
	}
	
	public Gorea_TrendSeoul_BoardTO trendSeoul_Modify(Gorea_TrendSeoul_BoardTO to) {
		to = mapper.trendSeoul_Modify(to);
		return to;
	}
	
	public int trendSeoul_Modify_Ok(Gorea_TrendSeoul_BoardTO to) {
		System.out.println("## " + to.toString());
		int flag = 1;
		int result = mapper.trendSeoul_Modify_Ok(to);
		
		if( result == 1 ) {
			flag = 0;
			System.out.println(flag);
		}
		return flag;
	}
	
	public int trendSeoul_Delete_Ok(Gorea_TrendSeoul_BoardTO to) {
		int flag = 2;
		int result = mapper.trendSeoul_Delete_Ok(to);
			
		if ( result == 1 ) {
			flag = 0;
		} else if ( result == 0 ) {
			flag = 1;
		}
		
		return flag;
	}
	
}
