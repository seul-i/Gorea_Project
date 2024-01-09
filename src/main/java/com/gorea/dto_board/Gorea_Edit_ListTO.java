package com.gorea.dto_board;

import java.io.Serializable;
import java.util.List;


import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Gorea_EditRecommendListTO implements Serializable {
    private int cpage = 1; // 현재 페이지
    private int pageSize = 5; // 한 페이지에 표시될 항목 수
    private int totalRecord; // 전체 레코드(데이터 항목)의 수
    private List<Gorea_EditRecommend_BoardTO> lists;
    private int firstRow; // 현재 페이지에서 첫 번째로 표시되는 항목의 인덱스
    private int lastRow; // 현재 페이지에서 마지막으로 표시되는 항목의 인덱스
    private int totalPage; // 전체 페이지 수
    private int firstPage; // 현재 페이지 범위에서 첫 번째 페이지
    private int lastPage; // 현재 페이지 범위에서 마지막 페이지

    public void pageSetting() {
        totalPage = (totalRecord - 1) / pageSize + 1;
        firstRow = (cpage - 1) * pageSize + 1;
        lastRow = firstRow + pageSize - 1;
        if (lastRow >= totalRecord) {
            lastRow = totalRecord;
        }

        firstPage = ((cpage - 1) / pageSize) * pageSize + 1;
        lastPage = firstPage + pageSize - 1;
        if (lastPage > totalPage) {
            lastPage = totalPage;
        }
    }

}
