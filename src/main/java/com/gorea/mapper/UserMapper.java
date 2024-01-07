package com.gorea.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Options;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.gorea.dto_board.Gorea_EditRecommend_BoardTO;
import com.gorea.dto_user.Gorea_JoinTO;
import com.gorea.dto_user.Gorea_UserTO;

@Mapper
public interface UserMapper {
	
	// 회원가입
	@Insert("insert into user (username, password, userLastname, userFirstname, userNickname, userMail, userNation, userPoint) " +
	        "values (#{username}, #{password}, #{userLastname}, #{userFirstname}, #{userNickname}, #{userMail}, #{userNation}, #{userPoint})")
	@Options(useGeneratedKeys = true, keyProperty = "userSeq")
	int join(Gorea_JoinTO gorea_JoinTO);
	
	// 로그인
	@Select("select "+
			"userSeq,"+
			"username,"+
			"password,"+
			"userLastname,"+
			"userFirstname,"+
			"userNickname,"+
			"userMail,"+
			"userNation,"+
			"userJoindate,"+
			"userPoint,"+
			"userRating,"+
			"userRole "+
				"FROM user " +
				"WHERE username = #{username}")
	Gorea_UserTO login(String username);
	
	/* editRecommend */
	
	// editrecoList
	@Select("SELECT editrecoSeq, filename, editrecoSubject, editrecoSubtitle, editrecoContent, uid FROM editrecommend ORDER BY editrecoSeq DESC LIMIT #{firstRow}, #{pageSize}")
	List<Gorea_EditRecommend_BoardTO> editRecommend_List(@Param("firstRow") int firstRow, @Param("pageSize") int pageSize);

    @Select("SELECT COUNT(*) FROM editrecommend")
    int getTotalRowCount();
	
	// editrecoWriteOk
	@Insert("insert into editrecommend values ( 0, #{editrecoSubject}, #{editrecoSubtitle}, #{editrecoContent}, 0, #{editrecoWdate}, #{uid}, #{filename} )")
	int editRecommend_Write_Ok(Gorea_EditRecommend_BoardTO to);

	// editrecoView
	@Select("select editrecoSubject, editrecoSubtitle, editrecoHit, editrecoContent, editrecoWdate from editrecommend where editrecoSeq=#{editrecoSeq}")
	Gorea_EditRecommend_BoardTO editRecommend_View(Gorea_EditRecommend_BoardTO to);
	
	// editrecoModify
	@Select("select editrecoSubject, editrecoSubtitle, editrecoContent, uid, filename from editrecommend where editrecoSeq=#{editrecoSeq}")
	Gorea_EditRecommend_BoardTO editRecommend_Modify(Gorea_EditRecommend_BoardTO to);
	
	// editrecoDeleteOk
	@Delete("delete from editrecommend where editrecoSeq=#{editrecoSeq}")
	int editRecommend_Delete_Ok(Gorea_EditRecommend_BoardTO to);
	
	// editrecoModifyOk
	@Update("update editrecommend set editrecoSubject=#{editrecoSubject}, editrecoSubtitle=#{editrecoSubtitle}, editrecoContent=#{editrecoContent}, filename=#{filename} where editrecoSeq=#{editrecoSeq}")
	int editRecommend_Modify_Ok(Gorea_EditRecommend_BoardTO to);

	// editrecoViewHit
	@Update("update editrecommend set editrecoHit=editrecoHit+1 where editrecoSeq=#{editrecoSeq}")
	int editRecommend_ViewHit(Gorea_EditRecommend_BoardTO to);
}


//@Insert("INSERT INTO BM_USER (USERNAME, PASSWORD, EMAIL, NICKNAME, PHONE) " +
//"VALUES (#{username}, #{password}, #{email}, #{nickname}, #{phone})")
//@Options(useGeneratedKeys = true, keyProperty = "id")
//int join(Gorea_JoinTO join);

//@Insert("INSERT INTO BM_USER (USERNAME, PASSWORD, EMAIL, NICKNAME, PHONE, ROLE) " +
//"VALUES (#{username}, #{password}, #{email}, #{nickname}, #{phone}, #{admin})")
//@Options(useGeneratedKeys = true, keyProperty = "id")
//int adminjoin(Join join);

//@Select("SELECT " +
//"U.ID, " +
//"U.USERNAME, " +
//"U.PASSWORD, " +
//"U.EMAIL, " +
//"U.NICKNAME, " +
//"U.PHONE, " +
//"U.RATING, " +
//"U.ROLE, " +
//"P.POINT " +
//"FROM " +
//"BM_USER U " +
//"LEFT JOIN " +
//"(SELECT USER_ID, SUM(POINT) POINT FROM BM_POINT GROUP BY USER_ID) P " +
//"ON " +
//"U.ID = P.USER_ID " +
//"WHERE U.USERNAME = #{username}")
//Gorea_UserTO login(String username);