package com.gorea.controller_contents;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
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
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.gorea.dto_board.Gorea_QnA_BoardTO;
import com.gorea.repository_contents.Gorea_QnADAO;

import jakarta.servlet.ServletOutputStream;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Controller
public class Gorea_QnA_Controller {
	
	@Value("${spring.servlet.multipart.location}")
    private String uploadDir;

	@Autowired
	private Gorea_QnADAO dao;
	
	@RequestMapping("/{language}/qna_write.do")
    public String gowrite(@PathVariable String language, HttpServletRequest request, Model model) {
		model.addAttribute("language", language);
		return "contents/contents_qna/qna_write";
    }
	
	@RequestMapping("/{language}/qna_write_ok.do")
	public String write_ok(@PathVariable String language, HttpServletRequest request, MultipartFile upload, Model model) {
		int flag = 2;
		
		Gorea_QnA_BoardTO to = new Gorea_QnA_BoardTO();
		
		to.setQnaTitle(request.getParameter( "qnaTitle" ));
		to.setQnaContent(request.getParameter("qnaContent"));
		
		if(language.equals("korean")) {
			flag = dao.qna_Write_Ok(to);
	      }else if(language.equals("english")) {
	    	  flag = dao.qna_Write_Ok(to);
	      }else if(language.equals("japanese")) {
	    	  flag = dao.qna_Write_Ok(to);
	      }else if(language.equals("chinese")) {
	    	  flag = dao.qna_Write_Ok(to);
	      }
		
		model.addAttribute("flag", flag);

		return "contents/contents_qna/qna_write_ok";
	}
	
	@RequestMapping("/{language}/qna_view.do")
	public String view(@PathVariable String language, HttpServletRequest request, Model model) {
		
		Gorea_QnA_BoardTO to = new Gorea_QnA_BoardTO();
		
		to.setQnaSeq(request.getParameter("qnaSeq"));
		System.out.println("## qna seq : " + request.getParameter("qnaSeq"));
		
		if(language.equals("korean")) {
			to = dao.qna_View(to);
	      }else if(language.equals("english")) {
	    	  to = dao.qna_View(to);
	      }else if(language.equals("japanese")) {
	    	  to = dao.qna_View(to);
	      }else if(language.equals("chinese")) {
	    	  to = dao.qna_View(to);
	      }
		
		 // 게시글 내용 정화
	    String unsafeContent = to.getQnaContent();

	    //Safelist.basic()에 추가적으로 img, div, span 태그를 허용하고, style 속성도 허용합니다. 
	    Safelist safelist = Safelist.basic()
	    	    .addTags("img", "div", "span") // 이미지 및 스타일 관련 태그 추가
	    	    .addAttributes("img", "src", "alt", "title") // 이미지 태그 속성
	    	    .addAttributes(":all", "style"); // 모든 태그에 대해 'style' 속성 허용

	    	String safeContent = Jsoup.clean(unsafeContent, safelist);
	    	to.setQnaContent(safeContent);
	    	
	    	model.addAttribute("to", to);
	    	model.addAttribute("language", language);
		
		return "contents/contents_qna/qna_view";
	}
	
	@RequestMapping("/{language}/qna_modify.do")
	public String modify(@PathVariable String language, HttpServletRequest request, Model model) {
		
		Gorea_QnA_BoardTO to = new Gorea_QnA_BoardTO();
	
		to.setQnaSeq( request.getParameter("qnaSeq") );
		System.out.println("## seq : " + request.getParameter("qnaSeq"));
		
		if(language.equals("korean")) {
			to = dao.qna_Modify(to);
	      }else if(language.equals("english")) {
	    	  to = dao.qna_Modify(to);
	      }else if(language.equals("japanese")) {
	    	  to = dao.qna_Modify(to);
	      }else if(language.equals("chinese")) {
	    	  to = dao.qna_Modify(to);
	      }
		
		model.addAttribute("to", to);
		model.addAttribute("qnaSeq", to.getQnaSeq());
		model.addAttribute("language", language);
		
		return "contents/contents_qna/qna_modify";
	}
	
	@RequestMapping("/{language}/qna_modify_ok.do")
	public String modify_ok(@PathVariable String language, HttpServletRequest request, MultipartFile upload, Model model) {
		
		Gorea_QnA_BoardTO to = new Gorea_QnA_BoardTO();
		
		int flag = 1;
		to.setQnaSeq( request.getParameter("qnaSeq") );
		to.setQnaTitle(request.getParameter( "qnaTitle" ));
		to.setQnaContent(request.getParameter("qnaContent"));
		
		System.out.println("## seq : " + request.getParameter("qnaSeq"));
		
		if(language.equals("korean")) {
			flag = dao.qna_Modify_Ok(to);
	      }else if(language.equals("english")) {
	    	  flag = dao.qna_Modify_Ok(to);
	      }else if(language.equals("japanese")) {
	    	  flag = dao.qna_Modify_Ok(to);
	      }else if(language.equals("chinese")) {
	    	  flag = dao.qna_Modify_Ok(to);
	      }
		
		model.addAttribute("flag", flag);
		System.out.println(flag);
		return "contents/contents_qna/qna_modify_ok";
	}
	
	@RequestMapping("/{language}/qna_delete_ok.do")
	public String delete_ok(@PathVariable String language, HttpServletRequest request, Model model) {
		
		Gorea_QnA_BoardTO to = new Gorea_QnA_BoardTO();
		
		int flag = 1;
		
		to.setQnaSeq(request.getParameter("qnaSeq"));
		
		if(language.equals("korean")) {
			flag = dao.qna_Delete_Ok(to);
	      }else if(language.equals("english")) {
	    	  flag = dao.qna_Delete_Ok(to);
	      }else if(language.equals("japanese")) {
	    	  flag = dao.qna_Delete_Ok(to);
	      }else if(language.equals("chinese")) {
	    	 flag = dao.qna_Delete_Ok(to);
	      }
		
		model.addAttribute("flag", flag);
		
		return "contents/contents_qna/qna_delete_ok";
	}
	
	// 이미지 업로드
    @RequestMapping(value = "/qna/imageUpload", method = RequestMethod.POST)
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
                String fileUrl = "/ckImgSubmitForqna?uid=" + uid + "&fileName=" + fileName;
                printWriter.println("{\"filename\" : \""+fileName+"\", \"uploaded\" : 1, \"url\":\""+fileUrl+"\"}");
                printWriter.flush();
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    @RequestMapping(value = "/ckImgSubmitForqna")
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
    
	private String extractFirstImageUrl(String content) {
//	    System.out.println("Content: " + content); // 콘텐츠 출력

	    String imageUrl = "";
	    Pattern pattern = Pattern.compile("<img[^>]+src\\s*=\\s*['\"]([^'\"]+)['\"][^>]*>");
	    Matcher matcher = pattern.matcher(content);
	    if (matcher.find()) {
	        imageUrl = matcher.group(1);
//	        System.out.println("Extracted Image URL: " + imageUrl); // 추출된 이미지 URL 출력

	        // URL에서 필요한 부분 추출 및 조정
	        imageUrl = imageUrl.replace("/ckImgSubmitForqna?uid=", "").replace("&amp;fileName=", "_");
//	        System.out.println("Formatted Image URL: " + imageUrl); // 조정된 이미지 URL 출력
	    } else {
	        System.out.println("No image found"); // 이미지를 찾지 못한 경우
	    }
	    return imageUrl;
	}
}