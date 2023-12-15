package com.office.library.weather;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/weather")
public class WeatherController {
	
	@Autowired
	KakaoMapService kakaoMapService;
	
	@Autowired
	WeatherService weatherService;
	
	
	@GetMapping("/getPosition")
	public String getPosition(@RequestParam("address") String address, HttpSession session) {
		Double lon = 127.0495556;
		Double lat = 37.514575;
		if (address != null && !address.isEmpty()) {
			String[] addr = address.split(" ");
			address = addr[0]+" "+addr[1]+" "+addr[2];
			Map<String, Double> pos = kakaoMapService.getAddressCoordinates(address);
			System.out.println("위도"+pos.get("lat"));
			System.out.println("경도"+pos.get("lon"));
			lat = pos.get("lat");
			lon = pos.get("lon");
		}
		return "redirect:/weather/getWeather?lat="+lat+"&lon="+lon;
		
	}	
	

	@GetMapping("/getWeather")
	public ResponseEntity<String> getWeather(@RequestParam("lat") Double lat, @RequestParam("lon") Double lon, HttpSession session) {
		Map<String, Double> pos = new HashMap<>();
		pos.put("lat", lat);
		pos.put("lon", lon);
		String weatherResponse = weatherService.getWeatherData(pos);
		System.out.println(weatherResponse);
		return ResponseEntity.ok(weatherResponse);
	}
	
	
		
}