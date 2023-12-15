package com.office.library.admin;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller  // @Controller 어노테이션을 붙이면 servlet-context.xml에서는 이를 인식하여 컨트롤러로 등록함
@RequestMapping("/admin")
public class AdminHomeController {

	@RequestMapping(value = {"", "/"}, method = RequestMethod.GET)
	public String home() {
		System.out.println("[AdminHomeController] home()");
		
		String nextPage = "admin/home";
		
		return nextPage;  // 최종적으로 컨트롤러는 결과를 출력할 뷰와 뷰에 전달할 객체를 담고 있는 Model 객체를 리턴
						  // servlet-context.xml에 ViewResolver는 컨트롤러에서 보내온 view이름을 토대로 view 화면을 찾음
	}

}