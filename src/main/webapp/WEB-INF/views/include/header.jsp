<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.office.library.user.member.UserMemberVo" %>
<link href="<c:url value='/resources/css/include/header.css' />" rel="stylesheet" type="text/css">

<header>

	<div id="header_wrap">
		<div class="menu">
			<ul>
				<li><a class="user" href="<c:url value='/user' />">USER HOME</a></li>
				<li><a class="admin" href="<c:url value='/admin' />">ADMIN HOME</a></li>
			</ul>
		</div>
		<div class="title">
			<h3>한국 도서관 - 도서 대여 서비스</h3>
		</div>
		<div style="text-align:center; margin:30px; display:flex; justify-content:center; align-items:center">
			<p><span id="wicon"><img src="" /></span></p>
			<p style="margin:0 10px">(<span id="weather"></span>)</p>
			<p style="margin:0 10px">최저기온: <span id="mintemp"></span></p>
			<p style="margin:0 10px">최고기온: <span id="maxtemp"></span></p>
			<p style="margin:0 10px">습도 : <span id="humidity"></span></p>
		</div>
	</div>
</header>

<%
	       UserMemberVo loginedUserMemberVo  = (UserMemberVo) session.getAttribute("loginedUserMemberVo");
	       
	    %>
<script>
let address = "${loginedUserMemberVo.u_m_address}";
jQ.ajax({
    type: "GET",
    url: "${pageContext.request.contextPath}/weather/getPosition?address="+address,
    success: function(response) {
    	let data = JSON.parse(response);
        console.log(data.weather[0].main);
        let weather = data.weather[0].main;
        if (weather=="Clear") {
        	jQ("#weather").text("맑음")
        } else if (weather=="Clouds") {
        	jQ("#weather").text("구름")
        } else if (weather=="Mist" || weather=="Smoke" || weather=="Haze" || weather=="Dust" || weather=="Fog" || weather=="Sand" || weather=="Dust" || weather=="Ash" || weather=="Squall" || weather=="Tornado"){
        	jQ("#weather").text("안개")
        } else if (weather=="Rain"){
        	jQ("#weather").text("비")
        } else if (weather=="Drizzle"){
        	jQ("#weather").text("이슬비")
        } else if (weather=="Snow"){
        	jQ("#weather").text("눈")
        } else if (weather=="Thunderstorm"){
        	jQ("#weather").text("폭풍우")
        }
        let src = "<c:url value='https://openweathermap.org/img/wn/"+data.weather[0].icon+".png' />";
        jQ("#wicon img").attr("src", src)
        let mintemp = Math.round(data.main.temp_min - 273.15)
        let maxtemp = Math.round(data.main.temp_max - 273.15)
        let humidity = data.main.humidity
        jQ("#mintemp").text(mintemp+"℃")
        jQ("#maxtemp").text(maxtemp+"℃")
        jQ("#humidity").text(humidity+"%")
        
    },
    error: function(error) {
        console.error('Error:', error);
    }
});
</script>



