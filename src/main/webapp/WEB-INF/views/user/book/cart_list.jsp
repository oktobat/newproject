<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<style>
     .cartInfo { text-align:center; margin:20px 0; border-collapse:collapse; width:100% }
     .cartInfo col:nth-child(1) { width:50px }
     .cartInfo col:nth-child(2) { width:100px }
     .cartInfo col:nth-child(3) { width:auto }
     .cartInfo col:nth-child(4) { width:200px }
     .cartInfo col:nth-child(5) { width:150px }
     .cartInfo col:nth-child(6) { width:200px }
     .cartInfo col:nth-child(7) { width:80px }
     .cartInfo th,
     .cartInfo td { border:1px solid #000 }
     .cartInfo thead th { padding:15px 0 }
     .cartInfo tbody td { text-align:center }
     .cartInfo tfoot td { padding:10px 0; text-align:center; font-size:30px;  }
     .cartInfo tbody button { padding:5px 10px; background:#555; color:#fff; }
     .cartInfo tbody input { width:30px; text-align:center; height:30px; margin:3px auto }
     .order { text-align:center; margin:20px 0 }
     .order button { padding:10px 20px; border-radius:10px; font-size:20px; background:#555; color:#fff }
</style>

<table class="cartInfo">
	<colgroup>
       <col>
       <col>
       <col>
       <col>
       <col>
       <col>
       <col>
    </colgroup>
    <thead>
        <tr>
        	<th><input class="allCheck" type="checkbox"></th>
            <th>이미지</th>
            <th>상품명</th>
            <th>판매가</th>
            <th>수량</th>
            <th>합계</th>
            <th>삭제</th>
        </tr>
    </thead>
    <tbody>
      <c:if test="${cartBookVos.size()==0 }">
      		<tr><td colspan="7" style="padding:30px">장바구니가 비어 있습니다.</td></tr>
      </c:if>
	  <c:forEach  var="item" items="${cartBookVos}">
	     <fmt:formatNumber value="${item.bm_price}" type="number" var="bm_price" />
		 <fmt:formatNumber value="${item.bm_price * item.cart_qty}" type="number" var="bm_amount" />
	     <tr data-bmno="${item.bm_no}">
	     	<td><input type="checkbox" checked></td>
            <td><img style="width:100px" src="<c:url value='/libraryUploadImg/${item.bm_photo0}' />"></td>
            <td>${item.bm_name }</td>
            <td class="price" data-price="${item.bm_price}">${bm_price}원</td>
            <td>
            	<button type="button" class="qty__plus">+</button>
            	<input style="width:50px" type="text" value="${item.cart_qty}">
            	<button type="button" class="qty__minus">-</button>
            </td>
            <td class="sub_total" data-sub-total="${item.bm_price*item.cart_qty}">${bm_amount}원</td>
            <td><button type="button" class="remove">삭제</button></td>
	     </tr>
	  </c:forEach>
	</tbody>
    <tfoot>
		<tr>
			<td colspan="7">
				<span class="total"></span>원
				+
				<span class="dfee"></span>
				=
				<span class="all_total"></span>원
			</td>
		</tr>
	</tfoot>
</table>
<div class="order">
	<button type="button">주문하기</button>
	<a href="<c:url value='/book/user/bookMall' />">쇼핑계속하기</a>
</div>


<script>
	total()
	function total(){
		let total = 0;
		jQ(".price").each(function(){
			total += parseInt(jQ(this).attr("data-price")) * parseInt(jQ(this).next().find("input").val())
		})
		jQ('tfoot').find('.total').text(total.toLocaleString())
		jQ('tfoot').find('.dfee').text("5,000원")
		let amount = total + 5000
		jQ('tfoot').find('.all_total').text(amount.toLocaleString())
	}

	jQ(".qty__plus").on("click", function(){
		let bm_no = jQ(this).closest("tr").attr("data-bmno")
		let cart_qty = jQ(this).next().val()
		let price = parseInt(jQ(this).parent().prev().attr("data-price"))
		cart_qty++;
		jQ(this).next().val(cart_qty);
		let toamount = cart_qty*price
		jQ(this).parent().next().text(toamount.toLocaleString()+"원")
		total()
		sqty(user_no, bm_no, cart_qty)
	})
	jQ(".qty__minus").on("click", function(){
		let bm_no = jQ(this).closest("tr").attr("data-bmno");
		let cart_qty = jQ(this).prev().val();
		let price = parseInt(jQ(this).parent().prev().attr("data-price"));
		cart_qty--;
		if (cart_qty==0) cart_qty=1;
		jQ(this).prev().val(cart_qty);
		let toamount = cart_qty*price;
		jQ(this).parent().next().text(toamount.toLocaleString()+"원");
		total();
		sqty(user_no, bm_no, cart_qty);
	})
	
	function sqty(user_no, bm_no, cart_qty){
		jQ.ajax({
			type :"POST",
			contentType : "application/json; charset=UTF-8",
			url : "${pageContext.request.contextPath}/book/user/cartQty/"+user_no,
			data : JSON.stringify({bm_no, cart_qty}),
			success : function(){
			},
			error : function(error){
				console.log(error)
			}
		})
	}
	
	jQ(".remove").on("click", function(){
		let answer = confirm("정말로 삭제하시겠습니까?")
		if (!answer) {
			return false;
		}
		let bm_no = jQ(this).closest("tr").attr("data-bmno")
		jQ.ajax({
			type :"POST",
			contentType : "application/json; charset=UTF-8",
			url : "${pageContext.request.contextPath}/book/user/cartDelete/"+user_no,
			data : JSON.stringify({bm_no}),
			success : function(rdata){
				jQ(".cartBox").html(rdata)
			},
			error : function(error){
				console.log(error)
			}
		})
	})
	
	jQ(".order button").on("click", function(){
		let bm_list = []
		let count = 0
		jQ("tbody input[type=checkbox]").each(function(){
			if (jQ(this).prop("checked")){
				bm_list[count] = jQ(this).closest("tr").attr("data-bmno")
				count++
			}
		})
		if (!count){
			alert("상품을 하나 이상 선택해 주세요.")
			return false;
		}
		if (!user_no){
			location.href = "${pageContext.request.contextPath}/user/member/loginForm"
			return false;
		}

		location.href = "${pageContext.request.contextPath}/book/user/orderForm?bmNos="+bm_list;
		
	})
	
	jQ(".allCheck").on("click", function(){
		if (jQ(this).prop("checked")){
			jQ("tbody input[type=checkbox]").prop("checked", true)
		} else {
			jQ("tbody input[type=checkbox]").prop("checked", false)
		}
	})
	
</script>
