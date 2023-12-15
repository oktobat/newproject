<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.office.library.book.CartBookVo" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<table id="orderTable" border="1">
    <colgroup>
    	<col />
    	<col />
    	<col />
    	<col />
    	<col />
    </colgroup>
	<thead>
		<tr>
			<th>구분</th>
			<th>상품명</th>
			<th>판매가</th>
			<th>수량</th>
			<th>합계</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach  var="item" items="${cartBookVos}">
		    <fmt:formatNumber value="${item.bm_price}" type="number" var="bm_price" />
		    <fmt:formatNumber value="${item.bm_price * item.cart_qty}" type="number" var="bm_amount" />
			<tr>
				<td>책</td>
				<td>${item.bm_name}</td>
				<td>${bm_price}원</td>
				<td>${item.cart_qty}</td>
				<td>${bm_amount}원</td>
			</tr>
		</c:forEach>
		<tr>
			<td colspan="5" style="padding:20px 0; border:none"> </td>
		</tr>
	</tbody>
	
	<c:set var="qty_total" value="0" />
	<c:set var="amount_total" value="0" />
	<c:forEach var="item" items="${cartBookVos}">
		<c:set var="qty_total" value="${qty_total + item.cart_qty }" />
		<c:set var="amount_total" value="${amount_total+(item.bm_price * item.cart_qty)}" />
	</c:forEach>
	<fmt:formatNumber value="${amount_total+5000}" type="number" var="allTotAmount" />
	
	<tfoot>
		<tr>
			<td colspan="5" style="text-align:center; padding:20px 0; border:1px solid #000">
				<span>주문상품 수량 : ${cartBookVos.size()}건 [${qty_total}]개</span>
				<span style="margin:0 30px">배송료 : 5,000원</span>
				<span>총 주문 금액 : ${allTotAmount}원</span>
			</td>
		</tr>
	</tfoot>
</table>
    
    
<div class="order_info">
    <p class="tit">주문 고객 정보</p>
    <dl>
      <dt>이름</dt>
      <dd>${cartBookVos.get(0).getU_m_name()}</dd>
      <dt>이메일</dt>
      <dd class="email_area">${cartBookVos.get(0).getU_m_mail()}</dd>
      <dt>전화번호</dt>
      <dd>${cartBookVos.get(0).getU_m_phone()}</dd>
    </dl>
</div>    


<form method="post" name="LGD_PAYINFO" id="LGD_PAYINFO">
    <input type="hidden" name="u_m_no" value="${cartBookVos.get(0).getU_m_no()}">
    <c:forEach var="item" items="${cartBookVos }">
    	<input type="hidden" name="order_nos" value="${item.getBm_no()}">
    	<input type="hidden" name="order_qtys" value="${item.getCart_qty()}">
    </c:forEach>
    <div class="addr_info_box">
      <p class="tit">배송지 정보</p>
      <div class="address_info" style="position:relative;">
        <fieldset>
        <legend>배송지 정보 입력</legend>
        <div class="register_addr">
          <div class="register_li">
            <div class="i_tit"><strong>배송지 선택<span> *</span></strong></div>
            <div class="i_con">                          
              <label class="ra_label">
                <input type="radio" name="delivery_addr" id="delivery_Orderaddr" value="Orderaddr" class="i_radio" checked onclick="javascript:set_deliveryAddr();">
                <span>주문자와 동일</span>
              </label>
              <label class="ra_label">
                <input type="radio" name="delivery_addr" id="delivery_Newaddr" value="Newaddr" class="i_radio" onclick="javascript:set_deliveryAddr();">
                <span>새로입력</span>
              </label>
            </div>
          </div>
          <div class="register_li">
            <div class="i_tit"><strong>이름<span> *</span></strong></div>
            <div class="i_con">
              <label>
                <input type="text" value="${cartBookVos.get(0).getU_m_name()}" name="delivery_name" id="m_name" class="i_text">  
              </label>
            </div>
          </div>
          <div class="register_li">
            <div class="i_tit"><strong>주소<span> * </span></strong></div>
            <div class="i_con">
              <label>
                <input type="text" name="u_m_zipcode" id="m_zipcode" class="i_text" value="${cartBookVos.get(0).getU_m_zipcode()}" onclick="openDaumPostcode();">  
              </label>
              <label>    
                <input type="button" value="우편번호 검색" id="prof_zipcode" class="i_button" onclick="openDaumPostcode();">
              </label>
              <div class="input_space"></div>
              <label>
                <input type="text" name="u_m_address" id="m_address" class="i_text2" value="${cartBookVos.get(0).getU_m_address()}">  
              </label>
              <label class="i_label">
                <input type="text" name="u_m_address_sub" id="m_address_sub" class="i_text2" value="${cartBookVos.get(0).getU_m_address_sub()}">
                <span>※ 배송주소를 다시 한번 확인해 주세요.</span>
              </label>
              <input type="hidden" name="delivery_address">
            </div>
          </div>
          <div class="register_li">
            <div class="i_tit"><strong>휴대전화<span> *</span></strong></div>
            <div class="i_con">
              <label>
                <input type="text" name="m_mobile_1" id="m_mobile_1" class="i_text3" onkeyup="this.value=number_filter(this.value);" maxlength="4">  
              </label>
              -
              <label>
                <input type="text" name="m_mobile_2" id="m_mobile_2" class="i_text3" onkeyup="this.value=number_filter(this.value);" maxlength="4">  
              </label>
              - 
              <label>
                <input type="text" name="m_mobile_3" id="m_mobile_3" class="i_text3" onkeyup="this.value=number_filter(this.value);" maxlength="4"><br>
              </label>
              <input type="hidden" name="delivery_phone">
            </div>
          </div>
                    
          <div class="register_li">
            <div class="i_tit"><strong>일반전화</strong></div>
            <div class="i_con">
              <label>
                <input type="text" name="m_phone_1" id="m_phone_1" class="i_text3" onkeyup="this.value=number_filter(this.value);" maxlength="4">  
              </label>
              - 
              <label>
                <input type="text" name="m_phone_2" id="m_phone_2" class="i_text3" onkeyup="this.value=number_filter(this.value);" maxlength="4">  
              </label>
              - 
              <label>
                <input type="text" name="m_phone_3" id="m_phone_3" class="i_text3" onkeyup="this.value=number_filter(this.value);" maxlength="4">  
              </label>
            </div>
          </div>
                    <div class="register_li">
            <div class="i_tit"><strong>배송메시지</strong></div>
            <div class="i_con">
              <label>
                <input type="text" name="ord_comment" id="ord_comment" class="i_text4">
                                 <span>(50자 이내 작성)</span>
              </label>
            </div>
          </div>
          <!-- EVENT -->
                    <!--
           <div class="register_li">
            <div class="i_tit"><strong>사은품</strong></div>
            <div class="i_con">
              <label>
                <input type="text" name="ord_gift" id="ord_gift" class="i_text4" readonly value="">
              </label>
            </div>
          </div>
          -->
                    <!--// EVENT -->
        </div>
        </fieldset>
              </div>
      
    </div>
    
  <script>
  set_deliveryAddr();
  function set_deliveryAddr() {
	  let type = "";
	  jQ("input[name=delivery_addr]").each(function(){
		  if (jQ(this).prop("checked")) {
			  type = jQ(this).val()
		  }
	  })
	  if (type=="Orderaddr") {
		  jQ("input[name=u_m_name]").val("${cartBookVos.get(0).getU_m_name()}");
		  jQ("input[name=u_m_zipcode]").val("${cartBookVos.get(0).getU_m_zipcode()}");
		  jQ("input[name=u_m_address]").val("${cartBookVos.get(0).getU_m_address()}");
		  jQ("input[name=u_m_address_sub]").val("${cartBookVos.get(0).getU_m_address_sub()}");
		  let phone = "${cartBookVos.get(0).getU_m_phone()}";
		  let phones = phone.split("-")
		  jQ("input[name=m_mobile_1]").val(phones[0]);
		  jQ("input[name=m_mobile_2]").val(phones[1]);
		  jQ("input[name=m_mobile_3]").val(phones[2]);
	  } else if (type=="Newaddr") {
		  jQ("input[name=u_m_name]").val("");
		  jQ("input[name=u_m_zipcode]").val("");
		  jQ("input[name=u_m_address]").val("");
		  jQ("input[name=u_m_address_sub]").val("");
		  jQ("input[name=m_mobile_1]").val("");
		  jQ("input[name=m_mobile_2]").val("");
		  jQ("input[name=m_mobile_3]").val("");
	  }
	  
  }
  
  </script>
  
  
  <!-- 배송지 정보 SCRIPT -->
  <script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>  
  <script>
    //새주소등록  우편번호찾기
    function openDaumPostcode() {
      new daum.Postcode({
        oncomplete: function(data) {
          var fullAddr = ''; // 최종 주소 변수
          var extraAddr = ''; // 조합형 주소 변수
          if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
            fullAddr = data.roadAddress;
          } else { // 사용자가 지번 주소를 선택했을 경우(J)
            fullAddr = data.jibunAddress;
          }
          if(data.userSelectedType === 'R'){
            if(data.bname !== ''){
              extraAddr += data.bname;
            }
            if(data.buildingName !== ''){
              extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
            }
            fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
          }
          document.querySelector("#m_zipcode").value = data.zonecode;
          document.querySelector("#m_address").value = fullAddr;
          document.querySelector("#m_address_sub").focus();
        }
      }).open();
    }
  </script>  

      <!-- 결제 정보 -->
  <div class="payment_info">
      <p class="tit">결제 정보</p>
      <dl class="payment_type">
        <dt>결제방법 선택</dt>
        <dd>
          <label class="ra_label">
            <input type="radio" name="ord_pay_method" id="ord_pay_method1" class="i_radio" value="card" checked onclick="select_pay_method(0);">
            <span>신용카드</span>
          </label>
          <input type="hidden" name="order_status">
        </dd>
        <dd>
          <label class="ra_label">
            <input type="radio" name="ord_pay_method" id="ord_pay_method2" class="i_radio" value="bank" onclick="select_pay_method(2);">
            <span>무통장 입금</span>
          </label>
        </dd>
      </dl>      
    </div>
        <!-- //결제 정보 -->
    
    <!-- 1.신용카드 - 주의사항 안내창 -->
    <div id="p_type_card" style="display:block">
      <div class="caution_box">
        <p>웹브라우저에 팝업차단 기능이 켜 있으면 정상적으로 결제가 되지 않을 수 있습니다.<br>팝업 차단을 미리 해제하시기 바랍니다.</p>
      </div>
    </div>
    <!-- //1.신용카드 - 안내창 -->

    <!-- 3.무통장입금 - 안내창 -->
    <div id="p_type_deposit" style="display:none">
      <!-- 무통장입금 입금 계좌 -->
      <div class="account_info">
        <div class="register_li">
          <div class="i_tit"><strong>입금계좌<span> *</span></strong></div>
          <div class="i_con">
            <label>
              <select id="ord_bank" name="ord_bank" class="i_select2">  
                <option value="">결제계좌를 선택해 주세요.</option>  
                <option value="KB">국민은행 / 069101-04-009393 / 한빛미디어(주)</option>
                <option value="URI">우리은행 / 068-396373-13-001 / 한빛미디어(주)</option>
                <option value="SH">신한은행 / 240-05-013166 / 한빛미디어(주)</option>
                <option value="NH">농협 / 038-17-003870 / 한빛미디어(주)</option>
              </select>  
            </label>
          </div>
        </div>
        <div class="register_li">
          <div class="i_tit"><strong>입금예정일<span> *</span></strong></div>
          <div class="i_con">
            <!-- 달력 -->
            <div class="cld_area">
              <label>
                <input class="i_text" id="ord_onlinedt" name="ord_onlinedt" type="text">
              </label>
              <label>
                <button name="ord_onlinedt_btn" id="ord_onlinedt_btn" type="button" value="검색" class="i_car">달력</button>
              </label>
            </div>
            <!-- //달력 -->
          </div>
        </div>
        <div class="register_li">
          <div class="i_tit"><strong>입금자명<span> *</span></strong></div>
          <div class="i_con">
            <label>
              <input type="text" name="ord_name" id="ord_name" class="i_text2">  
            </label>
          </div>
        </div>
        
        <script>
          jQ('#ord_onlinedt').datepicker();
    	  jQ(document).on("click", "#ord_onlinedt_btn", function(){
             jQ('#ord_onlinedt').datepicker('show');
	      });
    	  
    	  jQ.datepicker.regional['ko'] = {
  				closeText: '닫기',
  				prevText: '이전달',
  				nextText: '다음달',
  				currentText: '오늘',
  				monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],				
  				monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],					
  				dayNames: ['일','월','화','수','목','금','토'],
  				dayNamesShort: ['일','월','화','수','목','금','토'],
  				dayNamesMin: ['일','월','화','수','목','금','토'],
  				weekHeader: 'Wk',
  				dateFormat: 'yy-mm-dd',
  				firstDay: 0,
  				isRTL: false,
  				showMonthAfterYear:true,		
  				changeYear: true,
  				yearRange: "-50:+20",
  				yearSuffix: ' 년'};
  		jQ.datepicker.setDefaults(jQ.datepicker.regional['ko']);
    	 
	    </script>
         
        
      </div>
      
    </div>
              
    
    
    <script>
    function select_pay_method(num){
    	if (num==0) {
    		jQ("#p_type_card").show()
    		jQ("#p_type_deposit").hide()
    	} else if (num==2) {
    		jQ("#p_type_card").hide()
    		jQ("#p_type_deposit").show()
    	}
    }
    </script>
    
    
    <!-- 주문,결제 최종 정보 영역 -->
    <div class="total_info">
      <input type="hidden" id="sum_sale_price" name="sum_sale_price">
      <input type="hidden" id="sum_ecoin_price" name="sum_ecoin_price">
      <input type="hidden" id="sum_coupon_price" name="sum_coupon_price">
      <input type="hidden" id="sum_total_price" name="sum_total_price" value="176400">
      <input type="hidden" id="sum_total_mileage" name="sum_total_mileage" value="9800">
      <input type="hidden" id="p_delivery_price" name="p_delivery_price" value="0">
      
      <!-- 주문 총액 정보 -->
      <dl class="total_order">
        <dt>주문상품 : </dt>
        <dd>총 ${cartBookVos.size()}종 [${qty_total}개]</dd>
        <dt>총 상품금액 : </dt>
        <fmt:formatNumber value="${amount_total}" type="number" var="amountTotal" />
        <dd>${amountTotal}원</dd>
        <dt>배송비 : </dt>
        <dd>5,000원</dd>
      </dl>
      <!-- //주문 총액 정보 -->
      
      <!-- 최종 결제 정보 -->
      <dl class="total_payment">
        <dt><strong>최종 결제 금액 :</strong></dt>
        <dd><strong><span id="sum_t_price_show">${allTotAmount}원</span></strong></dd>
      </dl>
      <!-- //최종 결제 정보 -->
      
     
      <!-- 결제하기 버튼 -->
      <label>
        <button name="bynPay" type="button" value="결제하기" class="btn_payment" onclick="payment();">결제하기</button>
      </label>
      <!-- //결제하기 버튼 -->
    </div>
    <!-- //주문,결제 최종 정보 영역 -->
    
  </form>

<script>
    let form = document.LGD_PAYINFO
	function payment(){
 		let delivery_name = jQ("input[name=delivery_name]").val()
		let u_m_zipcode = jQ("input[name=u_m_zipcode]").val()
		let u_m_address = jQ("input[name=u_m_address]").val()
		let u_m_address_sub = jQ("input[name=u_m_address_sub]").val()
		let m_mobile_1 = jQ("input[name=m_mobile_1]").val()
		let m_mobile_2 = jQ("input[name=m_mobile_2]").val()
		let m_mobile_3 = jQ("input[name=m_mobile_3]").val()
		
		if (!delivery_name) {
			alert("받을 사람 이름을 입력해 주세요.")
			jQ("input[name=delivery_name]").focus()
			return false;
		} else if (!u_m_zipcode) {
			alert("우편번호를 입력하세요.")
			jQ("input[name=u_m_zipcode]").focus()
			return false;
		} else if (!u_m_address) {
			alert("주소를 입력하세요.")
			jQ("input[name=u_m_address]").focus()
			return false;
		} else if (!u_m_address_sub) {
			alert("상세주소를 입력하세요.")
			jQ("input[name=u_m_address_sub]").focus()
			return false;
		} else if (!m_mobile_1 || !m_mobile_2 || !m_mobile_3) {
			alert("연락처를 입력하세요.")
			jQ("input[name=m_mobile_1]").focus()
			return false;
		} 
		
		let purchase = ""
		jQ("input[name=ord_pay_method]").each(function(){
			if (jQ(this).prop("checked")){
				purchase = jQ(this).val()
			}
		})
		if (purchase=="bank") {
			let ord_bank = jQ("#ord_bank").val()
			let ord_onlinedt = jQ("input[name=ord_onlinedt]").val()
			let ord_name = jQ("input[name=ord_name]").val()
			if (!ord_bank) {
				alert("계좌번호를 입력하세요.")
				jQ("#ord_bank").focus()
				return false;
			} else if (!ord_onlinedt) {
				alert("입금예정일을 입력하세요.")
				jQ("input[name=ord_onlinedt]").focus()
				return false;
			} else if (!ord_name) {
				alert("입금자명을 입력하세요.")
				jQ("input[name=ord_name]").focus()
				return false;
			}
			jQ("input[name=order_status]").val("입금대기")
		} else {
			jQ("input[name=order_status]").val("배송준비중")
		}
		
		jQ("input[name=delivery_address]")
		.val("["+u_m_zipcode+"] " + u_m_address + " " + u_m_address_sub) 
		jQ("input[name=delivery_phone]")
		.val(m_mobile_1+"-"+m_mobile_2+"-"+ m_mobile_3)
		
		form.action = "${pageContext.request.contextPath}/book/user/purchaseRequest"
		form.submit()
		
	}

</script>         
				
				