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

import javax.swing.text.Document;

import org.jsoup.Jsoup;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.gorea.dto_board.Gorea_EditRecommendListTO;
import com.gorea.dto_board.Gorea_EditRecommend_BoardTO;
import com.gorea.dto_board.Gorea_EditTip_BoardTO;
import com.gorea.repository_contents.Gorea_EditDAO;

import java.util.regex.Matcher;
import jakarta.servlet.ServletOutputStream;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Controller
public class Gorea_Edit_Controller {
	@Autowired
	private Gorea_EditDAO dao;

	@Value("${spring.servlet.multipart.location}")
	private String uploadDir;

	@Autowired
	private Gorea_EditRecommend_BoardTO to;


	/* editRecommend */
	@RequestMapping("/korean/editRecommend_list.do")
	public String editRecommendList(Model model, @RequestParam(defaultValue = "1") int cpage,
			@RequestParam(defaultValue = "5") int pageSize) {
		int offset = (cpage <= 0) ? 0 : (cpage - 1) * pageSize;

		List<Gorea_EditRecommend_BoardTO> lists = dao.editRecommend_List(offset, pageSize);

		for (Gorea_EditRecommend_BoardTO to : lists) {
			String content = to.getEditrecoContent();
			String firstImageUrl = extractFirstImageUrl(content);
			to.setFirstImageUrl(firstImageUrl); // BoardTO에 첫 번째 이미지 URL을 설정

			System.out.printf("결과 : %s ", firstImageUrl);
		}
		Gorea_EditRecommendListTO paging = createPagingModel(lists);
		model.addAttribute("paging", paging);

		return "korean/contents_edit_recommend/editRecommend_List";
	}

	// extractFirstImageUrl 메서드
	private String extractFirstImageUrl(String content) {

		System.out.println("content : " + content);
		String imageUrl = "";
		Pattern pattern = Pattern.compile("<img[^>]+src\\s*=\\s*['\"]([^'\"]+)['\"][^>]*>");
		Matcher matcher = pattern.matcher(content);
		System.out.println("Extracted Image URL2: " + matcher);
		if (matcher.find()) {
			imageUrl = matcher.group(1);
			imageUrl = imageUrl.replace("/ckImgSubmitForEditRecommend?uid=", "").replace("&amp;fileName=", "_");
			System.out.println("Extracted Image URL2: " + imageUrl);

		} else {
			System.out.println("No image found");
		}
		return imageUrl;
	}

	private Gorea_EditRecommendListTO createPagingModel(List<Gorea_EditRecommend_BoardTO> lists) {
		Gorea_EditRecommendListTO paging = new Gorea_EditRecommendListTO();
		paging.setLists(lists != null ? lists : new ArrayList<>());
		paging.setTotalRecord(dao.getTotalRowCount());
		paging.pageSetting();
		return paging;

	}

	@RequestMapping("/korean/editRecommend_write.do")
	public ModelAndView editRecommend_Write(HttpServletRequest request, Model model) {
		ModelAndView modelAndView = new ModelAndView("korean/contents_edit_recommend/editRecommend_Write");
		return modelAndView;
	}

	@RequestMapping("/korean/editRecommend_write_ok.do")
	public ModelAndView editRecommend_Write_Ok(HttpServletRequest request, MultipartFile upload) {
		int flag = 2;

		to.setEditrecoSubject(request.getParameter("editrecoSubject"));
		to.setEditrecoSubtitle(request.getParameter("editrecoSubtitle"));
		to.setEditrecoContent(request.getParameter("editrecoContent"));
		to.setEditrecoWdate(request.getParameter("editrecoWdate"));

		flag = dao.editRecommend_Write_Ok(to);

		ModelAndView modelAndView = new ModelAndView("korean/contents_edit_recommend/editRecommend_Write_Ok");
		modelAndView.addObject("flag", flag);

		return modelAndView;
	}

	@RequestMapping("/korean/editRecommend_view.do")
	public ModelAndView editRecommend_View(HttpServletRequest request) {
		Gorea_EditRecommend_BoardTO to = new Gorea_EditRecommend_BoardTO(); // 객체를 새로 초기화
		to.setEditrecoSeq(request.getParameter("editrecoSeq"));
		System.out.println("## editrecoSeq : " + request.getParameter("editrecoSeq"));
		to = dao.editRecommend_View(to);

		System.out.println("content 결과 : " + to.getEditrecoContent());
		ModelAndView modelAndView = new ModelAndView("korean/contents_edit_recommend/editRecommend_View");
		modelAndView.addObject("to", to);

		return modelAndView;
	}

	@RequestMapping("/korean/editRecommend_delete_ok.do")
	public ModelAndView editRecommend_Delete_Ok(HttpServletRequest request) {

		to.setEditrecoSeq(request.getParameter("editrecoSeq"));

		int flag = dao.editRecommend_Delete_Ok(to);

		ModelAndView modelAndView = new ModelAndView("korean/contents_edit_recommend/editRecommend_Delete_Ok");
		modelAndView.addObject("flag", flag);

		return modelAndView;
	}

	@RequestMapping("/korean/editRecommend_modify.do")
	public ModelAndView editRecommend_Modify(HttpServletRequest request) {

		to.setEditrecoSeq(request.getParameter("editrecoSeq"));
		System.out.println("## editrecoSeq : " + request.getParameter("editrecoSeq"));

		to = dao.editRecommend_Modify(to);

		ModelAndView modelAndView = new ModelAndView("korean/contents_edit_recommend/editRecommend_Modify");
		modelAndView.addObject("to", to);
		modelAndView.addObject("editrecoSeq", to.getEditrecoSeq());

		return modelAndView;
	}

	@RequestMapping("/korean/editRecommend_modify_ok.do")
	public ModelAndView editRecommend_Modify_Ok(HttpServletRequest request, MultipartFile upload) {
		int flag = 1;
		to.setEditrecoSeq(request.getParameter("editrecoSeq"));
		to.setEditrecoSubject(request.getParameter("editrecoSubject"));
		to.setEditrecoContent(request.getParameter("editrecoContent"));
		System.out.println("## editrecoSeq : " + request.getParameter("editrecoSeq"));

		flag = dao.editRecommend_Modify_Ok(to);

		ModelAndView modelAndView = new ModelAndView("korean/contents_edit_recommend/editRecommend_Modify_Ok");
		modelAndView.addObject("flag", flag);
		System.out.println(flag);
		return modelAndView;

	}

	// 이미지 업로드
		@RequestMapping(value = "/korean/editRecommend/imageUpload", method = RequestMethod.POST)
		public void imageUploadForEditRecommend(HttpServletRequest request, HttpServletResponse response,
				@RequestParam("upload") MultipartFile upload) {
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

		@RequestMapping(value = "/korean/editRecommend/imageUpdate", method = RequestMethod.POST)
		public void imageUpdateForEditRecommend(HttpServletRequest request, HttpServletResponse response,
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
					String fileUrl = "/ckImgSubmitForEditRecommend?uid=" + uid + "&fileName=" + newFileName;

					printWriter.println(
							"{\"filename\" : \"" + newFileName + "\", \"uploaded\" : 1, \"url\":\"" + fileUrl + "\"}");
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