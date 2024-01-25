package com.gorea.controller_contents;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;
import java.util.regex.Pattern;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.gorea.dto_board.Gorea_EditTip_BoardTO;
import com.gorea.dto_board.Gorea_PagingTO;
import com.gorea.repository_contents.Gorea_EdittipDAO;
import com.gorea.serivce_trans_edit.Gorea_Translate_EditRecom_interface;
import com.gorea.service_contents.Gorea_Content_ListTranslation;
import com.gorea.service_contents.Gorea_Content_ViewTranslation;

import java.util.regex.Matcher;
import jakarta.servlet.ServletOutputStream;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Controller
public class Gorea_AdminEdittip_Controller {
	
	@Autowired
	private Gorea_EdittipDAO dao;

	@Value("${spring.servlet.multipart.location}")
	private String uploadDir;
	
	@Autowired
	private Gorea_Translate_EditRecom_interface service;

	/* editTip */
	@GetMapping("/admineditTip.do")
	public String editTipList( HttpServletRequest request, Model model, 
			@RequestParam(value = "searchType", required = false) String searchType,
            @RequestParam(value = "searchKeyword", required = false) String searchKeyword,
			@RequestParam(defaultValue = "1") int cpage,
	        @RequestParam(defaultValue = "20") int pageSize) {

		// cpage가 0 이하이면 1로 설정
	    cpage = (cpage <= 0) ? 1 : cpage;

	    if (cpage <= 0) {
	        // cpage가 0 이하인 경우, 1페이지로 리다이렉트
	        return "redirect:/admineditTip.do?cpage=1";
	    }

	    int offset = (cpage - 1) * pageSize;
	    
	    List<Gorea_EditTip_BoardTO> lists = new ArrayList<Gorea_EditTip_BoardTO>();
	    int totalRowCount = 0;
	    
	     if (searchType != null && searchKeyword != null && !searchKeyword.trim().isEmpty()) {
	    	  lists = service.editTip_List_SearchKO(searchType, searchKeyword, offset, pageSize);
	    	  totalRowCount = dao.getSearchTotalRowCount(searchType, searchKeyword);
	    }else {
	    	  lists = service.editTip_List_KO(offset, pageSize);
	    	  totalRowCount = dao.getTotalRowCount();
	    }
	    	
	    	
	    
	    Gorea_PagingTO paging = createPagingModel1(lists, totalRowCount, cpage, pageSize);
		
	    model.addAttribute("paging", paging);
	    model.addAttribute("lists", lists);
	    
		// 페이지 번호를 추가하는 부분
		List<Integer> pageNumbers = new ArrayList<>();
		for (int i = paging.getFirstPage(); i <= paging.getLastPage(); i++) {
		        pageNumbers.add(i);
		}
		
		model.addAttribute("pageNumbers", pageNumbers);	   
		
	    
	    return "admin/edittip/gorea_adminedittip";
	}
	
	private Gorea_PagingTO createPagingModel1(List<Gorea_EditTip_BoardTO> lists1, int totalRowCount,
			int cpage,  int pageSize ) {
		Gorea_PagingTO paging = new Gorea_PagingTO();
		paging.setLists1(lists1 != null ? lists1 : new ArrayList<>());
		paging.setTotalRecord(totalRowCount);
	    paging.setPageSize(pageSize);
	    paging.setCpage(cpage);  // 추가: cpage 값을 설정
		    
		// 수정: pageSetting 호출 전에 cpage 값을 확인하고 필요하다면 수정
		if (cpage > paging.getTotalPage()) {
		    cpage = paging.getTotalPage();
		}
		
		paging.pageSetting();
		    
		return paging;
	}


	@GetMapping("/admineditTip_write.do")
	public String editTip_Write(HttpServletRequest request, Model model) {
		
		return "admin/edittip/gorea_adminedittip_write";
	}

	@PostMapping("/admineditTip_write_ok.do")
	public String editTip_Write_Ok(HttpServletRequest request, MultipartFile upload, Model model) {
		Gorea_EditTip_BoardTO eto = new Gorea_EditTip_BoardTO();
		int flag = 2;
		eto.setUserSeq(request.getParameter("userSeq"));
		eto.setEdittipSubject(request.getParameter("edittipSubject"));
		eto.setEdittipSubtitle(request.getParameter("edittipSubtitle"));
		eto.setEdittipContent(request.getParameter("edittipContent"));
		eto.setEdittipWdate(request.getParameter("edittipWdate"));

		flag = dao.editTip_Write_Ok(eto);

		model.addAttribute("flag", flag);

		return "admin/edittip/gorea_adminedittip_write_ok";
	}

	@GetMapping("/admineditTip_view.do")
	public String editTip_View(@RequestParam("edittipSeq") String edittipSeqStr, HttpServletRequest request, 
			@RequestParam(value = "cpage", required = false) String cpage,
            @RequestParam(value = "searchType", required = false) String searchType,
            @RequestParam(value = "searchKeyword", required = false) String searchKeyword,Model model) {
				
		Gorea_EditTip_BoardTO eto = new Gorea_EditTip_BoardTO(); // 객체를 새로 초기화
		
		eto.setEdittipSeq(request.getParameter("edittipSeq"));
		
			eto = service.editTip_View_KO(eto);
		
		model.addAttribute("eto", eto);
		
		return "admin/edittip/gorea_adminedittip_view";
	}

	@GetMapping("/admineditTip_delete_ok.do")
	public String editTip_Delete_Ok(@RequestParam(value = "cpage", required = false) String cpage,
            @RequestParam(value = "searchType", required = false) String searchType,
            @RequestParam(value = "searchKeyword", required = false) String searchKeyword, 
            HttpServletRequest request, Model model) {
		
		Gorea_EditTip_BoardTO eto = new Gorea_EditTip_BoardTO();
		
		eto.setEdittipSeq(request.getParameter("edittipSeq"));

		int flag = 1;

		flag = dao.editTip_Delete_Ok(eto);
	     
		model.addAttribute("flag", flag);
		
		model.addAttribute("cpage", cpage);
		model.addAttribute("searchType", searchType);
		model.addAttribute("searchKeyword", searchKeyword);

		return "admin/edittip/gorea_adminedittip";
	}

	@GetMapping("/admineditTip_modify.do")
	public String editTip_Modify(HttpServletRequest request, 
			@RequestParam(value = "cpage", required = false) String cpage,
            @RequestParam(value = "searchType", required = false) String searchType,
            @RequestParam(value = "searchKeyword", required = false) String searchKeyword, Model model) {
		
		Gorea_EditTip_BoardTO eto = new Gorea_EditTip_BoardTO();
		
		eto.setEdittipSeq(request.getParameter("edittipSeq"));

		eto = dao.editTip_Modify(eto);

		model.addAttribute("eto", eto);
		model.addAttribute("edittipSeq", eto.getEdittipSeq());
		
		model.addAttribute("cpage", cpage);
		model.addAttribute("searchType", searchType);
		model.addAttribute("searchKeyword", searchKeyword);

		return "admin/edittip/gorea_adminedittip_modify";
	}

	@PostMapping("/admineditTip_modify_ok.do")
	public String editTip_Modify_Ok(HttpServletRequest request, 
			MultipartFile upload, @RequestParam(value = "cpage", required = false) String cpage,
            @RequestParam(value = "searchType", required = false) String searchType,
            @RequestParam(value = "searchKeyword", required = false) String searchKeyword, Model model) {
		
		Gorea_EditTip_BoardTO eto = new Gorea_EditTip_BoardTO();
		int flag = 1;
		
		eto.setEdittipSeq(request.getParameter("edittipSeq"));
		eto.setEdittipSubject(request.getParameter("edittipSubject"));
		eto.setEdittipSubtitle(request.getParameter("edittipSubtitle"));
		eto.setEdittipContent(request.getParameter("edittipContent"));

		flag = dao.editTip_Modify_Ok(eto);

		model.addAttribute("flag", flag);
		model.addAttribute("edittipSeq", eto.getEdittipSeq());
		
		model.addAttribute("cpage", cpage);
		model.addAttribute("searchType", searchType);
		model.addAttribute("searchKeyword", searchKeyword);
		
		return "admin/edittip/gorea_adminedittip_modify_ok";

	}


}
