package com.gorea.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import com.gorea.dto_board.Gorea_SearchResultTO;

@Mapper
public interface SearchMapper {
	
	// 자유게시판 검색
	@Select("SELECT 'FreeBoard' AS boardType, freeSeq AS id, freetitle AS title, freeContent AS content, date_format(freepostDate, '%Y-%m-%d') AS postDate, freeHit AS hit FROM FreeBoard WHERE freeTitle LIKE CONCAT('%', #{keyword}, '%') OR freeContent LIKE CONCAT('%', #{keyword}, '%') ORDER BY postDate DESC LIMIT #{pageSize} OFFSET #{offset}")
	List<Gorea_SearchResultTO> searchFreeBoard(@Param("keyword") String keyword, @Param("offset") int offset, @Param("pageSize") int pageSize);
	
	// 유저추천 검색
	@Select("SELECT 'UserRecommend' AS boardType, userRecomSeq AS id, userRecomTitle AS title, userRecomContent AS content, date_format(userRecompostDate, '%Y-%m-%d') AS postDate, userRecomHit AS hit FROM UserRecommend WHERE userRecomTitle LIKE CONCAT('%', #{keyword}, '%') OR userRecomContent LIKE CONCAT('%', #{keyword}, '%') ORDER BY postDate DESC LIMIT #{pageSize} OFFSET #{offset}")
	List<Gorea_SearchResultTO> searchUserRecommend(@Param("keyword") String keyword, @Param("offset") int offset, @Param("pageSize") int pageSize);

    // 공지사항 검색
    @Select("SELECT 'Notice' AS boardType, noticeSeq AS id, noticeTitle AS title, noticeContent AS content, date_format(noticepostDate, '%Y-%m-%d') AS postDate, noticeHit AS hit FROM Notice WHERE noticeTitle LIKE CONCAT('%', #{keyword}, '%') OR noticeContent LIKE CONCAT('%', #{keyword}, '%') ORDER BY postDate DESC LIMIT #{pageSize} OFFSET #{offset}")
    List<Gorea_SearchResultTO> searchNotice(@Param("keyword") String keyword, @Param("offset") int offset, @Param("pageSize") int pageSize);

    // 에디터 팁 검색
    @Select("SELECT 'EditTip' AS boardType, edittipSeq AS id, edittipSubject AS title, edittipContent AS content, date_format(edittipWdate, '%Y-%m-%d') AS postDate, edittipHit AS hit FROM EditTip WHERE edittipSubject LIKE CONCAT('%', #{keyword}, '%') OR edittipContent LIKE CONCAT('%', #{keyword}, '%') ORDER BY postDate DESC LIMIT #{pageSize} OFFSET #{offset}")
    List<Gorea_SearchResultTO> searchEditTip(@Param("keyword") String keyword, @Param("offset") int offset, @Param("pageSize") int pageSize);

    // 에디터 추천 검색
    @Select("SELECT 'EditRecommend' AS boardType, editrecoSeq AS id, editrecoSubject AS title, editrecoContent AS content, date_format(editrecoWdate, '%Y-%m-%d') AS postDate, editrecoHit AS hit FROM EditRecommend WHERE editrecoSubject LIKE CONCAT('%', #{keyword}, '%') OR editrecoContent LIKE CONCAT('%', #{keyword}, '%') ORDER BY postDate DESC LIMIT #{pageSize} OFFSET #{offset}")
    List<Gorea_SearchResultTO> searchEditRecommend(@Param("keyword") String keyword, @Param("offset") int offset, @Param("pageSize") int pageSize);
    
    // 트랜드 서울 게시판 검색
    @Select("SELECT 'TrendSeoul' AS boardType, seoulSeq AS id, seoulTitle AS title, seoulContent AS content, date_format(seoulpostDate, '%Y-%m-%d') AS postDate, seoulHit AS hit " +
            "FROM TrendSeoul WHERE seoulTitle LIKE CONCAT('%', #{keyword}, '%') OR seoulContent LIKE CONCAT('%', #{keyword}, '%') ORDER BY postDate DESC LIMIT #{pageSize} OFFSET #{offset}")
    List<Gorea_SearchResultTO> searchTrendSeoul(@Param("keyword") String keyword, @Param("offset") int offset, @Param("pageSize") int pageSize);
	
	 // 전체 게시판 검색 (통합 쿼리)
    @Select("SELECT 'FreeBoard' AS boardType, freeSeq AS id, freeTitle AS title, freeContent AS content, date_format(freepostDate, '%Y-%m-%d') AS postDate, freeHit AS hit " +
            "FROM FreeBoard WHERE freeTitle LIKE CONCAT('%', #{keyword}, '%') OR freeContent LIKE CONCAT('%', #{keyword}, '%') " +
            "UNION ALL " +
            "SELECT 'TrendSeoul' AS boardType, seoulSeq AS id, seoulTitle AS title, seoulContent AS content, date_format(seoulpostDate, '%Y-%m-%d') AS postDate, seoulHit AS hit " +
            "FROM TrendSeoul WHERE seoulTitle LIKE CONCAT('%', #{keyword}, '%') OR seoulContent LIKE CONCAT('%', #{keyword}, '%') " +
            "UNION ALL " +
            "SELECT 'EditTip' AS boardType, edittipSeq AS id, edittipSubject AS title, edittipContent AS content, date_format(edittipWdate, '%Y-%m-%d') AS postDate, edittipHit AS hit " +
            "FROM EditTip WHERE edittipSubject LIKE CONCAT('%', #{keyword}, '%') OR edittipContent LIKE CONCAT('%', #{keyword}, '%') " +
            "UNION ALL " +
            "SELECT 'EditRecommend' AS boardType, editrecoSeq AS id, editrecoSubject AS title, editrecoContent AS content, date_format(editrecoWdate, '%Y-%m-%d') AS postDate, editrecoHit AS hit " +
            "FROM EditRecommend WHERE editrecoSubject LIKE CONCAT('%', #{keyword}, '%') OR editrecoContent LIKE CONCAT('%', #{keyword}, '%') " +
            "UNION ALL " +
            "SELECT 'Notice' AS boardType, noticeSeq AS id, noticeTitle AS title, noticeContent AS content, date_format(noticepostDate, '%Y-%m-%d') AS postDate, noticeHit AS hit " +
            "FROM Notice WHERE noticeTitle LIKE CONCAT('%', #{keyword}, '%') OR noticeContent LIKE CONCAT('%', #{keyword}, '%') " +
            "UNION ALL " +
            "SELECT 'UserRecommend' AS boardType, userRecomSeq AS id, userRecomTitle AS title, userRecomContent AS content, date_format(userRecompostDate, '%Y-%m-%d') AS postDate, userRecomHit AS hit " +
            "FROM UserRecommend WHERE userRecomTitle LIKE CONCAT('%', #{keyword}, '%') OR userRecomContent LIKE CONCAT('%', #{keyword}, '%') " +
            "ORDER BY postDate DESC LIMIT #{pageSize} OFFSET #{offset}")
List<Gorea_SearchResultTO> searchAllBoards(@Param("keyword") String keyword, @Param("offset") int offset, @Param("pageSize") int pageSize);
    
    // 자유게시판 검색 결과 카운트
    @Select("SELECT COUNT(*) FROM FreeBoard WHERE freeTitle LIKE CONCAT('%', #{keyword}, '%') OR freeContent LIKE CONCAT('%', #{keyword}, '%')")
    int countFreeBoard(@Param("keyword") String keyword);
    
    // 유저 추천게시판 검색 결과 카운트
    @Select("SELECT COUNT(*) FROM UserRecommend WHERE userRecomTitle LIKE CONCAT('%', #{keyword}, '%') OR userRecomContent LIKE CONCAT('%', #{keyword}, '%')")
    int countUserRecommend(@Param("keyword") String keyword);

    // 트랜드 서울 검색 결과 카운트
    @Select("SELECT COUNT(*) FROM TrendSeoul WHERE seoulTitle LIKE CONCAT('%', #{keyword}, '%') OR seoulContent LIKE CONCAT('%', #{keyword}, '%')")
    int countTrendSeoul(@Param("keyword") String keyword);

    // 에디터 팁 검색 결과 카운트
    @Select("SELECT COUNT(*) FROM EditTip WHERE edittipSubject LIKE CONCAT('%', #{keyword}, '%') OR edittipContent LIKE CONCAT('%', #{keyword}, '%')")
    int countEditTip(@Param("keyword") String keyword);

    // 에디터 추천 검색 결과 카운트
    @Select("SELECT COUNT(*) FROM EditRecommend WHERE editrecoSubject LIKE CONCAT('%', #{keyword}, '%') OR editrecoContent LIKE CONCAT('%', #{keyword}, '%')")
    int countEditRecommend(@Param("keyword") String keyword);

    // 공지사항 검색 결과 카운트
    @Select("SELECT COUNT(*) FROM Notice WHERE noticeTitle LIKE CONCAT('%', #{keyword}, '%') OR noticeContent LIKE CONCAT('%', #{keyword}, '%')")
    int countNotice(@Param("keyword") String keyword);
    
    // 전체 게시판 검색 결과 카운트
    @Select("SELECT SUM(cnt) FROM (" +
            "SELECT COUNT(*) AS cnt FROM FreeBoard WHERE freeTitle LIKE CONCAT('%', #{keyword}, '%') OR freeContent LIKE CONCAT('%', #{keyword}, '%') " +
            "UNION ALL " +
            "SELECT COUNT(*) AS cnt FROM TrendSeoul WHERE seoulTitle LIKE CONCAT('%', #{keyword}, '%') OR seoulContent LIKE CONCAT('%', #{keyword}, '%') " +
            "UNION ALL " +
            "SELECT COUNT(*) AS cnt FROM EditTip WHERE edittipSubject LIKE CONCAT('%', #{keyword}, '%') OR edittipContent LIKE CONCAT('%', #{keyword}, '%') " +
            "UNION ALL " +
            "SELECT COUNT(*) AS cnt FROM EditRecommend WHERE editrecoSubject LIKE CONCAT('%', #{keyword}, '%') OR editrecoContent LIKE CONCAT('%', #{keyword}, '%') " +
            "UNION ALL " +
            "SELECT COUNT(*) AS cnt FROM Notice WHERE noticeTitle LIKE CONCAT('%', #{keyword}, '%') OR noticeContent LIKE CONCAT('%', #{keyword}, '%')" +
            "UNION ALL " +
            "SELECT COUNT(*) AS cnt FROM UserRecommend WHERE userRecomTitle LIKE CONCAT('%', #{keyword}, '%') OR userRecomContent LIKE CONCAT('%', #{keyword}, '%')" +
            ") total")
int countTotalSearchResults(@Param("keyword") String keyword);
}