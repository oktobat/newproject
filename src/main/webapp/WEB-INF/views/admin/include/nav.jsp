<%@ page import="com.office.library.admin.member.AdminMemberVo" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<link href="<c:url value='/resources/css/admin/include/nav.css' />" rel="stylesheet" type="text/css">

<script type="text/javascript">

	function searchBookForm() {
		console.log('searchBookForm() CALLED!!');
		
		let form = document.search_book_form;
		
		if (form.b_name.value == '') {
			alert('Enter the name of the book you are looking for.');
			form.b_name.focus();
			
		} else {
			form.submit();
			
		}
		
	}

</script>


<nav>
	<div id="nav_wrap">
	
	    <%
	       AdminMemberVo loginedAdminMemberVo  = (AdminMemberVo) session.getAttribute("loginedAdminMemberVo");
	       if (loginedAdminMemberVo != null) {
	    %>
	    
	    <div class="menu">
			<ul>
				<li><a href="<c:url value='/admin/member/logoutConfirm' />">로그아웃</a></li>
				<li><a href="<c:url value='/admin/member/modifyAccountForm' />">정보수정</a></li>
				
				<c:if test="${loginedAdminMemberVo.a_m_id == 'superman'}">
					<li><a href="<c:url value='/admin/member/listupAdmin' />">관리자목록</a></li>
				</c:if>
				
				<li><a href="<c:url value='/book/admin/getRentalBooks' />">대출도서</a></li>
				<li><a href="<c:url value='/book/admin/getHopeBooks' />">희망도서(입고처리)</a></li>
				<li><a href="<c:url value='/book/admin/getAllBooks' />">전체도서</a></li>
				<li><a href="<c:url value='/book/admin/registerBookForm' />">도서등록</a></li>
				<li><a href="<c:url value='/book/user/bookMall' />">판매도서리스트</a></li>
				<li><a href="<c:url value='/book/admin/mallBookForm' />">판매도서등록</a></li>
			</ul>
		</div>
	    
	    <% 	   
	       } else {
	    %>
	    
	    <div class="menu">
			<ul>
				<li><a href="<c:url value='/admin/member/loginForm' />">로그인</a></li>
				<li><a href="<c:url value='/admin/member/createAccountForm' />">회원가입</a></li>
			</ul>
		</div>  
	    
	    <%
	       }
	    %>
	
		
		
		<div class="search">
			<form action="<c:url value='/book/admin/searchBookConfirm' />" name="search_book_form" method="get">
				<input type="text" name="b_name" placeholder="검색할 도서명을 입력하세요.">
				<input type="button" value="search" onclick="searchBookForm();">
			</form>
		</div>
	</div>
</nav>