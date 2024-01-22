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
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.jsoup.Jsoup;
import org.jsoup.safety.Safelist;
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
import org.springframework.web.servlet.ModelAndView;

import com.gorea.dto_board.Gorea_CumuPagingTO;
import com.gorea.dto_board.Gorea_Free_BoardTO;
import com.gorea.dto_board.Gorea_Notice_BoardTO;
import com.gorea.repository_contents.Gorea_NoticeDAO;

import jakarta.servlet.ServletOutputStream;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Controller
public class Gorea_Notice_Controller {
	
	@Value("${spring.servlet.multipart.location}")
    private String uploadDir;

	@Autowired
	private Gorea_NoticeDAO dao;
	
	@GetMapping("/{language}/notice.do")
	public String list(@PathVariable String language, 
	                   @RequestParam(value = "searchType", required = false) String searchType,
	                   @RequestParam(value = "searchKeyword", required = false) String searchKeyword,
	                   HttpServletRequest request, Model model, 
	                   @RequestParam(defaultValue = "1") int cpage,
	                   @RequestParam(defaultValue = "7") int pageSize) {
	    System.out.println("list 호출 성공");

	    cpage = (cpage <= 0) ? 1 : cpage;
	    int offset = (cpage - 1) * pageSize;
	    List<Gorea_Notice_BoardTO> lists = new ArrayList<Gorea_Notice_BoardTO>();
	    int totalRowCount = 0;

	    if(language.equals("korean")) {
	    	if (searchType != null && searchKeyword != null && !searchKeyword.trim().isEmpty()) {
	    		lists = dao.searchNotices(searchType, searchKeyword, offset, pageSize);
	    		totalRowCount = dao.getSearchTotalRowCount(searchType, searchKeyword);
	    	} else {
	    		lists = dao.notice_List(offset, pageSize);
	    		totalRowCount = dao.getTotalRowCount();
	    	}
	    }else if(language.equals("english")) {
	    	if (searchType != null && searchKeyword != null && !searchKeyword.trim().isEmpty()) {
		        lists = dao.searchNotices(searchType, searchKeyword, offset, pageSize);
		        totalRowCount = dao.getSearchTotalRowCount(searchType, searchKeyword);
		    } else {
		        lists = dao.notice_List(offset, pageSize);
		        totalRowCount = dao.getTotalRowCount();
		    }
	    }else if(language.equals("japanese")) {
	    	if (searchType != null && searchKeyword != null && !searchKeyword.trim().isEmpty()) {
		        lists = dao.searchNotices(searchType, searchKeyword, offset, pageSize);
		        totalRowCount = dao.getSearchTotalRowCount(searchType, searchKeyword);
		    } else {
		        lists = dao.notice_List(offset, pageSize);
		        totalRowCount = dao.getTotalRowCount();
		    }
	    }else if(language.equals("chinese")) {
	    	if (searchType != null && searchKeyword != null && !searchKeyword.trim().isEmpty()) {
		        lists = dao.searchNotices(searchType, searchKeyword, offset, pageSize);
		        totalRowCount = dao.getSearchTotalRowCount(searchType, searchKeyword);
		    } else {
		        lists = dao.notice_List(offset, pageSize);
		        totalRowCount = dao.getTotalRowCount();
		    }
	    }
	    
	    Gorea_CumuPagingTO paging = createPagingModel(totalRowCount, cpage, pageSize);
	    
	    model.addAttribute("paging", paging);
	    model.addAttribute("lists", lists);
	    model.addAttribute("language", language);

	    List<Integer> pageNumbers = new ArrayList<>();
	    for (int i = paging.getFirstPage(); i <= paging.getLastPage(); i++) {
	        pageNumbers.add(i);
	    }
	    model.addAttribute("pageNumbers", pageNumbers);

	    return "contents/contents_notice/notice"; // 언어에 따른 경로 반환
	}
	
	@GetMapping("/{language}/notice_write.do")
    public String gowrite(@PathVariable String language, HttpServletRequest request, Model model) {
		model.addAttribute("language", language);
		return "contents/contents_notice/notice_write";
    }
	
	@PostMapping("/{language}/notice_write_ok.do")
	public String write_ok(@PathVariable String language, HttpServletRequest request, MultipartFile upload, Model model) {
		int flag = 2;
		
		Gorea_Notice_BoardTO to = new Gorea_Notice_BoardTO();
		
		to.setNoticeTitle(request.getParameter( "noticeTitle" ));
		to.setNoticeContent(request.getParameter("noticeContent"));
		to.setUserSeq(request.getParameter("userSeq"));
		
		if(language.equals("korean")) {
			flag = dao.notice_Write_Ok(to);
	      }else if(language.equals("english")) {
	    	  flag = dao.notice_Write_Ok(to);
	      }else if(language.equals("japanese")) {
	    	  flag = dao.notice_Write_Ok(to);
	      }else if(language.equals("chinese")) {
	    	  flag = dao.notice_Write_Ok(to);
	      }
		
		model.addAttribute("flag", flag);

		return "contents/contents_notice/notice_write_ok";
	}
	
	@GetMapping("/{language}/notice_view.do")
	public String view(@RequestParam("noticeSeq") String noticeSeqStr, @PathVariable String language, HttpServletRequest request, @RequestParam(value = "cpage", required = false) String cpage,
            @RequestParam(value = "searchType", required = false) String searchType,
            @RequestParam(value = "searchKeyword", required = false) String searchKeyword, Model model) {
		
		int noticeSeq;
        try {
        	noticeSeq = Integer.parseInt(noticeSeqStr.trim());
        } catch (NumberFormatException e) {
            // noticeSeq 파라미터가 유효하지 않을 때의 처리
            return "errorPage";
        }
		
		Gorea_Notice_BoardTO to = new Gorea_Notice_BoardTO();
		
	    to.setNoticeSeq(Integer.toString(noticeSeq));
	    Gorea_Notice_BoardTO prevPost = dao.getPreviousPost(noticeSeq);
	    Gorea_Notice_BoardTO nextPost = dao.getNextPost(noticeSeq);
	    System.out.println("## seq : " + request.getParameter("noticeSeq"));
	    
	    if(language.equals("korean")) {
	    	to = dao.notice_View(to);
	      }else if(language.equals("english")) {
	    	  to = dao.notice_View(to);
	      }else if(language.equals("japanese")) {
	    	  to = dao.notice_View(to);
	      }else if(language.equals("chinese")) {
	    	  to = dao.notice_View(to);
	      }

	    // 게시글 내용 정화
	    String unsafeContent = to.getNoticeContent();

	    //Safelist.basic()에 추가적으로 img, div, span 태그를 허용하고, style 속성도 허용합니다. 
	    Safelist safelist = Safelist.basic()
	    	    .addTags("img", "div", "span") // 이미지 및 스타일 관련 태그 추가
	    	    .addAttributes("img", "src", "alt", "title") // 이미지 태그 속성
	    	    .addAttributes(":all", "style"); // 모든 태그에 대해 'style' 속성 허용

	    	String safeContent = Jsoup.clean(unsafeContent, safelist);
	    	to.setNoticeContent(safeContent);

	    model.addAttribute("language", language);
	    model.addAttribute("to", to);
	    model.addAttribute("cpage", cpage);
	    model.addAttribute("searchType", searchType);
	    model.addAttribute("searchKeyword", searchKeyword);
	    model.addAttribute("prevPost", prevPost);
	    model.addAttribute("nextPost", nextPost);
	    
	    return "contents/contents_notice/notice_view";
	}
	
	@GetMapping("/{language}/notice_modify.do")
	public String modify(@PathVariable String language, HttpServletRequest request, @RequestParam(value = "cpage", required = false) String cpage,
            @RequestParam(value = "searchType", required = false) String searchType,
            @RequestParam(value = "searchKeyword", required = false) String searchKeyword, Model model) {
		
		Gorea_Notice_BoardTO to = new Gorea_Notice_BoardTO();
	
		to.setNoticeSeq( request.getParameter("noticeSeq") );
		System.out.println("## seq : " + request.getParameter("noticeSeq"));
		
		if(language.equals("korean")) {
			to = dao.notice_Modify(to);
	      }else if(language.equals("english")) {
	    	  to = dao.notice_Modify(to);
	      }else if(language.equals("japanese")) {
	    	  to = dao.notice_Modify(to);
	      }else if(language.equals("chinese")) {
	    	  to = dao.notice_Modify(to);
	      }
		
		model.addAttribute("to", to);
		model.addAttribute("noticeSeq", to.getNoticeSeq());
		model.addAttribute("language", language);
		
		model.addAttribute("cpage", cpage);
		model.addAttribute("searchType", searchType);
		model.addAttribute("searchKeyword", searchKeyword);
		
		return "contents/contents_notice/notice_modify";
	}
	
	@PostMapping("/{language}/notice_modify_ok.do")
	public String modify_ok(@PathVariable String language, HttpServletRequest request, MultipartFile upload, @RequestParam(value = "cpage", required = false) String cpage,
            @RequestParam(value = "searchType", required = false) String searchType,
            @RequestParam(value = "searchKeyword", required = false) String searchKeyword, Model model) {
		
		Gorea_Notice_BoardTO to = new Gorea_Notice_BoardTO();
		
		int flag = 1;
		to.setNoticeSeq( request.getParameter("noticeSeq") );
		to.setNoticeTitle(request.getParameter( "noticeTitle" ));
		to.setNoticeContent(request.getParameter("noticeContent"));
		
		System.out.println("## seq : " + request.getParameter("noticeSeq"));
		
		if(language.equals("korean")) {
			flag = dao.notice_Modify_Ok(to);
	      }else if(language.equals("english")) {
	    	  flag = dao.notice_Modify_Ok(to);
	      }else if(language.equals("japanese")) {
	    	  flag = dao.notice_Modify_Ok(to);
	      }else if(language.equals("chinese")) {
	    	 flag = dao.notice_Modify_Ok(to);
	      }
		
		model.addAttribute("flag", flag);
		model.addAttribute("language", language);
		model.addAttribute("noticeSeq", to.getNoticeSeq());
		
		model.addAttribute("cpage", cpage);
		model.addAttribute("searchType", searchType);
		model.addAttribute("searchKeyword", searchKeyword);
		
		return "contents/contents_notice/notice_modify_ok";
	}
	
	@GetMapping("/{language}/notice_delete_ok.do")
	public String delete_ok(@PathVariable String language, @RequestParam(value = "cpage", required = false) String cpage,
            @RequestParam(value = "searchType", required = false) String searchType,
            @RequestParam(value = "searchKeyword", required = false) String searchKeyword, HttpServletRequest request, Model model) {
		
		int flag = 1;
		
		Gorea_Notice_BoardTO to = new Gorea_Notice_BoardTO();
		
		to.setNoticeSeq(request.getParameter("noticeSeq"));
		
		if(language.equals("korean")) {
			flag = dao.notice_Delete_Ok(to);
	      }else if(language.equals("english")) {
	    	  flag = dao.notice_Delete_Ok(to);
	      }else if(language.equals("japanese")) {
	    	  flag = dao.notice_Delete_Ok(to);
	      }else if(language.equals("chinese")) {
	    	 flag = dao.notice_Delete_Ok(to);
	      }
		
		model.addAttribute("flag", flag);
		model.addAttribute("language", language);
		
		model.addAttribute("cpage", cpage);
		model.addAttribute("searchType", searchType);
		model.addAttribute("searchKeyword", searchKeyword);
		
		return "contents/contents_notice/notice_delete_ok";
	}
	
	// 이미지 업로드
    @RequestMapping(value = "notice/imageUpload", method = RequestMethod.POST)
    public void imageUploadForNotice(HttpServletRequest request, HttpServletResponse response, @RequestParam("upload") MultipartFile upload) {
        try {
            if (upload != null && !upload.isEmpty() && upload.getContentType().toLowerCase().startsWith("image/")) {
                UUID uid = UUID.randomUUID();

                String fileName = upload.getOriginalFilename();
                String encodedFileName = uid + "_" + fileName;
                String filePath = uploadDir + File.separator + encodedFileName;

                File uploadFile = new File(uploadDir);
                System.out.println(uid.toString());

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
                String fileUrl = "/ckImgSubmitForNotice?uid=" + uid + "&fileName=" + fileName;
                printWriter.println("{\"filename\" : \""+fileName+"\", \"uploaded\" : 1, \"url\":\""+fileUrl+"\"}");
                printWriter.flush();
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    @RequestMapping(value = "/ckImgSubmitForNotice")
    public void ckImgSubmitForNotice(@RequestParam("uid") String uid, @RequestParam("fileName") String fileName,
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
	
    // list에서 content 첫번째 이미지 썸네일
	private String extractFirstImageUrl(String content) {
//	    System.out.println("Content: " + content); // 콘텐츠 출력

	    String imageUrl = "";
	    Pattern pattern = Pattern.compile("<img[^>]+src\\s*=\\s*['\"]([^'\"]+)['\"][^>]*>");
	    Matcher matcher = pattern.matcher(content);
	    if (matcher.find()) {
	        imageUrl = matcher.group(1);
//	        System.out.println("Extracted Image URL: " + imageUrl); // 추출된 이미지 URL 출력

	        // URL에서 필요한 부분 추출 및 조정
	        imageUrl = imageUrl.replace("/ckImgSubmitForNotice?uid=", "").replace("&amp;fileName=", "_");
//	        System.out.println("Formatted Image URL: " + imageUrl); // 조정된 이미지 URL 출력
	    } else {
	        System.out.println("No image found"); // 이미지를 찾지 못한 경우
	    }
	    return imageUrl;
	}
	
	// 리스트 페이지 페이징 처리
		private Gorea_CumuPagingTO createPagingModel(int totalRowCount, int cpage, int pageSize) {
		    Gorea_CumuPagingTO paging = new Gorea_CumuPagingTO();
		    paging.setTotalRecord(totalRowCount);
		    paging.setCpage(cpage);
		    paging.setPageSize(pageSize);
		    paging.pageSetting();
		    return paging;
		}
	
	
}