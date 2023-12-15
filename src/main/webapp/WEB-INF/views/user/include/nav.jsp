<%@ page import="com.office.library.user.member.UserMemberVo" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<link href="<c:url value='/resources/css/user/include/nav.css' />" rel="stylesheet" type="text/css">

<script type="text/javascript">

	function searchBookForm() {
		console.log('searchBookForm() CALLED!!');
		let form = document.search_book_form;
		form.submit();
	}

</script>

<nav>
	<div id="nav_wrap">
	
	<div id="menu_wrap">
		
		<div class="menu">
			<ul>
			    <li><a href="<c:url value='/book/user/cartPage' />">장바구니</a></li>
				<li><a href="<c:url value='/book/user/bookMall' />">판매도서</a></li>
				<li><a href="<c:url value='/book/user/photoReview' />">도서포토후기</a></li>
			</ul>
		</div>
	
	
	    <%
	       UserMemberVo loginedUserMemberVo  = (UserMemberVo) session.getAttribute("loginedUserMemberVo");
	       if (loginedUserMemberVo != null) {
	    %>
	    
	    <div class="menu">
			<ul>
				<li><a href="<c:url value='/user/member/logoutConfirm' />">로그아웃</a></li>
				<li><a href="<c:url value='/user/member/modifyAccountForm' />">정보수정</a></li>
				<li><a href="<c:url value='/book/user/enterBookshelf' />">나의책장</a></li>
				<li><a href="<c:url value='/book/user/orderConfirm' />">주문목록</a></li>
			</ul>
		</div>
	    
	    <% 	   
	       } else {
	    %>
	    
	    <div class="menu">
			<ul>
				<li><a href="<c:url value='/user/member/loginForm' />">로그인</a></li>
				<li><a href="<c:url value='/user/member/createAccountForm' />">회원가입</a></li>
			</ul>
		</div>  
	    
	    <%
	       }
	    %>
		
	</div>	
		
		
		<div class="search">
			<form action="<c:url value='/book/user/searchBookConfirm' />" name="search_book_form" method="get">
				<input type="text" name="b_name" placeholder="Enter the name of the book you are looking for.">
				<input type="submit" value="search">
			</form>
		</div>
	</div>
</nav>