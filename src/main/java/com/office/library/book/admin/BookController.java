package com.office.library.book.admin;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.io.File;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.office.library.admin.member.AdminMemberVo;
import com.office.library.book.BookVo;
import com.office.library.book.HopeBookVo;
import com.office.library.book.MallBookVo;
import com.office.library.book.RentalBookVo;
import com.office.library.book.admin.util.UploadFileService;
import com.office.library.book.user.util.MultiUploadFileService;

@Controller
@RequestMapping("/book/admin")
public class BookController {

	@Autowired
	BookService bookService;
	
	@Autowired
	UploadFileService uploadFileService;
	
	@Autowired
	MultiUploadFileService multiUploadFileService;
	
	@GetMapping("/registerBookForm")
	public String registerBookForm() {
		String nextPage = "admin/book/register_book_form";
		return nextPage;
	}
	
	
	@PostMapping("/registerBookConfirm")
	public String registerBookConfirm(BookVo bookVo, @RequestParam("file") MultipartFile file) {
		String nextPage = "admin/book/register_book_ok";
		String savedFileName = "";
		if (!file.isEmpty()) {
			savedFileName = uploadFileService.upload(file);
			if (savedFileName != null) {
				bookVo.setB_thumbnail(savedFileName);
			}
		}
		int result = bookService.registerBookConfirm(bookVo);
		if (result <= 0) {
				nextPage = "admin/book/register_book_ng";
		} else {
			nextPage = "admin/book/register_book_ng";
		}
		return nextPage;
	}
	
	
	@GetMapping("/searchBookConfirm")
	public String searchBookConfirm(BookVo bookVo, Model model) {
		String nextPage = "admin/book/search_book";
		List<BookVo> bookVos = bookService.searchBookConfirm(bookVo);
		model.addAttribute("bookVos", bookVos);
		return nextPage;
	}
	
	
	@GetMapping("/bookDetail")
	public String bookDetail(@RequestParam("b_no") int b_no, Model model) {
		String nextPage = "admin/book/book_detail";
		BookVo bookVo = bookService.bookDetail(b_no);
		model.addAttribute("bookVo", bookVo);
		return nextPage;
	}
	
	
	@GetMapping("/modifyBookForm")
	public String modifyBookForm(@RequestParam("b_no") int b_no, 
								 Model model, 
								 HttpSession session) {
		String nextPage = "admin/book/modify_book_form";
		AdminMemberVo loginedAdminMemberVo = (AdminMemberVo) session.getAttribute("loginedAdminMemberVo");
		if (loginedAdminMemberVo == null)
			return "redirect:/admin/member/loginForm";
		
		BookVo bookVo = bookService.modifyBookForm(b_no);
		model.addAttribute("bookVo", bookVo);
		return nextPage;
	}
	
	@PostMapping("/modifyBookConfirm")
	public String modifyBookConfirm(BookVo bookVo, 
									@RequestParam("file") MultipartFile file, 
									HttpSession session) {
		String nextPage = "admin/book/modify_book_ok";
		
		AdminMemberVo loginedAdminMemberVo = (AdminMemberVo) session.getAttribute("loginedAdminMemberVo");
		if (loginedAdminMemberVo == null)
			return "redirect:/admin/member/loginForm";
		
		if (!file.getOriginalFilename().equals("")) {
			String savedFileName = uploadFileService.upload(file);
			if (savedFileName != null)
				bookVo.setB_thumbnail(savedFileName);
		}
		
		int result = bookService.modifyBookConfirm(bookVo);
		
		if (result <= 0)
			nextPage = "admin/book/modify_book_ng";
		return nextPage;
	}
	
	@GetMapping("/deleteBookConfirm")
	public String deleteBookConfirm(@RequestParam("thumbnail") String b_thumbnail,
									@RequestParam("no") int b_no,
									HttpSession session) {
		String nextPage = "admin/book/delete_book_ok";
		AdminMemberVo loginedAdminMemberVo = (AdminMemberVo) session.getAttribute("loginedAdminMemberVo");
		if (loginedAdminMemberVo == null)
			return "redirect:/admin/member/loginForm";
		int result = bookService.deleteBookConfirm(b_no);
		String deleteFile = "C:\\library\\upload\\"+b_thumbnail;
		if (result <= 0) {
			nextPage = "admin/book/delete_book_ng";
		} else {
			File file = new File(deleteFile);
			file.delete();
		}
		return nextPage;
	}
	
	
	@GetMapping("/getAllBooks")
	public String getAllBooks() {
		String nextPage = "admin/book/full_list_of_books";
		return nextPage;
	}
	
	@RequestMapping(value="/allBooks", method= {RequestMethod.POST, RequestMethod.GET})
	public String allBooks(Model model) {
		List<BookVo> bookVos = bookService.getAllBooks();
		model.addAttribute("bookVos", bookVos);
		return "admin/book/allBookList";
	}
	
	
	@GetMapping("/getHopeBooks")
	public String getHopeBooks(Model model) {
		String nextPage = "admin/book/hope_books";
		List<HopeBookVo> hopeBookVos = bookService.getHopeBooks();
		model.addAttribute("hopeBookVos", hopeBookVos);
		return nextPage;
	}
	
	@GetMapping("/registerHopeBookForm")
	public String registerHopeBookForm(HopeBookVo hopeBookVo, Model model) {
		String nextPage = "admin/book/register_hope_book_form";
		model.addAttribute("hopeBookVo", hopeBookVo);
		return nextPage;
	}
	
	@PostMapping("/registerHopeBookConfirm")
	public String registerHopeBookConfirm(BookVo bookVo, 
										  @RequestParam("hb_no") int hb_no, 
										  @RequestParam("file") MultipartFile file) {
		String nextPage = "admin/book/register_book_ok";

		String savedFileName = uploadFileService.upload(file);
		if (savedFileName != null) {
			bookVo.setB_thumbnail(savedFileName);
			int result = bookService.registerHopeBookConfirm(bookVo, hb_no);
			if (result <= 0)
				nextPage = "admin/book/register_book_ng";
		} else {
			nextPage = "admin/book/register_book_ng";
		}
		return nextPage;

	}
	
	@GetMapping("/getRentalBooks")
	public String getRentalBooks(Model model) {
		String nextPage = "admin/book/rental_books";
		List<RentalBookVo> rentalBookVos = bookService.getRentalBooks();
		model.addAttribute("rentalBookVos", rentalBookVos);
		return nextPage;
	}
	
	@GetMapping("/returnBookConfirm")
	public String returnBookConfirm(@RequestParam("b_no") int b_no, 
									@RequestParam("rb_no") int rb_no) {
		String nextPage = "admin/book/return_book_ok";
		int result = bookService.returnBookConfirm(b_no, rb_no);
		if (result <= 0)
			nextPage = "admin/book/return_book_ng";
		return nextPage;
	}
	
	@GetMapping("/mallBookForm")
	public String mallBookForm() {
		String nextPage = "admin/book/mall_book_form";
		return nextPage;
	}
	
	@ResponseBody
	@RequestMapping(value="/bookMallConfirm", method=RequestMethod.POST)
	public Map<String, Integer> bookMallConfirm(@RequestPart(value="key") MallBookVo mallBookVo, @RequestPart(value="file", required=false) List<MultipartFile> files, Model model) {
		List<String> savedFileNames = multiUploadFileService.multiUpload(files);
		mallBookVo.setBm_photo(savedFileNames);
		int result = bookService.bookMallConfirm(mallBookVo);
		Map<String, Integer> map = new HashMap<>();
		map.put("result", result);
		return map;
	}
	
}
