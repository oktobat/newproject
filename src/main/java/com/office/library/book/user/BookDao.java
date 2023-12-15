package com.office.library.book.user;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Component;

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

import org.apache.ibatis.session.SqlSession;
import org.springframework.dao.DataAccessException;

@Component
public class BookDao {

	@Autowired
	JdbcTemplate jdbcTemplate;
	
	@Autowired
	private SqlSession sqlSession;
	
	public List<BookVo> selectBooksBySearch(BookVo bookVo) throws DataAccessException { 
		List<BookVo> bookVos = null;
		bookVos = sqlSession.selectList("mapper.book.selectBooks", bookVo);
		return bookVos.size() > 0 ? bookVos : null;
	}	
	
	public BookVo selectBook(int b_no) {
		System.out.println("[BookDao] selectBook()");
		
		String sql = "SELECT * FROM tbl_book WHERE b_no = ?";
		
		List<BookVo> bookVos = null;
		
		try {
			
			RowMapper<BookVo> rowMapper = BeanPropertyRowMapper.newInstance(BookVo.class);
			bookVos = jdbcTemplate.query(sql, rowMapper, b_no);
			
		} catch (Exception e) {
			e.printStackTrace();
			
		}
		
		return bookVos.size() > 0 ? bookVos.get(0) : null;
		
	}
	
	
	public int insertRentalBook(int b_no, int u_m_no) {
		
		String sql =  "INSERT INTO tbl_rental_book(b_no, u_m_no, rb_start_date, rb_reg_date, rb_mod_date) "
					+ "VALUES(?, ?, NOW(), NOW(), NOW())";
		
		int result = -1;
		
		try {
			
			result = jdbcTemplate.update(sql, b_no, u_m_no);
			
		} catch (Exception e) {
			e.printStackTrace();
			
		}
		
		return result;
		
	}
	
	
	public void updateRentalBookAble(int b_no) {
		
		String sql =  "UPDATE tbl_book "
					+ "SET b_rental_able = 0 "
					+ "WHERE b_no = ?";
		
		try {
			
			jdbcTemplate.update(sql, b_no);
			
		} catch (Exception e) {
			e.printStackTrace();
			
		}
		
	}
	
	
	public List<RentalBookVo> selectRentalBooks(int u_m_no) {
		System.out.println("[BookDao] selectRentalBooks()");
		
		String sql =  "SELECT * FROM tbl_rental_book rb "
					+ "JOIN tbl_book b "
					+ "ON rb.b_no = b.b_no "
					+ "JOIN tbl_user_member um "
					+ "ON rb.u_m_no = um.u_m_no "
					+ "WHERE rb.u_m_no = ? AND rb.rb_end_date = '1000-01-01'";
		
		List<RentalBookVo> rentalBookVos = new ArrayList<RentalBookVo>();
		
		try {
			RowMapper<RentalBookVo> rowMapper = BeanPropertyRowMapper.newInstance(RentalBookVo.class);
			rentalBookVos = jdbcTemplate.query(sql, rowMapper, u_m_no);
			
		} catch (Exception e) {
			e.printStackTrace();
			
		}
		
		return rentalBookVos;
		
	}
	
	public int insertHopeBook(HopeBookVo hopeBookVo) {
		System.out.println("[BookDao] insertHopeBook()");
		
		String sql =  "INSERT INTO tbl_hope_book(u_m_no, hb_name, hb_author, hb_publisher, "
					+ "hb_publish_year, hb_reg_date, hb_mod_date, hb_result_last_date) "
					+ "VALUES(?, ?, ?, ?, ?, NOW(), NOW(), NOW())";
		
		int result = -1;
		
		try {
			
			result = jdbcTemplate.update(sql, 
											hopeBookVo.getU_m_no(), 
											hopeBookVo.getHb_name(), 
											hopeBookVo.getHb_author(), 
											hopeBookVo.getHb_publisher(), 
											hopeBookVo.getHb_publish_year());
			
		} catch (Exception e) {
			e.printStackTrace();
			
		}
		
		return result;
		
	}
	
	
	public List<HopeBookVo> selectRequestHopeBooks(int u_m_no) {
		System.out.println("[BookDao] insertHopeBook()");
		
		String sql = "SELECT * FROM tbl_hope_book WHERE u_m_no = ?";
		
		List<HopeBookVo> hopeBookVos = null;
		
		try {
			
			RowMapper<HopeBookVo> rowMapper = BeanPropertyRowMapper.newInstance(HopeBookVo.class);
			hopeBookVos = jdbcTemplate.query(sql, rowMapper, u_m_no);
			
		} catch (Exception e) {
			e.printStackTrace();
			
		}
		
		return hopeBookVos;
		
	}
	
	public List<RentalBookVo> selectRentalBookHistory(int u_m_no) {
		System.out.println("[BookDao] selectRentalBooks()");
		
		String sql =  "SELECT * FROM tbl_rental_book rb "
					+ "JOIN tbl_book b "
					+ "ON rb.b_no = b.b_no "
					+ "JOIN tbl_user_member um "
					+ "ON rb.u_m_no = um.u_m_no "
					+ "WHERE rb.u_m_no = ? "
					+ "ORDER BY rb.rb_reg_date DESC";
		
		List<RentalBookVo> rentalBookVos = new ArrayList<RentalBookVo>();
		
		try {
			
			RowMapper<RentalBookVo> rowMapper = BeanPropertyRowMapper.newInstance(RentalBookVo.class);
			rentalBookVos = jdbcTemplate.query(sql, rowMapper, u_m_no);
			
		} catch (Exception e) {
			e.printStackTrace();
			
		}
		
		return rentalBookVos;
		
	}
	
	public int insertReviewBook(ReviewBookVo reviewBookVo) throws DataAccessException {
		int result = -1;
		result = sqlSession.insert("mapper.book.insertReviewBook", reviewBookVo);
		return result;
	}
	
	public int revCountAddBook(ReviewBookVo reviewBookVo) throws DataAccessException {
		int result = -1;
		result = sqlSession.update("mapper.book.revCountUpdate", reviewBookVo);
		return result;
	}
	
	public List<ReviewBookVo> selectReviewBooks(ReviewBookVo reviewBookVo) throws DataAccessException {
		List<ReviewBookVo> reviewBookVos = null;
		reviewBookVos = sqlSession.selectList("mapper.book.selectBnoReview", reviewBookVo);
		return reviewBookVos.size() > 0 ? reviewBookVos : null;
	}
	
	public int requestReviewBookUpdate(ReviewBookVo reviewBookVo) throws DataAccessException {
		int result = -1;
		result = sqlSession.update("mapper.book.reviewBookUpdate", reviewBookVo);
		return result;
	}
	
	public int requestReviewBookDelete(ReviewBookVo reviewBookVo) throws DataAccessException {
		int result = -1;
		result = sqlSession.delete("mapper.book.reviewBookDelete", reviewBookVo);
		return result;
	}
	
	public int revCountMinusBook(ReviewBookVo reviewBookVo) throws DataAccessException {
		int result = -1;
		result = sqlSession.update("mapper.book.revCountMinusUpdate", reviewBookVo);
		return result;
	}
	
	public int requestBookLikeCount(LikeBookVo likeBookVo) throws DataAccessException {
		int result = -1;
		result = sqlSession.selectOne("mapper.book.requestBookLikeCount", likeBookVo);
		return result;
	}
	
	public int requestBookLikeStatus(LikeBookVo likeBookVo) throws DataAccessException {
		int result = -1;
		result = sqlSession.selectOne("mapper.book.requestBookLikeStatus", likeBookVo);
		return result;
	}
	
	public int requestBookLikeInsert(LikeBookVo likeBookVo) throws DataAccessException {
		int result = -1;
		result = sqlSession.insert("mapper.book.requestBookLikeInsert", likeBookVo);
		return result;
	}
	
	public int requestBookLikeDelete(LikeBookVo likeBookVo) throws DataAccessException {
		int result = -1;
		result = sqlSession.insert("mapper.book.requestBookLikeDelete", likeBookVo);
		return result;
	}
	
	public int requestBookBnoLikeCount(int b_no, int count) throws DataAccessException {
		int result = -1;
		Map<String, Integer> map = new HashMap<>();
		map.put("b_no", b_no);
		map.put("count", count);
		result = sqlSession.update("mapper.book.requestBookBnoLikeCountUpdate", map);
		return result;
	}
	
	public int photoReviewConfirm(PhotoReviewVo photoReviewVo) throws DataAccessException {
		int result = -1;
		result = sqlSession.insert("mapper.book.photoReviewConfirm", photoReviewVo);
		return result;
	}
	
	public List<PhotoReviewVo> photoReviewAll(int pNum, int scale) {
		List<PhotoReviewVo> reviewListAll = null;
		Map<String, Integer> map = new HashMap<>();
		map.put("pNum", pNum);
		map.put("scale", scale);
		reviewListAll = sqlSession.selectList("mapper.book.photoReviewAll", map);
		return reviewListAll;
	}
	
	public int photoReviewAll() {
		int result = -1;
		result = sqlSession.selectOne("mapper.book.photoReviewCount");
		return result;
	}
	
	public List<MallBookVo> mallBookListAll(int pNum, int scale) {
		List<MallBookVo> mallBookListAll = null;
		Map<String, Integer> map = new HashMap<>();
		map.put("pNum", pNum);
		map.put("scale", scale);
		mallBookListAll = sqlSession.selectList("mapper.book.mallBookListAll", map);
		return mallBookListAll;
	}
	
	public int mallBookListCount() {
		int result = -1;
		result = sqlSession.selectOne("mapper.book.mallBookListCount");
		return result;
	}
	
	public void cartIn(int bm_no, int user_no) {
		Map<String, Integer> map = new HashMap<>();
		map.put("bm_no", bm_no);
		map.put("user_no", user_no);
		sqlSession.insert("mapper.book.cartInsert", map);
	}
	
	public List<CartBookVo> cartSelectUser(int user_no) {
		List<CartBookVo> cartBookVos = new ArrayList<>();
		cartBookVos = sqlSession.selectList("mapper.book.cartSelectUser", user_no);
		return cartBookVos;
	}
	
	public int cartSessionInsert(List<CartBookVo> distinctCartList) {
		int result = -1;
		result = sqlSession.insert("mapper.book.cartSessionInsert", distinctCartList);
		return result;
	}
	
	public int cartInsert(CartBookVo cartBookVo) {
		int result = -1;
		result = sqlSession.insert("mapper.book.cartInsertLogin", cartBookVo);
		return result;
	}
	
	public void updateQty(CartBookVo cartBookVo) {
		sqlSession.update("mapper.book.updateQty", cartBookVo);
	}

	public int removeCart(CartBookVo cartBookVo) {
		int result = -1;
		result = sqlSession.delete("mapper.book.removeCart", cartBookVo);
		return result;
	}
	
	public List<CartBookVo> orderList(List<Map<String, Integer>> cartCheckList) {
		List<CartBookVo> orderResultList = new ArrayList<>();
		orderResultList = sqlSession.selectList("mapper.book.orderList", cartCheckList);
		return orderResultList;
	}
	
	public int purchase(OrderVo orderVo) throws DataAccessException {
		int result = -1;
		result = sqlSession.insert("mapper.book.purchase", orderVo);
		return result;
	}
	
	public int orderDetailInsert(List<OrderDetailVo> orderDetailVos) {
		int result = -1;
		result = sqlSession.insert("mapper.book.orderDetailInsert", orderDetailVos);
		return result;
	}

	public int cartDelete(List<CartBookVo> cartBookVos) {
		int result = -1;
		result = sqlSession.delete("mapper.book.cartDelete", cartBookVos);
		return result;
	}
	
	public List<OrderVo> orderUserSelect(int u_m_no) {
		List<OrderVo> orderVos = new ArrayList<>(); 
		orderVos = sqlSession.selectList("mapper.book.orderUserSelect", u_m_no);
		return orderVos;
	}
	
	public List<OrderVo> orderDetail(int order_no) {
		List<OrderVo> orderVos = new ArrayList<>();
		orderVos = sqlSession.selectList("mapper.book.orderDetail", order_no);
		return orderVos;
	}
	
	public void inventoryUpdate(List<OrderDetailVo> orderDetailVos) {
		for (int i=0; i<orderDetailVos.size(); i++) {
			sqlSession.update("mapper.book.inventoryUpdate", orderDetailVos.get(i));
		}
	}
	
	public void orderCancel(int order_no) {
		sqlSession.delete("mapper.book.orderCancel", order_no);
	}
	
	public void itemHitCount(int pr_no) {
		sqlSession.update("mapper.book.itemHit", pr_no);
	}
	
	public PhotoReviewVo itemDetail(int pr_no) {
		List<PhotoReviewVo> photoReviewVos = new ArrayList<>();
		photoReviewVos = sqlSession.selectList("mapper.book.itemDetail", pr_no);
		return photoReviewVos.size()>0 ? photoReviewVos.get(0) : null; 
	}
	
	
}
