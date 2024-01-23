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

import org.jsoup.Jsoup;
import org.jsoup.safety.Safelist;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.gorea.dto_board.Gorea_PagingTO;
import com.gorea.dto_board.Gorea_Recommend_BoardTO;
import com.gorea.repository_contents.Gorea_RecommendDAO;
import com.gorea.service_trans_userrecommend.Gorea_Translate_UserRecom_List_interface;
import com.gorea.service_trans_userrecommend.Gorea_Translate_UserRecom_View_interface;

import jakarta.servlet.ServletOutputStream;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Controller
public class Gorea_Recommend_Controller {

	@Autowired
	Gorea_RecommendDAO dao;
	
	@Value("${spring.servlet.multipart.location}")
    private String uploadDir;
	
	@Autowired
	private Gorea_Translate_UserRecom_List_interface listTranslation;
	
	@Autowired 
	private Gorea_Translate_UserRecom_View_interface viewTranslation;
	
	@GetMapping("/{language}/userRecom.do")
	public String list( @PathVariable String language,
			@RequestParam(value="searchType", required=false) String searchType,
			@RequestParam(value = "searchKeyword", required = false) String searchKeyword,
			HttpServletRequest request, Model model,
			@RequestParam(defaultValue = "1") int cpage,
			@RequestParam(defaultValue = "8") int pageSize ) {
		
		// cpage가 0 이하이면 1로 설정
		cpage = ( cpage <= 0 ) ? 1 : cpage;
		
		if ( cpage <= 0 ) {
			return "redirect:/{language}/userRecomList.do?cpage=1";
		}
		
		int offset = (cpage - 1 ) * pageSize;		
		
		int totalRowCount = 0;
		
		if( language.equals("korean")) {
			List<Gorea_Recommend_BoardTO> boardList = listTranslation.userRecommend_List_KO(offset, pageSize);
			Gorea_PagingTO paging = createPagingModel(boardList, cpage);
			
			//System.out.println( "lists : " + boardList );
			
			model.addAttribute( "lists", boardList );
			model.addAttribute( "paging", paging );
			
			// 페이지 번호를 추가하는 부분
		    List<Integer> pageNumbers = new ArrayList<>();
		    for (int i = paging.getFirstPage(); i <= paging.getLastPage(); i++) {
		        pageNumbers.add(i);
		    }
		    model.addAttribute("pageNumbers", pageNumbers);
		
		} else if( language.equals("english") ) {
			List<Gorea_Recommend_BoardTO> boardList_en = listTranslation.userRecommend_List_EN(offset, pageSize);
			Gorea_PagingTO paging = createPagingModel(boardList_en, cpage);
			
			model.addAttribute( "lists", boardList_en );
			model.addAttribute( "paging", paging );
			
			// 페이지 번호를 추가하는 부분
		    List<Integer> pageNumbers = new ArrayList<>();
		    for (int i = paging.getFirstPage(); i <= paging.getLastPage(); i++) {
		        pageNumbers.add(i);
		    }
		    model.addAttribute("pageNumbers", pageNumbers);
		    
		} else if( language.equals("japanese") ) {
			List<Gorea_Recommend_BoardTO> boardList_jp = listTranslation.userRecommend_List_JP(offset, pageSize);
			Gorea_PagingTO paging = createPagingModel(boardList_jp, cpage);
			
			model.addAttribute( "lists", boardList_jp );
			model.addAttribute( "paging", paging );
			
			// 페이지 번호를 추가하는 부분
		    List<Integer> pageNumbers = new ArrayList<>();
		    for (int i = paging.getFirstPage(); i <= paging.getLastPage(); i++) {
		        pageNumbers.add(i);
		    }
		    model.addAttribute("pageNumbers", pageNumbers);
		    
		} else if( language.equals("chinese") ) {
			List<Gorea_Recommend_BoardTO> boardList_chn = listTranslation.userRecommend_List_CHN(offset, pageSize);
			Gorea_PagingTO paging = createPagingModel(boardList_chn, cpage);
			
			model.addAttribute( "lists", boardList_chn );
			model.addAttribute( "paging", paging );
			
			// 페이지 번호를 추가하는 부분
		    List<Integer> pageNumbers = new ArrayList<>();
		    for (int i = paging.getFirstPage(); i <= paging.getLastPage(); i++) {
		        pageNumbers.add(i);
		    }
		    model.addAttribute("pageNumbers", pageNumbers);
		}
		
		model.addAttribute( "language", language );
		
		return "contents/contents_user_recommend/userRecommend_List";
	}
	
	//paging
		private Gorea_PagingTO createPagingModel(List<Gorea_Recommend_BoardTO> boardList, int cpage) {
		Gorea_PagingTO paging = new Gorea_PagingTO();
		    
		paging.setBoardList1( boardList != null ? boardList : new ArrayList<>());
		paging.setTotalRecord(dao.getTotalRowCount());
		paging.setCpage(cpage);  // 추가: cpage 값을 설정

		// 수정: pageSetting 호출 전에 cpage 값을 확인하고 필요하다면 수정
		if (cpage > paging.getTotalPage()) {
		    cpage = paging.getTotalPage();
		}

		paging.pageSetting();
		    
		return paging;
		}
	
	
	//write
	@GetMapping( "/{language}/userRecom_write.do" )
	public String write( @PathVariable String language, HttpServletRequest request, Model model ) {
		model.addAttribute("language", language);
		
		return "contents/contents_user_recommend/userRecommend_Write";
	}
	
	
	@PostMapping( "/{language}/userRecom_write_ok.do" )
	public String writeOk(@PathVariable String language, HttpServletRequest request, MultipartFile upload, Model model ) {
		int flag = 2;
		
		Gorea_Recommend_BoardTO to = new Gorea_Recommend_BoardTO();
		
		to.setUserRecomTitle( request.getParameter( "title" ) );
		to.setUserRecomContent( request.getParameter( "content" ) );
		to.setUserSeq( request.getParameter("userSeq") );
		//System.out.println( "userSeq : " + request.getParameter("userSeq") );
		System.out.println();
		if(language.equals("korean")) {
			flag = dao.userRecom_writeOk(to);
	         System.out.println(to);
	      }else if(language.equals("english")) {
	    	  flag = dao.userRecom_writeOk(to);
	      }else if(language.equals("japanese")) {
	    	  flag = dao.userRecom_writeOk(to);
	      }else if(language.equals("chinese")) {
	    	 flag = dao.userRecom_writeOk(to);
	      }
		
		model.addAttribute("language", language);
		model.addAttribute( "flag", flag );
		//System.out.println( "language : " + language );
		
		return "contents/contents_user_recommend/userRecommend_Write_Ok";
	}
	
	
	@GetMapping("/{language}/userRecom_view.do")
	public String view( @RequestParam("seq") String userRecomSeqStr, @PathVariable String language, HttpServletRequest request, Model model, @RequestParam(value = "cpage", required = false) String cpage,
			@RequestParam(value = "searchType", required = false) String searchType,
            @RequestParam(value = "searchKeyword", required = false) String searchKeyword) {
		
		int userRecomSeq;
		try {
			userRecomSeq = Integer.parseInt(userRecomSeqStr.trim());
        } catch (NumberFormatException e) {
            // freeSeq 파라미터가 유효하지 않을 때의 처리
            return "errorPage";
        }
		
		Gorea_Recommend_BoardTO to = new Gorea_Recommend_BoardTO();
		
		to.setUserRecomSeq( Integer.toString(userRecomSeq) );
		Gorea_Recommend_BoardTO prevPost = dao.getPreviousPost(userRecomSeq);
		Gorea_Recommend_BoardTO nextPost = dao.getNextPost(userRecomSeq);
		System.out.println( "view controller에서 : " + request.getParameter( "seq" ) );
		System.out.println( Integer.toString(userRecomSeq) );
		
		if( language.equals("korean")) {
			to = dao.userRecom_view(to);
			model.addAttribute( "to", to );
		} else if ( language.equals( "english" ) ) {
			to = viewTranslation.userRecommend_View_EN(to);
			model.addAttribute( "to", to );
		} else if ( language.equals( "japanese" ) ) {
			to = viewTranslation.userRecommend_View_EN(to);
			model.addAttribute( "to", to );
		} else if ( language.equals( "chinese" ) ) {
			to = viewTranslation.userRecommend_View_EN(to);
			model.addAttribute( "to", to );
		}
		
		// 게시글 내용 정화
		String unsafeContent = to.getUserRecomContent();
		
		// 이미지 태그에 대한 Safelist 설정을 조정합니다.
		Safelist safelist = Safelist.basic()
	    	    .addTags("img", "div", "span") // 이미지 및 스타일 관련 태그 추가
	    	    .addAttributes("img", "src", "alt", "title") // 이미지 태그 속성
	    	    .addAttributes(":all", "style"); // 모든 태그에 대해 'style' 속성 허용

	    	String safeContent = Jsoup.clean(unsafeContent, safelist);
	    	to.setUserRecomContent(safeContent);
	    	
	    	model.addAttribute("language", language);
	    	model.addAttribute("to", to);
	    	model.addAttribute("cpage", cpage);
	    	model.addAttribute("searchType", searchType);
	    	model.addAttribute("searchKeyword", searchKeyword);
	    	model.addAttribute("prevPost", prevPost);
	    	model.addAttribute("nextPost", nextPost);
		
		return "contents/contents_user_recommend/userRecommend_View";
	}
	
	
	/*
	 * @PostMapping("/increaseLikesUserRecommend")
	 * 
	 * @ResponseBody public ResponseEntity<?> increaseLikes(@RequestParam("seq")
	 * String userRecomSeq) { try { dao.increaseLikesUserRecommend(userRecomSeq);
	 * 
	 * // 새로운 Gorea_Recommend_BoardTO 객체를 생성하고 userRecomSeq를 설정
	 * Gorea_Recommend_BoardTO to = new Gorea_Recommend_BoardTO();
	 * to.setUserRecomSeq(userRecomSeq);
	 * 
	 * // 업데이트된 데이터를 가져옴 Gorea_Recommend_BoardTO updatedTo = dao.userRecom_view(to);
	 * 
	 * // 새로운 추천 수를 반환 return ResponseEntity.ok(updatedTo.getUserRecomcount()); }
	 * catch (Exception e) { e.printStackTrace(); return
	 * ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Error occurred"
	 * ); } }
	 */
	
	
	@RequestMapping( "/korean/userRecom_delete_ok.do" )
	public String deleteOk( HttpServletRequest request , Model model ) {
		Gorea_Recommend_BoardTO to = new Gorea_Recommend_BoardTO();
		
		to.setUserRecomSeq( request.getParameter( "userRecomSeq" ) );
		
		System.out.println( "seq : " + request.getParameter( "userRecomSeq" ) );
		
		int flag = dao.userRecom_deleteOk(to);
		
		model.addAttribute("flag", flag);
		
		System.out.println( "flag : " + flag );
		
		return "contents/contents_user_recommend/userRecommend_Delete_Ok";
	}
	
	
	@RequestMapping( "/{language}/userRecom_modify.do" )
	public String modify(@PathVariable String language, HttpServletRequest request, @RequestParam(value = "cpage", required = false) String cpage,
            @RequestParam(value = "searchType", required = false) String searchType,
            @RequestParam(value = "searchKeyword", required = false) String searchKeyword, Model model ) {
		Gorea_Recommend_BoardTO to = new Gorea_Recommend_BoardTO();
		
		to.setUserRecomSeq( request.getParameter("seq") );
		
		//System.out.println( "1 : " + request.getParameter( "seq" ) );
		
		//System.out.println( "modifyseq : " + to.getUserRecomSeq() );
		
		if(language.equals("korean")) {
	    	to = dao.userRecom_modify(to);
	      }else if(language.equals("english")) {
	    	  to = dao.userRecom_modify(to);
	      }else if(language.equals("japanese")) {
	    	  to = dao.userRecom_modify(to);
	      }else if(language.equals("chinese")) {
	    	  to = dao.userRecom_modify(to);
	      }
		
		model.addAttribute( "to" , to );
		//model.addAttribute( "seq", request.getParameter("userRecomSeq") );
		model.addAttribute( "seq", request.getParameter("seq") );
		
		model.addAttribute("cpage", cpage);
		model.addAttribute("searchType", searchType);
		model.addAttribute("searchKeyword", searchKeyword);
		
		return "contents/contents_user_recommend/userRecommend_Modify";
	}
	
	@RequestMapping( "/{language}/userRecom_modify_ok.do" )
	public String modifyOk(HttpServletRequest request, MultipartFile upload, Model model ) {
		
		Gorea_Recommend_BoardTO to = new Gorea_Recommend_BoardTO();
		
		int flag = 1;
		
		to.setUserRecomSeq( request.getParameter("userRecomSeq") );
		to.setUserRecomTitle( request.getParameter( "title" ) );
		to.setUserRecomContent( request.getParameter("content") );;
		
		System.out.println( "seq : " + request.getParameter("userRecomSeq") );
		System.out.println( "title : " + to.getUserRecomTitle() );
		System.out.println( "content : " + to.getUserRecomContent() );
		
		flag = dao.userRecom_modifyOk(to);
		
		System.out.println( "flag는 : " + flag);
		model.addAttribute( "flag", flag );
		
		return "contents/contents_user_recommend/userRecommend_Modify_Ok";
	}
	
	
	@GetMapping( "/{language}/gorea_replyCount.do" )
	public String replyCount( HttpServletRequest request, Model model ) {
		Gorea_Recommend_BoardTO to = new Gorea_Recommend_BoardTO();
		
		to.setUserRecomSeq( request.getParameter("seq") );
		
		System.out.println( "댓글 불러오기 seq : " + request.getParameter("seq") );
		
		to = dao.replyCount(to);
		
		System.out.println( to.getUserRecomCmt() );
		
		model.addAttribute( "to", to );
		
		return "contents/contents_user_recommend/replyCount";
	}
	
	
	// 이미지 업로드
    @RequestMapping(value = "UserRecom/imageUpload", method = RequestMethod.POST)
    public void imageUploadForUserRecom(HttpServletRequest request, HttpServletResponse response, @RequestParam("upload") MultipartFile upload) {
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
                String fileUrl = "/ckImgSubmitForUserRecom?uid=" + uid + "&fileName=" + fileName;
                printWriter.println("{\"filename\" : \""+fileName+"\", \"uploaded\" : 1, \"url\":\""+fileUrl+"\"}");
                printWriter.flush();
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    @RequestMapping(value = "/ckImgSubmitForUserRecom")
    public void ckSubmit(@RequestParam("uid") String uid, @RequestParam("fileName") String fileName,
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
