package com.office.library.weather;

import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.util.UriComponentsBuilder;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

import java.util.HashMap;
import java.util.Map;

@Service
public class KakaoMapService {

    private final String KAKAO_API_KEY = "67a7b2b6fce96906b326c26a7f6a4f74";

    public KakaoMapService() {
        // 생성자에서 초기화 또는 DI 등을 통해 안전하게 API 키를 관리할 수 있습니다.
    }

	public Map<String, Double> getAddressCoordinates(String address) {
		Map<String, Double> latlon = new HashMap<>();
    	try {
            RestTemplate restTemplate = new RestTemplate();

            // 카카오맵 API 호출 URL
            String apiUrl = UriComponentsBuilder.fromHttpUrl("https://dapi.kakao.com/v2/local/search/address.json")
                    .queryParam("query", address)
                    .build().toUriString();

            // 기존 HttpHeaders 객체 생성
            HttpHeaders headers = new HttpHeaders();
            
            // 기존 HttpHeaders 객체에 헤더 추가
            headers.set("Authorization", "KakaoAK " + KAKAO_API_KEY);
            
            // HttpEntity에 헤더 설정
            HttpEntity<String> entity = new HttpEntity<>(headers);

            // API 호출 및 응답 받기
            ResponseEntity<String> response = restTemplate.exchange(apiUrl, HttpMethod.GET, entity, String.class);

            // 응답 데이터에서 위도와 경도 추출
            ObjectMapper objectMapper = new ObjectMapper();
            JsonNode jsonNode = objectMapper.readTree(response.getBody());
            JsonNode documents = jsonNode.get("documents");

            if (documents.isArray() && documents.size() > 0) {
                double latitude = documents.get(0).get("y").asDouble();
                double longitude = documents.get(0).get("x").asDouble();

                System.out.println("구해줘: " + latitude);
                System.out.println("구해줘: " + longitude);
                
                latlon.put("lat", latitude);
                latlon.put("lon", longitude);
                
            } else {
                System.out.println("주소에 대한 결과를 찾을 수 없습니다.");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    	return latlon;
    }
}