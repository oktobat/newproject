<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>판매도서등록</title>
<link href="<c:url value='/resources/css/common/common.css' />" rel="stylesheet" type="text/css">
<link href="<c:url value='/resources/css/admin/mall_book_form.css' />" rel="stylesheet" type="text/css">

</head>
<body>
<jsp:include page="../../common/commonjq.jsp" />
<jsp:include page="../../include/header.jsp" />
	
	<jsp:include page="../include/nav.jsp" />
	
	<section>
		
		<div id="section_wrap">
			<div class="word">
				<h3>판매도서 등록</h3>
			</div>

		<div class="book_mall_form">
			<form name="book_mall_form">
				<input type="text"		name="bm_name" 		placeholder="도서명"> <br>
				<input type="text"		name="bm_author" 	placeholder="저자"> <br>
				<input type="text"		name="bm_publisher"	placeholder="출판사"> <br>
				<input type="text"		name="bm_isbn"		placeholder="ISBN"> <br>
				<input type="text"		name="bm_price"		placeholder="가격"> <br>
				<input type="text"		name="bm_quantity"	placeholder="수량"> <br>
				<input type="file" 		name="bm_photo" 	class="files"> <br>
				<input type="file" 		name="bm_photo" 	class="files"> <br>
				<input type="file" 		name="bm_photo" 	class="files"> <br>
				<input type="button"	value="전송"         onclick="bookMallConfirm()"> 
				<input type="reset"		value="취소">
			</form>
		</div>

</div>
		
	</section>
	
	<jsp:include page="../../include/footer.jsp" />


<script>
   let form = document.book_mall_form;
   
   function bookMallConfirm(){
	   const formData = new FormData();
	   let data = {
			bm_name : form.bm_name.value,
			bm_author: form.bm_author.value,
			bm_publisher:form.bm_publisher.value,
			bm_isbn:form.bm_isbn.value,
			bm_price:form.bm_price.value,
			bm_quantity:form.bm_quantity.value
		}
		
		let fileInput = jQ(".files")
		for (let i=0; i<fileInput.length; i++) {
			if (fileInput[i].files.length>0) {
				for (let j=0; j<fileInput[i].files.length; j++) {
					formData.append("file", jQ('.files')[i].files[j] )
				}
			}
		}
		
		formData.append("key", new Blob([ JSON.stringify(data) ], {type:"application/json"}))
		
		jQ.ajax({
			type :"POST",
			enctype : "multipart/form-data",
			url : "${pageContext.request.contextPath}/book/admin/bookMallConfirm",
			data : formData,
			contentType : false,
			processData : false,
			cache : false,
			success : function(rdata){
				if (rdata.result<0) {
					alert("도서가 등록되지 않았습니다.")
					formData.delete("key");
					formData.delete("file");
				} else {
					form.bm_name.value = "";
					form.bm_author.value = "";
					form.bm_publisher.value = "";
					form.bm_isbn.value = "";
					form.bm_price.value = "";
					form.bm_quantity.value = "";
					form.bm_photo[0].value = "";
					form.bm_photo[1].value = "";
					form.bm_photo[2].value = "";
					formData.delete("key");
					formData.delete("file");
				}
			},
			error : function(error){
				console.log(error)
			}
		})
		
   }
</script>

</body>
</html>