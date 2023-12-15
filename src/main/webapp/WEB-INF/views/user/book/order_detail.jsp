<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="<c:url value='/resources/css/common/common.css' />" rel="stylesheet" type="text/css">
<link href="<c:url value='/resources/css/user/order_detail.css' />" rel="stylesheet" type="text/css">

</head>
<body>
<jsp:include page="../../common/commonjq.jsp" />
	<jsp:include page="../../include/header.jsp" />
	<jsp:include page="../include/nav.jsp" />
	
	<section>
	<div class="myhanbit_wrap">
    <h3 class="ord_num">주문번호 : ${orderVos.get(0).getOrder_no()}</h3>
    <p class="myhanbit_reference2">주문취소 규정<a href="javascript:;" onclick="cancel_rule_layer_open('layer_cancel_rule');return false;"><img src="https://www.hanbit.co.kr/images/store/ico_question.gif" alt="주문취소 규정"></a>
    </p>
    
    <!-- 주문상태 -->
    <div class="order_state_area">
      <ul class="cancel_order">
        <li class="cancel state6">취소요청</li>
        <li class="bl_next"></li>
        <li class="cancel state7_r">취소완료</li>
      </ul>

    </div>
    <!-- //주문상태 -->
    
    <!-- 주문고객정보 -->
    <p class="tit">주문 고객 정보</p>
    <div class="table_area">
      <table class="tbl_type_list5" border="1" cellspacing="0" summary="주문고객 정보 테이블">
        <caption>주문고객 정보</caption>
        <colgroup>
        <col width="160px">
        <col width="410px">
        <col width="160px">
        <col width="">
        </colgroup>
        <tbody>
          <tr>
            <th>이름</th>
            <td>${orderVos.get(0).getU_m_name()}</td>
            <th>주문접수일</th>
            <td>${orderVos.get(0).getOrder_date()}</td>
          </tr>
        </tbody>
      </table>
    </div>
    <!-- //주문고객정보 -->

        
    <!-- 배송지 정보- 실물 상품 있는 경우에만 노출 -->
    <div class="delivery_info" style="margin:50px auto">
            <p class="tit">배송지 정보</p>
            <div class="table_area">
        <table class="tbl_type_list5" border="1" cellspacing="0" summary="배송지 정보 테이블">
          <caption>배송지 정보</caption>
          <colgroup>
          <col width="160px">
          <col width="220px">
          <col width="160px">
          <col width="220px">
          <col width="160px">
          <col width="">
          </colgroup>
          <tbody>
            <tr>
              <th>받으시는 분</th>
              <td>${orderVos.get(0).getDelivery_name() }</td>
              <th>휴대전화</th>
              <td>${orderVos.get(0).getDelivery_phone() }</td>
              <th>일반전화</th>
              <td>--</td>
            </tr>
            <tr>
              <th>주소</th>
              <td colspan="5">${orderVos.get(0).getDelivery_address() }</td>
            </tr>
          </tbody>
        </table>
      </div>
          </div>
    <!-- //배송지 정보 -->
    
    <!-- 상품 정보 -->
    <div class="product_info">
      <p class="tit">상품 정보</p>
      <div class="table_area_cart">
        <table class="tbl_type_list" border="1" cellspacing="0" summary="주문상품 리스트 테이블">
          <colgroup>
	          <col width="auto">
	          <col width="136px">
	          <col width="86px">
	          <col width="140px">
          </colgroup>
          <thead>
            <tr>
              <th scope="col">상품명</th>
              <th scope="col">판매가</th>
              <th scope="col">수량</th>
              <th scope="col">합계</th>
            </tr>
          </thead>
          <tbody>
			<c:forEach var="item" items="${orderVos}">             
	             <tr>
	              <td class="left info">
	                <a href="/store/books/look.php?p_code=B4012673740">${item.bm_name }</a>
	              </td>              
	              <td><p class="price">${item.bm_price }</p></td>
	              <td>${item.order_qty }</td>
	              <td class="price2">${item.bm_price*item.order_qty }</td>
	            </tr>   
            </c:forEach>                   
          </tbody>
        </table>  
      </div>
    </div>
    <!-- //상품 정보 -->
      
      <!-- 결제하기 버튼 -->
      <label>
          <button type="button" value="주문취소" class="btn_tracking_num2" onclick="orderCancel()">주문취소</button>
      </label>
     
  </div>
	</section>
	
	<jsp:include page="../../include/footer.jsp" />
	
	<script>
		
		function orderCancel(){
			if (!confirm("정말로 취소하시겠습니까?")){
				return
			}
			var form = document.createElement("form");
		    form.name = "order_cancel_form";
		    form.method = "post"; // 또는 "get" 등 필요에 따라 설정
		    form.action = "${pageContext.request.contextPath}/book/user/orderCancel";

		    // Input 생성 (예시로 hidden input을 추가)
		    var order_no = "${orderVos.get(0).getOrder_no()}";
		    var input = document.createElement("input");
		    input.type = "hidden";
		    input.name = "order_no";
		    input.value = order_no;

		    // Form에 Input 추가
		    form.appendChild(input);

		    // Body에 Form 추가
		    document.body.appendChild(form);

		    // Form 전송
		    form.submit();
		    
		}
	</script>
	
</body>
</html>