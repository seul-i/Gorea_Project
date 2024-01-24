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
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.gorea.dto_board.Gorea_EditRecommend_BoardTO;
import com.gorea.dto_board.Gorea_PagingTO;
import com.gorea.dto_user.Gorea_UserTO;
import com.gorea.repository_contents.Gorea_EditrecoDAO;
import com.gorea.serivce_trans_edit.Gorea_Translate_EditRecom_interface;

import java.util.regex.Matcher;
import jakarta.servlet.ServletOutputStream;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Controller
public class Gorea_Editreco_Controller {
	
	@Autowired
	private Gorea_EditrecoDAO dao;

	@Value("${spring.servlet.multipart.location}")
	private String uploadDir;
	
	 @Autowired
	 private Gorea_Translate_EditRecom_interface service;

	
	/* editRecommend */
	@GetMapping("/{language}/editRecommend_list.do")
	public String editRecommendList(@PathVariable String language, HttpServletRequest request, Model model, 
			@RequestParam(value = "searchType", required = false) String searchType,
            @RequestParam(value = "searchKeyword", required = false) String searchKeyword,
			@RequestParam(defaultValue = "1") int cpage,
	        @RequestParam(defaultValue = "6") int pageSize) {
	    // cpage가 0 이하이면 1로 설정
	    cpage = (cpage <= 0) ? 1 : cpage;

	    if (cpage <= 0) {
	        // cpage가 0 이하인 경우, 1페이지로 리다이렉트
	        return "redirect:/{language}/editRecommend_list.do?cpage=1";
	    }

	    int offset = (cpage - 1) * pageSize;
	    
	    model.addAttribute("language", language);
	    
	    List<Gorea_EditRecommend_BoardTO> lists = new ArrayList<Gorea_EditRecommend_BoardTO>();	    
	    
	    int totalRowCount = 0;
	    
	    if(language.equals("korean")) {
	      if (searchType != null && searchKeyword != null && !searchKeyword.trim().isEmpty()) {
	    	lists = service.editrecom_List_SearchKO(searchType, searchKeyword, offset, pageSize);
	    	totalRowCount = dao.getSearchTotalRowCount(searchType, searchKeyword);
	    	
	      } else {
	    	  lists = service.editrecom_List_KO(offset, pageSize);
	    	  totalRowCount = dao.getTotalRowCount();
	      }

	    }else if(language.equals("english")) {
	    	if (searchType != null && searchKeyword != null && !searchKeyword.trim().isEmpty()) {
		    	lists = service.editrecom_List_SearchEN(searchType, searchKeyword, offset, pageSize);
		    	totalRowCount = dao.getSearchTotalRowCount(searchType, searchKeyword);
		    	
		      } else {
		    	  lists = service.editrecom_List_EN(offset, pageSize);
		    	  totalRowCount = dao.getTotalRowCount();
		      }
	    
	    }else if(language.equals("japanese")) {
	    	if (searchType != null && searchKeyword != null && !searchKeyword.trim().isEmpty()) {
		    	lists = service.editrecom_List_SearchJP(searchType, searchKeyword, offset, pageSize);
		    	totalRowCount = dao.getSearchTotalRowCount(searchType, searchKeyword);
		      } else {
		    	  lists = service.editrecom_List_JP(offset, pageSize);
		    	  totalRowCount = dao.getTotalRowCount();
		      }
	    
	    }else if(language.equals("chinese")) {
	    	if (searchType != null && searchKeyword != null && !searchKeyword.trim().isEmpty()) {
		    	lists = service.editrecom_List_SearchCHN(searchType, searchKeyword, offset, pageSize);
		    	totalRowCount = dao.getSearchTotalRowCount(searchType, searchKeyword);
		      } else {
		    	  lists = service.editrecom_List_CHN(offset, pageSize);
		    	  totalRowCount = dao.getTotalRowCount();
		      }
	    }else {
	    	
	    	return "gorea_accessdeniedPage";  	
	    }
	    
	    Gorea_PagingTO paging = createPagingModel(lists, totalRowCount, cpage, pageSize);
	    
		    model.addAttribute("paging", paging);
		    model.addAttribute("lists", lists);
		    model.addAttribute("language", language);
	
		    // 페이지 번호를 추가하는 부분
		    List<Integer> pageNumbers = new ArrayList<>();
		    for (int i = paging.getFirstPage(); i <= paging.getLastPage(); i++) {
		        pageNumbers.add(i);
		    }
		    
		    model.addAttribute("pageNumbers", pageNumbers);
		    
		    return "contents/contents_edit_recommend/editRecommend_list";
	}

	/**
	 * 페이징 모델을 생성하여 반환하는 메소드
	 *
	 * @param lists  현재 페이지에 표시할 목록
	 * @param cpage  현재 페이지 번호
	 * @return 페이징 모델
	 */
	
	private Gorea_PagingTO createPagingModel( List<Gorea_EditRecommend_BoardTO> lists, int totalRowCount, 
			int cpage,  int pageSize) {
		Gorea_PagingTO paging = new Gorea_PagingTO();
		
		paging.setLists(lists != null ? lists : new ArrayList<>());
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

	// extractFirstImageUrl 메서드
		

	@GetMapping("/korean/editRecommend_write.do")
	public String editRecommend_Write(HttpServletRequest request, Model model) {

		return "contents/contents_edit_recommend/editRecommend_write";
	}

	@PostMapping("/korean/editRecommend_write_ok.do")
	public String editRecommend_Write_Ok(HttpServletRequest request, MultipartFile upload, Model model) {
		int flag = 2;

		Gorea_EditRecommend_BoardTO to = new Gorea_EditRecommend_BoardTO();
		to.setUserSeq(request.getParameter("userSeq"));
		to.setEditrecoSubject(request.getParameter("editrecoSubject"));
		to.setEditrecoSubtitle(request.getParameter("editrecoSubtitle"));
		to.setEditrecoContent(request.getParameter("editrecoContent"));
		to.setEditrecoWdate(request.getParameter("editrecoWdate"));

		flag = dao.editRecommend_Write_Ok(to);

		model.addAttribute("flag", flag);

		return "contents/contents_edit_recommend/editRecommend_write_ok";
	}

	@GetMapping("/{language}/editRecommend_view.do")
	public String editRecommend_View(@RequestParam("editrecoSeq") String editrecoSeqStr,@PathVariable String language, HttpServletRequest request, 
			@RequestParam(value = "cpage", required = false) String cpage,
            @RequestParam(value = "searchType", required = false) String searchType,
            @RequestParam(value = "searchKeyword", required = false) String searchKeyword, Model model) {

		Gorea_EditRecommend_BoardTO to = new Gorea_EditRecommend_BoardTO(); // 객체를 새로 초기화
		
		to.setEditrecoSeq(request.getParameter("editrecoSeq"));
		
		model.addAttribute("language", language);
		
		if(language.equals("korean")) {
			to = service.editrecom_View_KO(to);
		}else if(language.equals("english")) {
			to = service.editrecom_View_EN(to);
		}else if(language.equals("japanese")) {
			to = service.editrecom_View_JP(to);
		}else if(language.equals("chinese")) {
			to = service.editrecom_View_CHN(to);
		}else {
			return "gorea_accessdeniedPage";
		}
		
			model.addAttribute("to", to);
		
		return "contents/contents_edit_recommend/editRecommend_view";
	}

	@GetMapping("/korean/editRecommend_delete_ok.do")
	public String editRecommend_Delete_Ok(@RequestParam(value = "cpage", required = false) String cpage,
            @RequestParam(value = "searchType", required = false) String searchType,
            @RequestParam(value = "searchKeyword", required = false) String searchKeyword, 
            HttpServletRequest request, Model model) {
		
		Gorea_EditRecommend_BoardTO to = new Gorea_EditRecommend_BoardTO();
		
		to.setEditrecoSeq(request.getParameter("editrecoSeq"));

		int flag = 1;
		

		flag = dao.editRecommend_Delete_Ok(to);

		model.addAttribute("flag", flag);
		
		model.addAttribute("cpage", cpage);
		model.addAttribute("searchType", searchType);
		model.addAttribute("searchKeyword", searchKeyword);
		
		return "contents/contents_edit_recommend/editRecommend_delete_ok";
	}

	@GetMapping("/korean/editRecommend_modify.do")
	public String editRecommend_Modify(HttpServletRequest request, 
			@RequestParam(value = "cpage", required = false) String cpage,
            @RequestParam(value = "searchType", required = false) String searchType,
            @RequestParam(value = "searchKeyword", required = false) String searchKeyword, Model model) {

	    // 객체 생성 및 초기화
	    Gorea_EditRecommend_BoardTO to = new Gorea_EditRecommend_BoardTO();
	    to.setEditrecoSeq(request.getParameter("editrecoSeq"));
	    
	    to = dao.editRecommend_Modify(to);
		
		model.addAttribute("to", to);
		model.addAttribute("editrecoSeq", to.getEditrecoSeq());
		
		model.addAttribute("cpage", cpage);
		model.addAttribute("searchType", searchType);
		model.addAttribute("searchKeyword", searchKeyword);

	    return "contents/contents_edit_recommend/editRecommend_modify";
	}


	@PostMapping("/korean/editRecommend_modify_ok.do")
	public String editRecommend_Modify_Ok(HttpServletRequest request, 
			MultipartFile upload, @RequestParam(value = "cpage", required = false) String cpage,
            @RequestParam(value = "searchType", required = false) String searchType,
            @RequestParam(value = "searchKeyword", required = false) String searchKeyword, Model model) {
		
		Gorea_EditRecommend_BoardTO to = new Gorea_EditRecommend_BoardTO();
		
		int flag = 1;
		to.setEditrecoSeq(request.getParameter("editrecoSeq"));
		to.setEditrecoSubject(request.getParameter("editrecoSubject"));
		to.setEditrecoSubtitle(request.getParameter("editrecoSubtitle"));
		to.setEditrecoContent(request.getParameter("editrecoContent"));

			flag = dao.editRecommend_Modify_Ok(to);

		model.addAttribute("flag", flag);
		model.addAttribute("editrecoSeq", to.getEditrecoSeq());
		
		model.addAttribute("cpage", cpage);
		model.addAttribute("searchType", searchType);
		model.addAttribute("searchKeyword", searchKeyword);
		
		return "contents/contents_edit_recommend/editRecommend_modify_ok";
	}


	// 이미지 업로드
	@RequestMapping(value = "/editRecommend/imageUpload", method = RequestMethod.POST)
	public void imageUploadForEditRecommend(HttpServletRequest request, HttpServletResponse response,
		@RequestParam("upload") MultipartFile upload) {
			try {
				if (upload != null && !upload.isEmpty() && upload.getContentType().toLowerCase().startsWith("image/")) {
					UUID uid = UUID.randomUUID();

					String fileName = upload.getOriginalFilename();
					String encodedFileName = uid + "_" + fileName;
					String filePath = uploadDir + File.separator + encodedFileName;

					File uploadFile = new File(uploadDir);

				if (!uploadFile.exists()) {
						uploadFile.mkdirs(); // 디렉토리 생성
				}

				try (OutputStream outputStream = new FileOutputStream(new File(filePath))) {
						outputStream.write(upload.getBytes());
				}

					// 클라이언트에게 JSON 반환
					response.setCharacterEncoding("utf-8");
					response.setContentType("text/html;charset=utf-8");
					String callback = request.getParameter("CKEditorFuncNum");
					PrintWriter printWriter = response.getWriter();
					String fileUrl = "/ckImgSubmitForEditRecommend?uid=" + uid + "&fileName=" + fileName;
					printWriter.println(
							"{\"filename\" : \"" + fileName + "\", \"uploaded\" : 1, \"url\":\"" + fileUrl + "\"}");
					printWriter.flush();
				}
			} catch (IOException e) {
				e.printStackTrace();
			}
		}

	@RequestMapping(value = "/ckImgSubmitForEditRecommend")
	public void ckSubmitForEditRecommend(@RequestParam("uid") String uid, @RequestParam("fileName") String fileName,
		HttpServletResponse response) {
			try {
				String filePath = uploadDir + File.separator + uid + "_" + fileName;
				File imgFile = new File(filePath);

				if (imgFile.isFile()) {
					byte[] buf = new byte[1024];
					int readByte;
					int length;
					byte[] imgBuf = null;

					FileInputStream fileInputStream = new FileInputStream(imgFile);
					ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
					ServletOutputStream out = response.getOutputStream();

					while ((readByte = fileInputStream.read(buf)) != -1) {
						outputStream.write(buf, 0, readByte);
					}

					imgBuf = outputStream.toByteArray();
					length = imgBuf.length;
					out.write(imgBuf, 0, length);
					out.flush();

					outputStream.close();
					fileInputStream.close();
					out.close();
				}
			} catch (IOException e) {
				e.printStackTrace();
			}
		}


	
}
