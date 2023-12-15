<%@page import="java.util.List"%>
<%@page import="com.office.library.book.BookVo"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<link href="<c:url value='/resources/css/common/common.css' />" rel="stylesheet" type="text/css">
<link href="<c:url value='/resources/css/admin/full_list_of_books.css' />" rel="stylesheet" type="text/css">

</head>
<body>
    <jsp:include page="../../common/commonjq.jsp" />
	<jsp:include page="../../include/header.jsp" />
	
	<jsp:include page="../include/nav.jsp" />
	
	<section>
		
		<div id="section_wrap">
		
			<div class="word">
			
				<h3>FULL LIST OF BOOKS</h3>
				
			</div>
			
			
			<div class="book_list">
			</div>
			
		</div>
		
	</section>
	
	<jsp:include page="../../include/footer.jsp" />
	
	<script>
	    jQ.ajax({
	        url : "${pageContext.request.contextPath}/book/admin/allBooks",
	        type : "GET",
	        // dataType : "html", // 서버에서 반환되는 데이터형식, 생략하면 jQuery가 자동으로 결정함
	        // contentType : 'application/json; charset=utf-8',  // 서버로 보내는 데이터형식, application/x-www-form-urlencoded; charset=UTF-8
	        success:function(rdata){
	        	console.log(rdata)
	        	jQ('.book_list').html(rdata);
	        },
	        error:function(error){
	        	alert(error)
	        }
		})
	</script>	
	
</body>
</html>