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
import com.gorea.service_contents.Gorea_Content_ListTranslation;
import com.gorea.service_contents.Gorea_Content_ViewTranslation;

import java.util.regex.Matcher;
import jakarta.servlet.ServletOutputStream;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Controller
public class Gorea_Edittip_Controller {
	
	@Autowired
	private Gorea_EdittipDAO dao;

	@Value("${spring.servlet.multipart.location}")
	private String uploadDir;
	
	// @Autowired
	// private Gorea_Content_ListTranslation listTranslation;
	
	// @Autowired
	// private Gorea_Content_ViewTranslation viewTranslation;
	
	
	/* editTip */
	
	@GetMapping("/{language}/editTip_list.do")
	public String editTipList(@PathVariable String language, HttpServletRequest request, Model model, 
			@RequestParam(value = "searchType", required = false) String searchType,
            @RequestParam(value = "searchKeyword", required = false) String searchKeyword,
			@RequestParam(defaultValue = "1") int cpage,
	        @RequestParam(defaultValue = "8") int pageSize) {
		
		System.out.println("searchType: " + searchType);
		System.out.println("searchKeyword: " + searchKeyword);

		// cpage가 0 이하이면 1로 설정
	    cpage = (cpage <= 0) ? 1 : cpage;

	    if (cpage <= 0) {
	        // cpage가 0 이하인 경우, 1페이지로 리다이렉트
	        return "redirect:/{language}/editTip_list.do?cpage=1";
	    }

	    int offset = (cpage - 1) * pageSize;
	    
	    model.addAttribute("language", language);
	    
	    List<Gorea_EditTip_BoardTO> lists1 = new ArrayList<Gorea_EditTip_BoardTO>();
	    int totalRowCount = 0;
	    
	    if(language.equals("korean")) {
	     if (searchType != null && searchKeyword != null && !searchKeyword.trim().isEmpty()) {
	    	  lists1 = dao.searchEdittip(searchType, searchKeyword, offset, pageSize);
	    	  totalRowCount = dao.getSearchTotalRowCount(searchType, searchKeyword);
	    }else {
	    	  lists1 = dao.editTip_List(offset, pageSize);
	    	  totalRowCount = dao.getTotalRowCount();
	    } 
	    
	    }else if(language.equals("english")) {
	     if (searchType != null && searchKeyword != null && !searchKeyword.trim().isEmpty()) {
	    	  lists1 = dao.searchEdittip(searchType, searchKeyword, offset, pageSize);
		      totalRowCount = dao.getSearchTotalRowCount(searchType, searchKeyword);
		}else {
		      lists1 = dao.editTip_List(offset, pageSize);
		      totalRowCount = dao.getTotalRowCount();
		}
	    
	    }else if(language.equals("japanese")) {
		 if (searchType != null && searchKeyword != null && !searchKeyword.trim().isEmpty()) {
			  lists1 = dao.searchEdittip(searchType, searchKeyword, offset, pageSize);
			  totalRowCount = dao.getSearchTotalRowCount(searchType, searchKeyword);
		}else {
			  lists1 = dao.editTip_List(offset, pageSize);
			  totalRowCount = dao.getTotalRowCount();
		}
		
	    }else if(language.equals("chinese")) {
		 if (searchType != null && searchKeyword != null && !searchKeyword.trim().isEmpty()) {
			  lists1 = dao.searchEdittip(searchType, searchKeyword, offset, pageSize);
			  totalRowCount = dao.getSearchTotalRowCount(searchType, searchKeyword);
		}else {
			  lists1 = dao.editTip_List(offset, pageSize);
			  totalRowCount = dao.getTotalRowCount();
		} 	
		
	    }else {	
	    	return "";  	
	    }
	    	
	    	
	    for (Gorea_EditTip_BoardTO eto : lists1) {
	 		   String content = eto.getEdittipContent();
	 		   String firstImageUrl = extractFirstImageUrl1(content);
	 		   eto.setFirstImageUrl(firstImageUrl); // BoardTO에 첫 번째 이미지 URL을 설정
	 	}	
	    
	    Gorea_PagingTO paging = createPagingModel1(lists1, totalRowCount, cpage, pageSize);
		
	    model.addAttribute("paging", paging);
	    model.addAttribute("lists1", lists1);
	    model.addAttribute("language", language);
	    
		// 페이지 번호를 추가하는 부분
		List<Integer> pageNumbers = new ArrayList<>();
		for (int i = paging.getFirstPage(); i <= paging.getLastPage(); i++) {
		        pageNumbers.add(i);
		}
		
		model.addAttribute("pageNumbers", pageNumbers);	   
		
	    
	    return "contents/contents_edit_tip/editTip_list";
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

	// extractFirstImageUrl 메서드
	private String extractFirstImageUrl1(String content) {

		String imageUrl = "";
		Pattern pattern = Pattern.compile("<img[^>]+src\\s*=\\s*['\"]([^'\"]+)['\"][^>]*>");
		Matcher matcher = pattern.matcher(content);
		if (matcher.find()) {
			imageUrl = matcher.group(1);
			imageUrl = imageUrl.replace("/ckImgSubmitForEditTip?uid=", "").replace("&amp;fileName=", "_");

		} else {
			System.out.println("No image found");
		}
		return imageUrl;
	}


	@GetMapping("/korean/editTip_write.do")
	public String editTip_Write(HttpServletRequest request, Model model) {
		return "contents/contents_edit_tip/editTip_write";
	}

	@PostMapping("/korean/editTip_write_ok.do")
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

		return "contents/contents_edit_tip/editTip_write_ok";
	}

	@GetMapping("/{language}/editTip_view.do")
	public String editTip_View(@RequestParam("edittipSeq") String edittipSeqStr,@PathVariable String language, HttpServletRequest request, 
			@RequestParam(value = "cpage", required = false) String cpage,
            @RequestParam(value = "searchType", required = false) String searchType,
            @RequestParam(value = "searchKeyword", required = false) String searchKeyword,Model model) {
		
		int edittipSeq;
		
		try {
            edittipSeq = Integer.parseInt(edittipSeqStr.trim());
        } catch (NumberFormatException e) {
            //edittipSeq 파라미터가 유효하지 않을 때의 처리
            return "errorPage";
        }
				
		Gorea_EditTip_BoardTO eto = new Gorea_EditTip_BoardTO(); // 객체를 새로 초기화
		eto.setEdittipSeq(request.getParameter("edittipSeq"));
		
		model.addAttribute("language", language);
		
		if(language.equals("korean")) {
			eto = dao.editTip_View(eto);	
		}else if(language.equals("english")) {
			eto = dao.editTip_View(eto);
		}else if(language.equals("japanese")) {
			eto = dao.editTip_View(eto);
		}else if(language.equals("chinese")) {
			eto = dao.editTip_View(eto);
		}else {
			return "";
		}
		
		model.addAttribute("eto", eto);
		
		return "contents/contents_edit_tip/editTip_view";
	}

	@GetMapping("/{language}/editTip_delete_ok.do")
	public String editTip_Delete_Ok(@PathVariable String language, @RequestParam(value = "cpage", required = false) String cpage,
            @RequestParam(value = "searchType", required = false) String searchType,
            @RequestParam(value = "searchKeyword", required = false) String searchKeyword, 
            HttpServletRequest request, Model model) {
		
		Gorea_EditTip_BoardTO eto = new Gorea_EditTip_BoardTO();
		
		eto.setEdittipSeq(request.getParameter("edittipSeq"));

		int flag = 1;
		
		if(language.equals("korean")) {
			flag = dao.editTip_Delete_Ok(eto);
	      }else if(language.equals("english")) {
	    	  flag = dao.editTip_Delete_Ok(eto);
	      }else if(language.equals("japanese")) {
	    	  flag = dao.editTip_Delete_Ok(eto);
	      }else if(language.equals("chinese")) {
	    	 flag = dao.editTip_Delete_Ok(eto);
	      }

		model.addAttribute("flag", flag);
		model.addAttribute("language", language);
		
		model.addAttribute("cpage", cpage);
		model.addAttribute("searchType", searchType);
		model.addAttribute("searchKeyword", searchKeyword);

		return "contents/contents_edit_tip/editTip_delete_ok";
	}

	@GetMapping("/korean/editTip_modify.do")
	public String editTip_Modify(@PathVariable String language, HttpServletRequest request, 
			@RequestParam(value = "cpage", required = false) String cpage,
            @RequestParam(value = "searchType", required = false) String searchType,
            @RequestParam(value = "searchKeyword", required = false) String searchKeyword, Model model) {
		
		Gorea_EditTip_BoardTO eto = new Gorea_EditTip_BoardTO();
		
		eto.setEdittipSeq(request.getParameter("edittipSeq"));
		System.out.println("## seq : " + request.getParameter("edittipSeq"));

		if(language.equals("korean")) {
			eto = dao.editTip_Modify(eto);
	    }else if(language.equals("english")) {
	    	  eto = dao.editTip_Modify(eto);
	    }else if(language.equals("japanese")) {
	    	  eto = dao.editTip_Modify(eto);
	    }else if(language.equals("chinese")) {
	    	  eto = dao.editTip_Modify(eto);
	    }
		

		model.addAttribute("eto", eto);
		model.addAttribute("edittipSeq", eto.getEdittipSeq());
		
		model.addAttribute("language", language);
		
		model.addAttribute("cpage", cpage);
		model.addAttribute("searchType", searchType);
		model.addAttribute("searchKeyword", searchKeyword);

		return "contents/contents_edit_tip/editTip_modify";
	}

	@PostMapping("/{language}/korean/editTip_modify_ok.do")
	public String editTip_Modify_Ok(@PathVariable String language, HttpServletRequest request, 
			MultipartFile upload, @RequestParam(value = "cpage", required = false) String cpage,
            @RequestParam(value = "searchType", required = false) String searchType,
            @RequestParam(value = "searchKeyword", required = false) String searchKeyword, Model model) {
		
		Gorea_EditTip_BoardTO eto = new Gorea_EditTip_BoardTO();
		int flag = 1;
		
		eto.setEdittipSeq(request.getParameter("edittipSeq"));
		eto.setEdittipSubject(request.getParameter("edittipSubject"));
		eto.setEdittipSubtitle(request.getParameter("edittipSubtitle"));
		eto.setEdittipContent(request.getParameter("edittipContent"));

		System.out.println("## seq : " + request.getParameter("edittipSeq"));
		
		if(language.equals("korean")) {
			flag = dao.editTip_Modify_Ok(eto);
	    
		}else if(language.equals("english")) {  
			flag = dao.editTip_Modify_Ok(eto);
			
	    }else if(language.equals("japanese")) { 
	    	flag = dao.editTip_Modify_Ok(eto);
	    	
	    }else if(language.equals("chinese")) {
	    	flag = dao.editTip_Modify_Ok(eto);
	      }
		

		model.addAttribute("flag", flag);
		model.addAttribute("language", language);
		model.addAttribute("edittipSeq", eto.getEdittipSeq());
		
		model.addAttribute("cpage", cpage);
		model.addAttribute("searchType", searchType);
		model.addAttribute("searchKeyword", searchKeyword);
		
		return "contents/contents_edit_tip/editTip_modify_ok";

	}

	// 이미지 업로드
	@RequestMapping(value = "/editTip/imageUpload", method = RequestMethod.POST)
	public void imageUploadForEditTip(HttpServletRequest request, HttpServletResponse response,
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

				response.setCharacterEncoding("utf-8");
				response.setContentType("text/html;charset=utf-8");
				String callback = request.getParameter("CKEditorFuncNum");
				PrintWriter printWriter = response.getWriter();
				String fileUrl = "/ckImgSubmitForEditTip?uid=" + uid + "&fileName=" + fileName;
				printWriter.println(
						"{\"filename\" : \"" + fileName + "\", \"uploaded\" : 1, \"url\":\"" + fileUrl + "\"}");
				printWriter.flush();
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	@RequestMapping(value = "/ckImgSubmitForEditTip")
	public void ckSubmitForEditTip(@RequestParam("uid") String uid, @RequestParam("fileName") String fileName,
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
