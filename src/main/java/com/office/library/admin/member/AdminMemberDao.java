package com.office.library.admin.member;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import java.sql.ResultSet;
import java.sql.SQLException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import org.springframework.security.crypto.password.PasswordEncoder;

import org.apache.ibatis.session.SqlSession;
import org.springframework.dao.DataAccessException;


@Component
public class AdminMemberDao {

	@Autowired
	JdbcTemplate jdbcTemplate;
	
	@Autowired
	PasswordEncoder passwordEncoder;
	
	@Autowired
	private SqlSession sqlSession;
	
//	public boolean isAdminMember(String a_m_id) {
//		String sql = "select count(*) from tbl_admin_member ";
//		sql += "where a_m_id=?";
//		
//		int result = 0;
//		try {
//			result = jdbcTemplate.queryForObject(sql, Integer.class, a_m_id);
//		} catch(Exception e) {
//			e.printStackTrace();
//		}
//		return result>0 ? true : false;
//	}
	
	public boolean isAdminMember(String a_m_id) throws DataAccessException { 
		int result = 0;
		result = sqlSession.selectOne("mapper.adminMember.idCheck", a_m_id);
		return result > 0 ? true : false;
	}	
	
	
//	public int insertAdminAccount(AdminMemberVo adminMemberVo) {
//		
//		List<String> args = new ArrayList<String>();
//
//		String sql = "insert into tbl_admin_member (";
//		
//		if (adminMemberVo.getA_m_id().equals("superman")) {
//			 sql += "a_m_approval, ";
//			 args.add("1");
//		}
//		
//		sql += "a_m_id, ";
//		args.add(adminMemberVo.getA_m_id());
//		
//		sql += "a_m_pw, ";
//		args.add( passwordEncoder.encode( adminMemberVo.getA_m_pw() ) );
//		
//		sql += "a_m_name, ";
//		args.add(adminMemberVo.getA_m_name());
//		
//		sql += "a_m_gender, ";
//		args.add(adminMemberVo.getA_m_gender());
//		
//		sql += "a_m_part, ";
//		args.add(adminMemberVo.getA_m_part());
//		
//		sql += "a_m_position, ";
//		args.add(adminMemberVo.getA_m_position());
//		
//		sql += "a_m_mail, ";
//		args.add(adminMemberVo.getA_m_mail());
//		
//		sql += "a_m_phone, ";
//		args.add(adminMemberVo.getA_m_phone());
//		
//		sql += "a_m_reg_date, a_m_mod_date) ";
//		
//		if (adminMemberVo.getA_m_id().equals("superman")) {
//			sql += " values(?, ?, ?, ?, ?, ?, ?, ?, ?, now(), now())";
//		} else {
//			sql += " values(?, ?, ?, ?, ?, ?, ?, ?, now(), now())";
//		}
//		int result = -1; 
//		try {
//		 	result = jdbcTemplate.update(sql, args.toArray());
//		} catch(Exception e) {
//			e.printStackTrace();
//		}
//		return result;
//	}
	
	public int insertAdminAccount(AdminMemberVo adminMemberVo) throws DataAccessException { 
		int result = -1;
		adminMemberVo.setA_m_pw(passwordEncoder.encode( adminMemberVo.getA_m_pw()));
		result = sqlSession.insert("mapper.adminMember.insertAdminAccount", adminMemberVo);
		return result;
	}
	
	

// RowMapper<Type> �������̽� : �˻������ ResultSet�� �����ϴ� ������ ��
// mapRow(ResultSet rs, int rowNum) : mapRow() �̿ϼ� �޼��带 �͸�Ŭ���� ������� �����ؼ� �����
//	public AdminMemberVo selectAdmin(AdminMemberVo adminMemberVo) {
//		String sql =  "SELECT * FROM tbl_admin_member WHERE a_m_id = ?";
//		
//		List<AdminMemberVo> adminMemberVos = new ArrayList<>();
//		
//		try {
//			adminMemberVos = jdbcTemplate.query(sql, new RowMapper<AdminMemberVo>() {
//				@Override
//				public AdminMemberVo mapRow(ResultSet rs, int rowNum) throws SQLException {
//					AdminMemberVo adminMemberVo = new AdminMemberVo();
//					adminMemberVo.setA_m_no(rs.getInt("a_m_no"));
//					adminMemberVo.setA_m_approval(rs.getInt("a_m_approval"));
//					adminMemberVo.setA_m_id(rs.getString("a_m_id"));
//					adminMemberVo.setA_m_pw(rs.getString("a_m_pw"));
//					adminMemberVo.setA_m_name(rs.getString("a_m_name"));
//					adminMemberVo.setA_m_gender(rs.getString("a_m_gender"));
//					adminMemberVo.setA_m_part(rs.getString("a_m_part"));
//					adminMemberVo.setA_m_position(rs.getString("a_m_position"));
//					adminMemberVo.setA_m_mail(rs.getString("a_m_mail"));
//					adminMemberVo.setA_m_phone(rs.getString("a_m_phone"));
//					adminMemberVo.setA_m_reg_date(rs.getString("a_m_reg_date"));
//					adminMemberVo.setA_m_mod_date(rs.getString("a_m_mod_date"));
//					return adminMemberVo;
//				}
//			}, adminMemberVo.getA_m_id());
//			
//			if (!passwordEncoder.matches(adminMemberVo.getA_m_pw(), adminMemberVos.get(0).getA_m_pw())){
//				adminMemberVos.clear();
//			}
//				
//			
//		} catch (Exception e) {
//			e.printStackTrace();
//			
//		}
//		
//		return adminMemberVos.size() > 0 ? adminMemberVos.get(0) : null;
//	}
	
	public AdminMemberVo selectAdmin(AdminMemberVo adminMemberVo) throws DataAccessException { 
		List<AdminMemberVo> adminMemberVos = new ArrayList<>();
		adminMemberVos = sqlSession.selectList("mapper.adminMember.selectAdmin", adminMemberVo.getA_m_id());
		if (adminMemberVos != null && adminMemberVos.size()>0) {
			if (!passwordEncoder.matches(adminMemberVo.getA_m_pw(), adminMemberVos.get(0).getA_m_pw())){
				adminMemberVos.clear();
			}
		}
		return adminMemberVos.size() > 0 ? adminMemberVos.get(0) : null;
	}
	
	
	
//	public List<AdminMemberVo> selectAdmins() {
//		String sql =  "SELECT * FROM tbl_admin_member";
//		List<AdminMemberVo> adminMemberVos = new ArrayList<>();
//		
//		try {
//			RowMapper<AdminMemberVo> rowMapper = BeanPropertyRowMapper.newInstance(AdminMemberVo.class);
//			adminMemberVos = jdbcTemplate.query(sql, rowMapper);
//			
//		} catch (Exception e) {
//			e.printStackTrace();
//			
//		}
//		return adminMemberVos;
//	}
	
	public List<AdminMemberVo> selectAdmins() throws DataAccessException { 
		List<AdminMemberVo> adminMemberVos = null;
		adminMemberVos = sqlSession.selectList("mapper.adminMember.selectAdmins");
		return adminMemberVos;
	}
	
	
	
//	���� a_m_no�� ��ġ�ϴ� ���ڵ带 ã�Ƽ� a_m_approval �׸��� ���� 1�� �����Ͻÿ�.
	public int updateAdminAccount(int a_m_no) {
		String sql = "UPDATE tbl_admin_member SET a_m_approval=1 WHERE a_m_no=?";
		int result = -1;
		try {
			result = jdbcTemplate.update(sql, a_m_no);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
//	������ȸ�� ��������
	public int updateAdminAccount(AdminMemberVo adminMemberVo) {
		String sql = "UPDATE tbl_admin_member SET "
				+ "a_m_pw = ?, "
				+ "a_m_name = ?, "
				+ "a_m_gender = ?, "
				+ "a_m_part = ?, "
				+ "a_m_position = ?, "
				+ "a_m_mail = ?, "
				+ "a_m_phone = ?, "
				+ "a_m_mod_date = NOW() "
				+ "WHERE a_m_no = ?";
		int result = -1;
		try {
			result = jdbcTemplate.update(sql, passwordEncoder.encode( adminMemberVo.getA_m_pw() ), 
											  adminMemberVo.getA_m_name(), 
					 						  adminMemberVo.getA_m_gender(), 
					 						  adminMemberVo.getA_m_part(), 
					 						  adminMemberVo.getA_m_position(), 
					 						  adminMemberVo.getA_m_mail(), 
					 						  adminMemberVo.getA_m_phone(), 
					 						  adminMemberVo.getA_m_no());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	
public AdminMemberVo selectAdmin(int a_m_no) {
		
		String sql =  "SELECT * FROM tbl_admin_member "
					+ "WHERE a_m_no = ?";
	
		List<AdminMemberVo> adminMemberVos = new ArrayList<AdminMemberVo>();
		
		try {
			
			adminMemberVos = jdbcTemplate.query(sql, new RowMapper<AdminMemberVo>() {
				
				@Override
				public AdminMemberVo mapRow(ResultSet rs, int rowNum) throws SQLException {
					
					AdminMemberVo adminMemberVo = new AdminMemberVo();
					
					adminMemberVo.setA_m_no(rs.getInt("a_m_no"));
					adminMemberVo.setA_m_id(rs.getString("a_m_id"));
					adminMemberVo.setA_m_pw(rs.getString("a_m_pw"));
					adminMemberVo.setA_m_name(rs.getString("a_m_name"));
					adminMemberVo.setA_m_gender(rs.getString("a_m_gender"));
					adminMemberVo.setA_m_part(rs.getString("a_m_part"));
					adminMemberVo.setA_m_position(rs.getString("a_m_position"));
					adminMemberVo.setA_m_mail(rs.getString("a_m_mail"));
					adminMemberVo.setA_m_phone(rs.getString("a_m_phone"));
					adminMemberVo.setA_m_reg_date(rs.getString("a_m_reg_date"));
					adminMemberVo.setA_m_mod_date(rs.getString("a_m_mod_date"));
					return adminMemberVo;
				}
			}, a_m_no);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return adminMemberVos.size() > 0 ? adminMemberVos.get(0) : null;
	}
	

//public AdminMemberVo selectAdmin(String a_m_id, String a_m_name, String a_m_mail) {
//	String sql =  "SELECT * FROM tbl_admin_member "
//				+ "WHERE a_m_id = ? AND a_m_name = ? AND a_m_mail = ?";
//
//	List<AdminMemberVo> adminMemberVos = new ArrayList<AdminMemberVo>();
//	
//	try {
//		
//		adminMemberVos = jdbcTemplate.query(sql, new RowMapper<AdminMemberVo>() {
//			
//			@Override
//			public AdminMemberVo mapRow(ResultSet rs, int rowNum) throws SQLException {
//				
//				AdminMemberVo adminMemberVo = new AdminMemberVo();
//				
//				adminMemberVo.setA_m_no(rs.getInt("a_m_no"));
//				adminMemberVo.setA_m_id(rs.getString("a_m_id"));
//				adminMemberVo.setA_m_pw(rs.getString("a_m_pw"));
//				adminMemberVo.setA_m_name(rs.getString("a_m_name"));
//				adminMemberVo.setA_m_gender(rs.getString("a_m_gender"));
//				adminMemberVo.setA_m_part(rs.getString("a_m_part"));
//				adminMemberVo.setA_m_position(rs.getString("a_m_position"));
//				adminMemberVo.setA_m_mail(rs.getString("a_m_mail"));
//				adminMemberVo.setA_m_phone(rs.getString("a_m_phone"));
//				adminMemberVo.setA_m_reg_date(rs.getString("a_m_reg_date"));
//				adminMemberVo.setA_m_mod_date(rs.getString("a_m_mod_date"));
//				
//				return adminMemberVo;
//				
//			}
//			
//		}, a_m_id, a_m_name, a_m_mail);
//		
//	} catch (Exception e) {
//		e.printStackTrace();
//		
//	}
//	
//	return adminMemberVos.size() > 0 ? adminMemberVos.get(0) : null;
//	
//}


public AdminMemberVo selectAdmin(String a_m_id, String a_m_name, String a_m_mail) throws DataAccessException { 
	List<AdminMemberVo> adminMemberVos = new ArrayList<AdminMemberVo>();
	Map<String, Object> map = new HashMap<String, Object>();
	map.put("a_m_id", a_m_id);
	map.put("a_m_name", a_m_name);
	map.put("a_m_mail", a_m_mail);
	adminMemberVos = sqlSession.selectList("mapper.adminMember.selectAdminFind", map);
	return adminMemberVos.size()>0 ? adminMemberVos.get(0) : null;   
}


public int updatePassword(String a_m_id, String newPassword) {
	
	String sql =  "UPDATE tbl_admin_member SET "
				+ "a_m_pw = ?,  a_m_mod_date = NOW() "
				+ "WHERE a_m_id = ?";
	
	int result = -1;
	
	try {
		
		result = jdbcTemplate.update(sql, passwordEncoder.encode(newPassword), a_m_id);
		
	} catch (Exception e) {
		e.printStackTrace();
		
	}
			
	return result;
}

	
}
