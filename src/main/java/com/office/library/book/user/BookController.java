package com.office.library.book.user;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.office.library.book.BookVo;
import com.office.library.book.CartBookVo;
import com.office.library.book.HopeBookVo;
import com.office.library.book.LikeBookVo;
import com.office.library.book.MallBookVo;
import com.office.library.book.OrderDetailVo;
import com.office.library.book.OrderVo;
import com.office.library.book.PageVo;
import com.office.library.book.PhotoReviewVo;
import com.office.library.book.RentalBookVo;
import com.office.library.book.ReviewBookVo;
import com.office.library.user.member.UserMemberVo;

import com.office.library.book.user.util.MultiUploadFileService;


@Controller
@RequestMapping("/book/user")
public class BookController {

	@Autowired
	BookService bookService;
	
	@Autowired
	MultiUploadFileService uploadFileService;

//	@RequestMapping(value = "/searchBookConfirm", method = RequestMethod.GET)
	@GetMapping("/searchBookConfirm")
	public String searchBookConfirm(BookVo bookVo, Model model) {
		String nextPage = "user/book/search_book";
		
		List<BookVo> bookVos = bookService.searchBookConfirm(bookVo);
		
		model.addAttribute("bookVos", bookVos);
		
		return nextPage;
		
	}
	
//	@RequestMapping(value = "/bookDetail", method = RequestMethod.GET)
	@GetMapping("/bookDetail")
	public String bookDetail(@RequestParam("b_no") int b_no, Model model) {
		System.out.println("[UserBookController] bookDetail()");
		
		String nextPage = "user/book/book_detail";
		
		BookVo bookVo = bookService.bookDetail(b_no);
		
		model.addAttribute("bookVo", bookVo);
		
		return nextPage;
		
	}
	
		
//	@RequestMapping(value = "/enterBookshelf", method = RequestMethod.GET)
	@GetMapping("/enterBookshelf")
	public String enterBookshelf(HttpSession session, Model model) {
		
		String nextPage = "user/book/bookshelf";
		
		UserMemberVo loginedUserMemberVo = (UserMemberVo) session.getAttribute("loginedUserMemberVo");
		
		List<RentalBookVo> rentalBookVos = bookService.enterBookshelf(loginedUserMemberVo.getU_m_no());
		
		model.addAttribute("rentalBookVos", rentalBookVos);
		
		return nextPage;
	
	}
	
	@GetMapping("/rentalBookConfirm")
	public String rentalBookConfirm(@RequestParam("b_no") int b_no, HttpSession session) {
		
		String nextPage = "user/book/rental_book_ok";
		
		UserMemberVo loginedUserMemberVo = 
				(UserMemberVo) session.getAttribute("loginedUserMemberVo");

//		if (loginedUserMemberVo == null)
//			return "redirect:/user/member/loginForm";
		
		int result = bookService.rentalBookConfirm(b_no, loginedUserMemberVo.getU_m_no());
		
		if (result <= 0)
			nextPage = "user/book/rental_book_ng";
		
		return nextPage;
		
	}
	
	
	@GetMapping("/requestHopeBookForm")
	public String requestHopeBookForm() {
		System.out.println("[UserBookController] requestHopeBookForm()");
		
		String nextPage = "user/book/request_hope_book_form";
		
		return nextPage;
		
	}
	
	@GetMapping("/requestHopeBookConfirm")
	public String requestHopeBookConfirm(HopeBookVo hopeBookVo, HttpSession session) {
		System.out.println("[UserBookController] requestHopeBookConfirm()");
		
		String nextPage = "user/book/request_hope_book_ok";
		
		UserMemberVo loginedUserMemberVo = (UserMemberVo) session.getAttribute("loginedUserMemberVo");
		hopeBookVo.setU_m_no(loginedUserMemberVo.getU_m_no());
		
		int result = bookService.requestHopeBookConfirm(hopeBookVo);
		
		if (result <= 0)
			nextPage = "user/book/request_hope_book_ng";
		
		return nextPage;
		
	}
	
	
	@GetMapping("/listupRequestHopeBook")
	public String listupRequestHopeBook(HttpSession session, Model model) {
		System.out.println("[UserBookController] listupRequestHopeBook()");
		
		String nextPage = "user/book/list_hope_book";
		
		UserMemberVo loginedUserMemberVo = (UserMemberVo) session.getAttribute("loginedUserMemberVo");
		
		List<HopeBookVo> hopeBookVos = 
				bookService.listupRequestHopeBook(loginedUserMemberVo.getU_m_no());
		
		model.addAttribute("hopeBookVos", hopeBookVos);
		
		return nextPage;
		
	}
	
	@GetMapping("/listupRentalBookHistory")
	public String listupRentalBookHistory(HttpSession session, Model model) {
		
		String nextPage = "user/book/rental_book_history";
		
		UserMemberVo loginedUserMemberVo = (UserMemberVo) session.getAttribute("loginedUserMemberVo");
		
		List<RentalBookVo> rentalBookVos = bookService.listupRentalBookHistory(loginedUserMemberVo.getU_m_no());
		
		model.addAttribute("rentalBookVos", rentalBookVos);
		
		return nextPage;
		
	}
	
	
	@PostMapping("/bookReviewInsert")
	public String bookReviewInsert(@RequestBody ReviewBookVo reviewBookVo, Model model) {
		String nextPage = "user/book/review_list";
		int result = bookService.requestReviewBook(reviewBookVo);
		List<ReviewBookVo> reviewBookVos = null;
		if (result>0) {
			int cntResult = bookService.revCountBook(reviewBookVo);
			reviewBookVos = bookService.selectReviewBooks(reviewBookVo);
		}
		model.addAttribute("reviewBookVos", reviewBookVos);
		return nextPage;
	}
	
	@PostMapping("/bookReviewList")
	public String bookReviewList(@RequestBody ReviewBookVo reviewBookVo, Model model) {
		String nextPage = "user/book/review_list";
		List<ReviewBookVo> reviewBookVos = null;
		reviewBookVos = bookService.selectReviewBooks(reviewBookVo);
		model.addAttribute("reviewBookVos", reviewBookVos);
		return nextPage;
	}
	
	@PostMapping("/bookReviewModify")
	public String bookReviewModify(@RequestBody ReviewBookVo reviewBookVo, Model model) {
		String nextPage = "user/book/review_list";
		int result = bookService.requestReviewBookModify(reviewBookVo);
		List<ReviewBookVo> reviewBookVos = null;
		if (result>0) {
			reviewBookVos = bookService.selectReviewBooks(reviewBookVo);
		}
		model.addAttribute("reviewBookVos", reviewBookVos);
		return nextPage;
	}
	
	
	@PostMapping("/bookReviewDelete")
	public String bookReviewDelete(@RequestBody ReviewBookVo reviewBookVo, Model model) {
		String nextPage = "user/book/review_list";
		int result = bookService.requestReviewBookDelete(reviewBookVo);
		List<ReviewBookVo> reviewBookVos = null;
		if (result>0) {
			int cntResult = bookService.revCountMinusBook(reviewBookVo);
			reviewBookVos = bookService.selectReviewBooks(reviewBookVo);
		}
		model.addAttribute("reviewBookVos", reviewBookVos);
		return nextPage;
	}
	
	
	@ResponseBody
	@PostMapping("/bookReviewCount")
	public Map<String, Integer> bookReviewCount(@RequestBody ReviewBookVo reviewBookVo){
		List<ReviewBookVo> reviewBookVos = null;
		Map<String, Integer> map = new HashMap<>();
		reviewBookVos = bookService.selectReviewBooks(reviewBookVo);
		map.put("revcnt", reviewBookVos.size());
		return map;
	}
	
	@ResponseBody
	@PostMapping("/bookLikeCount")
	public Map<String, Integer> bookLikeCount(@RequestBody LikeBookVo likeBookVo){
		Map<String, Integer> map = new HashMap<>();
		int count = bookService.requestBookLikeCount(likeBookVo);
		map.put("likecnt", count);
		return map;
	}
	
	@ResponseBody
	@PostMapping("/bookLikeStatus")
	public Map<String, Integer> bookLikeStatus(@RequestBody LikeBookVo likeBookVo){
		Map<String, Integer> map = new HashMap<>();
		int count = bookService.requestBookLikeCount(likeBookVo);
		int status = bookService.requestBookLikeStatus(likeBookVo);
		map.put("likecnt", count);
		map.put("status", status);
		return map;
	}
	
	@ResponseBody
	@PostMapping("/bookLikeInsert")
	public Map<String, Integer> bookLikeInsert(@RequestBody LikeBookVo likeBookVo){
		Map<String, Integer> map = new HashMap<>();
		int count = 0;
		int result = bookService.requestBookLikeInsert(likeBookVo);
		if (result>0) {
			count = bookService.requestBookLikeCount(likeBookVo);
			bookService.requestBookBnoLikeCount(likeBookVo.getB_no(), count);
		}
		map.put("likecnt", count);
		return map;
	}
	
	@ResponseBody
	@PostMapping("/bookLikeDelete")
	public Map<String, Integer> bookLikeDelete(@RequestBody LikeBookVo likeBookVo){
		Map<String, Integer> map = new HashMap<>();
		int count = 0;
		int result = bookService.requestBookLikeDelete(likeBookVo);
		System.out.println(result);
		if (result>0) {
			count = bookService.requestBookLikeCount(likeBookVo);
			bookService.requestBookBnoLikeCount(likeBookVo.getB_no(), count);
		}
		map.put("likecnt", count);
		return map;
	}
	
	@GetMapping("/bookMall")
	public String bookMall() {
		String nextPage = "user/book/book_mall";
		return nextPage;
	}
	
	@GetMapping("/photoReview")
	public String photoReview() {
		String nextPage = "user/book/photo_review";
		return nextPage;
	}
	
    
	@RequestMapping(value="/photoReviewInsert", method=RequestMethod.POST)
	public String photoReviewInsert(@RequestPart(value="key") PhotoReviewVo photoReviewVo, @RequestPart(value="file", required=false) List<MultipartFile> files, Model model) {
		List<String> savedFileNames = uploadFileService.multiUpload(files);
		photoReviewVo.setPr_photo(savedFileNames);
		bookService.photoReviewConfirm(photoReviewVo);
		return "redirect:/book/user/photoReviewAll?pageGroup=1&pageNum=1";
	}
	
	
	@GetMapping("/photoReviewAll")
	public String photoReviewAll(@RequestParam("pageGroup") String pageGroup, @RequestParam("pageNum") String pageNum, Model model) {
		String nextPage = "user/book/photo_review_list";
		List<PhotoReviewVo> reviewListAll = new ArrayList<>();
		int pGroup = Integer.parseInt(pageGroup);
		int pNum = Integer.parseInt(pageNum);
		int amount = 2; 
		int pageNums = 10;
		reviewListAll = bookService.photoReviewAll((pNum-1)*amount, amount);
		int totArticles = bookService.photoReviewAll();
		PageVo pageVo = new PageVo(pGroup, pNum, amount, pageNums, totArticles);
		model.addAttribute("reviewListAll", reviewListAll);
		model.addAttribute("pageVo", pageVo);
		return nextPage;
	}
	
	@GetMapping("/mallBookAll")
	public String mallBookAll(@RequestParam("pageGroup") String pageGroup, @RequestParam("pageNum") String pageNum, Model model) {
		String nextPage = "user/book/mall_book_list";
		int pGroup = Integer.parseInt(pageGroup);
		int pNum = Integer.parseInt(pageNum);
		int amount = 2; 
		int pageNums = 10;
		List<MallBookVo> mallBookListAll = null;
		mallBookListAll = bookService.mallBookListAll((pNum-1)*amount, amount);
		int totArticles = bookService.mallBookListCount();
		PageVo pageVo = new PageVo(pGroup, pNum, amount, pageNums, totArticles);
		model.addAttribute("mallBookListAll", mallBookListAll);
		model.addAttribute("pageVo", pageVo);
		return nextPage;
	}
	
	@RequestMapping(value="/cartIn/{user_no}", method = {RequestMethod.POST, RequestMethod.GET})
	public void cartIn(@RequestBody CartBookVo cartBookVo, 
			@PathVariable("user_no") int user_no, HttpSession session) {
		List<CartBookVo> cartBookVos = new ArrayList<>();
		if (user_no>0) {
			if (session.getAttribute("cartList")!=null) {
				cartBookVos = (List<CartBookVo>) session.getAttribute("cartList");
				cartBookVo.setCart_qty(1);
				cartBookVos.add(cartBookVo);
				List<CartBookVo> distinctCartList = removeDuplicates(cartBookVos, user_no);
				session.setAttribute("cartList", distinctCartList);
				int result = bookService.cartSessionInsert(distinctCartList);
				if (result>0) {
					session.removeAttribute("cartList");
				}
			} else {
				cartBookVo.setU_m_no(user_no);
				cartBookVo.setCart_qty(1);
				int result = bookService.cartInsert(cartBookVo);
			}
		} else {
			if (session.getAttribute("cartList")!=null) {
				cartBookVos = (List<CartBookVo>) session.getAttribute("cartList");
				cartBookVo.setCart_qty(1);
				cartBookVos.add(cartBookVo);
				List<CartBookVo> distinctCartList = removeDuplicates(cartBookVos, user_no);
				session.setAttribute("cartList", distinctCartList);
			} else {
				cartBookVo.setCart_qty(1);
				cartBookVos.add(cartBookVo);
				session.setAttribute("cartList", cartBookVos);
				session.setMaxInactiveInterval(60*30);
			}
		}
	}
	
	
	@GetMapping("/cartPage")
	public String cartPage() {
		String nextPage = "user/book/cart_page";
		return nextPage;
	}
	
	
	@RequestMapping(value="/cartList/{user_no}", method = {RequestMethod.POST, RequestMethod.GET})
	public String cartList(@PathVariable("user_no") int user_no, HttpSession session, Model model) {
		String nextPage = "user/book/cart_list";
		List<CartBookVo> cartBookVos = new ArrayList<>();
		if (user_no>0) {
			if (session.getAttribute("cartList")!=null) {
				cartBookVos = (List<CartBookVo>) session.getAttribute("cartList");
//				cartBookVos = removeDuplicates(cartBookVos, user_no);
				for (int i=0; i<cartBookVos.size(); i++) {
					cartBookVos.get(i).setU_m_no(user_no);
				}
				int result = bookService.cartSessionInsert(cartBookVos);
				if (result>0) {
					cartBookVos = bookService.cartSelectUser(user_no);
					session.removeAttribute("cartList");
				}
			} else {
				cartBookVos = bookService.cartSelectUser(user_no);
			}
		} else {
			if (session.getAttribute("cartList")!=null) {
				cartBookVos = (List<CartBookVo>) session.getAttribute("cartList");
			} 
		}
		model.addAttribute("cartBookVos", cartBookVos);
		return nextPage;
	}
	
	@RequestMapping(value="/cartQty/{user_no}", method = {RequestMethod.POST, RequestMethod.GET})
	public void cartQty(@RequestBody CartBookVo cartBookVo, 
			@PathVariable("user_no") int user_no, HttpSession session) {
		List<CartBookVo> cartBookVos = new ArrayList<>();
		if (user_no>0) {
			cartBookVo.setU_m_no(user_no);
			bookService.updateQty(cartBookVo);
		} else {
			cartBookVos = (List<CartBookVo>) session.getAttribute("cartList");
			for (CartBookVo item : cartBookVos) {
				if (item.getBm_no()==cartBookVo.getBm_no()) {
					item.setCart_qty(cartBookVo.getCart_qty());
					break;
				}
			}
			session.setAttribute("cartList", cartBookVos);
		}
	}

	@RequestMapping(value="/cartDelete/{user_no}", method = {RequestMethod.POST, RequestMethod.GET})
	public String cartDelete(@RequestBody CartBookVo cartBookVo, 
			@PathVariable("user_no") int user_no, HttpSession session, Model model) {
		String nextPage = "user/book/cart_list";
		List<CartBookVo> cartBookVos = new ArrayList<>();
		if (user_no>0) {
			cartBookVo.setU_m_no(user_no);
			int result = bookService.removeCart(cartBookVo);
			cartBookVos = bookService.cartSelectUser(user_no);
		} else {
			cartBookVos = (List<CartBookVo>) session.getAttribute("cartList");
			for (CartBookVo item : cartBookVos) {
				if (item.getBm_no()==cartBookVo.getBm_no()) {
					cartBookVos.remove(item);
					break;
				}
			}
			session.setAttribute("cartList", cartBookVos);
		}
		model.addAttribute("cartBookVos", cartBookVos);
		return nextPage;
	}
	
	private List<CartBookVo> removeDuplicates(List<CartBookVo> cartList, int user_no) {
		Set<Integer> bmNos = new HashSet<>();
		List<CartBookVo> distinctCartList = new ArrayList<>();
		
		for (CartBookVo cartBookVo : cartList) {
			if (bmNos.add(cartBookVo.getBm_no())) {
				cartBookVo.setU_m_no(user_no);
				distinctCartList.add(cartBookVo);
			}
		}
		
		return distinctCartList;
	}
	
//	@ResponseBody
//	@PostMapping("/orderRequest")
//	public Map<String, int[]> orderRequest(@RequestBody BmList bmList, Model model) {
//		int[] bmNos = bmList.getBmNos();
//		Map<String, int[]> map = new HashMap<>();
//	    map.put("bmNos", bmNos);
//		return map;	
//	}
//	
//	public static class BmList {
//		private int[] bmNos;
//		public int[] getBmNos() {
//            return bmNos;
//        }
//        public void setBmNos(int[] bmNos) {
//            this.bmNos = bmNos;
//        }
//	}
//	
	
	@RequestMapping("/orderForm")
    public String orderForm(@RequestParam(name="bmNos") String bmNos, Model model) {
		String nextPage = "user/book/order_form";
//		System.out.println(bmNos);
		model.addAttribute("bmNos", bmNos);
        return nextPage; 
    }
	
	@PostMapping("/orderFormList/{bmNos}")
	public String orderFormList(@PathVariable("bmNos") String bmNos, Model model, HttpSession session) {
		String nextPage = "user/book/order_list";
        String[] bmList = bmNos.split(",");
		List<Map<String, Integer>> cartCheckList = new ArrayList<>();
		List<CartBookVo> orderCheckList = new ArrayList<>();
		UserMemberVo loginedUserMemberVo = (UserMemberVo) session.getAttribute("loginedUserMemberVo");
	    for (int i=0; i<bmList.length; i++) {
	    	Map<String, Integer> map = new HashMap<>();
	    	map.put("bm_no", Integer.parseInt(bmList[i]));
	    	map.put("u_m_no", loginedUserMemberVo.getU_m_no());
	    	cartCheckList.add(map);
	    }
	    orderCheckList = bookService.orderList(cartCheckList);
	    model.addAttribute("cartBookVos", orderCheckList);
	    model.addAttribute("bmList", bmList);
	    return nextPage;
	}
	
	@Transactional
	@PostMapping("/purchaseRequest")
	public String puchaseRequest(@ModelAttribute OrderVo orderVo, Model model) {
		List<OrderDetailVo> orderDetailVos = new ArrayList<>();
		List<CartBookVo> cartBookVos = new ArrayList<>();
		List<OrderVo> orderVos = new ArrayList<>();
		
		bookService.purchase(orderVo);
		
		for (int i=0; i<orderVo.getOrder_nos().size(); i++) {
			int order_no = orderVo.getOrder_no();
			int order_nos = orderVo.getOrder_nos().get(i);
            int order_qtys = orderVo.getOrder_qtys().get(i);
            OrderDetailVo newOrderDetailVo = new OrderDetailVo();
            newOrderDetailVo.setOrder_no(order_no);
            newOrderDetailVo.setBm_no(order_nos);
            newOrderDetailVo.setOrder_qty(order_qtys);
            orderDetailVos.add(newOrderDetailVo);
		}
		bookService.orderDetailInsert(orderDetailVos);
		bookService.inventoryUpdate(orderDetailVos);
		
		for (int i=0; i<orderVo.getOrder_nos().size(); i++) {
            int u_m_no = orderVo.getU_m_no();
			int order_nos = orderVo.getOrder_nos().get(i);
			CartBookVo newCartBookVo = new CartBookVo();
			newCartBookVo.setU_m_no(u_m_no);
            newCartBookVo.setBm_no(order_nos);
            cartBookVos.add(newCartBookVo);
		}
	    bookService.cartDelete(cartBookVos);
	    
	    return "redirect:/book/user/orderConfirm";
	}
	
	@GetMapping("/orderConfirm")
	public String orderConfirm(HttpSession session, Model model) {
		String nextPage = "user/book/order_confirm";
		List<OrderVo> orderVos = new ArrayList<>();
		UserMemberVo loginedUserMemberVo = (UserMemberVo) session.getAttribute("loginedUserMemberVo");
		orderVos = bookService.orderUserSelect(loginedUserMemberVo.getU_m_no());
		model.addAttribute("orderVos", orderVos);
		return nextPage;
	}
	
	@GetMapping("/orderDetail")
	public String orderDetail(@RequestParam("order_no") int order_no, Model model) {
		String nextPage = "user/book/order_detail";
		List<OrderVo> orderVos = new ArrayList<>();
		orderVos = bookService.orderDetail(order_no);
		model.addAttribute("orderVos", orderVos);
		return nextPage;
	}
	
	@PostMapping("/orderCancel")
	public String orderCancel(@RequestParam("order_no") int order_no) {
		bookService.orderCancel(order_no);
		return "redirect:/book/user/orderConfirm";
	}
	
	@GetMapping("/reviewDetail")
	public String reviewDetail(@RequestParam("pr_no") int pr_no, PhotoReviewVo photoReviewVo, Model model) {
		String nextPage = "user/book/review_detail";
		photoReviewVo = bookService.itemDetail(pr_no);
		model.addAttribute("photoReviewVo", photoReviewVo);
		return nextPage;
	}
	
	
}
