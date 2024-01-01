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

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.gorea.dto_board.Gorea_TrendSeoul_BoardTO;
import com.gorea.repository_contents.Gorea_TrendSeoulDAO;

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
	
	
	@RequestMapping("/korean/trend_seoul.do")
	public String list(HttpServletRequest request, Model model) {
	 System.out.println("list 호출 성공");
      List<Gorea_TrendSeoul_BoardTO> lists = dao.trendSeoul_List();
      model.addAttribute("lists", lists);
      
      return "korean/contents_trend_seoul/trend_seoul";
	}
	
	
	@RequestMapping("/korean/trend_write.do")
    public ModelAndView gowrite(HttpServletRequest request, Model model) {
		ModelAndView modelAndView = new ModelAndView("korean/contents_trend_seoul/trend_write");
		return modelAndView;
    }
	
	@RequestMapping("/korean/trend_write_ok.do")
	public ModelAndView write_ok(HttpServletRequest request, MultipartFile upload) {
		int flag = 2;
		
		to.setGo_seoul_subject(request.getParameter( "go_seoul_subject" ));
		to.setGo_seoul_subtitle(request.getParameter( "go_seoul_subtitle" ) );
		to.setGo_seoul_content(request.getParameter("go_seoul_content"));
		to.setGo_seoul_loc(request.getParameter("go_seoul_loc"));
		to.setTel(request.getParameter("tel"));
		to.setAddress(request.getParameter("address"));
		to.setFacilities(request.getParameter("facilities"));
		to.setTraffic_info(request.getParameter("traffic_info"));
		
		flag = dao.trendSeoul_Write_Ok(to);
		
		ModelAndView modelAndView = new ModelAndView("korean/contents_trend_seoul/trend_write_ok");
		modelAndView.addObject("flag", flag);

		return modelAndView;
	}
	
	@RequestMapping("/korean/trend_view.do")
	public ModelAndView view(HttpServletRequest request) {
		to.setGo_seoul_seq(request.getParameter("go_seoul_seq"));
		System.out.println("## seq : " + request.getParameter("go_seoul_seq"));
		
		to = dao.trendSeoul_View(to);
		
		ModelAndView modelAndView = new ModelAndView("korean/contents_trend_seoul/trend_view");
		modelAndView.addObject("to", to);
		
		return modelAndView;
	}
	
	@RequestMapping("/korean/trend_modify.do")
	public ModelAndView modify(HttpServletRequest request) {
	
		to.setGo_seoul_seq( request.getParameter("go_seoul_seq") );
		System.out.println("## seq : " + request.getParameter("go_seoul_seq"));
		
		to = dao.trendSeoul_Modify(to);
		
		ModelAndView modelAndView = new ModelAndView("korean/trend_modify");
		modelAndView.addObject("to", to);
		modelAndView.addObject("go_seoul_seq", to.getGo_seoul_seq());
		
		return modelAndView;
	}
	
	@RequestMapping("/korean/trend_modify_ok.do")
	public ModelAndView modify_ok(HttpServletRequest request, MultipartFile upload) {
		int flag = 1;
		to.setGo_seoul_seq( request.getParameter("go_seoul_seq") );
		to.setGo_seoul_subject(request.getParameter( "go_seoul_subject" ));
		to.setGo_seoul_subtitle(request.getParameter( "go_seoul_subtitle" ) );
		to.setGo_seoul_content(request.getParameter("go_seoul_content"));
		to.setGo_seoul_loc(request.getParameter("go_seoul_loc"));
		
		to.setTel(request.getParameter("tel"));
		to.setAddress(request.getParameter("address"));
		to.setFacilities(request.getParameter("facilities"));
		to.setTraffic_info(request.getParameter("traffic_info"));
		
		System.out.println("## seq : " + request.getParameter("go_seoul_seq"));
		
		flag = dao.trendSeoul_Modify_Ok(to);
		
		ModelAndView modelAndView = new ModelAndView("korean/contents_trend_seoul/trend_modify_ok");
		modelAndView.addObject("flag", flag);
		System.out.println(flag);
		return modelAndView;
	}
	
	@RequestMapping("/korean/trend_delete_ok.do")
	public ModelAndView delete_ok(HttpServletRequest request) {
		to.setGo_seoul_seq(request.getParameter("go_seoul_seq"));
		
		int flag = dao.trendSeoul_Delete_Ok(to);
		
		ModelAndView modelAndView = new ModelAndView("korean/contents_trend_seoul/trend_delete_ok");
		modelAndView.addObject("flag", flag);
		
		return modelAndView;
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
