<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>도서등록::도서관서비스</title>

<link href="<c:url value='/resources/css/common/common.css' />" rel="stylesheet" type="text/css">
<link href="<c:url value='/resources/css/admin/register_book_form.css' />" rel="stylesheet" type="text/css">

<script type="text/javascript">

	function registerBookForm() {
		console.log('registerBookForm() CALLED!!');
		let form = document.register_book_form;
		
		let b_name = form.b_name.value;
		let b_author = form.b_author.value;
		let b_publisher = form.b_publisher.value;
		let b_publish_year = form.b_publish_year.value;
		let b_isbn = form.b_isbn.value;
		let b_call_number = form.b_call_number.value;
		let b_rental_able = form.b_rental_able.value;
		
		if (b_name == '') {
			alert('INPUT BOOK NAME.');
			b_name.focus();
		} else if (b_author == '') {
			alert('INPUT BOOK AUTHOR.');
			b_author.focus();
		} else if (b_publisher == '') {
			alert('INPUT BOOK PUBLISHER.');
			b_publisher.focus();
		} else if (b_publish_year == '') {
			alert('INPUT BOOK PUBLISH YEAR.');
			b_publish_year.focus();
		} else if (b_isbn == '') {
			alert('INPUT BOOK ISBN.');
			b_isbn.focus();
		} else if (b_call_number == '') {
			alert('INPUT BOOK CALL NUMBER.');
			b_call_number.focus();
		} else if (b_rental_able == '') {
			alert('SELECT BOOK RANTAL ABLE.');
			b_rantal_able.focus();
		} else {
			form.submit();
		}
		
	}

</script>

</head>
<body>
<jsp:include page="../../common/commonjq.jsp" />
	<jsp:include page="../../include/header.jsp" />
	
	<jsp:include page="../include/nav.jsp" />
	
	<section>
		
		<div id="section_wrap">
			<div class="word">
				<h3>REGISTER BOOK FORM</h3>
			</div>

	
			<div class="register_book_form">
				<form action="<c:url value='/book/admin/registerBookConfirm' />" name="register_book_form" method="post" enctype="multipart/form-data">
					<input type="text" name="b_name" placeholder="INPUT BOOK NAME."> <br>
					<input type="text" name="b_author" placeholder="INPUT BOOK AUTHOR."> <br>
					<input type="text" name="b_publisher" placeholder="INPUT BOOK PUBLISHER."> <br>
					<input type="text" name="b_publish_year" placeholder="INPUT BOOK PUBLISH YEAR."> <br>
					<input type="text" name="b_isbn" placeholder="INPUT BOOK ISBN."> <br>
					<input type="text" name="b_call_number" placeholder="INPUT BOOK CALL NUMBER."> <br>
					<select name="b_rental_able">
						<option value="">SELECT BOOK RENTAL ABLE.</option>
						<option value="0">UNABLE.</option>
						<option value="1">ABLE.</option>
					</select><br>
					<input type="file" name="file"><br>
					<input type="button" value="도서등록" onclick="registerBookForm();"> 
					<input type="reset"	value="취소">
					
				</form>
				
			</div>
		
		</div>
		
	</section>
	
	<jsp:include page="../../include/footer.jsp" />
	
</body>
</html>