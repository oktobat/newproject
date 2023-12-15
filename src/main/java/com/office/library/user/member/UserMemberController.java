package com.office.library.user.member;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/user/member")
public class UserMemberController {

	@Autowired
	UserMemberService userMemberService;
	
	@GetMapping("/createAccountForm")
	public String createAccountForm() {
		String nextPage = "user/member/create_account_form";
		return nextPage;
	}
	
	@PostMapping("/createAccountConfirm")
	public String createAccountConfirm(UserMemberVo userMemberVo) {
		String nextPage = "user/member/create_account_ok";
		
		int result = userMemberService.createAccountConfirm(userMemberVo);
		
		if (result <= 0)
			nextPage = "user/member/create_account_ng";
		
		return nextPage;
		
	}
	
	@GetMapping("/loginForm")
	public String loginForm() {
		String nextPage = "user/member/login_form";
		return nextPage;
	}
	
	@PostMapping("/loginConfirm")	
	public String loginConfirm(UserMemberVo userMemberVo, HttpSession session) {
		System.out.println("[UserMemberController] loginConfirm()");
		
		String nextPage = "user/member/login_ok";
		
		UserMemberVo loginedUserMemberVo = userMemberService.loginConfirm(userMemberVo);
		
		if (loginedUserMemberVo == null) {
			nextPage = "user/member/login_ng";
		} else {
			session.setAttribute("loginedUserMemberVo", loginedUserMemberVo);
			session.setMaxInactiveInterval(60 * 30);
		}
		return nextPage;
	}
	
	/*
	 * ���� ����
	 */
//	@RequestMapping(value = "/modifyAccountForm", method = RequestMethod.GET)
	@GetMapping("/modifyAccountForm")
	public String modifyAccountForm(HttpSession session) {
		System.out.println("[UserMemberController] modifyAccountForm()");
		
		String nextPage = "user/member/modify_account_form";
		
//		UserMemberVo loginedUserMemberVo = (UserMemberVo) session.getAttribute("loginedUserMemberVo");
//		if (loginedUserMemberVo == null)
//			nextPage = "redirect:/user/member/loginForm";
		
		return nextPage;
		
	}
	
	/*
	 * ȸ�� ���� ���� Ȯ��
	 */
	@RequestMapping(value = "/modifyAccountConfirm", method = {RequestMethod.POST, RequestMethod.GET})
//	@PostMapping("/modifyAccountConfirm")
	public String modifyAccountConfirm(UserMemberVo userMemberVo, HttpSession session) {
		
		String nextPage = "user/member/modify_account_ok";
		
		int result = userMemberService.modifyAccountConfirm(userMemberVo);
		
		if (result > 0) {
			UserMemberVo loginedUserMemberVo = userMemberService.getLoginedUserMemberVo(userMemberVo.getU_m_no());
			
			session.setAttribute("loginedUserMemberVo", loginedUserMemberVo);
			session.setMaxInactiveInterval(60 * 30);
			
		} else {
			nextPage = "user/member/modify_account_ng";
			
		}
		
		return nextPage;
		
	}
	
	/*
	 * �α׾ƿ� Ȯ��
	 */
//	@RequestMapping(value = "/logoutConfirm", method = RequestMethod.GET)
	@GetMapping("/logoutConfirm")
	public String logoutConfirm(HttpSession session) {
		
		String nextPage = "redirect:/user";
		session.invalidate();
		return nextPage;
	}
	
	/*
	 * ��й�ȣ ã��
	 */
//	@RequestMapping(value = "/findPasswordForm", method = RequestMethod.GET)
	@GetMapping("/findPasswordForm")
	public String findPasswordForm() {
		System.out.println("[UserMemberController] findPasswordForm()");
		
		String nextPage = "user/member/find_password_form";
		
		return nextPage;
		
	}
	
	/*
	 * ��й�ȣ ã�� Ȯ��
	 */
//	@RequestMapping(value = "/findPasswordConfirm", method = RequestMethod.POST)
	@PostMapping("/findPasswordConfirm")
	public String findPasswordConfirm(UserMemberVo userMemberVo) {
		System.out.println("[UserMemberController] findPasswordConfirm()");
		
		String nextPage = "user/member/find_password_ok";
		
		int result = userMemberService.findPasswordConfirm(userMemberVo);
		
		if (result <= 0)
			nextPage = "user/member/find_password_ng";
		
		return nextPage;
		
	}
	
}
