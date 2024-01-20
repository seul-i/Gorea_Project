package com.gorea.repository_contents;

import java.util.ArrayList;
import java.util.List;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.gorea.dto_board.Gorea_SearchResultTO;
import com.gorea.dto_board.Gorea_TrendSeoul_BoardTO;
import com.gorea.mapper.SearchMapper;

@Repository
public class Gorea_SearchDAO {
	
	@Autowired
	private SearchMapper searchMapper;

    public List<Gorea_SearchResultTO> searchAllBoards(String keyword, int offset, int pageSize) {
    	List<Gorea_SearchResultTO> lists = new ArrayList<Gorea_SearchResultTO>();
    	lists = searchMapper.searchAllBoards(keyword, offset, pageSize);
    	for(Gorea_SearchResultTO to : lists) {
			String content = to.getContent();
			
			Document document = Jsoup.parse(content);
	        String textContent = document.text();
	        
	        to.setContent(textContent);
		}
		 return lists;
    }

    public List<Gorea_SearchResultTO> searchFreeBoard(String keyword, int offset, int pageSize) {
    	List<Gorea_SearchResultTO> lists = new ArrayList<Gorea_SearchResultTO>();
    	lists = searchMapper.searchFreeBoard(keyword, offset, pageSize);
    	for(Gorea_SearchResultTO to : lists) {
			String content = to.getContent();
			
			Document document = Jsoup.parse(content);
	        String textContent = document.text();
	        
	        to.setContent(textContent);
		}
		 return lists;
    }

    public List<Gorea_SearchResultTO> searchNotice(String keyword, int offset, int pageSize) {
    	List<Gorea_SearchResultTO> lists = new ArrayList<Gorea_SearchResultTO>();
    	lists = searchMapper.searchNotice(keyword, offset, pageSize);
    	for(Gorea_SearchResultTO to : lists) {
			String content = to.getContent();
			
			Document document = Jsoup.parse(content);
	        String textContent = document.text();
	        
	        to.setContent(textContent);
		}
		 return lists;
    }

    public List<Gorea_SearchResultTO> searchEditTip(String keyword, int offset, int pageSize) {
    	
    	List<Gorea_SearchResultTO> lists = new ArrayList<Gorea_SearchResultTO>();
    	lists = searchMapper.searchEditTip(keyword, offset, pageSize);
    	for(Gorea_SearchResultTO to : lists) {
			String content = to.getContent();
			
			Document document = Jsoup.parse(content);
	        String textContent = document.text();
	        
	        to.setContent(textContent);
		}
		 return lists;
    }

    public List<Gorea_SearchResultTO> searchEditRecommend(String keyword, int offset, int pageSize) {
    	List<Gorea_SearchResultTO> lists = new ArrayList<Gorea_SearchResultTO>();
    	lists = searchMapper.searchEditRecommend(keyword, offset, pageSize);
    	for(Gorea_SearchResultTO to : lists) {
			String content = to.getContent();
			
			Document document = Jsoup.parse(content);
	        String textContent = document.text();
	        
	        to.setContent(textContent);
		}
		 return lists;
    }

    public List<Gorea_SearchResultTO> searchTrendSeoul(String keyword, int offset, int pageSize) {
    	List<Gorea_SearchResultTO> lists = new ArrayList<Gorea_SearchResultTO>();
    	lists = searchMapper.searchTrendSeoul(keyword, offset, pageSize);
    	for(Gorea_SearchResultTO to : lists) {
			String content = to.getContent();
			
			Document document = Jsoup.parse(content);
	        String textContent = document.text();
	        
	        to.setContent(textContent);
		}
		 return lists;
    }

    public int countTotalSearchResults(String keyword) {
        return searchMapper.countTotalSearchResults(keyword);
    }

    public int countFreeBoard(String keyword) {
        return searchMapper.countFreeBoard(keyword);
    }

    public int countTrendSeoul(String keyword) {
        return searchMapper.countTrendSeoul(keyword);
    }

    public int countEditTip(String keyword) {
        return searchMapper.countEditTip(keyword);
    }

    public int countEditRecommend(String keyword) {
        return searchMapper.countEditRecommend(keyword);
    }

    public int countNotice(String keyword) {
        return searchMapper.countNotice(keyword);
    }

}
