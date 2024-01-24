package com.gorea.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.gorea.dto.mypage.Gorea_BoardListTO;
import com.gorea.dto_board.Gorea_QnA_BoardTO;
import com.gorea.dto_board.Gorea_SearchResultTO;
import com.gorea.dto_user.Gorea_UserTO;

@Mapper
public interface MypageMapper {
	
	// 회원 정보
	@Select("SELECT userSeq, username, password, userLastname, userFirstname, userNickname, userMail, userNation FROM User WHERE userSeq=#{userSeq}")
	Gorea_UserTO userInfoModify(Gorea_UserTO uto);
	
	// 회원정보수정
	@Update("Update User SET userFirstname=#{userFirstname}, userLastname=#{userLastname}, userNickname=#{userNickname}, userNation=#{userNation} WHERE userSeq=#{userSeq}")
	int userInfoModify_Ok(Gorea_UserTO uto);
	
	// 페이징
	// 게시글 - 자유게시판, 여행자 추천, BestTop5
	@Select("SELECT SUM(total_count) AS total_count FROM (" +
	        "SELECT COUNT(*) AS total_count FROM editrecommend " +
	        "UNION ALL " +
	        "SELECT COUNT(*) AS total_count FROM FreeBoard " +
	        "UNION ALL " +
	        "SELECT COUNT(*) AS total_count FROM UserRecommend " +
	        ") AS counts")
	int mypageBoardList_TotalCount();
	
	// 댓글 - 자유게시판, 여행자추천, 에디터추천, 에디터꿀팁, 트렌드서울, BestTop5
	// 여행자 추천, BestTop5 추가해야함
	@Select("SELECT SUM(total_count) AS total_count FROM (" +
	        "SELECT COUNT(*) AS total_count FROM editrecommendReply " +
	        "UNION ALL " +
	        "SELECT COUNT(*) AS total_count FROM TrendReview " +
	        "UNION ALL " +
	        "SELECT COUNT(*) AS total_count FROM reply " +
	        "UNION ALL " +
	        "SELECT COUNT(*) AS total_count FROM edittipReply " +
	        ") AS counts")
	int mypageReplyList_TotalCount();

	
	@Select("SELECT COUNT(*) FROM qna")
	int mypageQnaList_TotalCount();
	
	// 회원 게시글 조회
	// 자유게시판, 여행자 추천, BestTop5
	// 에디터 추천  -> BestTop5 변경해야함
	@Select("SELECT '자유게시판' AS boardType, f.freeSeq AS id, f.freeTitle AS title, date_format(f.freepostDate, '%Y.%m.%d') AS postDate, f.freeHit AS hit, u.userNickname AS userNickname "
	        + "FROM FreeBoard f "
	        + "JOIN User u ON f.userSeq = u.userSeq "
	        + "WHERE f.userSeq=#{userSeq}"
	        + " UNION ALL "
	        + "SELECT '여행자 추천' AS boardType, ur.userRecomSeq AS id, ur.userRecomTitle AS title, date_format(ur.userRecompostDate, '%Y.%m.%d') AS postDate, ur.userRecomHit AS hit, u.userNickname AS userNickname "
	        + "FROM UserRecommend ur "
	        + "JOIN User u ON ur.userSeq = u.userSeq "
	        + "WHERE ur.userSeq=#{userSeq}"
	        + " UNION ALL "
	        + "SELECT '에디터 추천' AS boardType, er.editrecoSeq AS id, er.editrecoSubject AS title, date_format(er.editrecoWdate, '%Y.%m.%d') AS postDate, er.editrecoHit AS hit, u.userNickname AS userNickname "
	        + "FROM editrecommend er "
	        + "JOIN User u ON er.userSeq = u.userSeq "
	        + "WHERE er.userSeq=#{userSeq} LIMIT #{firstRow}, #{pageSize}")
	List<Gorea_BoardListTO> boardList(@Param("userSeq") String userSeq, @Param("firstRow") int firstRow, @Param("pageSize") int pageSize);

	// 게시글  검색
	@Select({
	    "<script>",
	    "SELECT '자유게시판' AS boardType, f.freeSeq AS id, f.freeTitle AS title, date_format(f.freepostDate, '%Y.%m.%d') AS postDate, f.freeHit AS hit, u.userNickname AS userNickname ",
	    "FROM FreeBoard f JOIN User u ON f.userSeq = u.userSeq ",
	    "WHERE f.userSeq=#{userSeq}",
	    "<if test='keyword != null and keyword != \"\"'>",
	    " AND (f.freeTitle LIKE CONCAT('%', #{keyword}, '%') OR f.freeContent LIKE CONCAT('%', #{keyword}, '%'))",
	    "</if>",
	    " UNION ALL ",
	    "SELECT '여행자 추천' AS boardType, ur.userRecomSeq AS id, ur.userRecomTitle AS title, date_format(ur.userRecompostDate, '%Y.%m.%d') AS postDate, ur.userRecomHit AS hit, u.userNickname AS userNickname ",
	    "FROM UserRecommend ur JOIN User u ON ur.userSeq = u.userSeq ",
	    "WHERE ur.userSeq=#{userSeq}",
	    "<if test='keyword != null and keyword != \"\"'>",
	    " AND (ur.userRecomTitle LIKE CONCAT('%', #{keyword}, '%') OR ur.userRecomContent LIKE CONCAT('%', #{keyword}, '%'))",
	    "</if>",
	    " UNION ALL ",
	    "SELECT '에디터 추천' AS boardType, er.editrecoSeq AS id, er.editrecoSubject AS title, date_format(er.editrecoWdate, '%Y.%m.%d') AS postDate, er.editrecoHit AS hit, u.userNickname AS userNickname ",
	    "FROM editrecommend er JOIN User u ON er.userSeq = u.userSeq ",
	    "WHERE er.userSeq=#{userSeq}",
	    "<if test='keyword != null and keyword != \"\"'>",
	    " AND (er.editrecoSubject LIKE CONCAT('%', #{keyword}, '%') OR er.editrecoContent LIKE CONCAT('%', #{keyword}, '%'))",
	    "</if>",
	    " LIMIT #{firstRow}, #{pageSize}",
	    "</script>"
	})
	List<Gorea_BoardListTO> searchBoardList(@Param("userSeq") String userSeq, @Param("keyword") String keyword, @Param("firstRow") int firstRow, @Param("pageSize") int pageSize);

    // 전체 게시판 검색 결과 카운트
    @Select("SELECT SUM(cnt) FROM (" +
            "SELECT COUNT(*) AS cnt FROM Freeboard WHERE freeTitle LIKE CONCAT('%', #{keyword}, '%') OR freeContent LIKE CONCAT('%', #{keyword}, '%') " +
            "UNION ALL " +
            "SELECT COUNT(*) AS cnt FROM EditTip WHERE edittipSubject LIKE CONCAT('%', #{keyword}, '%') OR edittipContent LIKE CONCAT('%', #{keyword}, '%') " +
            "UNION ALL " +
            "SELECT COUNT(*) AS cnt FROM EditRecommend WHERE editrecoSubject LIKE CONCAT('%', #{keyword}, '%') OR editrecoContent LIKE CONCAT('%', #{keyword}, '%') " +
            ") total")
    int countTotalSearchResults(@Param("keyword") String keyword);

	// 댓글 - 자유게시판, 여행자추천, 에디터추천, 에디터꿀팁, 트렌드서울, BestTop5
	// 자유게시판, 여행자추천 게시판 추가해야함
	// 댓글 조회
	@Select("SELECT '트렌드 서울' AS boardType, tr.userSeq AS id, tr.seoulSeq AS boardID, tr.comment AS comment, date_format(tr.reviewDate, '%Y.%m.%d') AS postDate, ts.seoulTitle AS title "
			+ "FROM TrendReview tr JOIN TrendSeoul ts ON tr.seoulSeq = ts.seoulSeq "
			+ "WHERE tr.userSeq = #{userSeq} "
			+ "UNION ALL "
			+ "SELECT '에디터 추천장소' AS boardType, err.userSeq AS id, err.editrecoSeq AS boardID, err.editRecoCmtContent AS comment, date_format(err.editrecoCmtWdate, '%Y.%m.%d') AS postDate, er.editrecoSubject AS title  "
			+ "FROM editrecommendReply err JOIN editRecommend er ON err.editrecoSeq = er.editrecoSeq "
			+ "WHERE err.userSeq = #{userSeq}"
			+ "UNION ALL "
			+ "SELECT '에디터 꿀팁' AS boardType, etr.userSeq AS id, etr.edittipSeq AS boardID, etr.edittipCmtContent AS comment, date_format(etr.edittipCmtWdate, '%Y.%m.%d') AS postDate, et.edittipSubject AS title  "
			+ "FROM edittipReply etr JOIN edittip et ON etr.edittipSeq = et.edittipSeq "
			+ "WHERE etr.userSeq = #{userSeq} LIMIT #{firstRow}, #{pageSize}")
	List<Gorea_BoardListTO> replyList(@Param("userSeq") String userSeq, @Param("firstRow") int firstRow, @Param("pageSize") int pageSize);
	
	@Select({
	    "<script>",
	    "SELECT '트렌드 서울' AS boardType, tr.userSeq AS id, tr.seoulSeq AS boardID, tr.comment AS comment, date_format(tr.reviewDate, '%Y.%m.%d') AS postDate, ts.seoulTitle AS title ",
	    "FROM TrendReview tr JOIN TrendSeoul ts ON tr.seoulSeq = ts.seoulSeq ",
	    "WHERE tr.userSeq = #{userSeq}",
	    "<if test='keyword != null and keyword != \"\"'>",
	    " AND tr.comment LIKE CONCAT('%', #{keyword}, '%')",
	    "</if>",
	    " UNION ALL ",
	    "SELECT '에디터 추천장소' AS boardType, err.userSeq AS id, err.editrecoSeq AS boardID, err.editRecoCmtContent AS comment, date_format(err.editrecoCmtWdate, '%Y.%m.%d') AS postDate, er.editrecoSubject AS title  ",
	    "FROM editrecommendReply err JOIN editRecommend er ON err.editrecoSeq = er.editrecoSeq ",
	    "WHERE err.userSeq = #{userSeq}",
	    "<if test='keyword != null and keyword != \"\"'>",
	    " AND err.editRecoCmtContent LIKE CONCAT('%', #{keyword}, '%')",
	    "</if>",
	    " UNION ALL ",
	    "SELECT '에디터 꿀팁' AS boardType, etr.userSeq AS id, etr.edittipSeq AS boardID, etr.edittipCmtContent AS comment, date_format(etr.edittipCmtWdate, '%Y.%m.%d') AS postDate, et.edittipSubject AS title  ",
	    "FROM edittipReply etr JOIN edittip et ON etr.edittipSeq = et.edittipSeq ",
	    "WHERE etr.userSeq = #{userSeq}",
	    "<if test='keyword != null and keyword != \"\"'>",
	    " AND etr.edittipCmtContent LIKE CONCAT('%', #{keyword}, '%')",
	    "</if>",
	    " LIMIT #{firstRow}, #{pageSize}",
	    "</script>"
	})
	List<Gorea_BoardListTO> searchReplyList(@Param("userSeq") String userSeq, @Param("keyword") String keyword, @Param("firstRow") int firstRow, @Param("pageSize") int pageSize);

	@Select({
	    "<script>",
	    "SELECT COUNT(*) FROM (",
	    "SELECT '트렌드 서울' AS boardType, tr.userSeq AS id, tr.seoulSeq AS boardID, tr.comment AS comment, date_format(tr.reviewDate, '%Y.%m.%d') AS postDate ",
	    "FROM TrendReview tr JOIN TrendSeoul ts ON tr.seoulSeq = ts.seoulSeq ",
	    "WHERE tr.userSeq = #{userSeq}",
	    "<if test='keyword != null and keyword != \"\"'>",
	    " AND tr.comment LIKE CONCAT('%', #{keyword}, '%')",
	    "</if>",
	    " UNION ALL ",
	    "SELECT '에디터 추천장소' AS boardType, err.userSeq AS id, err.editrecoSeq AS boardID, err.editRecoCmtContent AS comment, date_format(err.editrecoCmtWdate, '%Y.%m.%d') AS postDate ",
	    "FROM editrecommendReply err JOIN editRecommend er ON err.editrecoSeq = er.editrecoSeq ",
	    "WHERE err.userSeq = #{userSeq}",
	    "<if test='keyword != null and keyword != \"\"'>",
	    " AND err.editRecoCmtContent LIKE CONCAT('%', #{keyword}, '%')",
	    "</if>",
	    " UNION ALL ",
	    "SELECT '에디터 꿀팁' AS boardType, etr.userSeq AS id, etr.edittipSeq AS boardID, etr.edittipCmtContent AS comment, date_format(etr.edittipCmtWdate, '%Y.%m.%d') AS postDate ",
	    "FROM edittipReply etr JOIN edittip et ON etr.edittipSeq = et.edittipSeq ",
	    "WHERE etr.userSeq = #{userSeq}",
	    "<if test='keyword != null and keyword != \"\"'>",
	    " AND etr.edittipCmtContent LIKE CONCAT('%', #{keyword}, '%')",
	    "</if>",
	    ") AS TotalCount",
	    "</script>"
	})
	int countSearchReplyList(@Param("userSeq") String userSeq, @Param("keyword") String keyword);

	
	// 문의 내역 조회
	@Select("SELECT qnaSeq, qnaTitle, qnaCategory, date_format(qnapostDate, '%Y.%m.%d') as qnapostDate FROM qna WHERE userSeq = #{userSeq} LIMIT #{firstRow}, #{pageSize}")
	List<Gorea_QnA_BoardTO> qnaList(@Param("userSeq") String userSeq, @Param("firstRow") int firstRow, @Param("pageSize") int pageSize);
	
   
}
