package com.gorea.repository_contents;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import com.gorea.mapper.EditMapperInter;
import com.gorea.dto_board.Gorea_EditRecommend_BoardTO;
import com.gorea.dto_board.Gorea_EditTip_BoardTO;

@Repository
public class Gorea_EditDAO {
	@Autowired
	private EditMapperInter mapper;
	
	/**
	 * 에디터 추천 목록을 가져오는 메소드
	 *
	 * @param offset   가져올 목록의 시작 위치
	 * @param pageSize 페이지당 표시할 항목 수
	 * @return 에디터 추천 목록
	 */
	public List<Gorea_EditRecommend_BoardTO> editRecommend_List(int offset, int pageSize) {
	    List<Gorea_EditRecommend_BoardTO> lists = mapper.editRecommend_List(offset, pageSize);

	    return lists;
	}

	/**
	 * 전체 레코드(데이터 항목)의 수를 가져오는 메소드
	 *
	 * @return 전체 레코드 수
	 */
	public int getTotalRowCount() {
	    // MyBatis 매퍼를 통해 전체 레코드 수를 조회
	    int totalRowCount = mapper.getTotalRowCount();
	    return totalRowCount;
	}



	public void editRecommend_Write() {}

	
	public int editRecommend_Write_Ok(Gorea_EditRecommend_BoardTO to) {	
		int flag = 1;
		int result = mapper.editRecommend_Write_Ok(to);
			
		if( result == 1 ) {
			flag = 0;
		}
		return flag;
	}
	
	public Gorea_EditRecommend_BoardTO editRecommend_View(Gorea_EditRecommend_BoardTO to) {
	    // 조회수 증가 메서드 호출
	    int hitResult = mapper.editRecommend_ViewHit(to);
	    // 상세 정보 조회
	    to = mapper.editRecommend_View(to);
	    return to;
	}
	
	public Gorea_EditRecommend_BoardTO editRecommend_Modify(Gorea_EditRecommend_BoardTO to) {
		return mapper.editRecommend_Modify(to);
	}
	
	public int editRecommend_Modify_Ok(Gorea_EditRecommend_BoardTO to) {
		int flag = 1;
		int result = mapper.editRecommend_Modify_Ok(to);
		
		if( result == 1 ) {
			flag = 0;
			
		}
		return flag;
	}
	
	public int editRecommend_Delete_Ok(Gorea_EditRecommend_BoardTO to) {
		int flag = 2;
		int result = mapper.editRecommend_Delete_Ok(to);
			
		if ( result == 1 ) {
			flag = 0;
		} else if ( result == 0 ) {
			flag = 1;
		}
		
		return flag;
	}

	
	/* editTip */
	
	public List<Gorea_EditTip_BoardTO> editTip_List(int offset, int pageSize) {
	    List<Gorea_EditTip_BoardTO> lists1 = mapper.editTip_List(offset, pageSize);

	    return lists1;
	}

	public int getTotalCount() {
	    int totalCount = mapper.getTotalCount();
	    return totalCount;
	    
	}

	
	public void editTip_Write() {}
	
	public int editTip_Write_Ok(Gorea_EditTip_BoardTO eto) {	
		int flag = 1;
		int result = mapper.editTip_Write_Ok(eto);
			
		if( result == 1 ) {
			flag = 0;
		}
		return flag;
	}
	
	public Gorea_EditTip_BoardTO editTip_View(Gorea_EditTip_BoardTO eto) {
	    // 조회수 증가 메서드 호출
	    int hitResult = mapper.editTip_ViewHit(eto);
	    // 상세 정보 조회
	    eto = mapper.editTip_View(eto);
	    return eto;
	}
	
	public Gorea_EditTip_BoardTO editTip_Modify(Gorea_EditTip_BoardTO eto) {
		return mapper.editTip_Modify(eto);
	}
	
	public int editTip_Modify_Ok(Gorea_EditTip_BoardTO eto) {
		int flag = 1;
		int result = mapper.editTip_Modify_Ok(eto);
		
		if( result == 1 ) {
			flag = 0;
		}
		return flag;
	}
	
	public int editTip_Delete_Ok(Gorea_EditTip_BoardTO eto) {
		int flag = 2;
		int result = mapper.editTip_Delete_Ok(eto);
			
		if ( result == 1 ) {
			flag = 0;
		} else if ( result == 0 ) {
			flag = 1;
		}
		
		return flag;
	}

}

