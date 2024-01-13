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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.gorea.dto_board.Gorea_EditRecommend_BoardTO;
import com.gorea.dto_board.Gorea_EditTip_BoardTO;
import com.gorea.dto_board.Gorea_PagingTO;
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

	/* editRecommend */
	@RequestMapping("/korean/editRecommend_list.do")
	public String editRecommendList(Model model, @RequestParam(defaultValue = "1") int cpage,
	        @RequestParam(defaultValue = "8") int pageSize) {
	    // cpage가 0 이하이면 1로 설정
	    cpage = (cpage <= 0) ? 1 : cpage;

	    if (cpage <= 0) {
	        // cpage가 0 이하인 경우, 1페이지로 리다이렉트
	        return "redirect:/korean/editRecommend_list.do?cpage=1";
	    }

	    int offset = (cpage - 1) * pageSize;

	    List<Gorea_EditRecommend_BoardTO> lists = dao.editRecommend_List(offset, pageSize);

	    for (Gorea_EditRecommend_BoardTO to : lists) {
	        String content = to.getEditrecoContent();
	        String firstImageUrl = extractFirstImageUrl(content);
	        to.setFirstImageUrl(firstImageUrl); // BoardTO에 첫 번째 이미지 URL을 설정

	    }

	    Gorea_PagingTO paging = createPagingModel(lists, cpage);
	    model.addAttribute("paging", paging);

	    // 페이지 번호를 추가하는 부분
	    List<Integer> pageNumbers = new ArrayList<>();
	    for (int i = paging.getFirstPage(); i <= paging.getLastPage(); i++) {
	        pageNumbers.add(i);
	    }
	    model.addAttribute("pageNumbers", pageNumbers);

	    return "contents/contents_edit_recommend/editRecommend_List";
	}

	/**
	 * 페이징 모델을 생성하여 반환하는 메소드
	 *
	 * @param lists  현재 페이지에 표시할 목록
	 * @param cpage  현재 페이지 번호
	 * @return 페이징 모델
	 */
	private Gorea_PagingTO createPagingModel(List<Gorea_EditRecommend_BoardTO> lists, int cpage) {
		Gorea_PagingTO paging = new Gorea_PagingTO();
	    paging.setLists(lists != null ? lists : new ArrayList<>());
	    paging.setTotalRecord(dao.getTotalRowCount());
	    paging.setCpage(cpage);  // 추가: cpage 값을 설정

	    // 수정: pageSetting 호출 전에 cpage 값을 확인하고 필요하다면 수정
	    if (cpage > paging.getTotalPage()) {
	        cpage = paging.getTotalPage();
	    }

	    paging.pageSetting();

	    return paging;
	}


	
	// extractFirstImageUrl 메서드
		private String extractFirstImageUrl(String content) {

			String imageUrl = "";
			Pattern pattern = Pattern.compile("<img[^>]+src\\s*=\\s*['\"]([^'\"]+)['\"][^>]*>");
			Matcher matcher = pattern.matcher(content);

			if (matcher.find()) {
				imageUrl = matcher.group(1);
				imageUrl = imageUrl.replace("/ckImgSubmitForEditRecommend?uid=", "").replace("&amp;fileName=", "_");
				

			} else {
				System.out.println("No image found");
			}
			return imageUrl;
		}

	@RequestMapping("/korean/editRecommend_write.do")
	public ModelAndView editRecommend_Write(HttpServletRequest request, Model model) {
		ModelAndView modelAndView = new ModelAndView("contents/contents_edit_recommend/editRecommend_Write");
		return modelAndView;
	}

	@RequestMapping("/korean/editRecommend_write_ok.do")
	public ModelAndView editRecommend_Write_Ok(HttpServletRequest request, MultipartFile upload) {
		Gorea_EditRecommend_BoardTO to = new Gorea_EditRecommend_BoardTO();
		int flag = 2;

		to.setEditrecoSubject(request.getParameter("editrecoSubject"));
		to.setEditrecoSubtitle(request.getParameter("editrecoSubtitle"));
		to.setEditrecoContent(request.getParameter("editrecoContent"));
		to.setEditrecoWdate(request.getParameter("editrecoWdate"));

		flag = dao.editRecommend_Write_Ok(to);

		ModelAndView modelAndView = new ModelAndView("contents/contents_edit_recommend/editRecommend_Write_Ok");
		modelAndView.addObject("flag", flag);

		return modelAndView;
	}

	@RequestMapping("/korean/editRecommend_view.do")
	public ModelAndView editRecommend_View(HttpServletRequest request) {
		Gorea_EditRecommend_BoardTO to = new Gorea_EditRecommend_BoardTO(); // 객체를 새로 초기화
		to.setEditrecoSeq(request.getParameter("editrecoSeq"));
		to = dao.editRecommend_View(to);

		ModelAndView modelAndView = new ModelAndView("contents/contents_edit_recommend/editRecommend_View");
		modelAndView.addObject("to", to);

		return modelAndView;
	}

	@RequestMapping("/korean/editRecommend_delete_ok.do")
	public ModelAndView editRecommend_Delete_Ok(HttpServletRequest request) {
		Gorea_EditRecommend_BoardTO to = new Gorea_EditRecommend_BoardTO();
		to.setEditrecoSeq(request.getParameter("editrecoSeq"));

		int flag = dao.editRecommend_Delete_Ok(to);

		ModelAndView modelAndView = new ModelAndView("contents/contents_edit_recommend/editRecommend_Delete_Ok");
		modelAndView.addObject("flag", flag);

		return modelAndView;
	}

	@RequestMapping("/korean/editRecommend_modify.do")
	public ModelAndView editRecommend_Modify(HttpServletRequest request) {
	    ModelAndView modelAndView;

	    // 객체 생성 및 초기화
	    Gorea_EditRecommend_BoardTO to = new Gorea_EditRecommend_BoardTO();
	    to.setEditrecoSeq(request.getParameter("editrecoSeq"));

	    
	    // editRecommend_Modify 메서드 호출
	    to = dao.editRecommend_Modify(to);

	    modelAndView = new ModelAndView("contents/contents_edit_recommend/editRecommend_Modify");
	    modelAndView.addObject("to", to);
	    modelAndView.addObject("editrecoSeq", to.getEditrecoSeq());

	    return modelAndView;
	}


	@RequestMapping("/korean/editRecommend_modify_ok.do")
	public ModelAndView editRecommend_Modify_Ok(HttpServletRequest request, MultipartFile upload) {
		Gorea_EditRecommend_BoardTO to = new Gorea_EditRecommend_BoardTO();
		int flag = 1;
		to.setEditrecoSeq(request.getParameter("editrecoSeq"));
		to.setEditrecoSubject(request.getParameter("editrecoSubject"));
		to.setEditrecoSubtitle(request.getParameter("editrecoSubtitle"));
		to.setEditrecoContent(request.getParameter("editrecoContent"));

		flag = dao.editRecommend_Modify_Ok(to);

		ModelAndView modelAndView = new ModelAndView("contents/contents_edit_recommend/editRecommend_Modify_Ok");
		modelAndView.addObject("flag", flag);
		return modelAndView;

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



	/* editTip */

	@RequestMapping("/korean/editTip_list.do")
	public String editTipList(Model model, @RequestParam(defaultValue = "1") int cpage,
		@RequestParam(defaultValue = "8") int pageSize) {
		
		// cpage가 0 이하이면 1로 설정
	    cpage = (cpage <= 0) ? 1 : cpage;

	    if (cpage <= 0) {
	        // cpage가 0 이하인 경우, 1페이지로 리다이렉트
	        return "redirect:/korean/editTip_list.do?cpage=1";
	    }

	    int offset = (cpage - 1) * pageSize;

		List<Gorea_EditTip_BoardTO> lists1 = dao.editTip_List(offset, pageSize);

		for (Gorea_EditTip_BoardTO eto : lists1) {
		   String content = eto.getEdittipContent();
		   String firstImageUrl = extractFirstImageUrl1(content);
		   eto.setFirstImageUrl(firstImageUrl); // BoardTO에 첫 번째 이미지 URL을 설정
		}

		Gorea_PagingTO paging = createPagingModel1(lists1, cpage);

		    model.addAttribute("paging", paging);
		    
		    // 페이지 번호를 추가하는 부분
		    List<Integer> pageNumbers = new ArrayList<>();
		    for (int i = paging.getFirstPage(); i <= paging.getLastPage(); i++) {
		        pageNumbers.add(i);
		    }
		    model.addAttribute("pageNumbers", pageNumbers);

		    return "contents/contents_edit_tip/editTip_List";
		}

		private Gorea_PagingTO createPagingModel1(List<Gorea_EditTip_BoardTO> lists1, int cpage) {
			Gorea_PagingTO paging = new Gorea_PagingTO();
		    paging.setLists1(lists1 != null ? lists1 : new ArrayList<>());
		    paging.setTotalRecord(dao.getTotalCount());
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
		System.out.println("Extracted Image URL2: " + matcher);
		if (matcher.find()) {
			imageUrl = matcher.group(1);
			imageUrl = imageUrl.replace("/ckImgSubmitForEditTip?uid=", "").replace("&amp;fileName=", "_");

		} else {
			System.out.println("No image found");
		}
		return imageUrl;
	}

	@RequestMapping("/korean/editTip_write.do")
	public ModelAndView editTip_Write(HttpServletRequest request, Model model) {
		ModelAndView modelAndView = new ModelAndView("contents/contents_edit_tip/editTip_Write");
		return modelAndView;
	}

	@RequestMapping("/korean/editTip_write_ok.do")
	public ModelAndView editTip_Write_Ok(HttpServletRequest request, MultipartFile upload) {
		Gorea_EditTip_BoardTO eto = new Gorea_EditTip_BoardTO();
		int flag = 2;

		eto.setEdittipSubject(request.getParameter("edittipSubject"));
		eto.setEdittipSubtitle(request.getParameter("edittipSubtitle"));
		eto.setEdittipContent(request.getParameter("edittipContent"));
		eto.setEdittipWdate(request.getParameter("edittipWdate"));

		flag = dao.editTip_Write_Ok(eto);

		ModelAndView modelAndView = new ModelAndView("contents/contents_edit_tip/editTip_Write_Ok");
		modelAndView.addObject("flag", flag);

		return modelAndView;
	}

	@RequestMapping("/korean/editTip_view.do")
	public ModelAndView editTip_View(HttpServletRequest request) {
		Gorea_EditTip_BoardTO eto = new Gorea_EditTip_BoardTO(); // 객체를 새로 초기화
		eto.setEdittipSeq(request.getParameter("edittipSeq"));
		eto = dao.editTip_View(eto);

		System.out.println("content 결과 : " + eto.getEdittipContent());
		ModelAndView modelAndView = new ModelAndView("contents/contents_edit_tip/editTip_View");
		modelAndView.addObject("eto", eto);

		return modelAndView;
	}

	@RequestMapping("/korean/editTip_delete_ok.do")
	public ModelAndView editTip_Delete_Ok(HttpServletRequest request) {
		Gorea_EditTip_BoardTO eto = new Gorea_EditTip_BoardTO();
		eto.setEdittipSeq(request.getParameter("edittipSeq"));

		int flag = dao.editTip_Delete_Ok(eto);

		ModelAndView modelAndView = new ModelAndView("contents/contents_edit_tip/editTip_Delete_Ok");
		modelAndView.addObject("flag", flag);

		return modelAndView;
	}

	@RequestMapping("/korean/editTip_modify.do")
	public ModelAndView editTip_Modify(HttpServletRequest request) {
		Gorea_EditTip_BoardTO eto = new Gorea_EditTip_BoardTO();
		eto.setEdittipSeq(request.getParameter("edittipSeq"));

		eto = dao.editTip_Modify(eto);

		ModelAndView modelAndView = new ModelAndView("contents/contents_edit_tip/editTip_Modify");
		modelAndView.addObject("eto", eto);
		modelAndView.addObject("edittipSeq", eto.getEdittipSeq());

		return modelAndView;
	}

	@RequestMapping("/korean/editTip_modify_ok.do")
	public ModelAndView editTip_Modify_Ok(HttpServletRequest request, MultipartFile upload) {
		Gorea_EditTip_BoardTO eto = new Gorea_EditTip_BoardTO();
		int flag = 1;
		eto.setEdittipSeq(request.getParameter("edittipSeq"));
		eto.setEdittipSubject(request.getParameter("edittipSubject"));
		eto.setEdittipSubtitle(request.getParameter("edittipSubtitle"));
		eto.setEdittipContent(request.getParameter("edittipContent"));

		flag = dao.editTip_Modify_Ok(eto);

		ModelAndView modelAndView = new ModelAndView("contents/contents_edit_tip/editTip_Modify_Ok");
		modelAndView.addObject("flag", flag);
		System.out.println(flag);
		return modelAndView;

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
