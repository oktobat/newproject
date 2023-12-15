package com.office.library.weather;

import java.util.Map;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

@Service
public class WeatherService {

    private final String API_KEY = "b22cc400a3b25ecf2837a48f16606d93"; // 실제 API 키로 대체

    public String getWeatherData(Map<String, Double> pos) {
    	Double lat = pos.get("lat");
    	Double lon = pos.get("lon");
    	String apiUrl = "https://api.openweathermap.org/data/2.5/weather";
    	apiUrl += "?lat=" + lat;
    	apiUrl += "&lon=" + lon;
    	apiUrl += "&appid=" + API_KEY;
 
        // RestTemplate 생성
        RestTemplate restTemplate = new RestTemplate();

        // API 호출 및 응답 받기
        String response = restTemplate.getForObject(apiUrl, String.class);

        System.out.println(response);
        // 응답 데이터 반환
        return response;
    }

    
}