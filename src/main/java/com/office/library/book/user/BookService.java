package com.office.library.book.user;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.office.library.book.BookVo;
import com.office.library.book.CartBookVo;
import com.office.library.book.HopeBookVo;
import com.office.library.book.LikeBookVo;
import com.office.library.book.MallBookVo;
import com.office.library.book.OrderDetailVo;
import com.office.library.book.OrderVo;
import com.office.library.book.PhotoReviewVo;
import com.office.library.book.RentalBookVo;
import com.office.library.book.ReviewBookVo;

@Service
public class BookService {

	@Autowired
	BookDao bookDao;

	public List<BookVo> searchBookConfirm(BookVo bookVo) {
		System.out.println("[BookService] searchBookConfirm()");
		
		return bookDao.selectBooksBySearch(bookVo);
		
	}
	
	public BookVo bookDetail(int b_no) {
		System.out.println("[BookService] bookDetail()");
		
		return bookDao.selectBook(b_no);
		
	}
	
	public int rentalBookConfirm(int b_no, int u_m_no) {
		
		int result = bookDao.insertRentalBook(b_no, u_m_no);
		if (result >= 0)
			bookDao.updateRentalBookAble(b_no);
		
		return result;
	}
	
	public List<RentalBookVo> enterBookshelf(int u_m_no) {
		System.out.println("[BookService] enterBookshelf()");
		
		return bookDao.selectRentalBooks(u_m_no);
		
	}
	
	public int requestHopeBookConfirm(HopeBookVo hopeBookVo) {
		System.out.println("[BookService] requestHopeBookConfirm()");
		
		return bookDao.insertHopeBook(hopeBookVo);
		
	}
	
	public List<HopeBookVo> listupRequestHopeBook(int u_m_no) {
		System.out.println("[BookService] listupRequestHopeBook()");
		return bookDao.selectRequestHopeBooks(u_m_no);
		
	}
	
	public List<RentalBookVo> listupRentalBookHistory(int u_m_no) {
		System.out.println("[BookService] listupRentalBookHistory()");
		
		return bookDao.selectRentalBookHistory(u_m_no);
		
	}
	
	public int requestReviewBook(ReviewBookVo reviewBookVo) {
		 return bookDao.insertReviewBook(reviewBookVo);
	}
	
	public int revCountBook(ReviewBookVo reviewBookVo) {
		return bookDao.revCountAddBook(reviewBookVo);
	}
	
	public List<ReviewBookVo> selectReviewBooks(ReviewBookVo reviewBookVo) {
		return bookDao.selectReviewBooks(reviewBookVo);
	}
	
	public int requestReviewBookModify(ReviewBookVo reviewBookVo) {
		return bookDao.requestReviewBookUpdate(reviewBookVo);
	}
	
	public int requestReviewBookDelete(ReviewBookVo reviewBookVo) {
		return bookDao.requestReviewBookDelete(reviewBookVo);
	}
	
	public int revCountMinusBook(ReviewBookVo reviewBookVo){
		return bookDao.revCountMinusBook(reviewBookVo);
	}
	
	public int requestBookLikeCount(LikeBookVo likeBookVo) {
		return bookDao.requestBookLikeCount(likeBookVo);
	}
	
	public int requestBookLikeStatus(LikeBookVo likeBookVo) {
		return bookDao.requestBookLikeStatus(likeBookVo);
	}
	
	public int requestBookLikeInsert(LikeBookVo likeBookVo){
		return bookDao.requestBookLikeInsert(likeBookVo);
	}
	
	public int requestBookLikeDelete(LikeBookVo likeBookVo){
		return bookDao.requestBookLikeDelete(likeBookVo);
	}
	
	public void requestBookBnoLikeCount(int b_no, int count) {
		bookDao.requestBookBnoLikeCount(b_no, count);
	}
	
	public int photoReviewConfirm(PhotoReviewVo photoReviewVo) {
		return bookDao.photoReviewConfirm(photoReviewVo);
	}
	
	public List<PhotoReviewVo> photoReviewAll(int pNum, int scale) {
		return bookDao.photoReviewAll(pNum, scale);
	}
	
	public int photoReviewAll() {
		return bookDao.photoReviewAll();
	}
	
	public List<MallBookVo> mallBookListAll(int pNum, int scale) {
		return bookDao.mallBookListAll(pNum, scale);
	}
	
	public int mallBookListCount() {
		return bookDao.mallBookListCount();
	}
	
	public void cartIn(int bm_no, int user_no) {
		bookDao.cartIn(bm_no, user_no);
	}
	
	public List<CartBookVo> cartSelectUser(int user_no) {
		return bookDao.cartSelectUser(user_no);
	}
	
	public int cartSessionInsert(List<CartBookVo> distinctCartList) {
		return bookDao.cartSessionInsert(distinctCartList);
	}
	
	public int cartInsert(CartBookVo cartBookVo) {
		return bookDao.cartInsert(cartBookVo);
	}
	
	public void updateQty(CartBookVo cartBookVo) {
		bookDao.updateQty(cartBookVo);
	}
	
	public int removeCart(CartBookVo cartBookVo) {
		return bookDao.removeCart(cartBookVo);
	}
	
	public List<CartBookVo> orderList(List<Map<String, Integer>> cartCheckList) {
		return bookDao.orderList(cartCheckList);
	}
	
	public int purchase(OrderVo orderVo) {
		return bookDao.purchase(orderVo);
	}
	
	public int orderDetailInsert(List<OrderDetailVo> orderDetailVos) {
		return bookDao.orderDetailInsert(orderDetailVos);
	}
	
	public void cartDelete(List<CartBookVo> cartBookVos) {
		bookDao.cartDelete(cartBookVos);
	}
	
	public List<OrderVo> orderUserSelect(int u_m_no) {
		return bookDao.orderUserSelect(u_m_no);
	}
	
	public List<OrderVo> orderDetail(int order_no) {
		return bookDao.orderDetail(order_no);
	}
	
	public void inventoryUpdate(List<OrderDetailVo> orderDetailVos) {
		bookDao.inventoryUpdate(orderDetailVos);
	}
	
	public void orderCancel(int order_no) {
		bookDao.orderCancel(order_no);
	}
	
	public PhotoReviewVo itemDetail(int pr_no) {
		bookDao.itemHitCount(pr_no);
		return bookDao.itemDetail(pr_no);
	}
	
}
