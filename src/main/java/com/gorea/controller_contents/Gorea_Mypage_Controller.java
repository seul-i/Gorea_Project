package com.gorea.controller_contents;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.gorea.dto.mypage.Gorea_BoardListTO;
import com.gorea.dto_board.Gorea_CumuPagingTO;
import com.gorea.dto_board.Gorea_QnA_BoardTO;
import com.gorea.dto_user.Gorea_UserTO;
import com.gorea.repository_contents.Gorea_MypageDAO;
import com.gorea.service_contents.Gorea_ViewMypage;

@Controller
public class Gorea_Mypage_Controller {
	
	@Autowired
	private Gorea_ViewMypage mypageService;
	
	@Autowired
	private Gorea_MypageDAO mypageDao;
	
	// 회원 정보 수정
	@PostMapping("/{language}/userInfoModifyOk")
	public String userInfoModify_Ok(@PathVariable String language,
	                                Gorea_UserTO uto) {
	    int result = mypageService.userInfoModify_Ok(uto);

	    if (result > 0) {
	        // 수정이 성공했을 경우 해당 사용자의 프로필 페이지로 리다이렉트
	        return "redirect:/" + language + "/userMypage.do?userSeq=" + uto.getUserSeq();
	    } else {
	        // 수정이 실패했을 경우 에러 페이지로 리다이렉트 또는 다른 처리
	        return "redirect:/error"; // 또는 다른 URL로 변경
	    }
	}


	
	// 게시글 관리
	 @GetMapping("/{language}/userBoardList.do")
	 public String boardList(@PathVariable String language,
			 					@RequestParam(required = false) String boardType,
			 					@RequestParam(required = true) String userSeq,
			 					@RequestParam(required = false) String keyword,
	                            @RequestParam(defaultValue = "1") int cpage,
	     	                   	@RequestParam(defaultValue = "20") int pageSize,
	                            Model model) {
		 
		 cpage = (cpage <= 0) ? 1 : cpage;
		 int offset = (cpage - 1) * pageSize;
	    
		 model.addAttribute("language", language);
		 
		 List<Gorea_BoardListTO> lists = new ArrayList<Gorea_BoardListTO>();
		 int totalRowCount = 0;
	    
		 if(language.equals("korean")) {
			if(keyword != null && !keyword.trim().isEmpty()) {
				 lists = mypageService.searchBoardList(userSeq, keyword, offset, pageSize);
				 totalRowCount = mypageDao.countTotalSearchResults(keyword);
			} else {
				lists = mypageService.boardList(userSeq, offset, pageSize);
				 totalRowCount = mypageDao.getTotalRowCount();
			}
		 } else if(language.equals("english")) {
			 if(keyword != null && !keyword.trim().isEmpty()) {
				 lists = mypageService.searchBoardList(userSeq, keyword, offset, pageSize);
				 totalRowCount = mypageDao.countTotalSearchResults(keyword);
			} else {
				lists = mypageService.boardList(userSeq, offset, pageSize);
				 totalRowCount = mypageDao.getTotalRowCount();
			}
		 } else if(language.equals("japanese")) {
			 if(keyword != null && !keyword.trim().isEmpty()) {
				 lists = mypageService.searchBoardList(userSeq, keyword, offset, pageSize);
				 totalRowCount = mypageDao.countTotalSearchResults(keyword);
			} else {
				lists = mypageService.boardList(userSeq, offset, pageSize);
				 totalRowCount = mypageDao.getTotalRowCount();
			}
		 } else if(language.equals("chinese")) {
			 if(keyword != null && !keyword.trim().isEmpty()) {
				 lists = mypageService.searchBoardList(userSeq, keyword, offset, pageSize);
				 totalRowCount = mypageDao.countTotalSearchResults(keyword);
			} else {
				lists = mypageService.boardList(userSeq, offset, pageSize);
				 totalRowCount = mypageDao.getTotalRowCount();
			}
		 } else {
			 return "";
		 }

		 Gorea_CumuPagingTO paging = createPagingModel2(lists, totalRowCount, cpage, pageSize);
	    
		 model.addAttribute("paging", paging);
		 model.addAttribute("lists", lists);
		 
		 List<Integer> pageNumbers = new ArrayList<>();
		 for (int i = paging.getFirstPage(); i <= paging.getLastPage(); i++) {
			 pageNumbers.add(i);
		 }
		 model.addAttribute("pageNumbers", pageNumbers);
		 
		 return "user/mypage/mypage_BoardList";
	 }
	 
	 // 댓글 관리
	 @GetMapping("/{language}/userReplyList.do")
	 public String replyList(@PathVariable String language,
			 					@RequestParam(required = false) String boardType,
			 					@RequestParam(required = true) String userSeq,
			 					@RequestParam(required = false) String keyword,
	                            @RequestParam(defaultValue = "1") int cpage,
	     	                   	@RequestParam(defaultValue = "20") int pageSize,
	                            Model model) {
		 
		 cpage = (cpage <= 0) ? 1 : cpage;
		 int offset = (cpage - 1) * pageSize;
	    
		 model.addAttribute("language", language);
		 
		 List<Gorea_BoardListTO> lists = new ArrayList<Gorea_BoardListTO>();
		 int totalRowCount = 0;
	    
		 if(language.equals("korean")) {
			if(keyword != null && !keyword.trim().isEmpty()) {
				 lists = mypageService.searchReplyList(userSeq, keyword, offset, pageSize);
				 totalRowCount = mypageDao.countSearchReplyLish(userSeq, keyword);
			} else {
				lists = mypageService.replyList(userSeq, offset, pageSize);
				 totalRowCount = mypageDao.getReplyTotalRowCount();
			}
		 } else if(language.equals("english")) {
			 if(keyword != null && !keyword.trim().isEmpty()) {
				 lists = mypageService.searchReplyList(userSeq, keyword, offset, pageSize);
				 totalRowCount = mypageDao.countSearchReplyLish(userSeq, keyword);
			} else {
				lists = mypageService.replyList(userSeq, offset, pageSize);
				 totalRowCount = mypageDao.getReplyTotalRowCount();
			}
		 } else if(language.equals("japanese")) {
			 if(keyword != null && !keyword.trim().isEmpty()) {
				 lists = mypageService.searchReplyList(userSeq, keyword, offset, pageSize);
				 totalRowCount = mypageDao.countSearchReplyLish(userSeq, keyword);
			} else {
				lists = mypageService.replyList(userSeq, offset, pageSize);
				 totalRowCount = mypageDao.getReplyTotalRowCount();
			}
		 } else if(language.equals("chinese")) {
			 if(keyword != null && !keyword.trim().isEmpty()) {
				 lists = mypageService.searchReplyList(userSeq, keyword, offset, pageSize);
				 totalRowCount = mypageDao.countSearchReplyLish(userSeq, keyword);
			} else {
				lists = mypageService.replyList(userSeq, offset, pageSize);
				 totalRowCount = mypageDao.getReplyTotalRowCount();
			}
		 } else {
			 return "";
		 }

		 Gorea_CumuPagingTO paging = createPagingModel2(lists, totalRowCount, cpage, pageSize);
	    
		 model.addAttribute("paging", paging);
		 model.addAttribute("lists", lists);
		 
		 List<Integer> pageNumbers = new ArrayList<>();
		 for (int i = paging.getFirstPage(); i <= paging.getLastPage(); i++) {
			 pageNumbers.add(i);
		 }
		 model.addAttribute("pageNumbers", pageNumbers);
		 
		 return "user/mypage/mypage_ReplyList";
	 }
	 
	 // 1:1 문의내역
	 @GetMapping("/{language}/userQnaList.do")
	 public String boardList(@PathVariable String language,
			                @RequestParam(required = true) String userSeq,
			                @RequestParam(defaultValue = "1") int cpage,
		                	@RequestParam(defaultValue = "20") int pageSize,
			                Model model) {
		 
		 cpage = (cpage <= 0) ? 1 : cpage;
		 int offset = (cpage - 1) * pageSize;
		    
		 model.addAttribute("language", language);
		 
		 List<Gorea_QnA_BoardTO> lists = new ArrayList<Gorea_QnA_BoardTO>();
		 int totalRowCount = 0;
			 
		 if(language.equals("korean")) {
		 	lists = mypageService.qnaList(userSeq, offset, pageSize);
	    	totalRowCount = mypageDao.QnaTotalRowCount();
	    } else if(language.equals("english")) {
	    	lists = mypageService.qnaList(userSeq, offset, pageSize);
	    	totalRowCount = mypageDao.QnaTotalRowCount();
	    } else if(language.equals("japanese")) {
	    	lists = mypageService.qnaList(userSeq, offset, pageSize);
	    	totalRowCount = mypageDao.QnaTotalRowCount();
	    } else if(language.equals("chinese")) {
	    	lists = mypageService.qnaList(userSeq, offset, pageSize);
	    	totalRowCount = mypageDao.QnaTotalRowCount();
	    }
			 
		 Gorea_CumuPagingTO paging = createPagingModel(totalRowCount, cpage, pageSize);
			    
		 model.addAttribute("paging", paging);
		 model.addAttribute("lists", lists);
			 
		 List<Integer> pageNumbers = new ArrayList<>();
		 for (int i = paging.getFirstPage(); i <= paging.getLastPage(); i++) {
			 pageNumbers.add(i);
		 }
		 model.addAttribute("pageNumbers", pageNumbers);
			 
		 return "user/mypage/mypage_q&aList";
 	}
	 
	 // 회원 탈퇴
	 @GetMapping("/{language}/userDropAccount.do")
	 public String userLeave(@PathVariable String language, Model model) {
		 
		model.addAttribute("language", language);
			
		if(language.equals("korean")) {
			
		}else if(language.equals("english")) {
			
		}else if(language.equals("japanese")) {
			
		}else if(language.equals("chinese")) {
			
		}
			
		return "user/mypage/mypage_userLeave";
	 }
	 
	// 리스트 페이지 페이징 처리
	private Gorea_CumuPagingTO createPagingModel2(List<Gorea_BoardListTO> lists, int totalRowCount, int cpage, int pageSize) {
	    Gorea_CumuPagingTO paging = new Gorea_CumuPagingTO();
	    
	    paging.setMypageBoardList(lists != null ? lists : new ArrayList<>());
	    paging.setTotalRecord(totalRowCount);
	    paging.setCpage(cpage);
	    paging.setPageSize(pageSize);
	    paging.pageSetting();
	    return paging;
	}
	
	private Gorea_CumuPagingTO createPagingModel( int totalRowCount, int cpage, int pageSize) {
	    Gorea_CumuPagingTO paging = new Gorea_CumuPagingTO();
	   
	    paging.setTotalRecord(totalRowCount);
	    paging.setCpage(cpage);
	    paging.setPageSize(pageSize);
	    paging.pageSetting();
	    return paging;
	}
}
