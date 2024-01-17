package com.gorea.dto_board;

import java.util.List;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Gorea_PagingTO {
	
    private int cpage = 1; // 현재 페이지
    private int pageSize = 8; // 한 페이지에 표시될 항목 수
    private int totalRecord; // 전체 레코드(데이터 항목)의 수
    private int firstRow; // 현재 페이지에서 첫 번째로 표시되는 항목의 인덱스
    private int lastRow; // 현재 페이지에서 마지막으로 표시되는 항목의 인덱스
    private int totalPage; // 전체 페이지 수
    private int firstPage; // 현재 페이지 범위에서 첫 번째 페이지
    private int lastPage; // 현재 페이지 범위에서 마지막 페이지
    private int pageGroupSize = 5; // 한 화면에 보여질 페이지의 개수
    
    private List<Gorea_EditRecommend_BoardTO> lists;
    private List<Gorea_EditTip_BoardTO> lists1;
    private List<Gorea_TrendSeoul_ListTO> boardList;
    private List<Gorea_Recommend_BoardTO> boardList1;

    /**
     * 페이지 설정 메소드
     */
    public void pageSetting() {
        totalPage = (totalRecord - 1) / pageSize + 1;
        firstRow = (cpage - 1) * pageSize + 1;
        lastRow = firstRow + pageSize - 1;
        if (lastRow >= totalRecord) {
            lastRow = totalRecord;
        }

        firstPage = getFirstPageInGroup();
        lastPage = getLastPageInGroup();

        // 추가: cpage가 totalPage를 초과하지 않도록 설정
        if (cpage > totalPage) {
            cpage = totalPage;
        }
    }

    /**
     * 현재 페이지가 속한 페이지 그룹을 반환
     *
     * @return 페이지 그룹 번호
     */
    public int getPageGroup() {
        return (cpage - 1) / pageGroupSize + 1;
    }

    /**
     * 현재 페이지 그룹에서 첫 번째 페이지 번호를 반환
     *
     * @return 첫 번째 페이지 번호
     */
    public int getFirstPageInGroup() {
        return (getPageGroup() - 1) * pageGroupSize + 1;
    }

    /**
     * 현재 페이지 그룹에서 마지막 페이지 번호를 반환
     *
     * @return 마지막 페이지 번호
     */
    public int getLastPageInGroup() {
        int lastPage = getPageGroup() * pageGroupSize;
        return (lastPage > totalPage) ? totalPage : lastPage;
    }
}
