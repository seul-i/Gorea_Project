package com.gorea.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.gorea.dto_board.Gorea_Recommend_BoardTO;

@Mapper
public interface UserRecomMapperInter {
	// list
	@Select( "select us.userRecomSeq, us.userSeq , us.userRecomboardNo, us.userRecomTitle, date_format( us.userRecompostDate, '%Y /%m /%d') userRecompostDate, us.userRecomHit , us.userRecomContent ,  us.userRecomCmt, us.userRecomRecomcount, u.userNickname from UserRecommend us join user u on us.userSeq = u.userSeq" )
	List<Gorea_Recommend_BoardTO> userRecom_list(@Param("firstRow") int firstRow, @Param("pageSize") int pageSize);
	
	@Select( "select count(*) from UserRecommend" )
	int get_userRecommentTotalCount();
	
	// writeOk
	@Insert( "insert into UserRecommend values (0, 1, 2, #{userRecomTitle}, now(), 0, #{userRecomContent}, 0, 0)" )
	int userRecom_WriteOk( Gorea_Recommend_BoardTO to );
		
	// view
	@Select( "select us.userRecomSeq, us.userSeq, us.userRecomboardNo, us.userRecomTitle, date_format(us.userRecompostDate, '%Y.%m.%d %H:%i') userRecompostDate, us.userRecomHit, us.userRecomContent, us.userRecomCmt, us.userRecomRecomcount, u.userNickname "
			+ "from UserRecommend us join user u on us.userSeq = u.userSeq where us.userRecomSeq=#{userRecomSeq}")
	Gorea_Recommend_BoardTO userRecom_View( Gorea_Recommend_BoardTO to );
		
	//viewuserRecomHit
	@Update("update UserRecommend set userRecomHit=userRecomHit+1 where userRecomSeq=#{userRecomSeq}")
	int userRecom_Hit(Gorea_Recommend_BoardTO to);
		
	// deleteOk
	@Delete( "delete from UserRecommend where userRecomSeq=#{userRecomSeq}" )
	int userRecom_deleteOk( Gorea_Recommend_BoardTO to );
		
	// modify
	@Select( "select userRecomTitle, userRecomContent from UserRecommend where userRecomSeq=#{userRecomSeq}" )
	Gorea_Recommend_BoardTO userRecom_modify( Gorea_Recommend_BoardTO to );
		
	// modifyOk
	@Update( "update UserRecommend set userRecomTitle=#{userRecomTitle}, userRecomContent=#{userRecomContent} where userRecomSeq=#{userRecomSeq}")
	int userRecom_modifyOk( Gorea_Recommend_BoardTO to );
}
