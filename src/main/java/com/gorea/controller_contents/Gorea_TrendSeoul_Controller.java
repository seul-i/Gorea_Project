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
import org.jsoup.nodes.Document;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.gorea.dto_board.Gorea_EditRecommend_BoardTO;
import com.gorea.dto_board.Gorea_PagingTO;
import com.gorea.dto_board.Gorea_TrendSeoul_BoardTO;
import com.gorea.dto_board.Gorea_TrendSeoul_ListTO;
import com.gorea.repository_contents.Gorea_TrendSeoulDAO;
import com.gorea.service_contents.Gorea_Content_ListTranslation;
import com.gorea.service_contents.Gorea_Content_ViewTranslation;

import jakarta.annotation.Resource;
import jakarta.servlet.ServletOutputStream;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Controller
public class Gorea_TrendSeoul_Controller {
	
	@Value("${spring.servlet.multipart.location}")
    private String uploadDir;

	@Autowired
	private Gorea_TrendSeoulDAO dao;
	
	@Autowired
	private Gorea_TrendSeoul_BoardTO to;
	
	@Autowired
	private Gorea_Content_ListTranslation listTranslation;
	
	@Autowired
	private Gorea_Content_ViewTranslation viewTranslation;
	
	@Value("${geocoding.api.key}")
	private String googlemap;
	
	@GetMapping("/{language}/trend_seoul.do")
	public String trendList(@PathVariable String language, Model model,
			@RequestParam(defaultValue = "1") int cpage,
	        @RequestParam(defaultValue = "8") int pageSize) {
	    System.out.println("TrendSeoul list 호출 성공");

	    // cpage가 0 이하이면 1로 설정
	    cpage = (cpage <= 0) ? 1 : cpage;
	    
	    if (cpage <= 0) {
	        // cpage가 0 이하인 경우, 1페이지로 리다이렉트
	        return "redirect:/{language}/trend_seoul.do?cpage=1";
	    }
	    
	    int offset = (cpage - 1) * pageSize;
	    
	    // language 변수를 이용하여 언어에 따른 경로를 동적으로 설정
	    // String path = language.equals("korean") ? "korean" : "english";
	    
	    String viewPath = "trend_seoul.do";
	    viewPath = viewPath.toLowerCase();
	    
	    model.addAttribute("viewPath", viewPath);
	    model.addAttribute("language", language);
	    
	    if(language.equals("korean")) {
	    	List<Gorea_TrendSeoul_ListTO> boardList = dao.trendSeoul_List(offset, pageSize);
		    //model.addAttribute("boardList", boardList);
	    	Gorea_PagingTO paging = createPagingModel(boardList, cpage);
	    	System.out.println(paging);
	    	model.addAttribute("paging", paging);
	    	
	    	// 페이지 번호를 추가하는 부분
		    List<Integer> pageNumbers = new ArrayList<>();
		    for (int i = paging.getFirstPage(); i <= paging.getLastPage(); i++) {
		        pageNumbers.add(i);
		    }
		    model.addAttribute("pageNumbers", pageNumbers);
	    	
	    }else if(language.equals("english")) {
	    	List<Gorea_TrendSeoul_ListTO> boardList_en = listTranslation.trendSeoul_List_EN(offset, pageSize);				
			//model.addAttribute("boardList", boardList_en);
	    	Gorea_PagingTO paging = createPagingModel(boardList_en, cpage);
	    	System.out.println(paging);
	    	model.addAttribute("paging", paging);
	    	
	    	// 페이지 번호를 추가하는 부분
		    List<Integer> pageNumbers = new ArrayList<>();
		    for (int i = paging.getFirstPage(); i <= paging.getLastPage(); i++) {
		        pageNumbers.add(i);
		    }
		    model.addAttribute("pageNumbers", pageNumbers);
		    
	    }else if(language.equals("japanese")) {
	    	List<Gorea_TrendSeoul_ListTO> boardList_jp = listTranslation.trendSeoul_List_JP(offset, pageSize);				
			//model.addAttribute("boardList", boardList_en);
	    	Gorea_PagingTO paging = createPagingModel(boardList_jp, cpage);
	    	System.out.println(paging);
	    	model.addAttribute("paging", paging);
	    	
	    	// 페이지 번호를 추가하는 부분
		    List<Integer> pageNumbers = new ArrayList<>();
		    for (int i = paging.getFirstPage(); i <= paging.getLastPage(); i++) {
		        pageNumbers.add(i);
		    }
		    model.addAttribute("pageNumbers", pageNumbers);
		    
	    }else if(language.equals("chinese")) {
	    	List<Gorea_TrendSeoul_ListTO> boardList_chn = listTranslation.trendSeoul_List_CHN(offset, pageSize);				
			//model.addAttribute("boardList", boardList_en);
	    	Gorea_PagingTO paging = createPagingModel(boardList_chn, cpage);
	    	System.out.println(paging);
	    	model.addAttribute("paging", paging);
	    	
	    	// 페이지 번호를 추가하는 부분
		    List<Integer> pageNumbers = new ArrayList<>();
		    for (int i = paging.getFirstPage(); i <= paging.getLastPage(); i++) {
		        pageNumbers.add(i);
		    }
		    model.addAttribute("pageNumbers", pageNumbers);
	    }

	    // 동적으로 경로를 설정
	    //return path + "/contents_trend_seoul/trend_seoul";
	    return "korean/contents_trend_seoul/trend_seoul";
	}	
	
	private Gorea_PagingTO createPagingModel(List<Gorea_TrendSeoul_ListTO> boardList, int cpage) {
	    Gorea_PagingTO paging = new Gorea_PagingTO();
	    paging.setBoardList(boardList != null ? boardList : new ArrayList<>());
	    paging.setTotalRecord(dao.getTotalRowCount());
	    paging.setCpage(cpage);  // 추가: cpage 값을 설정

	    // 수정: pageSetting 호출 전에 cpage 값을 확인하고 필요하다면 수정
	    if (cpage > paging.getTotalPage()) {
	        cpage = paging.getTotalPage();
	    }

	    paging.pageSetting();

	    return paging;
	}
	
	@GetMapping("/{language}/trend_view.do")
	public String view(@PathVariable String language, HttpServletRequest request, Model model) {
		
		to.setSeoulSeq(request.getParameter("seoulSeq"));
		System.out.println("## seq : " + request.getParameter("seoulSeq"));
		
		model.addAttribute("language", language);
		model.addAttribute("googlemap",googlemap);
		
		if(language.equals("korean")) {
			to = dao.trendSeoul_View(to);
			System.out.println(to);			
			model.addAttribute("to", to);
		}else if(language.equals("english")) {
			to = viewTranslation.trendSeoul_View_EN(to);
			model.addAttribute("to", to);
		}else if(language.equals("japanese")) {
			to = viewTranslation.trendSeoul_View_JP(to);
			model.addAttribute("to", to);
		}else if(language.equals("chinese")) {
			to = viewTranslation.trendSeoul_View_CHN(to);
			model.addAttribute("to", to);
		}
		
		return "korean/contents_trend_seoul/trend_view";
	}
	
	// =======================================================================================
	
	@RequestMapping("/korean/trend_write.do")
    public String gowrite(HttpServletRequest request, Model model) {
		return "korean/contents_trend_seoul/trend_write";
    }
	
	@RequestMapping("/korean/trend_write_ok.do")
    public String write_ok(HttpServletRequest request, MultipartFile upload, Model model) {
        int flag = 2;
        
//        to.setSeoulboardNo(request.getParameter("seoulboardNo"));
        to.setSeoulcategoryNo(request.getParameter("seoulcategoryNo"));
//        to.setSeoulRank(request.getParameter("seoulRank"));
        to.setSeoulTitle(request.getParameter("seoulTitle"));
        to.setSeoulsubTitle(request.getParameter("seoulsubTitle"));
        to.setSeoulContent(request.getParameter("seoulContent"));
        to.setSeoulLoc(request.getParameter("seoulLoc"));
        to.setSeoulLocGu(request.getParameter("seoulLocGu"));
        to.setSeoulSite(request.getParameter("seoulSite"));
        to.setSeoulusageTime(request.getParameter("seoulusageTime"));
        to.setSeoulusageFee(request.getParameter("seoulusageFee"));
        to.setSeoulTrafficinfo(request.getParameter("seoulTrafficinfo"));
        to.setSeoulNotice(request.getParameter("seoulNotice"));
//        to.setSeoulScore(request.getParameter("seoulScore"));
        
        flag = dao.trendSeoul_Write_Ok(to);
        
        model.addAttribute("flag", flag);

        return "korean/contents_trend_seoul/trend_write_ok";
	}
	
	@RequestMapping("/korean/trend_modify.do")
	public String modify(HttpServletRequest request, Model model) {
	
		to.setSeoulSeq( request.getParameter("seoulSeq") );
		System.out.println("## seq : " + request.getParameter("seoulSeq"));
		
		to = dao.trendSeoul_Modify(to);
		
		model.addAttribute("to", to);
		model.addAttribute("seoulSeq", to.getSeoulSeq());
		
		return "korean/contents_trend_seoul/trend_modify";
	}
	
	@RequestMapping("/korean/trend_modify_ok.do")
	public String modify_ok(HttpServletRequest request, MultipartFile upload, Model model) {
		int flag = 1;
		
		to.setSeoulSeq( request.getParameter("seoulSeq") );
		to.setSeoulboardNo(request.getParameter("seoulboardNo"));
        to.setSeoulcategoryNo(request.getParameter("seoulcategoryNo"));
        to.setSeoulRank(request.getParameter("seoulRank"));
        to.setSeoulTitle(request.getParameter("seoulTitle"));
        to.setSeoulsubTitle(request.getParameter("seoulsubTitle"));
        to.setSeoulContent(request.getParameter("seoulContent"));
        to.setSeoulLoc(request.getParameter("seoulLoc"));
        to.setSeoulLocGu(request.getParameter("seoulLocGu"));
        to.setSeoulSite(request.getParameter("seoulSite"));
        to.setSeoulusageTime(request.getParameter("seoulusageTime"));
        to.setSeoulusageFee(request.getParameter("seoulusageFee"));
        to.setSeoulTrafficinfo(request.getParameter("seoulTrafficinfo"));
        to.setSeoulNotice(request.getParameter("seoulNotice"));
        to.setSeoulScore(request.getParameter("seoulScore"));
		
		System.out.println("## seq : " + request.getParameter("seoulSeq"));
		
		flag = dao.trendSeoul_Modify_Ok(to);

		model.addAttribute("flag", flag);
		System.out.println(flag);
		return "korean/contents_trend_seoul/trend_modify_ok";
	}
	
	@RequestMapping("/korean/trend_delete_ok.do")
	public String delete_ok(HttpServletRequest request, Model model) {
		to.setSeoulSeq(request.getParameter("seoulSeq"));
		
		int flag = dao.trendSeoul_Delete_Ok(to);
		
		model.addAttribute("flag", flag);
		
		return "korean/contents_trend_seoul/trend_delete_ok";
	}
	
	
	// 이미지 업로드
    @RequestMapping(value = "korean/imageUpload", method = RequestMethod.POST)
    public void imageUpload(HttpServletRequest request, HttpServletResponse response, @RequestParam("upload") MultipartFile upload) {
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
                
                to.setUid(uid.toString());
                to.setFilename(encodedFileName);
                // 클라이언트에게 JSON 반환
                response.setCharacterEncoding("utf-8");
                response.setContentType("text/html;charset=utf-8");
                String callback = request.getParameter("CKEditorFuncNum");
                PrintWriter printWriter = response.getWriter();
                String fileUrl = "/ckImgSubmit?uid=" + uid + "&fileName=" + fileName;
                printWriter.println("{\"filename\" : \""+fileName+"\", \"uploaded\" : 1, \"url\":\""+fileUrl+"\"}");
                printWriter.flush();
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    @RequestMapping(value = "ckImgSubmit")
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
    @RequestMapping(value = "", method = RequestMethod.POST)
    public void imageUpdate(HttpServletRequest request, HttpServletResponse response,
                            @RequestParam("upload") MultipartFile upload, @RequestParam("uid") String uid,
                            @RequestParam("fileName") String fileName) {
        try {
            response.setCharacterEncoding("utf-8");
            response.setContentType("text/html;charset=utf-8");
            System.out.println(uid.toString());

            if (upload != null && !upload.isEmpty() && upload.getContentType().toLowerCase().startsWith("image/")) {
                String newFileName = upload.getOriginalFilename();
                String newEncodedFileName = uid + "_" + newFileName;
                String newFilePath = uploadDir + File.separator + newEncodedFileName;

                File newUploadFile = new File(uploadDir);
                if (!newUploadFile.exists()) {
                    newUploadFile.mkdirs(); // 디렉토리 생성
                }

                try (OutputStream outputStream = new FileOutputStream(new File(newFilePath))) {
                    outputStream.write(upload.getBytes());
                }
                to.setFilename(newEncodedFileName);

                String callback = request.getParameter("CKEditorFuncNum");
                PrintWriter printWriter = response.getWriter();
                String fileUrl = "/ckImgSubmit?uid=" + uid + "&fileName=" + newFileName;
                
                printWriter.println("{\"filename\" : \""+newFileName+"\", \"uploaded\" : 1, \"url\":\""+fileUrl+"\"}");
                printWriter.flush();

                // 원본 파일 삭제
                String originalFilePath = uploadDir + File.separator + fileName;
                File originalFile = new File(originalFilePath);
                if (originalFile.exists()) {
                    originalFile.delete();
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
