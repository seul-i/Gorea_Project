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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.gorea.dto_board.Gorea_EditRecommend_BoardTO;
import com.gorea.dto_board.Gorea_TrendSeoul_BoardTO;
import com.gorea.dto_board.Gorea_TrendSeoul_ListTO;
import com.gorea.repository_contents.Gorea_TrendSeoulDAO;
import com.gorea.service_contents.Gorea_Content_Translation;

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
	private Gorea_Content_Translation translation;
	
	@GetMapping("/korean/trend_seoul.do")
	public String Trendlist(Model model) {
		System.out.println("TrendSeoul list 호출 성공");
		List<Gorea_TrendSeoul_ListTO> boardList = dao.trendSeoul_List();

		model.addAttribute("boardList", boardList);

		return "korean/contents_trend_seoul/trend_seoul";
	}

	// 영어 번역 처리 ============================================================================
	
	@GetMapping("/english/trend_seoul.do")
	public String Trendlist_En(Model model) {
		System.out.println("TrendSeoul list 영어번역 호출 성공");
		
		List<Gorea_TrendSeoul_ListTO> boardList_en = translation.trendSeoul_List_EN();	
		
		System.out.println(boardList_en);
		
		model.addAttribute("boardList", boardList_en);
		
		return "english/contents_trend_seoul/trend_seoul";
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
	
	@GetMapping("/korean/trend_view.do")
	public String view(HttpServletRequest request, Model model) {
		to.setSeoulSeq(request.getParameter("seoulSeq"));
		System.out.println("## seq : " + request.getParameter("seoulSeq"));
		
		to = dao.trendSeoul_View(to);
		
	    model.addAttribute("to", to);
		
		return "korean/contents_trend_seoul/trend_view";
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
